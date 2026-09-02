-- ============================================================================================
-- MinigameAutoWin v0.1 — ТЕСТОВЫЙ мод (UE4SS Lua) для Palworld
-- Авто-победа мини-игр: Отмычка (Picking) / Рулетка-датчик (GaugeStop) / Росчерк (OneStroke)
--
-- ПРИНЦИП (без паков, без правки ассетов, только свой Lua-код):
--   При старте мини-игры игра создаёт HUD-dispatch-параметр (наследники
--   PalHUDDispatchParameter_LockGimmickMiniGame):
--     PalHUDDispatchParameter_PickingMiniGame   — отмычка
--     PalHUDDispatchParameter_OneStrokeMiniGame — росчерк
--     PalHUDDispatchParameter_GaugeStopMiniGame — рулетка
--   При ЧЕСТНОЙ победе игра вызывает нативную функцию завершения на параметре:
--     OnReceiveSuccessPicking()      — отмычка
--     OnReceiveGameSuccess()         — росчерк
--     OnReceiveMiniGameResult(true)  — рулетка (виджет до этого дёргает Model:SendResult(true))
--   Мы ловим старт мини-игры (NotifyOnNewObject на параметре + хук OnTriggerInteract),
--   ждём Config.DelayMs и вызываем ту же функцию завершения. Дальше игра САМА
--   закрывает UI и отпирает замок; вся цепочка видна в логах:
--     [hook] OnReceive* → [hook] OnMiniGameComplete → [hook] RequestMiniGameSuccess_ToServer
--
-- РЕЖИМЫ:
--   "autowin" — авто-победа (по умолчанию)
--   "observe" — только логи, ничего не вызываем (для честного прогона и снимка цепочки)
--   Переключение на лету — консоль UE4SS: `mgaw observe` / `mgaw autowin` (или `mgaw help`)
--
-- БЕЗОПАСНОСТЬ:
--   • вызываются только нативные UFunction через ProcessEvent — тот же механизм,
--     что в рабочих модах Relic Collector / PalWarp;
--   • никаких чтений по оффсетам / MemberVariableLayout / правки памяти;
--   • каждый шаг обёрнут в pcall — ошибка Lua не роняет игру;
--   • все хуки только ЛОГИРУЮТ, поведение игры не меняют;
--   • единственное активное действие — вызов функции завершения мини-игры.
--
-- УДАЛЕНИЕ: снести папку Mods/MinigameAutoWin (+ строку в mods.txt, если добавлял).
-- ============================================================================================

local TAG = "[MinigameAutoWin]"

-- ============================== НАСТРОЙКИ (правь тут) ==============================
local Config = {
    Mode            = "autowin", -- "autowin" | "observe"
    DelayMs         = 1200,      -- сколько мс держать мини-игру открытой перед победой
    Games           = { picking = true, gauge = true, onestroke = true },

    -- Рулетка: сначала "натуральный" путь (Model:SendResult(true) — ровно как виджет
    -- при удачной остановке), если ответа нет за GaugeFallbackMs — прямой
    -- OnReceiveMiniGameResult(true).
    GaugeNatural    = true,
    GaugeFallback   = true,
    GaugeFallbackMs = 2500,

    TryCloseUI      = true,      -- если через 900 мс после победы виджет ещё висит — попробовать Close()
    LogVerbose      = true,      -- подробные логи (модель рулетки, процессор, пак)
}
-- ====================================================================================

-- защита от повторного исполнения (hot reload / повторный require)
if rawget(_G, "MINIGAMEAUTOWIN_ACTIVE") then
    print(TAG .. " повторная загрузка скрипта — игнорирую (после правок main.lua перезапусти игру)\n")
    return
end
rawset(_G, "MINIGAMEAUTOWIN_ACTIVE", true)

-- ------------------------------- состояние -------------------------------
local S = {
    mode           = Config.Mode,
    lastParam      = nil,   -- последний dispatch-параметр мини-игры
    lastParamClass = nil,
    lastParamAt    = 0,
    lastScheduleAt = 0,     -- дедуп планирования победы
    stats = { minigames = 0, autowins = 0, interacts = 0, rpc = 0 },
}

local handledParams   = {}  -- param -> true (уже выигран этим модом)
local gaugeResultSeen = {}  -- param -> true (модель рулетки прислала ответ)
setmetatable(handledParams,   { __mode = "k" })
setmetatable(gaugeResultSeen, { __mode = "k" })

-- ------------------------------- утилиты -------------------------------
local function Log(msg)  print(TAG .. " " .. tostring(msg) .. "\n") end
local function Logf(fmt, ...) print(TAG .. " " .. string.format(fmt, ...) .. "\n") end

local function SafeCall(label, fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then Log("ОШИБКА[" .. tostring(label) .. "]: " .. tostring(err)) end
    return ok
end

local function nowMs()
    local ok, c = pcall(os.clock)
    return (ok and c) and math.floor(c * 1000) or 0
end

local function IsValidObj(o)
    if o == nil then return false end
    local ok, v = pcall(function() return o:IsValid() end)
    return ok and v == true
end

local function ObjName(o)
    if o == nil then return "nil" end
    local ok, n = pcall(function() return o:GetFullName() end)
    if ok and type(n) == "string" then return n end
    ok, n = pcall(function() return o:GetName() end)
    if ok and type(n) == "string" then return n end
    return tostring(o)
end

local function ClassName(o)
    if o == nil then return nil end
    local ok, cls = pcall(function() return o:GetClass() end)
    if not ok or cls == nil then return nil end
    local ok2, n = pcall(function() return cls:GetName() end)
    if ok2 and type(n) == "string" then return n end
    return nil
end

local function FmtArg(a)
    if a == nil then return "nil" end
    if type(a) == "userdata" then return "<" .. ObjName(a) .. ">" end
    local ok, s = pcall(tostring, a)
    return ok and s or ("?(" .. type(a) .. ")")
end

-- Отложенный запуск в игровом потоке (паттерн как в PalWarp)
local function ScheduleInGameThread(delayMs, label, fn)
    if type(ExecuteWithDelay) ~= "function" then
        Log("ExecuteWithDelay недоступен — выполняю сразу: " .. tostring(label))
        SafeCall(label, fn)
        return
    end
    ExecuteWithDelay(delayMs, function()
        local outer = function() SafeCall(label, fn) end
        if type(ExecuteInGameThread) == "function" then
            if pcall(ExecuteInGameThread, outer) then return end
        end
        outer()
    end)
end

-- ------------------------------- наши 3 игры -------------------------------
local GAMES = {
    ["PalHUDDispatchParameter_PickingMiniGame"] = {
        key = "picking", title = "Отмычка (Picking)",
        widget = "WBP_PickingGame02_ForDisplay_C",
    },
    ["PalHUDDispatchParameter_OneStrokeMiniGame"] = {
        key = "onestroke", title = "Росчерк (OneStroke)",
        widget = "WBP_OneStrokeGame_ForDisplay_C",
    },
    ["PalHUDDispatchParameter_GaugeStopMiniGame"] = {
        key = "gauge", title = "Рулетка (GaugeStop)",
        widget = "WBP_SalvageGame_GaugeStopMiniGame_C",
    },
}

-- ------------------------------- победа -------------------------------
local ScheduleGaugeFallback -- forward declaration

local function ExecuteWin(g, param)
    if g.key == "picking" then
        param:OnReceiveSuccessPicking()
        return "param:OnReceiveSuccessPicking()"
    elseif g.key == "onestroke" then
        param:OnReceiveGameSuccess()
        return "param:OnReceiveGameSuccess()"
    elseif g.key == "gauge" then
        local model = nil
        pcall(function() model = param.Model end)
        if Config.GaugeNatural and IsValidObj(model) then
            model:SendResult(true) -- ровно то, что делает виджет при удачной остановке
            if Config.GaugeFallback then ScheduleGaugeFallback(param) end
            return "param.Model:SendResult(true)"
        end
        param:OnReceiveMiniGameResult(true)
        return "param:OnReceiveMiniGameResult(true)"
    end
    return nil
end

ScheduleGaugeFallback = function(param)
    local ms = Config.GaugeFallbackMs
    ScheduleInGameThread(ms, "gauge-fallback", function()
        if not IsValidObj(param) then return end
        if gaugeResultSeen[param] then
            Log("рулетка: ответ модели получен — fallback не нужен")
            return
        end
        Log("рулетка: ответа от SendResult нет за " .. ms .. " мс → OnReceiveMiniGameResult(true) напрямую")
        pcall(function() param:OnReceiveMiniGameResult(true) end)
    end)
end

-- ------------------------------- UI после победы -------------------------------
local function WidgetVisible(w)
    -- пробуем известные геттеры видимости UUserWidget
    for _, fname in ipairs({ "GetIsVisible", "IsVisible", "IsInViewport" }) do
        local ok, v = pcall(function() return w[fname](w) end)
        if ok and type(v) == "boolean" then return v, fname end
    end
    return nil, nil
end

local function ScheduleCloseCheck(g)
    if not Config.TryCloseUI then return end
    ScheduleInGameThread(Config.DelayMs + 900, "close-check:" .. g.key, function()
        local ok, w = pcall(FindFirstOf, g.widget)
        if not ok or not IsValidObj(w) then
            Log("UI: виджет " .. g.widget .. " не найден — игра закрыла сама ОК")
            return
        end
        local vis, how = WidgetVisible(w)
        if vis == false then
            Log("UI: виджет скрыт (" .. tostring(how) .. ") — игра закрыла сама ОК")
        elseif vis == true then
            Log("UI: виджет ещё виден → пробую Close()")
            pcall(function() w:Close() end)
        else
            Log("UI: видимость проверить не удалось → пробую Close() на всякий случай")
            pcall(function() w:Close() end)
        end
    end)
end

-- ------------------------------- триггер победы -------------------------------
local function TryWinNow(sourceDesc, resolveParam)
    -- resolveParam() -> параметр мини-игры (вызывается в игровом потоке в момент победы)
    if S.mode ~= "autowin" then
        Logf("(%s) режим observe — авто-победу не дёргаю (включить: консоль `mgaw autowin`)", sourceDesc)
        return
    end
    local t = nowMs()
    if (t - S.lastScheduleAt) < 2500 then
        Logf("(%s) дедуп: победа только что запланирована — пропуск", sourceDesc)
        return
    end
    S.lastScheduleAt = t
    Logf("(%s) мини-игра открыта → авто-победа через %d мс...", sourceDesc, Config.DelayMs)

    ScheduleInGameThread(Config.DelayMs, "autowin", function()
        if S.mode ~= "autowin" then
            Log("за время задержки выключили autowin — отменяю")
            return
        end
        local param = nil
        SafeCall("resolve-param", function() param = resolveParam() end)
        if not IsValidObj(param) then
            Log("параметр мини-игры не найден/мертв — авто-победа отменена (погоняй observe и пришли лог)")
            return
        end
        if handledParams[param] then
            Log("этот параметр уже выигран — пропуск (двойной триггер, это нормально)")
            return
        end
        local cls = ClassName(param)
        local g = cls and GAMES[cls] or nil
        if not g then
            Log("параметр не нашей игры: " .. tostring(cls) .. " — пропуск")
            return
        end
        if not Config.Games[g.key] then
            Log(g.title .. " выключена в конфиге (включить: mgaw " .. g.key .. " on)")
            return
        end
        handledParams[param] = true
        local how = nil
        local ok = SafeCall("win:" .. g.key, function() how = ExecuteWin(g, param) end)
        if ok then
            S.stats.autowins = S.stats.autowins + 1
            Logf(">>> АВТО-ПОБЕДА: %s через %s — ниже должна пройти цепочка [hook]-ов", g.title, tostring(how))
            ScheduleCloseCheck(g)
        end
    end)
end

-- ------------------------------- детекторы старта -------------------------------
local function OnNewParam(param)
    SafeCall("on-new-param", function()
        -- защита от Default__-объектов (CDO), если класс сконструировался уже после загрузки мода
        local full = ObjName(param)
        if full:find("Default__", 1, true) then return end
        local cls = ClassName(param) or "?"
        S.lastParam, S.lastParamClass, S.lastParamAt = param, cls, nowMs()
        S.stats.minigames = S.stats.minigames + 1

        local packName = "нет"
        pcall(function()
            local pack = param.MiniGamePack
            if IsValidObj(pack) then packName = ClassName(pack) .. " (" .. ObjName(pack) .. ")" end
        end)

        local g = GAMES[cls]
        Logf("-- мини-игра началась: %s | pack: %s", cls, packName)

        if g and Config.LogVerbose then
            if g.key == "gauge" then
                pcall(function()
                    local m = param.Model
                    if IsValidObj(m) then
                        Logf("   модель рулетки: Start=%s End=%s Range=%s CursorSpeed=%s",
                            tostring(m.GaugeStart), tostring(m.GaugeEnd),
                            tostring(m.GaugeRange), tostring(m.CursorSpeed))
                    else
                        Log("   модель рулетки: param.Model пуст")
                    end
                end)
            else
                pcall(function()
                    local p = param.Processor
                    if IsValidObj(p) then Log("   процессор: " .. ClassName(p) .. " (" .. ObjName(p) .. ")") end
                end)
            end
        end

        if g then
            TryWinNow("notify", function() return param end)
        else
            Log("   -> вне наших 3 игр (только наблюдение)")
        end
    end)
end

local function OnInteract(levelObj)
    -- хук срабатывает ДО создания параметра — сам параметр ищем в момент победы
    local interactAt = nowMs()
    S.stats.interacts = S.stats.interacts + 1
    TryWinNow("interact", function()
        -- 1) параметр, созданный после нажатия F
        if IsValidObj(S.lastParam) and S.lastParamAt >= (interactAt - 100) then
            return S.lastParam
        end
        -- 2) текущий параметр этого замка
        if IsValidObj(levelObj) then
            local ok, p = pcall(function() return levelObj.CurrentParameter end)
            if ok and IsValidObj(p) then return p end
        end
        -- 3) последний известный параметр
        if IsValidObj(S.lastParam) then return S.lastParam end
        return nil
    end)
end

-- ------------------------------- observe-хуки (только лог) -------------------------------
local HOOKS = {
    { path = "/Script/Pal.PalHUDDispatchParameter_PickingMiniGame:OnReceiveSuccessPicking",   label = "ОТМЫЧКА: успех" },
    { path = "/Script/Pal.PalHUDDispatchParameter_PickingMiniGame:OnReceiveFailPicking",      label = "ОТМЫЧКА: провал" },
    { path = "/Script/Pal.PalHUDDispatchParameter_OneStrokeMiniGame:OnReceiveGameSuccess",    label = "РОСЧЕРК: успех" },
    { path = "/Script/Pal.PalHUDDispatchParameter_OneStrokeMiniGame:OnReceiveGameFail",       label = "РОСЧЕРК: провал" },
    { path = "/Script/Pal.PalHUDDispatchParameter_GaugeStopMiniGame:OnReceiveMiniGameResult", label = "РУЛЕТКА: результат" },
    { path = "/Script/Pal.PalLevelObject_LockGimmickMiniGame:OnMiniGameComplete",             label = "ЗАМОК: OnMiniGameComplete" },
    { path = "/Script/Pal.PalLevelObject_LockGimmickMiniGame:OnTriggerInteract",              label = "ЗАМОК: F-нажатие", interact = true },
    { path = "/Script/Pal.PalNetworkPlayerComponent:RequestMiniGameSuccess_ToServer",         label = "RPC: успех на сервер" },
}

local hookRegistered = {}

local function OnHook(d, context, ...)
    local args = { ... }
    SafeCall("hook:" .. d.label, function()
        if d.interact then
            Logf("[hook] %s | замок=%s", d.label, ObjName(context))
            OnInteract(context)
            return
        end
        if d.label == "RPC: успех на сервер" then S.stats.rpc = S.stats.rpc + 1 end
        if d.label == "РУЛЕТКА: результат" and args[1] == true and IsValidObj(context) then
            gaugeResultSeen[context] = true
        end
        local extra = ""
        for i = 1, math.min(#args, 3) do
            extra = extra .. " arg" .. i .. "=" .. FmtArg(args[i])
        end
        if d.label == "ЗАМОК: OnMiniGameComplete" and IsValidObj(args[1]) then
            local okS, bS = pcall(function() return args[1].bMiniGameSuccess end)
            if okS then extra = extra .. " bMiniGameSuccess=" .. tostring(bS) end
        end
        Logf("[hook] %s | self=%s%s", d.label, ObjName(context), extra)
    end)
end

-- ------------------------------- консольные команды -------------------------------
local function PrintStatus()
    Log("=== статус ===")
    Logf("режим: %s  (mgaw observe / mgaw autowin)", tostring(S.mode))
    Logf("задержка: %d мс  (mgaw delay <мс>)", Config.DelayMs)
    Logf("игры: picking=%s gauge=%s onestroke=%s",
        tostring(Config.Games.picking), tostring(Config.Games.gauge), tostring(Config.Games.onestroke))
    Logf("статистика: стартов мини-игр=%d, F-нажатий=%d, авто-побед=%d, RPC-успехов замечено=%d",
        S.stats.minigames, S.stats.interacts, S.stats.autowins, S.stats.rpc)
    if IsValidObj(S.lastParam) then
        Logf("последний параметр: %s (%.1f сек назад)",
            tostring(S.lastParamClass), (nowMs() - S.lastParamAt) / 1000)
    else
        Log("последний параметр: нет (мини-игры ещё не было)")
    end
end

local function ParseOnOff(v)
    if v == nil then return true end
    local s = tostring(v):lower()
    if s == "1" or s == "true" or s == "on" or s == "yes" then return true end
    return false
end

local function ManualWin()
    if not IsValidObj(S.lastParam) then
        Log("mgaw win: параметра ещё нет — сначала открой мини-игру")
        return
    end
    local param = S.lastParam
    local cls = ClassName(param) or "?"
    local g = GAMES[cls]
    if not g then
        Log("mgaw win: последний параметр не нашей игры: " .. cls)
        return
    end
    if handledParams[param] then
        Log("mgaw win: этот параметр уже выигран")
        return
    end
    handledParams[param] = true
    local how = nil
    local ok = SafeCall("manual-win", function() how = ExecuteWin(g, param) end)
    if ok then
        S.stats.autowins = S.stats.autowins + 1
        Logf(">>> РУЧНАЯ ПОБЕДА (%s) через %s", g.title, tostring(how))
        ScheduleCloseCheck(g)
    end
end

local cmdHandler = function(fullCmd, params)
    SafeCall("cmd:mgaw", function()
        local sub = (params and params[1] and tostring(params[1]):lower()) or "status"
        if sub == "status" then
            PrintStatus()
        elseif sub == "observe" then
            S.mode = "observe"; Log("режим -> OBSERVE (только логи)")
        elseif sub == "autowin" then
            S.mode = "autowin"; Log("режим -> AUTOWIN (авто-победа)")
        elseif sub == "win" then
            ManualWin()
        elseif sub == "delay" then
            local v = tonumber(params and params[2])
            if v and v >= 100 then
                Config.DelayMs = math.floor(v)
                Logf("DelayMs = %d", Config.DelayMs)
            else
                Log("формат: mgaw delay 2000")
            end
        elseif Config.Games[sub] ~= nil then
            local on = ParseOnOff(params and params[2])
            Config.Games[sub] = on
            Logf("игра '%s' -> %s", sub, tostring(on))
        elseif sub == "help" then
            Log("команды: mgaw status | observe | autowin | win | delay <мс> | picking on/off | gauge on/off | onestroke on/off")
        else
            Log("неизвестная подкоманда '" .. tostring(sub) .. "' — mgaw help")
        end
    end)
    return true
end

local okCmd = pcall(RegisterConsoleCommandHandler, "mgaw", cmdHandler)
if okCmd then
    Log("консольная команда `mgaw help` доступна в консоли UE4SS")
else
    Log("RegisterConsoleCommandHandler недоступен — управление только через правку Config")
end

-- ------------------------------- регистрация с ретраями -------------------------------
-- (в момент загрузки мода часть Pal-классов может быть ещё не готова — пробуем до 20 раз)
local notifyOk = false
local notifyShortTried = false

local function RegisterNotify(useShortName)
    if notifyOk then return true end
    local clsName = useShortName
        and "PalHUDDispatchParameter_LockGimmickMiniGame"
        or  "/Script/Pal.PalHUDDispatchParameter_LockGimmickMiniGame"
    local ok = pcall(NotifyOnNewObject, clsName, function(param) OnNewParam(param) end)
    if ok then
        notifyOk = true
        Log("NotifyOnNewObject зарегистрирован: " .. clsName)
    end
    return ok
end

local initAttempts = 0
local function TryInit()
    initAttempts = initAttempts + 1
    local allHooks = true
    for i, d in ipairs(HOOKS) do
        if not hookRegistered[i] then
            local ok = pcall(RegisterHook, d.path, function(context, ...) OnHook(d, context, ...) end)
            if ok then
                hookRegistered[i] = true
                Log("хук ОК: " .. d.label)
            else
                allHooks = false
            end
        end
    end
    local okNotify = RegisterNotify(false)
    if not okNotify and initAttempts >= 5 and not notifyShortTried then
        notifyShortTried = true
        RegisterNotify(true) -- пробуем короткое имя класса
    end

    if allHooks and okNotify then
        Logf("все регистрации завершены (попытка %d) — мод готов", initAttempts)
        return
    end
    if initAttempts >= 20 then
        Log("ВНИМАНИЕ: не всё зарегистрировалось за 20 попыток — работают только хуки со строкой 'хук ОК' выше")
        return
    end
    if type(ExecuteWithDelay) == "function" then
        ExecuteWithDelay(3000, TryInit)
    end
end

-- ------------------------------- старт -------------------------------
Log("=== MinigameAutoWin v0.1 (тест) загружен ===")
Logf("режим: %s | задержка: %d мс | игры: picking/gauge/onestroke = %s/%s/%s",
    tostring(S.mode), Config.DelayMs,
    tostring(Config.Games.picking), tostring(Config.Games.gauge), tostring(Config.Games.onestroke))
Log("как тестировать: открой любую из 3 мини-игр (F на замке). Логи — здесь, в консоли UE4SS.")
Log("команды: mgaw status | mgaw observe | mgaw autowin | mgaw win | mgaw help")

TryInit()
