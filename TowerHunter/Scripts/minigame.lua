-- ============================================================================
--  TowerHunter - lock mini-game auto-win module (Palworld, UE4SS Lua)
--  Games: Picking (lockpick) / GaugeStop (roulette) / OneStroke
-- ============================================================================
--  When a lock mini-game starts, the game creates a HUD dispatch parameter
--  (a subclass of PalHUDDispatchParameter_LockGimmickMiniGame). We wait
--  CONFIG.DelayMs and call the same native completion function the game
--  itself calls on an honest win:
--      picking   -> param:OnReceiveSuccessPicking()
--      onestroke -> param:OnReceiveGameSuccess()
--      gauge     -> param.Model:SendResult(true)  (exactly what the widget
--                   does on a lucky stop), fallback:
--                   param:OnReceiveMiniGameResult(true)
--  The lock only opens when the mini-game widget CLOSES, so if the game has
--  not closed it within CONFIG.CloseCheckMs we close the widget ourselves
--  (the same StackableUI:Close() path the ESC key uses). Completion is
--  verified through the OnMiniGameComplete event, with a
--  CloseOverlayUIAll() escalation if Close() alone is not enough.
--
--  Safety: only native UFunctions are called (through ProcessEvent - the
--  same channel every Lua mod uses), no offset reads, every step is
--  pcall-guarded, and nothing can fire outside a live world because both
--  triggers (new dispatch parameter / interacting with a lock) are in-game
--  events. Fully event-driven, zero background polling.
-- ============================================================================

local TAG = "[TowerHunter]"

local CONFIG = {
    Enabled      = true,   -- master switch: false disables the whole module
    DelayMs      = 800,    -- how long the mini-game stays open before the win
    CloseCheckMs = 500,    -- after the win: grace period before we close the widget

    Games = { picking = true, gauge = true, onestroke = true },

    GaugeNatural    = true,   -- gauge: use Model:SendResult(true) like the widget does
    GaugeFallback   = true,   -- gauge: if no answer within GaugeFallbackMs,
    GaugeFallbackMs = 2500,   --        call OnReceiveMiniGameResult(true) directly

    ProbeWhenUnknown = true,  -- if the parameter class is not recognized, try the
                              -- completion functions in order (a function missing
                              -- on a class only raises a pcall'd Lua error)
    EscalateCloseAll = true,  -- if Close() does not finish the game, CloseOverlayUIAll()
}

-- ============================== local helpers ==============================

local function Err(msg) print(TAG .. " minigame: " .. tostring(msg) .. "\n") end

local function nowSec()
    local ok, c = pcall(os.clock)
    return (ok and c) or 0
end

local function SafeDo(label, fn)
    local ok, err = pcall(fn)
    if not ok then Err("[" .. tostring(label) .. "] " .. tostring(err)) end
    return ok
end

local function hasMethod(obj, name)
    local res = false
    pcall(function() res = (type(obj[name]) == "function") end)
    return res
end

-- hook/notify callbacks hand out RemoteUnrealParam wrappers - unwrap them
local function Unwrap(v)
    if type(v) == "userdata" or type(v) == "table" then
        if hasMethod(v, "get") then
            local ok, r = pcall(function() return v:get() end)
            if ok and r ~= nil then return r end
        end
    end
    return v
end

local function IsValidObj(o)
    o = Unwrap(o)
    if o == nil then return false end
    local ok, v = pcall(function() return o:IsValid() end)
    return ok and v == true
end

local function ObjName(o)
    o = Unwrap(o)
    if o == nil then return "nil" end
    local ok, n = pcall(function() return o:GetFullName() end)
    if ok and type(n) == "string" then return n end
    ok, n = pcall(function() return o:GetName() end)
    if ok and type(n) == "string" then return n end
    return tostring(o)
end

local function ClassName(o)
    o = Unwrap(o)
    if o == nil then return nil end
    local ok, cls = pcall(function() return o:GetClass() end)
    if ok and cls ~= nil then
        cls = Unwrap(cls)
        local ok2, n = pcall(function() return cls:GetName() end)
        if ok2 and type(n) == "string" then return n end
        local ok3, f = pcall(function() return cls:GetFullName() end)
        if ok3 and type(f) == "string" then return f:match("([%w_]+)$") end
    end
    return nil
end

local function ProbeMember(o, name)
    o = Unwrap(o)
    if o == nil then return false end
    local res = false
    pcall(function() res = (o[name] ~= nil) end)
    return res
end

local function ScheduleInGameThread(delayMs, label, fn)
    if type(ExecuteWithDelay) ~= "function" then
        SafeDo(label, fn)
        return
    end
    ExecuteWithDelay(delayMs, function()
        local outer = function() SafeDo(label, fn) end
        if type(ExecuteInGameThread) == "function" then
            if pcall(ExecuteInGameThread, outer) then return end
        end
        outer()
    end)
end

-- ================================ the games ================================

local GAMES = {
    ["PalHUDDispatchParameter_PickingMiniGame"] = {
        key = "picking", widget = "WBP_PickingGame02_ForDisplay_C",
    },
    ["PalHUDDispatchParameter_OneStrokeMiniGame"] = {
        key = "onestroke", widget = "WBP_OneStrokeGame_ForDisplay_C",
    },
    ["PalHUDDispatchParameter_GaugeStopMiniGame"] = {
        key = "gauge", widget = "WBP_SalvageGame_GaugeStopMiniGame_C",
    },
}

local function GameByKey(key)
    for _, g in pairs(GAMES) do
        if g.key == key then return g end
    end
    return nil
end

-- ================================= state ===================================

local lastParam, lastParamAt = nil, 0
local lastScheduleAt = 0
-- dedup by the object's full name (userdata identity is not stable - the
-- wrappers are recreated on every access)
local handledNames     = {}  -- parameter name -> already won
local gaugeResultNames = {}  -- parameter name -> the gauge model answered
local completedNames   = {}  -- parameter name -> OnMiniGameComplete observed

-- classify a dispatch parameter: class -> object name -> member probe
local function ClassifyParam(rawParam)
    local param = Unwrap(rawParam)
    if not IsValidObj(param) then return nil, param end

    local cls = ClassName(param)
    if cls and GAMES[cls] then return cls, param end

    local okF, fn = pcall(function() return param:GetFullName() end)
    if okF and type(fn) == "string" then
        local own = fn:match("([%w_]+)$") or fn
        for cname in pairs(GAMES) do
            if own:find(cname, 1, true) then return cname, param end
        end
    end

    if ProbeMember(param, "OnReceiveSuccessPicking") then return "PalHUDDispatchParameter_PickingMiniGame", param end
    if ProbeMember(param, "OnReceiveGameSuccess")    then return "PalHUDDispatchParameter_OneStrokeMiniGame", param end
    if ProbeMember(param, "OnReceiveMiniGameResult") then return "PalHUDDispatchParameter_GaugeStopMiniGame", param end

    return cls, param
end

-- ================================== win ====================================

local ScheduleGaugeFallback -- forward declaration

local function ExecuteWin(g, rawParam)
    local param = Unwrap(rawParam)
    if g.key == "picking" then
        param:OnReceiveSuccessPicking()
    elseif g.key == "onestroke" then
        param:OnReceiveGameSuccess()
    elseif g.key == "gauge" then
        local model = nil
        pcall(function() model = Unwrap(param.Model) end)
        if CONFIG.GaugeNatural and IsValidObj(model) then
            model:SendResult(true)
            if CONFIG.GaugeFallback then ScheduleGaugeFallback(param) end
            return "model"
        end
        param:OnReceiveMiniGameResult(true)
        return "direct"
    end
    return "native"
end

ScheduleGaugeFallback = function(rawParam)
    local ms = CONFIG.GaugeFallbackMs
    ScheduleInGameThread(ms, "gauge-fallback", function()
        local param = Unwrap(rawParam)
        if not IsValidObj(param) then return end
        if gaugeResultNames[ObjName(param)] then return end
        pcall(function() param:OnReceiveMiniGameResult(true) end)
    end)
end

-- last resort when the class was not recognized: try the completion
-- functions in order (each exists on exactly one parameter class)
local function ExecuteWinByProbe(rawParam)
    local param = Unwrap(rawParam)
    local attempts = {}
    if CONFIG.Games.picking then
        attempts[#attempts + 1] = { "picking", function() param:OnReceiveSuccessPicking() end }
    end
    if CONFIG.Games.onestroke then
        attempts[#attempts + 1] = { "onestroke", function() param:OnReceiveGameSuccess() end }
    end
    if CONFIG.Games.gauge then
        attempts[#attempts + 1] = { "gauge", function() ExecuteWin(GameByKey("gauge"), param) end }
    end
    for _, a in ipairs(attempts) do
        if pcall(a[2]) then return a[1] end
    end
    return nil
end

-- ============================== closing the UI =============================

-- all live instances of a class, CDOs (Default__...) filtered out -
-- FindFirstOf returns the CDO first, and its visibility flags lie
local function FindInstancesOf(className)
    local out = {}
    local ok, arr = pcall(FindAllOf, className)
    if ok and type(arr) == "table" then
        for _, o in ipairs(arr) do
            o = Unwrap(o)
            if IsValidObj(o) then
                local nm = ObjName(o)
                if not nm:find("Default__", 1, true) then out[#out + 1] = o end
            end
        end
    end
    return out
end

local function SchedulePostWinClose(g, paramName)
    -- the lock only opens when the widget closes; if the game has not done
    -- it itself, close the widget the way the ESC key does
    ScheduleInGameThread(CONFIG.CloseCheckMs, "close:" .. g.key, function()
        if completedNames[paramName] then return end
        local inst = FindInstancesOf(g.widget)
        if #inst == 0 then return end
        for _, w in ipairs(inst) do
            pcall(function() w:Close() end)
        end

        ScheduleInGameThread(1000, "close2:" .. g.key, function()
            if completedNames[paramName] then return end
            if not CONFIG.EscalateCloseAll then return end
            local svc = FindInstancesOf("PalHUDService")
            if #svc == 0 then return end
            for _, s in ipairs(svc) do
                pcall(function() s:CloseOverlayUIAll() end)
            end

            ScheduleInGameThread(1200, "close3:" .. g.key, function()
                if not completedNames[paramName] then
                    Err("could not finish the mini-game automatically (widget closed by the game state)")
                end
            end)
        end)
    end)
end

-- ================================ trigger ==================================

local function TryWinNow(resolveParam)
    local t = nowSec()
    if (t - lastScheduleAt) < 2.5 then return end
    lastScheduleAt = t

    ScheduleInGameThread(CONFIG.DelayMs, "win", function()
        local param = nil
        SafeDo("resolve", function() param = Unwrap(resolveParam()) end)
        if not IsValidObj(param) then return end

        local name = ObjName(param)
        if handledNames[name] then return end

        local cls, p2 = ClassifyParam(param)
        param = p2
        local g = cls and GAMES[cls] or nil

        if g == nil then
            if not CONFIG.ProbeWhenUnknown then return end
            local key = ExecuteWinByProbe(param)
            if key == nil then return end
            handledNames[name] = true
            local gg = GameByKey(key)
            if gg then SchedulePostWinClose(gg, name) end
            return
        end

        if not CONFIG.Games[g.key] then return end
        handledNames[name] = true
        if SafeDo("win:" .. g.key, function() ExecuteWin(g, param) end) then
            SchedulePostWinClose(g, name)
        end
    end)
end

local function OnNewParam(rawParam)
    SafeDo("on-new-param", function()
        local param = Unwrap(rawParam)
        if not IsValidObj(param) then return end
        local full = ObjName(param)
        if full:find("Default__", 1, true) then return end

        local cls = ClassifyParam(param)
        lastParam, lastParamAt = param, nowSec()

        if cls and GAMES[cls] then
            TryWinNow(function() return param end)
        end
    end)
end

local function OnInteract(levelObj)
    local interactAt = nowSec()
    TryWinNow(function()
        -- 1) the parameter created after the F press
        if IsValidObj(lastParam) and lastParamAt >= (interactAt - 0.1) then
            return lastParam
        end
        -- 2) the lock's current parameter
        if IsValidObj(levelObj) then
            local ok, p = pcall(function() return levelObj.CurrentParameter end)
            if ok then
                p = Unwrap(p)
                if IsValidObj(p) then return p end
            end
        end
        -- 3) the last known parameter
        if IsValidObj(lastParam) then return lastParam end
        return nil
    end)
end

-- ============================ functional hooks =============================

local HOOKS = {
    { path = "/Script/Pal.PalHUDDispatchParameter_GaugeStopMiniGame:OnReceiveMiniGameResult", gauge = true },
    { path = "/Script/Pal.PalLevelObject_LockGimmickMiniGame:OnMiniGameComplete",            complete = true },
    { path = "/Script/Pal.PalLevelObject_LockGimmickMiniGame:OnTriggerInteract",              interact = true },
}

local function OnHook(d, rawContext, ...)
    local context = Unwrap(rawContext)
    local args = {}
    for i = 1, select("#", ...) do args[i] = Unwrap(select(i, ...)) end

    SafeDo("hook", function()
        if d.gauge then
            if args[1] == true and IsValidObj(context) then
                gaugeResultNames[ObjName(context)] = true
            end
        elseif d.complete then
            if IsValidObj(args[1]) then
                completedNames[ObjName(args[1])] = true
            end
        elseif d.interact then
            OnInteract(context)
        end
    end)
end

-- ============================ registration =================================

local notifyOk = false
local hookRegistered = {}
local initAttempts = 0

local function TryInit()
    if not CONFIG.Enabled then return end
    initAttempts = initAttempts + 1
    local allOk = true

    for i, d in ipairs(HOOKS) do
        if not hookRegistered[i] then
            if pcall(RegisterHook, d.path, function(context, ...) OnHook(d, context, ...) end) then
                hookRegistered[i] = true
            else
                allOk = false
            end
        end
    end

    if not notifyOk then
        notifyOk = pcall(NotifyOnNewObject,
            "/Script/Pal.PalHUDDispatchParameter_LockGimmickMiniGame",
            function(param) OnNewParam(param) end)
    end

    if allOk and notifyOk then return end
    if initAttempts >= 20 then
        Err("could not register all hooks/notifications - mini-game auto-win is partially active")
        return
    end
    if type(ExecuteWithDelay) == "function" then
        ExecuteWithDelay(3000, TryInit)
    end
end

TryInit()

return { _MODULE = "minigame-autowin", _VERSION = "1.0" }
