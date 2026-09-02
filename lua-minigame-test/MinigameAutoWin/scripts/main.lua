-- ============================================================================================
-- MinigameAutoWin v0.3 — ТЕСТОВЫЙ мод (UE4SS Lua) для Palworld
-- Авто-победа мини-игр: Отмычка (Picking) / Рулетка-датчик (GaugeStop) / Росчерк (OneStroke)
--
-- ИСТОРИЯ ВЕРСИЙ:
--   v0.2 — FIX: объекты из колбэков хуков/NotifyOnNewObject приходят обёрнутыми в
--          RemoteUnrealParam — теперь разворачиваются через :get() (паттерн PalWarp).
--          Классификация параметра — 4 уровня: GetClass → имя объекта → проба членов →
--          проба вызова. Дедуп победы — по полному имени объекта (не по identity).
--          Добавлена диагностика в лог, если параметр не опознан.
--   v0.1 — первая версия.
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

    -- Если класс параметра не опознался — пробуем вызвать функции завершения по очереди
    -- (каждая существует только у своего класса; несуществующая даёт ошибку Lua в pcall)
    ProbeWinWhenUnknown = true,

    -- Если после победы мини-игра не завершилась сама (OnMiniGameComplete не пришёл за
    -- CloseCheckMs) — принудительно закрываем виджет (эквивалент ESC). Завершение
    -- (OnMiniGameComplete → RPC → замок открывается) в этой игре срабатывает именно
    -- при закрытии виджета — это делал ESC во втором тесте.
    CloseIfHanging   = true,
    CloseCheckMs     = 2200,  -- ожидание после победы (поверх DelayMs), мс
    EscalateCloseAll = true,  -- если Close() не завершил — PalHUDService:CloseOverlayUIAll()

    LogVerbose      = true,      -- подробные логи (модель рулетки, процессор, пак)
}
-- ====================================================================================

-- защита от повторного исполнения (hot reload / повторный require)
if rawget(_G, "MINIGAMEAUTOWIN_ACTIVE") then
    print(TAG .. " повторная загрузка скрипта — игнорирую (после правок main.lua перезапусти игру)\n")
    return
end
rawset(_G, "MINIGAMEAUTOWIN_ACTIVE", true)

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

local function GameByKey(key)
    for _, g in pairs(GAMES) do
        if g.key == key then return g end
    end
    return nil
end

-- ------------------------------- состояние -------------------------------
local S = {
    mode           = Config.Mode,
    lastParam      = nil,   -- последний dispatch-параметр мини-игры (развёрнутый)
    lastParamClass = nil,
    lastParamAt    = 0,
    lastScheduleAt = 0,     -- дедуп планирования победы
    stats = { minigames = 0, autowins = 0, interacts = 0, rpc = 0 },
}

-- дедуп по ПОЛНОМУ ИМЕНИ объекта (identity userdata ненадёжен — обёртки каждый раз новые)
local handledNames       = {}  -- "полное имя параметра" -> true (уже выигран)
local gaugeResultNames   = {}  -- "полное имя параметра" -> true (модель рулетки прислала ответ)

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

-- есть ли у объекта метод (точный паттерн из PalWarp)
local function hasMethod(obj, name)
    local res = false
    pcall(function() res = (type(obj[name]) == "function") end)
    return res
end

-- Разворачивание RemoteUnrealParam → настоящий UObject/значение.
-- В колбэках хуков и NotifyOnNewObject объекты приходят обёрнутыми; у обёртки есть :get().
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

local function SafeText(v)
    v = Unwrap(v)
    if v == nil then return "nil" end
    local ok, s = pcall(tostring, v)
    return ok and s or "?"
end

local function FmtArg(a)
    a = Unwrap(a)
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

-- есть ли у объекта член с таким именем (без вызова)
local function ProbeMember(o, name)
    o = Unwrap(o)
    if o == nil then return false end
    local res = false
    pcall(function() res = (o[name] ~= nil) end)
    return res
end

-- ------------------------------- классификация параметра (4 уровня) -------------------------------
-- 1) GetClass():GetName()  2) имя объекта (инстанс назван как класс)  3) проба членов  4) проба вызова (в ExecuteWinByProbe)
local function ClassifyParam(rawParam)
    local param = Unwrap(rawParam)
    if not IsValidObj(param) then return nil, param end

    -- уровень 1: честный класс
    local cls = ClassName(param)
    if cls and GAMES[cls] then return cls, param end

    -- уровень 2: имя объекта содержит имя класса (инстанс = "ИмяКласса_N")
    local okF, fn = pcall(function() return param:GetFullName() end)
    if okF and type(fn) == "string" then
        local own = fn:match("([%w_]+)$") or fn
        for cname in pairs(GAMES) do
            if own:find(cname, 1, true) then return cname, param end
        end
    end

    -- уровень 3: уникальные члены (функции завершения существуют только у своего класса)
    if ProbeMember(param, "OnReceiveSuccessPicking") then return "PalHUDDispatchParameter_PickingMiniGame", param end
    if ProbeMember(param, "OnReceiveGameSuccess")    then return "PalHUDDispatchParameter_OneStrokeMiniGame", param end
    if ProbeMember(param, "OnReceiveMiniGameResult") then return "PalHUDDispatchParameter_GaugeStopMiniGame", param end

    return cls, param
end

local diagDone = false
local function DumpParamDiagnostics(param)
    if diagDone then return end
    diagDone = true
    Log("ДИАГНОСТИКА параметра (один раз за сессию; пришли этот блок в чат):")
    local function probe(label, fn)
        local ok, v = pcall(fn)
        local shown
        if not ok then shown = "ОШИБКА"
        elseif type(v) == "string" then shown = v
        else shown = type(v) end
        Logf("   %-32s => %s", label, shown)
    end
    probe("param имеет :get()",        function() return hasMethod(param, "get") and "да (обёртка)" or "нет" end)
    probe("param:GetClass():GetName()", function() return (Unwrap(param)):GetClass():GetName() end)
    probe("param:GetName()",           function() return (Unwrap(param)):GetName() end)
    probe("param:GetFullName()",       function() return (Unwrap(param)):GetFullName() end)
    probe("param:IsValid()",           function() return tostring((Unwrap(param)):IsValid()) end)
    probe("param[OnReceiveSuccessPicking]", function() return tostring((Unwrap(param))["OnReceiveSuccessPicking"]) end)
    probe("param[OnReceiveGameSuccess]",    function() return tostring((Unwrap(param))["OnReceiveGameSuccess"]) end)
    probe("param[OnReceiveMiniGameResult]", function() return tostring((Unwrap(param))["OnReceiveMiniGameResult"]) end)
    probe("param.MiniGamePack",        function() return tostring((Unwrap(param)).MiniGamePack) end)
end

-- ------------------------------- победа -------------------------------
local ScheduleGaugeFallback -- forward declaration

local function ExecuteWin(g, rawParam)
    local param = Unwrap(rawParam)
    if g.key == "picking" then
        param:OnReceiveSuccessPicking()
        return "param:OnReceiveSuccessPicking()"
    elseif g.key == "onestroke" then
        param:OnReceiveGameSuccess()
        return "param:OnReceiveGameSuccess()"
    elseif g.key == "gauge" then
        local model = nil
        pcall(function() model = Unwrap(param.Model) end)
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

ScheduleGaugeFallback = function(rawParam)
    local ms = Config.GaugeFallbackMs
    ScheduleInGameThread(ms, "gauge-fallback", function()
        local param = Unwrap(rawParam)
        if not IsValidObj(param) then return end
        if gaugeResultNames[ObjName(param)] then
            Log("рулетка: ответ модели получен — fallback не нужен")
            return
        end
        Log("рулетка: ответа от SendResult нет за " .. ms .. " мс → OnReceiveMiniGameResult(true) напрямую")
        pcall(function() param:OnReceiveMiniGameResult(true) end)
    end)
end

-- последний рубеж: класс не опознан — пробуем функции завершения по очереди.
-- Несуществующая у данного класса функция даёт ошибку Lua (ловится pcall), нативно ничего не зовётся.
local function ExecuteWinByProbe(rawParam)
    local param = Unwrap(rawParam)
    local attempts = {}
    if Config.Games.picking then
        attempts[#attempts + 1] = { "picking", function()
            param:OnReceiveSuccessPicking()
            return "probe: OnReceiveSuccessPicking()"
        end }
    end
    if Config.Games.onestroke then
        attempts[#attempts + 1] = { "onestroke", function()
            param:OnReceiveGameSuccess()
            return "probe: OnReceiveGameSuccess()"
        end }
    end
    if Config.Games.gauge then
        attempts[#attempts + 1] = { "gauge", function()
            return ExecuteWin(GameByKey("gauge"), param)
        end }
    end
    for _, a in ipairs(attempts) do
        local ok, how = pcall(a[2])
        if ok then
            local g = GameByKey(a[1])
            -- (для рулетки fallback уже запланирован внутри ExecuteWin при натуральном пути)
            return a[1], how, g
        end
    end
    return nil, nil, nil
end

-- ------------------------------- UI после победы -------------------------------
local function WidgetVisible(w)
    -- информационно: видимость конкретного инстанса (в лог)
    for _, fname in ipairs({ "GetIsVisible", "IsVisible", "IsInViewport" }) do
        local ok, v = pcall(function() return w[fname](w) end)
        if ok and type(v) == "boolean" then return v, fname end
    end
    return nil, nil
end

-- все живые инстансы класса, КРОМЕ CDO (Default__...) — FindFirstOf берёт CDO первым!
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

-- Если после победы мини-игра не завершилась сама (OnMiniGameComplete не пришёл) —
-- принудительно закрываем виджет. Именно закрытие виджета (что делал ESC) запускает
-- OnMiniGameComplete → RequestMiniGameSuccess_ToServer → замок открывается.
local function SchedulePostWinClose(g, paramName)
    if not Config.CloseIfHanging then return end

    -- проверка 1: может, игра сама доиграла успех (анимация → закрытие)?
    ScheduleInGameThread(Config.DelayMs + Config.CloseCheckMs, "close-if-hanging:" .. g.key, function()
        if completedNames[paramName] then
            Log("UI: игра сама завершила и закрыла мини-игру — ОК")
            return
        end
        local inst = FindInstancesOf(g.widget)
        if #inst == 0 then
            Log("UI: живых инстансов виджета нет, но завершение не замечено — ждём (ESC, если висит ввод)")
            return
        end
        for _, w in ipairs(inst) do
            local vis, how = WidgetVisible(w)
            Logf("UI: виджет висит (%s | visible=%s/%s) → Close()", ObjName(w), tostring(vis), tostring(how))
            pcall(function() w:Close() end)
        end

        -- проверка 2: Close() завершил мини-игру?
        ScheduleInGameThread(1000, "close-check2:" .. g.key, function()
            if completedNames[paramName] then
                Log("UI: Close() сработал — мини-игра завершена, замок должен открыться")
                return
            end
            if not Config.EscalateCloseAll then
                Log("UI: Close() не завершил — эскалация выключена (нажми ESC и пришли лог)")
                return
            end
            Log("UI: Close() не завершил → PalHUDService:CloseOverlayUIAll()")
            local svc = FindInstancesOf("PalHUDService")
            if #svc == 0 then
                Log("UI: PalHUDService не найден — эскалация невозможна (нажми ESC и пришли лог)")
                return
            end
            for _, s in ipairs(svc) do
                pcall(function() s:CloseOverlayUIAll() end)
            end

            -- проверка 3: последняя
            ScheduleInGameThread(1200, "close-check3:" .. g.key, function()
                if completedNames[paramName] then
                    Log("UI: CloseOverlayUIAll() завершил мини-игру")
                else
                    Log("UI: автоматически завершить не удалось — нажми ESC и пришли этот кусок лога")
                end
            end)
        end)
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
        SafeCall("resolve-param", function() param = Unwrap(resolveParam()) end)
        if not IsValidObj(param) then
            Log("параметр мини-игры не найден/мертв — авто-победа отменена (погоняй observe и пришли лог)")
            return
        end
        local name = ObjName(param)
        if handledNames[name] then
            Log("этот параметр уже выигран — пропуск (двойной триггер, это нормально)")
            return
        end
        local cls, p2 = ClassifyParam(param)
        param = p2
        local g = cls and GAMES[cls] or nil
        if not g then
            -- класс не опознан — последний рубеж: пробуем по очереди
            if Config.ProbeWinWhenUnknown then
                local key, how, gg = ExecuteWinByProbe(param)
                if key then
                    handledNames[name] = true
                    S.stats.autowins = S.stats.autowins + 1
                    Logf(">>> АВТО-ПОБЕДА (probe, класс не опознан): %s через %s", key, tostring(how))
                    if gg then SchedulePostWinClose(gg, name) end
                    return
                end
            end
            Log("параметр не опознан (" .. name .. ") — победа не дёргана")
            DumpParamDiagnostics(param)
            return
        end
        if not Config.Games[g.key] then
            Log(g.title .. " выключена в конфиге (включить: mgaw " .. g.key .. " on)")
            return
        end
        handledNames[name] = true
        local how = nil
        local ok = SafeCall("win:" .. g.key, function() how = ExecuteWin(g, param) end)
        if ok then
            S.stats.autowins = S.stats.autowins + 1
            Logf(">>> АВТО-ПОБЕДА: %s через %s — ниже должна пройти цепочка [hook]-ов", g.title, tostring(how))
            SchedulePostWinClose(g, name)
        end
    end)
end

-- ------------------------------- детекторы старта -------------------------------
local function OnNewParam(rawParam)
    SafeCall("on-new-param", function()
        local param = Unwrap(rawParam)
        if not IsValidObj(param) then return end

        -- защита от Default__-объектов (CDO)
        local full = ObjName(param)
        if full:find("Default__", 1, true) then return end

        local cls, p2 = ClassifyParam(param)
        param = p2
        S.lastParam, S.lastParamClass, S.lastParamAt = param, cls or "?", nowMs()
        S.stats.minigames = S.stats.minigames + 1

        local g = cls and GAMES[cls] or nil
        Logf("-- мини-игра началась: %s | объект: %s", tostring(cls), full)

        if g and Config.LogVerbose then
            if g.key == "gauge" then
                pcall(function()
                    local m = Unwrap(param.Model)
                    if IsValidObj(m) then
                        Logf("   модель рулетки: Start=%s End=%s Range=%s CursorSpeed=%s",
                            SafeText(m.GaugeStart), SafeText(m.GaugeEnd),
                            SafeText(m.GaugeRange), SafeText(m.CursorSpeed))
                    else
                        Log("   модель рулетки: param.Model пуст на старте (обычно заполняется чуть позже — проверим в момент победы)")
                    end
                end)
            else
                pcall(function()
                    local p = Unwrap(param.Processor)
                    if IsValidObj(p) then
                        local pk = "нет"
                        pcall(function()
                            local pack = Unwrap(param.MiniGamePack)
                            if IsValidObj(pack) then pk = ObjName(pack) end
                        end)
                        Log("   процессор: " .. ObjName(p) .. " | pack: " .. pk)
                    end
                end)
            end
        end

        if g then
            TryWinNow("notify", function() return param end)
        else
            Log("   -> класс не опознан (только наблюдение; в autowin сработает проба вызова)")
            DumpParamDiagnostics(param)
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
            if ok then
                p = Unwrap(p)
                if IsValidObj(p) then return p end
            end
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

local function OnHook(d, rawContext, ...)
    -- объекты из хука приходят обёрнутыми в RemoteUnrealParam — разворачиваем
    local context = Unwrap(rawContext)
    local args = {}
    for i = 1, select("#", ...) do args[i] = Unwrap(select(i, ...)) end

    SafeCall("hook:" .. d.label, function()
        if d.interact then
            Logf("[hook] %s | замок=%s", d.label, ObjName(context))
            OnInteract(context)
            return
        end
        if d.label == "RPC: успех на сервер" then S.stats.rpc = S.stats.rpc + 1 end
        if d.label == "РУЛЕТКА: результат" and args[1] == true and IsValidObj(context) then
            gaugeResultNames[ObjName(context)] = true
        end
        local extra = ""
        for i = 1, math.min(#args, 3) do
            extra = extra .. " arg" .. i .. "=" .. FmtArg(args[i])
        end
        if d.label == "ЗАМОК: OnMiniGameComplete" then
            S.stats.completes = S.stats.completes + 1
            if IsValidObj(args[1]) then
                completedNames[ObjName(args[1])] = true
                local okS, bS = pcall(function() return (Unwrap(args[1])).bMiniGameSuccess end)
                if okS then extra = extra .. " bMiniGameSuccess=" .. SafeText(bS) end
            end
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
    Logf("статистика: стартов мини-игр=%d, F-нажатий=%d, авто-побед=%d, завершений=%d, RPC-успехов=%d",
        S.stats.minigames, S.stats.interacts, S.stats.autowins, S.stats.completes, S.stats.rpc)
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
    local param = Unwrap(S.lastParam)
    local name = ObjName(param)
    if handledNames[name] then
        Log("mgaw win: этот параметр уже выигран")
        return
    end
    local cls, p2 = ClassifyParam(param)
    param = p2
    local g = cls and GAMES[cls] or nil
    local how = nil
    if g and not Config.Games[g.key] then
        Log("mgaw win: " .. g.title .. " выключена в конфиге — всё равно дёргаю (ручной режим)")
    end
    local ok
    if g then
        ok = SafeCall("manual-win", function() how = ExecuteWin(g, param) end)
    else
        local key
        ok, key, how = true, nil, nil
        SafeCall("manual-win-probe", function()
            key, how, g = ExecuteWinByProbe(param)
        end)
        if not key then
            Log("mgaw win: параметр не опознан и пробы не сработали")
            DumpParamDiagnostics(param)
            return
        end
        Log("mgaw win: класс не опознан, сработала проба: " .. tostring(key))
    end
    if ok then
        handledNames[name] = true
        S.stats.autowins = S.stats.autowins + 1
        Logf(">>> РУЧНАЯ ПОБЕДА через %s", tostring(how))
        if g then SchedulePostWinClose(g, name) end
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
Log("=== MinigameAutoWin v0.3 (тест) загружен ===")
Logf("режим: %s | задержка: %d мс | игры: picking/gauge/onestroke = %s/%s/%s",
    tostring(S.mode), Config.DelayMs,
    tostring(Config.Games.picking), tostring(Config.Games.gauge), tostring(Config.Games.onestroke))
Log("как тестировать: открой любую из 3 мини-игр (F на замке). Логи — здесь, в консоли UE4SS.")
Log("команды: mgaw status | mgaw observe | mgaw autowin | mgaw win | mgaw help")

TryInit()
