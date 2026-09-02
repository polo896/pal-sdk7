-- ============================================================================================
-- ExpeditionHubTest v0.2 — ТЕСТОВЫЙ мод-пробник (UE4SS Lua) для Palworld 0.4.11
-- СИСТЕМА ЭКСПЕДИЦИЙ: разведка перед чистым модом-менеджером. GUI на F6, только кнопки —
-- консоль НЕ нужна. Весь вывод проб печатается прямо в панель (и в лог UE4SS).
--
-- ЧТО ПРОВЕРЯЕМ (по итогам разведки SDK):
--   1. FindAllOf("PalMapObjectCharacterTeamMissionModel") находит ВСЕ станции со всех баз;
--   2. чтение состояния (Ready/InProgress/Reward), таймера, базы, сундука;
--   3. UI-модель через StaticConstructObject(класс, outer=станция): удалённый запуск
--      (RequestSelectMission / RequestSelectAuto / RequestStartMission);
--   4. сбор лута: RequestMoveItemToInventoryFromContainer(сундук, false) — та же кнопка
--      «забрать всё», что в игре;
--   5. фолбэк: ServerInternal-функции напрямую (синглплеер).
--
-- КАК ТЕСТИРОВАТЬ: F6 → панель. Сверху выбор станции (◀ ▶), ниже — её данные,
-- дальше кнопки проб. Жми по порядку: SCAN → INFO → UI-PROBE → MISSIONS → AUTO → START.
-- Когда экспедиция завершится: CHEST → COLLECT. Панель пишет всё сама.
--
-- БЕЗОПАСНОСТЬ (не повторяем краши чужого мода при перезаходе):
--   • только нативные UFunction через ProcessEvent; каждое действие в pcall;
--   • между действиями мод ничего не хранит: станции ищутся заново каждый раз;
--   • UI-модель живёт ровно одно действие: RequestStartReplication → действие →
--     RequestStopReplication → ссылка отброшена (делегаты не висят);
--   • панель пересоздаётся при каждом открытии и закрывается при смене мира
--     (хук OnInitializeLocalPlayer_BP + спавн персонажа).
--
-- УДАЛЕНИЕ: снести папку Mods/ExpeditionHubTest.
-- ============================================================================================

local TAG = "[ExpeditionHub]"

-- ============================== НАСТРОЙКИ (правь тут) ==============================
local Config = {
    OpenKey     = "F6",   -- открыть/закрыть панель
    VerifyMs    = 500,    -- задержка проверки состояния после действия
    AutoStartMs = 400,    -- пауза между шагами цепочки select→auto→start
    RefreshMs   = 3000,   -- авто-обновление панели, пока открыта
    LogLines    = 11,     -- сколько строк лога видно в панели
    LogBuffer   = 100,    -- сколько строк храним всего
}

local STATE_NAMES = { [0] = "None", [1] = "Ready", [2] = "InProgress", [3] = "Reward" }
local DIFF_NAMES  = { [0] = "Easy", [1] = "Normal", [2] = "Hard", [3] = "VeryHard" }
local UI_MODEL_CLASS = "/Script/Pal.PalUIMapObjectCharacterTeamMissionModel"

-- ============================== СОСТОЯНИЕ МОДА ==============================
local S = {
    sel       = 1,     -- выбранная станция (индекс в FindStations)
    logLines  = {},    -- кольцевой буфер лога (строки)
    missions  = nil,   -- список миссий последнего MISSIONS: { {id=..., text=...}, ... }
}

-- ============================== ЛОГ ==============================
local function pushLog(line)
    S.logLines[#S.logLines + 1] = tostring(line)
    if #S.logLines > Config.LogBuffer then
        table.remove(S.logLines, 1)
    end
end

local function Log(msg)
    pushLog(msg)
    print(TAG .. " " .. tostring(msg) .. "\n")
end

local function Err(msg)
    pushLog("ОШИБКА: " .. tostring(msg))
    print(TAG .. " ERR: " .. tostring(msg) .. "\n")
end

local function Logf(fmt, ...)
    Log(string.format(fmt, ...))
end

-- ============================== БАЗОВЫЕ ХЕЛПЕРЫ ==============================
local function SafeDo(label, fn)
    if type(label) == "function" then
        local ok, res = pcall(label)
        if not ok then Err(tostring(res)) end
        return ok, res
    end
    local ok, res = pcall(fn)
    if not ok then Err(label .. " → " .. tostring(res)) end
    return ok, res
end

local function hasMethod(obj, name)
    local res = false
    pcall(function() res = (type(obj[name]) == "function") end)
    return res
end

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

local function Str(v)
    v = Unwrap(v)
    if v == nil then return nil end
    if type(v) == "string" then return v end
    if type(v) == "number" then return tostring(v) end
    local ok, s = pcall(function() return v:ToString() end)
    if ok and type(s) == "string" then return s end
    ok, s = pcall(function() return tostring(v) end)
    if ok and type(s) == "string" and not s:find("^userdata") then return s end
    return nil
end

local function Num(v)
    v = Unwrap(v)
    if type(v) == "number" then return v end
    if v == nil then return nil end
    local ok, n = pcall(function() return tonumber(v) end)
    if ok and type(n) == "number" then return n end
    ok, n = pcall(function() return tonumber(tostring(v)) end)
    if ok and type(n) == "number" then return n end
    return nil
end

-- чтение свойства объекта/структуры — всегда безопасно.
-- ВАЖНО: без проверки IsValid — она врёт на обёртках структур (FVector, FDateTime…);
-- TowerHunter читает поля структур напрямую (l.X + tonumber), так же делаем здесь.
local function ReadField(obj, name)
    if obj == nil then return nil end
    local ok, v = pcall(function() return obj[name] end)
    if not ok then return nil end
    return Unwrap(v)
end

local function TryLen(v)
    if v == nil then return nil end
    local ok, n = pcall(function() return #v end)
    if ok and type(n) == "number" then return n end
    ok, n = pcall(function() return v:Length() end)
    if ok and type(n) == "number" then return n end
    ok, n = pcall(function() return v:Num() end)
    if ok and type(n) == "number" then return n end
    ok, n = pcall(function() return v.Num() end)
    if ok and type(n) == "number" then return n end
    return nil
end

local function ArrAt(arr, i)
    local ok, v = pcall(function() return arr[i] end)
    if not ok then return nil end
    return Unwrap(v)
end

local function DelayCall(ms, fn)
    local ok, err = pcall(ExecuteWithDelay, ms, fn)
    if not ok then Err("ExecuteWithDelay → " .. tostring(err)) end
end

-- ============================== ПОИСК ОБЪЕКТОВ ==============================
local function FindStations()
    local found = {}
    SafeDo("FindAllOf(PalMapObjectCharacterTeamMissionModel)", function()
        local all = FindAllOf("PalMapObjectCharacterTeamMissionModel")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) then
                local fn = ObjName(mo)
                if not fn:find("Default__", 1, true) then
                    found[#found + 1] = mo
                end
            end
        end
    end)
    table.sort(found, function(a, b) return ObjName(a) < ObjName(b) end)
    return found
end

local function GetNetComp()
    local result = nil
    SafeDo("FindAllOf(PalNetworkPlayerComponent)", function()
        local all = FindAllOf("PalNetworkPlayerComponent")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) and not ObjName(mo):find("Default__", 1, true) then
                result = mo
                break
            end
        end
    end)
    return result
end

local function GetGuildMission()
    local result = nil
    SafeDo("FindAllOf(PalGuildCharacterTeamMission)", function()
        local all = FindAllOf("PalGuildCharacterTeamMission")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) and not ObjName(mo):find("Default__", 1, true) then
                result = mo
                break
            end
        end
    end)
    return result
end

-- ============================== ЧТЕНИЕ СОСТОЯНИЙ ==============================
local function GetState(st)
    local v = ReadField(st, "State")
    local n = Num(v)
    if n ~= nil then
        local i = math.floor(n)
        return i, (STATE_NAMES[i] or ("?" .. tostring(n)))
    end
    return nil, Str(v)
end

local function GetBaseName(st)
    local ok, bcm = pcall(function() return st:GetBaseCampModelBelongTo() end)
    if ok and bcm ~= nil then
        bcm = Unwrap(bcm)
        if IsValidObj(bcm) then
            local okN, name = pcall(function() return bcm:GetBaseCampName() end)
            if okN then
                local s = Str(name)
                if s and s ~= "" then return s end
            end
            return Str(ReadField(bcm, "BaseCampName")) or "?"
        end
    end
    return nil
end

local function GetLoc(st)
    local out = {}
    local ok = pcall(function() st:GetMapObjectLocation(out) end)
    if not ok then return nil end
    local v = Unwrap(out.outVector or out.OutVector or out[1])
    if v == nil then return nil end
    local x = Num(ReadField(v, "X"))
    local y = Num(ReadField(v, "Y"))
    if x == nil then return nil end
    return { x = x, y = y, z = Num(ReadField(v, "Z")) }
end

local function GetStationContainer(st)
    local ok, mod = pcall(function() return st:GetItemContainerModule() end)
    if not ok then return nil, "GetItemContainerModule → " .. tostring(mod) end
    mod = Unwrap(mod)
    if not IsValidObj(mod) then return nil, "item container module = nil/invalid" end

    local okC, cont = pcall(function() return mod:GetContainer() end)
    if okC and cont ~= nil then
        cont = Unwrap(cont)
        if IsValidObj(cont) then return cont end
    end

    local out = {}
    local okT = pcall(function() return mod:TryGetContainer(out) end)
    if okT then
        local c = Unwrap(out.OutContainer or out.outContainer or out[1])
        if IsValidObj(c) then return c end
    end
    return nil, "у станции нет контейнера (GetContainer/TryGetContainer пусты)"
end

-- сколько занято/всего слотов в сундуке
local function CountChest(cont)
    if not IsValidObj(cont) then return 0, 0 end
    local slots = ReadField(cont, "ItemSlotArray")
    local total = TryLen(slots)
    if not total then
        local n2 = nil
        pcall(function() n2 = Num(cont:Num()) end)
        total = n2 or 0
    end
    local used = 0
    for i = 1, total do
        local slot = ArrAt(slots, i)
        if IsValidObj(slot) then
            local empty = true
            pcall(function() empty = (slot:IsEmpty() == true) end)
            if not empty then used = used + 1 end
        end
    end
    return used, total
end

local function DumpContainer(label, cont)
    if not IsValidObj(cont) then
        Log(label .. ": контейнер невалиден")
        return
    end
    local slots = ReadField(cont, "ItemSlotArray")
    local len = TryLen(slots)
    if not len then
        local n2 = nil
        pcall(function() n2 = Num(cont:Num()) end)
        len = n2
    end
    if not len then
        Log(label .. ": длину ItemSlotArray не прочитать")
        return
    end
    local used = 0
    for i = 1, len do
        local slot = ArrAt(slots, i)
        if IsValidObj(slot) then
            local empty = true
            pcall(function() empty = (slot:IsEmpty() == true) end)
            if not empty then
                used = used + 1
                local itemId = ReadField(slot, "ItemId")
                local sid = itemId and Str(ReadField(itemId, "StaticId")) or "?"
                local cnt = Num(ReadField(slot, "StackCount"))
                Logf("%s: слот %d — %s x%s", label, i, tostring(sid), tostring(cnt))
            end
        end
    end
    if used == 0 then Log(label .. ": сундук ПУСТ (" .. tostring(len) .. " слотов)") end
end

local function TicksToUTC(ticks)
    if not ticks then return nil, nil end
    local secs = math.floor(ticks / 10000000)
    local epoch = secs - 62135596800
    return os.date("!%Y-%m-%d %H:%M:%S UTC", epoch), epoch
end

local function NowEpoch()
    return os.time(os.date("!*t"))
end

-- ============================== UI-МОДЕЛЬ (одно действие = одна жизнь) ==============================
local function CreateUIModel(st)
    local cls = StaticFindObject(UI_MODEL_CLASS)
    if not IsValidObj(cls) then return nil, "класс " .. UI_MODEL_CLASS .. " не найден" end
    local ok, ui = pcall(function() return StaticConstructObject(cls, st) end)
    if not ok then return nil, "StaticConstructObject → " .. tostring(ui) end
    ui = Unwrap(ui)
    if not IsValidObj(ui) then return nil, "StaticConstructObject вернул невалидный объект" end
    return ui
end

local function WithUIModel(st, useRep, fn)
    local ui, why = CreateUIModel(st)
    if not ui then
        Err("UI-модель не создана: " .. tostring(why))
        return
    end
    local bound = false
    if useRep then
        bound = SafeDo("RequestStartReplication", function() ui:RequestStartReplication() end)
        Log("RequestStartReplication: " .. ((bound and "ok") or "FAIL"))
    end
    local okr, res = pcall(fn, ui)
    if not okr then Err("действие UI-модели → " .. tostring(res)) end
    if bound then
        SafeDo("RequestStopReplication", function() ui:RequestStopReplication() end)
        Log("RequestStopReplication: ok (делегаты отвязаны)")
    end
end

local function ProbeUIModelReads(ui)
    local f = ReadField(ui, "Functions")
    Log("  Functions: " .. ((IsValidObj(f) and ObjName(f)) or "nil (пусто — нужен инжект из PalGameSetting)"))

    local out = {}
    local ok = pcall(function() ui:GetConcreteModelInstanceId(out) end)
    if ok then
        local parts = {}
        for k, v in pairs(out) do
            parts[#parts + 1] = tostring(k) .. "=" .. tostring(Str(v) or Num(v) or "?")
        end
        Log("  GetConcreteModelInstanceId: " .. table.concat(parts, ", "))
    else
        Log("  GetConcreteModelInstanceId: FAIL")
    end

    local okS, s = pcall(function() return ui:GetCurrentState() end)
    if okS then
        local n = Num(s)
        Log("  GetCurrentState: " .. ((n ~= nil and (STATE_NAMES[math.floor(n)] or tostring(n))) or tostring(Str(s))))
    else
        Log("  GetCurrentState: FAIL")
    end

    local okC, c = pcall(function() return ui:CanStartMission() end)
    Log("  CanStartMission: " .. ((okC and tostring(c == true)) or "FAIL"))

    local okR, r = pcall(function() return ui:GetRemainMissionSeconds() end)
    Log("  GetRemainMissionSeconds: " .. ((okR and tostring(Num(r))) or "FAIL"))
end

-- ============================== ДЕЙСТВИЯ (пробы) ==============================
local refreshIfOpen  -- назначается после сборки UI (перенаправляет в панель)

local function SelectedStation()
    local stations = FindStations()
    if #stations == 0 then return nil, 0 end
    if S.sel < 1 or S.sel > #stations then S.sel = 1 end
    return stations[S.sel], #stations
end

local function DoScan()
    local stations = FindStations()
    Logf("SCAN: станций экспедиций найдено: %d", #stations)
    for i, st in ipairs(stations) do
        local _, sname = GetState(st)
        local tmid = Str(ReadField(st, "TargetMissionId"))
        local base = GetBaseName(st) or "?"
        local loc = GetLoc(st)
        local locStr = loc and string.format("(%.0f, %.0f)", loc.x, loc.y) or "?"
        Logf("  [%d] %s | миссия=%s | база=%q | %s", i, tostring(sname), tostring(tmid), tostring(base), locStr)
    end
    local net = GetNetComp()
    Log("NetworkPlayerComponent: " .. ((net and "найден") or "НЕ НАЙДЕН"))
    if refreshIfOpen then refreshIfOpen() end
end

local function StationDetailLines()
    local st, total = SelectedStation()
    if not st then return { "СТАНЦИЙ НЕ НАЙДЕНО — построй станцию или проверь лог" }, 0 end
    local lines = {}
    local _, sname = GetState(st)
    lines[#lines + 1] = string.format("СОСТОЯНИЕ: %s     МИССИЯ: %s", tostring(sname), tostring(Str(ReadField(st, "TargetMissionId"))))
    local loc = GetLoc(st)
    local locStr = loc and string.format("     коорд: (%.0f, %.0f)", loc.x, loc.y) or ""
    lines[#lines + 1] = string.format("БАЗА: %s%s", tostring(GetBaseName(st) or "?"), locStr)
    local ai = ReadField(st, "AssignedInfo")
    local rep = ai and ReadField(ai, "RepInfoArray") or nil
    local items = rep and ReadField(rep, "Items") or nil
    lines[#lines + 1] = "НАЗНАЧЕНО ПАЛОВ: " .. tostring(items and TryLen(items) or nil)
    local endT = Num(ReadField(ReadField(st, "MissionCompleteDateTime"), "Ticks"))
    if endT then
        local s, e = TicksToUTC(endT)
        lines[#lines + 1] = string.format("ФИНИШ: %s     ОСТАЛОСЬ: %s сек", tostring(s), tostring(e and (e - NowEpoch()) or "?"))
    else
        lines[#lines + 1] = "ТАЙМЕР: нет (станция не в рейсе)"
    end
    local cont = GetStationContainer(st)
    if cont then
        local used, totalSlots = CountChest(cont)
        lines[#lines + 1] = string.format("СУНДУК: занято %s из %s слотов", tostring(used), tostring(totalSlots))
    else
        lines[#lines + 1] = "СУНДУК: не найден"
    end
    return lines, total
end

local function DoInfo()
    local st = SelectedStation()
    if not st then
        Err("станций не найдено (SCAN)")
        if refreshIfOpen then refreshIfOpen() end
        return
    end
    Log("=== INFO станции " .. S.sel .. " ===")
    Log("  объект: " .. ObjName(st))
    local sn, sname = GetState(st)
    Logf("  State: %s (%s) | disposed=%s", tostring(sname), tostring(sn), tostring(ReadField(st, "bDisposed")))
    Log("  InstanceId: " .. tostring(Str(ReadField(st, "InstanceId"))))
    Log("  ModelInstanceId: " .. tostring(Str(ReadField(st, "ModelInstanceId"))))
    local startT = Num(ReadField(ReadField(st, "MissionStartDateTime"), "Ticks"))
    if startT then
        local s = TicksToUTC(startT)
        Log("  старт: " .. tostring(s) .. " (ticks=" .. tostring(startT) .. ")")
    else
        Log("  MissionStartDateTime.Ticks: не читается")
    end
    local endT = Num(ReadField(ReadField(st, "MissionCompleteDateTime"), "Ticks"))
    if endT then
        local s, e = TicksToUTC(endT)
        Logf("  финиш: %s (ticks=%s), осталось: %s сек", tostring(s), tostring(endT), tostring(e and (e - NowEpoch()) or "?"))
    else
        Log("  MissionCompleteDateTime.Ticks: не читается")
    end
    if refreshIfOpen then refreshIfOpen() end
end

local function DoChest()
    local st = SelectedStation()
    if not st then return end
    local cont, why = GetStationContainer(st)
    if not cont then
        Err("станция " .. S.sel .. ": " .. tostring(why))
        if refreshIfOpen then refreshIfOpen() end
        return
    end
    Log("=== CHEST станции " .. S.sel .. " ===")
    DumpContainer("[chest]", cont)
    if refreshIfOpen then refreshIfOpen() end
end

local function DoUIProbe()
    local st = SelectedStation()
    if not st then return end
    Log("=== UI-ПРОБА станции " .. S.sel .. " (БЕЗ репликации) ===")
    WithUIModel(st, false, ProbeUIModelReads)
    Log("=== UI-ПРОБА станции " .. S.sel .. " (С репликацией) ===")
    WithUIModel(st, true, ProbeUIModelReads)
    if refreshIfOpen then refreshIfOpen() end
end

local function DumpMissionElem(el)
    local res = { id = nil, text = "" }
    if el == nil then res.text = "(элемент nil)"; return res end
    local mid = Str(ReadField(el, "MissionId"))
    res.id = mid
    local line = tostring(mid or "?")
    local md = ReadField(el, "MasterData")
    if md ~= nil then
        local secs = Num(ReadField(md, "RequiredSeconds"))
        local rec = Num(ReadField(md, "RecommendedStrength"))
        local diff = Num(ReadField(md, "Difficulty"))
        local elem = Num(ReadField(md, "RequiredElementType"))
        local elemN = Num(ReadField(md, "RequiredElementNum"))
        line = line .. string.format(" | %s | %sс | сила %s | элемент %s x%s",
            diff ~= nil and (DIFF_NAMES[diff] or diff) or "?",
            tostring(secs), tostring(rec), tostring(elem), tostring(elemN))
    else
        line = line .. " | (MasterData не читается)"
    end
    local rew = ReadField(el, "RewardStaticItemIds")
    local rl = rew and TryLen(rew) or nil
    if rl and rl > 0 then
        local names = {}
        for j = 1, math.min(rl, 4) do
            names[#names + 1] = tostring(Str(ArrAt(rew, j)))
        end
        line = line .. " | награды: " .. table.concat(names, ", ") .. ((rl > 4 and (" (+" .. (rl - 4) .. ")")) or "")
    end
    res.text = line
    return res
end

local function DoMissions()
    local st = SelectedStation()
    if not st then return end
    Log("=== MISSIONS станции " .. S.sel .. " ===")
    WithUIModel(st, true, function(ui)
        local out = {}
        local ok, res = pcall(function() ui:GetSelectableMissionInfos(out) end)
        if not ok then
            Err("GetSelectableMissionInfos → " .. tostring(res))
            return
        end
        local arr = out.OutInfos or out.outInfos or out[1]
        if arr == nil then
            local parts = {}
            for k, v in pairs(out) do parts[#parts + 1] = tostring(k) .. " (" .. type(v) .. ")" end
            Log("  out-таблица: {" .. table.concat(parts, ", ") .. "}")
            return
        end
        local n = TryLen(arr)
        if not n then
            local cnt = 0
            SafeDo("missions (pairs)", function()
                for k, v in pairs(arr) do
                    if type(k) == "number" then cnt = cnt + 1 end
                end
            end)
            Log("  длина массива не читается; pairs дал " .. cnt .. " числовых ключей")
            return
        end
        Logf("  доступно миссий: %d (показаны в панели — кнопка SELECT+START)", n)
        S.missions = {}
        for i = 1, math.min(n, 12) do
            local info = DumpMissionElem(ArrAt(arr, i))
            S.missions[#S.missions + 1] = info
            Log("  " .. info.text)
        end
    end)
    if refreshIfOpen then refreshIfOpen() end
end

-- цепочка: select → auto → start (кнопка у строки миссии)
local function LaunchMission(missionId)
    local st = SelectedStation()
    if not st then return end
    if missionId == nil or missionId == "" then Err("missionId пуст — сначала MISSIONS") return end
    Logf("=== ЗАПУСК '%s' на станции %d: select → auto → start ===", tostring(missionId), S.sel)
    WithUIModel(st, true, function(ui)
        local ok, res = pcall(function() ui:RequestSelectMission(missionId) end)
        Log("RequestSelectMission: " .. ((ok and "вызвана") or ("FAIL → " .. tostring(res))))
    end)
    DelayCall(Config.AutoStartMs, function()
        SafeDo("проверка TargetMissionId", function()
            local st2 = SelectedStation()
            if IsValidObj(st2) then
                Log("TargetMissionId теперь: " .. tostring(Str(ReadField(st2, "TargetMissionId"))))
            end
        end)
        local st3 = SelectedStation()
        if IsValidObj(st3) then
            WithUIModel(st3, true, function(ui)
                local ok, res = pcall(function() ui:RequestSelectAuto() end)
                Log("RequestSelectAuto: " .. ((ok and "вызвана") or ("FAIL → " .. tostring(res))))
            end)
        end
        DelayCall(Config.AutoStartMs, function()
            local st4 = SelectedStation()
            if not IsValidObj(st4) then return end
            WithUIModel(st4, true, function(ui)
                local okC, c = pcall(function() return ui:CanStartMission() end)
                Log("CanStartMission: " .. ((okC and tostring(c == true)) or "FAIL"))
                local ok, res = pcall(function() ui:RequestStartMission() end)
                Log("RequestStartMission: " .. ((ok and "вызвана") or ("FAIL → " .. tostring(res))))
            end)
            DelayCall(Config.VerifyMs + 200, function()
                SafeDo("проверка после запуска", function()
                    local st5 = SelectedStation()
                    if IsValidObj(st5) then
                        local _, sname = GetState(st5)
                        Logf("state станции %d после запуска: %s (ожидаем InProgress)", S.sel, tostring(sname))
                        if refreshIfOpen then refreshIfOpen() end
                    end
                end)
            end)
        end)
    end)
end

local function DoAuto()
    local st = SelectedStation()
    if not st then return end
    Log("=== AUTO станции " .. S.sel .. " (RequestSelectAuto) ===")
    WithUIModel(st, true, function(ui)
        local ok, res = pcall(function() ui:RequestSelectAuto() end)
        Log("RequestSelectAuto: " .. ((ok and "вызвана") or ("FAIL → " .. tostring(res))))
    end)
    DelayCall(Config.VerifyMs, function()
        SafeDo("проверка назначенных", function()
            local st2 = SelectedStation()
            if IsValidObj(st2) then
                local ai = ReadField(st2, "AssignedInfo")
                local rep = ai and ReadField(ai, "RepInfoArray") or nil
                local items = rep and ReadField(rep, "Items") or nil
                Log("назначено палов (AssignedInfo): " .. tostring(items and TryLen(items) or nil))
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end

local function DoStart()
    local st = SelectedStation()
    if not st then return end
    Log("=== START станции " .. S.sel .. " ===")
    WithUIModel(st, true, function(ui)
        local okC, c = pcall(function() return ui:CanStartMission() end)
        Log("CanStartMission до запуска: " .. ((okC and tostring(c == true)) or "FAIL"))
        local ok, res = pcall(function() ui:RequestStartMission() end)
        Log("RequestStartMission: " .. ((ok and "вызвана") or ("FAIL → " .. tostring(res))))
    end)
    DelayCall(Config.VerifyMs + 200, function()
        SafeDo("проверка после запуска", function()
            local st2 = SelectedStation()
            if IsValidObj(st2) then
                local _, sname = GetState(st2)
                Logf("state станции %d после запуска: %s (ожидаем InProgress)", S.sel, tostring(sname))
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end

local function DoRemain()
    local st = SelectedStation()
    if not st then return end
    Log("=== REMAIN станции " .. S.sel .. " ===")
    local endT = Num(ReadField(ReadField(st, "MissionCompleteDateTime"), "Ticks"))
    if endT then
        local s, e = TicksToUTC(endT)
        Logf("  из модели: финиш=%s, осталось ≈ %s сек (сейчас UTC %s)",
            tostring(s), tostring(e and (e - NowEpoch()) or "?"), os.date("!%Y-%m-%d %H:%M:%S"))
    else
        Log("  MissionCompleteDateTime.Ticks не читается")
    end
    WithUIModel(st, true, function(ui)
        local ok, r = pcall(function() return ui:GetRemainMissionSeconds() end)
        Log("  из UI-модели GetRemainMissionSeconds: " .. ((ok and tostring(Num(r))) or "FAIL"))
    end)
    if refreshIfOpen then refreshIfOpen() end
end

local function DoCollectOne(idx)
    local stations = FindStations()
    local st = stations[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена")
        return
    end
    local cont, why = GetStationContainer(st)
    if not cont then
        Err("станция " .. idx .. ": " .. tostring(why))
        return
    end
    local net = GetNetComp()
    if not net then
        Err("PalNetworkPlayerComponent не найден")
        return
    end
    DumpContainer("ДО сбора (ст." .. idx .. ")", cont)
    Log("RequestMoveItemToInventoryFromContainer …")
    local ok, res = pcall(function() return net:RequestMoveItemToInventoryFromContainer(cont, false) end)
    if not ok then
        Err("RequestMoveItemToInventoryFromContainer → " .. tostring(res))
        return
    end
    DelayCall(Config.VerifyMs, function()
        SafeDo("проверка после сбора", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                local _, sname = GetState(st2)
                local cont2 = GetStationContainer(st2)
                if cont2 then DumpContainer("ПОСЛЕ сбора (ст." .. idx .. ", state=" .. tostring(sname) .. ")", cont2) end
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end

local function DoCollect()
    if not SelectedStation() then return end
    Log("=== COLLECT станции " .. S.sel .. " ===")
    DoCollectOne(S.sel)
end

local function DoCollectAll()
    local stations = FindStations()
    local targets = {}
    for i, st in ipairs(stations) do
        local sn = GetState(st)
        if sn == 3 then targets[#targets + 1] = i end
    end
    if #targets == 0 then
        Log("нет станций в состоянии Reward — собирать нечего")
        if refreshIfOpen then refreshIfOpen() end
        return
    end
    Logf("=== COLLECT ALL: станций с наградой: %d (%s) ===", #targets, table.concat(targets, ", "))
    for k, i in ipairs(targets) do
        DelayCall(200 * k, function()
            SafeDo("collect ст." .. i, function() DoCollectOne(i) end)
        end)
    end
end

local function DoFallbackStart()
    local st = SelectedStation()
    if not st then return end
    Log("=== ФОЛБЭК станции " .. S.sel .. ": ServerInternal напрямую, playerId=0 ===")
    SafeDo("RequestSelectAuto_ServerInternal(0)", function() st:RequestSelectAuto_ServerInternal(0) end)
    DelayCall(Config.AutoStartMs, function()
        SafeDo("проверка авто-назначения", function()
            local st2 = SelectedStation()
            if IsValidObj(st2) then
                local ai = ReadField(st2, "AssignedInfo")
                local rep = ai and ReadField(ai, "RepInfoArray") or nil
                local items = rep and ReadField(rep, "Items") or nil
                Log("AssignedInfo: " .. tostring(items and TryLen(items) or nil) .. " палов назначено")
            end
        end)
        SafeDo("RequestStartMission_ServerInternal(0)", function()
            local st3 = SelectedStation()
            if IsValidObj(st3) then st3:RequestStartMission_ServerInternal(0) end
        end)
        DelayCall(Config.VerifyMs + 200, function()
            SafeDo("проверка после фолбэк-запуска", function()
                local st4 = SelectedStation()
                if IsValidObj(st4) then
                    local _, sname = GetState(st4)
                    Logf("state станции %d после фолбэк-запуска: %s", S.sel, tostring(sname))
                    if refreshIfOpen then refreshIfOpen() end
                end
            end)
        end)
    end)
end

local function DoGuild()
    local guild = GetGuildMission()
    if not guild then
        Err("GuildCharacterTeamMission не найден")
        if refreshIfOpen then refreshIfOpen() end
        return
    end
    Log("=== GUILD ===")
    Log("  объект: " .. ObjName(guild))
    Log("  одновременных экспедиций (GuildExpedtionCount): " .. tostring(Num(ReadField(guild, "GuildExpedtionCount"))))
    local rel = ReadField(guild, "ReleasedMissionInfos")
    local n = rel and TryLen(rel) or nil
    Log("  открытых миссий: " .. tostring(n))
    if n then
        for i = 1, math.min(n, 30) do
            local el = ArrAt(rel, i)
            if el ~= nil then
                Logf("    [%d] %s (bEnableChallenge=%s)", i,
                    tostring(Str(ReadField(el, "MissionId"))), tostring(ReadField(el, "bEnableChallenge")))
            end
        end
    end
    if refreshIfOpen then refreshIfOpen() end
end

local function DoSettings()
    Log("=== SETTINGS ===")
    local gs = nil
    SafeDo("FindFirstOf(PalGameSetting)", function()
        local g = FindFirstOf("PalGameSetting")
        g = Unwrap(g)
        if IsValidObj(g) then gs = g end
    end)
    if not gs then
        Log("  PalGameSetting не найден (FindFirstOf)")
        if refreshIfOpen then refreshIfOpen() end
        return
    end
    Log("  объект: " .. ObjName(gs))
    local cls = ReadField(gs, "ExpeditionStrengthSortFunctionsClass")
    if IsValidObj(cls) then
        Log("  ExpeditionStrengthSortFunctionsClass: " .. ObjName(cls))
    else
        Log("  ExpeditionStrengthSortFunctionsClass: nil/не класс")
    end
    if refreshIfOpen then refreshIfOpen() end
end

-- ============================================================================================
--  GUI (каркас проверен в TowerHunter / Relic Collector)
-- ============================================================================================

local function hexToLinearColor(hexStr, alpha)
    local cleanHex = hexStr:gsub("#", "")
    local r = tonumber(cleanHex:sub(1, 2), 16) / 255.0
    local g = tonumber(cleanHex:sub(3, 4), 16) / 255.0
    local b = tonumber(cleanHex:sub(5, 6), 16) / 255.0
    local function srgbToLinear(val)
        if val <= 0.04045 then return val / 12.92 end
        return ((val + 0.055) / 1.055) ^ 2.4
    end
    return { srgbToLinear(r), srgbToLinear(g), srgbToLinear(b), alpha or 1.0 }
end

local Theme = {
    PanelBase     = hexToLinearColor("#131A1D", 0.95),
    PanelHeader   = hexToLinearColor("#26333A", 1.00),
    PanelSection  = hexToLinearColor("#192226", 0.90),
    CardActive    = hexToLinearColor("#1D2D2A", 0.96),
    CardInactive  = hexToLinearColor("#241D1E", 0.85),
    Divider       = hexToLinearColor("#314046", 1.00),
    BorderDefault = hexToLinearColor("#42555C", 1.00),
    TextPrimary   = hexToLinearColor("#EAF2F6", 1.00),
    TextSecond    = hexToLinearColor("#9DB0B9", 1.00),
    TextDim       = hexToLinearColor("#6C808A", 1.00),
    Gold          = hexToLinearColor("#FFC53D", 1.00),
    Green         = hexToLinearColor("#4ADE80", 1.00),
    Red           = hexToLinearColor("#F87171", 1.00),
    Blue          = hexToLinearColor("#7DD3FC", 1.00),
    Purple        = hexToLinearColor("#C084FC", 1.00),
    Orange        = hexToLinearColor("#FB923C", 1.00),
}

local Assets = {
    WindowBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_PalCommonWindow.WBP_PalCommonWindow_C",
    ButtonBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_CommonButton_Activation.WBP_CommonButton_Activation_C",
    DefaultFont     = "/Game/Pal/Font/Ft_PalDefaultFont.Ft_PalDefaultFont",
    OverallLayout   = "WBP_PalOverallUILayout_C",
    HostPanelName   = "CanvasPanel_Root",
}

local ObjectCache = {}

local function resolveStaticObject(path)
    if ObjectCache[path] and IsValidObj(ObjectCache[path]) then
        return ObjectCache[path]
    end
    local obj = StaticFindObject(path)
    if not IsValidObj(obj) then
        pcall(LoadAsset, path)
        obj = StaticFindObject(path)
    end
    if IsValidObj(obj) then
        ObjectCache[path] = obj
        return obj
    end
    return nil
end

local ClickDispatcher = {
    subscribers = {},
    hookActive  = false,
}

function ClickDispatcher.Subscribe(buttonWidget, callback)
    if not IsValidObj(buttonWidget) or not callback then return end
    if not ClickDispatcher.hookActive then
        ClickDispatcher.hookActive = true
        pcall(function()
            RegisterHook("/Script/CommonUI.CommonButtonBase:HandleButtonClicked", function(self)
                local okGet, widget = pcall(function() return self:get() end)
                if not okGet or not widget then return end
                local okName, fullName = pcall(function() return widget:GetFullName() end)
                if not okName or not fullName then return end
                local handler = ClickDispatcher.subscribers[fullName]
                if handler then pcall(handler) end
            end)
        end)
    end
    local okName, name = pcall(function() return buttonWidget:GetFullName() end)
    if okName and name then
        ClickDispatcher.subscribers[name] = callback
    end
end

function ClickDispatcher.Reset()
    ClickDispatcher.subscribers = {}
end

-- ------------------------------- Factory ---------------------------------
local Factory = {}

function Factory.CreateText(tree, message, fontSize, colorTuple, boldFont, justify)
    local cls = resolveStaticObject("/Script/UMG.TextBlock")
    if not cls then return nil end
    local widget = StaticConstructObject(cls, tree)
    if not IsValidObj(widget) then return nil end
    widget:SetText(FText(message or ""))
    widget:SetRenderOpacity(1.0)
    pcall(function()
        local fontInfo = widget.Font
        fontInfo.Size = fontSize or 11
        local fontAsset = resolveStaticObject(Assets.DefaultFont)
        if fontAsset then
            fontInfo.FontObject = fontAsset
            fontInfo.TypefaceFontName = FName(boldFont and "Bold" or "Medium")
        end
        widget.Font = fontInfo
    end)
    if colorTuple then
        pcall(function()
            local c = widget.ColorAndOpacity
            c.SpecifiedColor.R = colorTuple[1]
            c.SpecifiedColor.G = colorTuple[2]
            c.SpecifiedColor.B = colorTuple[3]
            c.SpecifiedColor.A = colorTuple[4] or 1.0
            widget.ColorAndOpacity = c
        end)
    end
    if justify then pcall(function() widget:SetJustification(justify) end) end
    pcall(function() widget:SetClipping(0) end)
    return widget
end

function Factory.CreateSolidBorder(tree, colorTuple)
    local cls = resolveStaticObject("/Script/UMG.Border")
    if not cls then return nil end
    local border = StaticConstructObject(cls, tree)
    if not IsValidObj(border) then return nil end
    border:SetRenderOpacity(1.0)
    pcall(function()
        local brush = border.BrushColor
        brush.R = colorTuple[1]
        brush.G = colorTuple[2]
        brush.B = colorTuple[3]
        brush.A = colorTuple[4] or 1.0
        border:SetBrushColor(brush)
    end)
    return border
end

function Factory.AnchorWidget(parentCanvas, childWidget, x, y, w, h, zOrder)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not IsValidObj(slot) then return end
    slot:SetAutoSize(false)
    local pos = slot:GetPosition()
    pos.X, pos.Y = math.floor(x), math.floor(y)
    slot:SetPosition(pos)
    local size = slot:GetSize()
    size.X, size.Y = math.floor(w), math.floor(h)
    slot:SetSize(size)
    slot:SetZOrder(zOrder or 0)
end

function Factory.AnchorCenter(parentCanvas, childWidget, w, h)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not IsValidObj(slot) then return end
    slot:SetAutoSize(false)
    local anchors = slot:GetAnchors()
    anchors.Minimum.X, anchors.Minimum.Y = 0.5, 0.5
    anchors.Maximum.X, anchors.Maximum.Y = 0.5, 0.5
    slot:SetAnchors(anchors)
    local align = slot:GetAlignment()
    align.X, align.Y = 0.5, 0.5
    slot:SetAlignment(align)
    local pos = slot:GetPosition()
    pos.X, pos.Y = 0, 0
    slot:SetPosition(pos)
    local size = slot:GetSize()
    size.X, size.Y = w, h
    slot:SetSize(size)
end

function Factory.DrawFrame(canvas, tree, x, y, w, h, color)
    local function line(lx, ly, lw, lh)
        local b = Factory.CreateSolidBorder(tree, color)
        if b then Factory.AnchorWidget(canvas, b, lx, ly, lw, lh, 1) end
    end
    line(x, y, w, 1)
    line(x, y + h - 1, w, 1)
    line(x, y, 1, h)
    line(x + w - 1, y, 1, h)
end

-- ------------------------------- Engine ----------------------------------
local Engine = {}

function Engine.LocateMainLayout()
    local ok, instances = pcall(FindAllOf, Assets.OverallLayout)
    if ok and instances and #instances > 0 then return instances[1] end
    return nil
end

function Engine.FindHostCanvas(outerFullName, panelName)
    local ok, canvasList = pcall(FindAllOf, "CanvasPanel")
    if not ok or not canvasList then return nil end
    local needle = "." .. panelName
    for _, canvas in ipairs(canvasList) do
        if IsValidObj(canvas) then
            local okName, name = pcall(function() return canvas:GetFullName() end)
            if okName and name and name:sub(-#needle) == needle then
                local okOuter, outerObj = pcall(function() return canvas:GetOuter() end)
                if okOuter and IsValidObj(outerObj) then
                    local okOuterName, outerName = pcall(function() return outerObj:GetFullName() end)
                    if okOuterName and outerName == outerFullName then
                        return canvas
                    end
                end
            end
        end
    end
    return nil
end

function Engine.DiscoverNamedSlot(windowObj)
    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not IsValidObj(tree) then return nil end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not IsValidObj(root) then return nil end
    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return nil end
    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and IsValidObj(child) then
            local okName, name = pcall(function() return child:GetFullName() end)
            if okName and name and name:match("^NamedSlot%s") then
                return child
            end
        end
    end
    return nil
end

function Engine.MuteUnusedChrome(windowObj)
    local slot = Engine.DiscoverNamedSlot(windowObj)
    if not slot then return end
    local okName, slotFullName = pcall(function() return slot:GetFullName() end)
    if not okName then return end
    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not IsValidObj(tree) then return end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not IsValidObj(root) then return end
    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return end
    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and IsValidObj(child) then
            local okChildName, childName = pcall(function() return child:GetFullName() end)
            if okChildName and childName ~= slotFullName then
                pcall(function() child:SetVisibility(1) end)
            end
        end
    end
end

function Engine.AcquireModalSurface()
    local layout = Engine.LocateMainLayout()
    if not IsValidObj(layout) then return nil end
    local ok, modalLayer = pcall(function() return layout.Modal end)
    if ok and IsValidObj(modalLayer) then return modalLayer end
    return nil
end

-- ------------------------------- окно ----------------------------------
local UI_W = 1000
local UI_H = 800
local PAD  = 16

local State = {
    activeShell   = nil,
    activeSurface = nil,
    widgetTree    = nil,
    hostCanvas    = nil,
    isDisplayed   = false,
}

local function assembleModalFrame(panel, tree, frameWidth, frameHeight)
    local winCls     = resolveStaticObject(Assets.WindowBlueprint)
    local canvasCls  = resolveStaticObject("/Script/UMG.CanvasPanel")
    local sizeBoxCls = resolveStaticObject("/Script/UMG.SizeBox")
    local widgetLib  = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    local modalHost  = Engine.AcquireModalSurface()

    if not winCls or not canvasCls or not sizeBoxCls or not widgetLib or not modalHost then
        Err("core UMG classes missing for modal")
        return nil
    end

    local frameShell, contentSurface
    local ok, err = pcall(function()
        local player = panel:GetOwningPlayer()
        frameShell = modalHost:BP_AddWidget(winCls)
        if not IsValidObj(frameShell) then error("Modal host rejected widget") end

        Engine.MuteUnusedChrome(frameShell)
        local shellSlot = Engine.DiscoverNamedSlot(frameShell)
        if not shellSlot then error("Shell slot missing") end

        local innerWindow = widgetLib:Create(panel, winCls, player)
        if not IsValidObj(innerWindow) then error("Inner window failed") end

        local innerSlot = Engine.DiscoverNamedSlot(innerWindow)
        if not innerSlot then error("Inner slot missing") end

        contentSurface = StaticConstructObject(canvasCls, tree)
        local frameBox = StaticConstructObject(sizeBoxCls, tree)
        frameBox:SetWidthOverride(frameWidth)
        frameBox:SetHeightOverride(frameHeight)
        frameBox:SetContent(contentSurface)
        innerSlot:SetContent(frameBox)

        local hostCanvas = StaticConstructObject(canvasCls, tree)
        shellSlot:SetContent(hostCanvas)
        Factory.AnchorCenter(hostCanvas, innerWindow, frameWidth, frameHeight)
    end)

    if not ok or not IsValidObj(frameShell) then
        Err("assembleModalFrame err: " .. tostring(err))
        return nil
    end

    pcall(function()
        local blurCls = resolveStaticObject("/Script/UMG.BackgroundBlur")
        if blurCls then
            local blur = StaticConstructObject(blurCls, tree)
            if IsValidObj(blur) then
                blur:SetRenderOpacity(1.0)
                pcall(function() blur:SetBlurStrength(6.0) end)
                Factory.AnchorWidget(contentSurface, blur, 0, 0, frameWidth, frameHeight, 0)
            end
        end
        local base = Factory.CreateSolidBorder(tree, Theme.PanelBase)
        if base then Factory.AnchorWidget(contentSurface, base, 0, 0, frameWidth, frameHeight, 1) end
    end)

    return { shell = frameShell, surface = contentSurface }
end

local function createGameButton(hostCanvas, surface, tree, label, x, y, w, h, onClick, z)
    local btnCls    = resolveStaticObject(Assets.ButtonBlueprint)
    local widgetLib = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    if not btnCls or not widgetLib then return nil end

    local ok, btn = pcall(function()
        local owner = hostCanvas:GetOwningPlayer()
        local b = widgetLib:Create(hostCanvas, btnCls, owner)
        if not IsValidObj(b) then error("button create failed") end
        pcall(function() b:Setup(false) end)
        pcall(function() b:SetText(FText(label)) end)
        return b
    end)
    if not ok or not IsValidObj(btn) then return nil end

    Factory.AnchorWidget(surface, btn, x, y, w, h, z or 60)

    local target = btn
    local okIn, inner = pcall(function() return btn.WBP_PalInvisibleButton end)
    if okIn and IsValidObj(inner) then target = inner end
    ClickDispatcher.Subscribe(target, onClick)

    return btn
end

-- ------------------------------- отрисовка ----------------------------------
local Presenter_Close  -- forward declaration: используется кнопкой CLOSE внутри renderAllContent

local function renderAllContent()
    if not IsValidObj(State.activeSurface) or not IsValidObj(State.widgetTree) then return end

    local surface    = State.activeSurface
    local tree       = State.widgetTree
    local hostCanvas = State.hostCanvas
    local contentW   = UI_W - PAD * 2

    pcall(function() surface:ClearChildren() end)
    ClickDispatcher.Reset()

    local blurCls = resolveStaticObject("/Script/UMG.BackgroundBlur")
    if blurCls then
        local blur = StaticConstructObject(blurCls, tree)
        if IsValidObj(blur) then
            pcall(function() blur:SetBlurStrength(6.0) end)
            Factory.AnchorWidget(surface, blur, 0, 0, UI_W, UI_H, 0)
        end
    end
    local base = Factory.CreateSolidBorder(tree, Theme.PanelBase)
    if base then Factory.AnchorWidget(surface, base, 0, 0, UI_W, UI_H, 1) end

    -- ===== header (16..62) =====
    local headerH = 46
    local headerBg = Factory.CreateSolidBorder(tree, Theme.PanelHeader)
    if headerBg then Factory.AnchorWidget(surface, headerBg, PAD, PAD, contentW, headerH, 5) end
    Factory.DrawFrame(surface, tree, PAD, PAD, contentW, headerH, Theme.BorderDefault)
    local goldLine = Factory.CreateSolidBorder(tree, Theme.Gold)
    if goldLine then Factory.AnchorWidget(surface, goldLine, PAD, PAD + headerH - 2, contentW, 2, 6) end
    local title = Factory.CreateText(tree, "EXPEDITION HUB — TEST v0.2", 16, Theme.TextPrimary, true, 0)
    if title then Factory.AnchorWidget(surface, title, PAD + 16, PAD + 12, 460, 24, 7) end
    local _, stationTotal = SelectedStation()
    local sub = Factory.CreateText(tree, string.format("станций в мире: %d", stationTotal), 11, Theme.TextSecond, false, 2)
    if sub then Factory.AnchorWidget(surface, sub, PAD + contentW - 300, PAD + 16, 284, 16, 7) end

    -- ===== селектор станции (70..124) =====
    local selY, selH = 70, 54
    local selBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if selBg then Factory.AnchorWidget(surface, selBg, PAD, selY, contentW, selH, 5) end
    Factory.DrawFrame(surface, tree, PAD, selY, contentW, selH, Theme.Divider)

    createGameButton(hostCanvas, surface, tree, "<< PREV", PAD + 16, selY + 10, 110, 34, function()
        local _, total = SelectedStation()
        if total > 0 then
            S.sel = (S.sel - 2) % total + 1
        end
        renderAllContent()
    end, 60)
    local selText = Factory.CreateText(tree,
        string.format("СТАНЦИЯ  %d / %d", (stationTotal > 0 and S.sel) or 0, stationTotal), 13, Theme.Gold, true, 1)
    if selText then Factory.AnchorWidget(surface, selText, PAD + 140, selY + 15, 240, 20, 7) end
    createGameButton(hostCanvas, surface, tree, "NEXT >>", PAD + contentW - 126, selY + 10, 110, 34, function()
        local _, total = SelectedStation()
        if total > 0 then
            S.sel = S.sel % total + 1
        end
        renderAllContent()
    end, 60)

    -- ===== детали станции (132..244) =====
    local detY, detH = 132, 112
    local detBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if detBg then Factory.AnchorWidget(surface, detBg, PAD, detY, contentW, detH, 5) end
    Factory.DrawFrame(surface, tree, PAD, detY, contentW, detH, Theme.Divider)
    local detLines = StationDetailLines()
    for i, lineTxt in ipairs(detLines) do
        local t = Factory.CreateText(tree, lineTxt, 11, Theme.TextPrimary, false, 0)
        if t then Factory.AnchorWidget(surface, t, PAD + 16, detY + 10 + (i - 1) * 17, contentW - 32, 16, 7) end
    end

    -- ===== миссии (252..412) =====
    local misY, misH = 252, 160
    local misBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if misBg then Factory.AnchorWidget(surface, misBg, PAD, misY, contentW, misH, 5) end
    Factory.DrawFrame(surface, tree, PAD, misY, contentW, misH, Theme.Divider)

    if S.missions and #S.missions > 0 then
        local mTitle = Factory.CreateText(tree,
            string.format("МИССИИ СТАНЦИИ %d — нажми SELECT+START:", S.sel), 11, Theme.TextPrimary, true, 0)
        if mTitle then Factory.AnchorWidget(surface, mTitle, PAD + 16, misY + 8, 700, 16, 7) end
        createGameButton(hostCanvas, surface, tree, "x CLEAR", PAD + contentW - 96, misY + 5, 80, 24, function()
            S.missions = nil
            renderAllContent()
        end, 60)
        for i, info in ipairs(S.missions) do
            if i > 4 then break end
            local cy = misY + 32 + (i - 1) * 31
            local rowBg = Factory.CreateSolidBorder(tree, Theme.CardActive)
            if rowBg then Factory.AnchorWidget(surface, rowBg, PAD + 14, cy, contentW - 28, 27, 6) end
            local t = Factory.CreateText(tree, string.format("%d. %s", i, info.text), 10, Theme.TextSecond, false, 0)
            if t then Factory.AnchorWidget(surface, t, PAD + 24, cy + 6, 620, 16, 7) end
            createGameButton(hostCanvas, surface, tree, "SELECT+START", PAD + contentW - 174, cy - 2, 156, 26, function()
                LaunchMission(info.id)
            end, 60)
        end
    else
        local hint = Factory.CreateText(tree,
            "МИССИИ: нажми MISSIONS ниже — здесь появится список с кнопками SELECT+START (выбор→авто-палы→запуск одной кнопкой)",
            10, Theme.TextDim, false, 0)
        if hint then Factory.AnchorWidget(surface, hint, PAD + 16, misY + 12, contentW - 32, 60, 7) end
    end

    -- ===== кнопки проб (420..560) =====
    local btnY = 420
    local btnW, btnH, gap = 225, 42, 8
    local rows = {
        { "SCAN", DoScan, "INFO", DoInfo, "CHEST", DoChest, "UI-PROBE", DoUIProbe },
        { "MISSIONS", DoMissions, "AUTO", DoAuto, "START", DoStart, "COLLECT", DoCollect },
        { "COLLECT ALL", DoCollectAll, "REMAIN", DoRemain, "FB-START", DoFallbackStart, "GUILD", DoGuild },
    }
    for r, row in ipairs(rows) do
        local cy = btnY + (r - 1) * (btnH + gap)
        for c = 1, 4 do
            local label = row[c * 2 - 1]
            local fn    = row[c * 2]
            createGameButton(hostCanvas, surface, tree, label,
                PAD + 16 + (c - 1) * (btnW + gap), cy, btnW, btnH, function()
                    SafeDo("btn:" .. tostring(label), fn)
                    renderAllContent()
                end, 60)
        end
    end

    -- ===== лог (568..748) =====
    local logY, logH = 568, 180
    local logBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if logBg then Factory.AnchorWidget(surface, logBg, PAD, logY, contentW, logH, 5) end
    Factory.DrawFrame(surface, tree, PAD, logY, contentW, logH, Theme.Divider)
    local logTitle = Factory.CreateText(tree, "ЛОГ ПРОБ (последние строки; полный лог — в логе UE4SS):", 10, Theme.TextDim, true, 0)
    if logTitle then Factory.AnchorWidget(surface, logTitle, PAD + 16, logY + 6, 600, 14, 7) end
    local startIdx = math.max(1, #S.logLines - Config.LogLines + 1)
    local shown = 0
    for i = startIdx, #S.logLines do
        shown = shown + 1
        local lineTxt = S.logLines[i]
        local color = Theme.TextSecond
        if lineTxt:find("ОШИБКА", 1, true) then color = Theme.Red
        elseif lineTxt:find("ok", 1, true) or lineTxt:find("вызвана", 1, true) then color = Theme.Green end
        local t = Factory.CreateText(tree, lineTxt, 10, color, false, 0)
        if t then Factory.AnchorWidget(surface, t, PAD + 16, logY + 24 + (shown - 1) * 14, contentW - 32, 13, 7) end
    end

    -- ===== футер (752..784) =====
    local footerY = UI_H - PAD - 32
    local footLine = Factory.CreateSolidBorder(tree, Theme.Divider)
    if footLine then Factory.AnchorWidget(surface, footLine, PAD, footerY - 4, contentW, 1, 6) end
    local escHint = Factory.CreateText(tree, "F6 или ESC — закрыть | тестируй по порядку: SCAN → INFO → UI-PROBE → MISSIONS → AUTO → START", 10, Theme.TextDim, false, 0)
    if escHint then Factory.AnchorWidget(surface, escHint, PAD + 10, footerY + 8, 640, 16, 7) end
    createGameButton(hostCanvas, surface, tree, "SETTINGS", PAD + contentW - 320, footerY - 2, 140, 30, function()
        SafeDo("btn:SETTINGS", DoSettings)
        renderAllContent()
    end, 60)
    createGameButton(hostCanvas, surface, tree, "CLOSE [ESC]", PAD + contentW - 166, footerY - 2, 150, 30, function()
        Presenter_Close()
    end, 60)
end

-- ------------------------------- Presenter ----------------------------------
function Presenter_Close()
    if IsValidObj(State.activeShell) then
        local modalHost = Engine.AcquireModalSurface()
        if modalHost then
            pcall(function() modalHost:RemoveWidget(State.activeShell) end)
        end
    end
    State.activeShell   = nil
    State.activeSurface = nil
    State.widgetTree    = nil
    State.hostCanvas    = nil
    State.isDisplayed   = false
    ClickDispatcher.Reset()
end

local function Presenter_Show()
    Presenter_Close()

    local layout = Engine.LocateMainLayout()
    if not IsValidObj(layout) then
        Log("layout не найден — войди в мир и открой панель снова")
        return
    end
    local tree = layout.WidgetTree
    if not IsValidObj(tree) then
        Log("WidgetTree не найден")
        return
    end
    local layoutName
    local okN, n = pcall(function() return tree:GetFullName() end)
    if okN and type(n) == "string" then layoutName = n end
    if not layoutName then Log("не удалось получить имя layout"); return end

    local hostCanvas = Engine.FindHostCanvas(layoutName, Assets.HostPanelName)
    if not IsValidObj(hostCanvas) then
        Log("host canvas не найден")
        return
    end

    local frame = assembleModalFrame(hostCanvas, tree, UI_W, UI_H)
    if not frame then return end

    State.activeShell   = frame.shell
    State.activeSurface = frame.surface
    State.widgetTree    = tree
    State.hostCanvas    = hostCanvas
    State.isDisplayed   = true

    renderAllContent()
    Log("панель открыта")
end

local function Presenter_IsVisible()
    return State.isDisplayed
end

local function Presenter_Refresh()
    if State.isDisplayed then
        renderAllContent()
    end
end

refreshIfOpen = Presenter_Refresh

-- авто-обновление открытой панели (таймеры/состояние тикают сами)
local function scheduleAutoRefresh()
    DelayCall(Config.RefreshMs, function()
        if State.isDisplayed then
            renderAllContent()
            scheduleAutoRefresh()
        end
    end)
end

-- ============================== ХОТКЕИ / МИР ==============================
local function bindAction(fn)
    local guarded = function() SafeDo(fn) end
    return function()
        if type(ExecuteInGameThread) == "function" and pcall(ExecuteInGameThread, guarded) then
            return
        end
        SafeDo(guarded)
    end
end

local function bindKey(keyName, fn)
    if type(RegisterKeyBind) ~= "function" or type(Key) ~= "table" then
        Err("RegisterKeyBind недоступен")
        return false
    end
    local keyEnum = Key[tostring(keyName):upper()]
    if keyEnum == nil then
        Err("неизвестная клавиша: " .. tostring(keyName))
        return false
    end
    return pcall(RegisterKeyBind, keyEnum, bindAction(fn))
end

local function toggleUI()
    if Presenter_IsVisible() then
        Presenter_Close()
    else
        Presenter_Show()
        scheduleAutoRefresh()
    end
end

local function onWorldEnter()
    SafeDo(function()
        if Presenter_IsVisible() then Presenter_Close() end
    end)
    Log("мир загружен — панель закрыта, кэши сброшены")
end

local function registerWorldEnterHook()
    local ok = pcall(RegisterHook,
        "/Script/Pal.PalPlayerController:OnInitializeLocalPlayer_BP",
        function() end,
        function() SafeDo(onWorldEnter) end)
    if ok then Log("world-enter hook attached (OnInitializeLocalPlayer_BP)") end
    if type(NotifyOnNewObject) == "function" then
        local okN = pcall(NotifyOnNewObject, "/Script/Pal.PalPlayerCharacter", function()
            SafeDo(function()
                ExecuteWithDelay(500, function() SafeDo(onWorldEnter) end)
            end)
        end)
        if okN then Log("world-enter hook attached (PalPlayerCharacter spawn)") end
    end
end

-- ============================== INIT ==============================
local function init()
    bindKey(Config.OpenKey, toggleUI)
    bindKey("ESCAPE", function()
        if Presenter_IsVisible() then Presenter_Close() end
    end)
    registerWorldEnterHook()
    Log("ExpeditionHubTest v0.2 готов. F6 — панель проб экспедиций (кнопки, консоль не нужна).")
    Log("порядок теста: SCAN → INFO → UI-PROBE → MISSIONS → SELECT+START → COLLECT")
end

SafeDo(init)
