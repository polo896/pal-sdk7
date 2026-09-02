-- ============================================================================================
-- ExpeditionHubTest v0.1 — ТЕСТОВЫЙ мод-пробник (UE4SS Lua) для Palworld 0.4.11
-- Разведка системы экспедиций (CharacterTeamMission) перед написанием чистого мода
-- с GUI. Никаких пак-файлов — только свой Lua-код.
--
-- ЧТО ПРОВЕРЯЕМ (по итогам разведки SDK):
--   1. FindAllOf("PalMapObjectCharacterTeamMissionModel") находит ВСЕ станции экспедиций
--      со всех баз (это модели-объекты, живут независимо от стриминга акторов);
--   2. чтение состояния (Ready/InProgress/Reward), таймеров, имени базы, сундука;
--   3. UI-модель через StaticConstructObject(класс, outer=станция) — рабочий путь для
--      удалённого запуска: RequestSelectMission / RequestSelectAuto / RequestStartMission;
--   4. сбор лута: RequestMoveItemToInventoryFromContainer(сундук_станции, false) —
--      тот же вызов, что кнопка «забрать всё» в игре (легальный клиентский путь);
--   5. фолбэк, если UI-модель не взлетит: ServerInternal-функции напрямую (синглплеер).
--
-- КОМАНДЫ КОНСОЛИ UE4SS (префикс exh):
--   exh help                 — список команд
--   exh scan                 — все станции + сетевой компонент + гильдия
--   exh info <N>             — подробный дамп станции N
--   exh chest <N>            — слоты сундука станции N (что за лут лежит)
--   exh bases                — все базы (имена) для сверки
--   exh guild                — открытые экспедиции гильдии
--   exh settings             — PalGameSetting.ExpeditionStrengthSortFunctionsClass
--   exh ui <N>               — проба UI-модели (outer-паттерн): чтения без/с репликацией
--   exh missions <N>         — доступные миссии станции N (GetSelectableMissionInfos)
--   exh select <N> <MissionId> — выбрать миссию (по id из exh missions)
--   exh auto <N>             — авто-назначение палов станции N
--   exh start <N>            — запуск экспедиции станции N
--   exh remain <N>           — сколько осталось (UI-модель + сырые DateTime)
--   exh collect <N>          — забрать лут станции N в инвентарь игрока
--   exh collectall           — забрать лут со ВСЕХ станций в состоянии Reward
--   exh fb <N>               — фолбэк: ServerInternal напрямую (auto+start, playerId=0)
--
-- БЕЗОПАСНОСТЬ (главное — не повторить краши чужого мода при перезаходе):
--   • только вызовы нативных UFunction через ProcessEvent (как Relic Collector / PalWarp /
--     MinigameAutoWin); никаких чтений по оффсетам и правок памяти;
--   • каждый вызов обёрнут в pcall — ошибка Lua не роняет игру;
--   • мод НИЧЕГО не хранит между командами: станции и компоненты ищутся заново каждый
--     раз, никаких долгоживущих ссылок на объекты мира;
--   • UI-модель живёт ровно одну команду: RequestStartReplication() → действие →
--     RequestStopReplication() → ссылка отбрасывается. Делегаты не висят на мёртвых
--     моделях — именно это крашит чужой мод при выходе в меню и повторном входе.
--
-- УДАЛЕНИЕ: снести папку Mods/ExpeditionHubTest.
-- ============================================================================================

local TAG = "[ExpeditionHub]"

-- ============================== НАСТРОЙКИ (правь тут) ==============================
local Config = {
    VerifyMs   = 500,   -- задержка проверки состояния после действия
    AutoStartMs = 400,  -- пауза между auto и start в фолбэке
}

-- ============================== КОНСТАНТЫ ==============================
local STATE_NAMES = { [0] = "None", [1] = "Ready", [2] = "InProgress", [3] = "Reward" }
local DIFF_NAMES  = { [0] = "Easy", [1] = "Normal", [2] = "Hard", [3] = "VeryHard" }
local UI_MODEL_CLASS = "/Script/Pal.PalUIMapObjectCharacterTeamMissionModel"

-- ============================== ХЕЛПЕРЫ (проверенные паттерны) ==============================
local function Log(msg) print(TAG .. " " .. tostring(msg) .. "\n") end
local function Err(msg) print(TAG .. " ERR: " .. tostring(msg) .. "\n") end
local function Logf(fmt, ...) Log(string.format(fmt, ...)) end

local function SafeDo(label, fn)
    local ok, res = pcall(fn)
    if not ok then Err(label .. " → " .. tostring(res)) end
    return ok, res
end

-- есть ли у объекта метод (точный паттерн из PalWarp)
local function hasMethod(obj, name)
    local res = false
    pcall(function() res = (type(obj[name]) == "function") end)
    return res
end

-- Разворачивание RemoteUnrealParam → настоящий UObject/значение.
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

-- FName / FString / текст → строка (или nil)
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

-- число из поля/значения (int, float, enum) или nil
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

-- длина TArray-подобного значения или nil
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

-- элемент TArray-подобного (1-based) или nil
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

-- Все станции экспедиций (модели CharacterTeamMission), стабильный порядок по полному имени
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

-- UPalNetworkPlayerComponent локального игрока (не CDO!)
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

-- UPalGuildCharacterTeamMission (гильдия локального игрока)
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

-- состояние станции: число, имя
local function GetState(st)
    local v = ReadField(st, "State")
    local n = Num(v)
    if n ~= nil then
        local i = math.floor(n)
        return i, (STATE_NAMES[i] or ("?" .. tostring(n)))
    end
    return nil, Str(v)
end

-- имя базы, к которой принадлежит станция
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

-- координаты станции (out-параметр FVector)
local function GetLoc(st)
    local out = {}
    local ok = pcall(function() st:GetMapObjectLocation(out) end)
    if not ok then return nil, out end
    local v = out.outVector or out.OutVector or out[1]
    v = Unwrap(v)
    if v == nil then return nil, out end
    local x = Num(ReadField(v, "X")) or ReadField(v, "X")
    local y = Num(ReadField(v, "Y")) or ReadField(v, "Y")
    local z = Num(ReadField(v, "Z")) or ReadField(v, "Z")
    if x == nil then return nil, out end
    return { x = x, y = y, z = z }, out
end

-- контейнер (сундук) станции или nil + причина
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

-- дамп слотов контейнера: возвращает строку-сводку и число занятых слотов
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

-- человекочитаемое время из тиков FDateTime (+ epoch-секунды)
local function TicksToUTC(ticks)
    if not ticks then return nil, nil end
    local secs = math.floor(ticks / 10000000)
    local epoch = secs - 62135596800
    return os.date("!%Y-%m-%d %H:%M:%S UTC", epoch), epoch
end

local function NowEpoch()
    return os.time(os.date("!*t"))
end

-- ============================== UI-МОДЕЛЬ (одна команда = одна жизнь) ==============================

local function CreateUIModel(st)
    local cls = StaticFindObject(UI_MODEL_CLASS)
    if not IsValidObj(cls) then return nil, "класс " .. UI_MODEL_CLASS .. " не найден" end
    local ok, ui = pcall(function() return StaticConstructObject(cls, st) end)
    if not ok then return nil, "StaticConstructObject → " .. tostring(ui) end
    ui = Unwrap(ui)
    if not IsValidObj(ui) then return nil, "StaticConstructObject вернул невалидный объект" end
    return ui
end

-- создать UI-модель (outer = станция), выполнить fn, ВСЕГДА остановить репликацию
local function WithUIModel(st, useRep, fn)
    local ui, why = CreateUIModel(st)
    if not ui then
        Err("UI-модель не создана: " .. tostring(why))
        return
    end
    Log("UI-модель создана: " .. ObjName(ui))
    local bound = false
    if useRep then
        bound = SafeDo("RequestStartReplication", function() ui:RequestStartReplication() end)
        Log("RequestStartReplication: " .. (bound and "ok" or "FAIL"))
    end
    local okr, res = pcall(fn, ui)
    if not okr then Err("действие UI-модели → " .. tostring(res)) end
    if bound then
        SafeDo("RequestStopReplication", function() ui:RequestStopReplication() end)
        Log("RequestStopReplication: ok (делегаты отвязаны, ссылка отброшена)")
    end
end

-- чтения UI-модели для пробы
local function ProbeUIModelReads(ui)
    local f = ReadField(ui, "Functions")
    Log("  Functions: " .. (IsValidObj(f) and ObjName(f) or "nil (пусто — надо инжектить из PalGameSetting)"))

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
        Log("  GetCurrentState: " .. (n ~= nil and (STATE_NAMES[math.floor(n)] or tostring(n)) or tostring(Str(s))))
    else
        Log("  GetCurrentState: FAIL")
    end

    local okC, c = pcall(function() return ui:CanStartMission() end)
    Log("  CanStartMission: " .. (okC and tostring(c == true) or "FAIL"))

    local okR, r = pcall(function() return ui:GetRemainMissionSeconds() end)
    Log("  GetRemainMissionSeconds: " .. (okR and tostring(Num(r)) or "FAIL"))
end

-- дамп элемента FPalCharacterTeamMissionInfo (элемент — структура, не UObject)
local function DumpMissionElem(i, el)
    if el == nil then
        Logf("  [%d] (элемент nil)", i)
        return
    end
    local mid = Str(ReadField(el, "MissionId"))
    local line = string.format("  [%d] %s", i, mid or "?")
    local md = ReadField(el, "MasterData")
    if md ~= nil then
        local title = Str(ReadField(md, "TitleTextId"))
        local secs = Num(ReadField(md, "RequiredSeconds"))
        local rec = Num(ReadField(md, "RecommendedStrength"))
        local diff = Num(ReadField(md, "Difficulty"))
        local elem = Num(ReadField(md, "RequiredElementType"))
        local elemN = Num(ReadField(md, "RequiredElementNum"))
        local maxc = Num(ReadField(md, "MaxCharacterNum"))
        line = line .. string.format(" | %s | сложность=%s | время=%sс | сила=%s | элемент=%s x%s | макс.палов=%s",
            tostring(title), diff ~= nil and (DIFF_NAMES[diff] or diff) or "?",
            tostring(secs), tostring(rec), tostring(elem), tostring(elemN), tostring(maxc))
    else
        line = line .. " | (MasterData не читается)"
    end
    local rew = ReadField(el, "RewardStaticItemIds")
    local rl = rew and TryLen(rew) or nil
    if rl and rl > 0 then
        local names = {}
        for j = 1, math.min(rl, 6) do
            names[#names + 1] = tostring(Str(ArrAt(rew, j)))
        end
        line = line .. " | награды: " .. table.concat(names, ", ") .. (rl > 6 and (" (+" .. (rl - 6) .. ")") or "")
    end
    Log(line)
end

local function DumpMissionArray(arr, label)
    if arr == nil then
        Log(label .. ": массив nil")
        return
    end
    local n = TryLen(arr)
    if not n then
        -- запасной путь: pairs
        local cnt = 0
        SafeDo(label .. " (pairs)", function()
            for k, v in pairs(arr) do
                if type(k) == "number" then
                    cnt = cnt + 1
                    if cnt <= 60 then DumpMissionElem(k, Unwrap(v)) end
                end
            end
        end)
        Log(label .. ": (через pairs) элементов: " .. cnt)
        return
    end
    Logf("%s: миссий: %d", label, n)
    for i = 1, math.min(n, 60) do
        DumpMissionElem(i, ArrAt(arr, i))
    end
    if n > 60 then Logf("  ... и ещё %d (обрезано)", n - 60) end
end

-- ============================== ДЕЙСТВИЯ ==============================

local function DoCollect(st, idx)
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
            end
        end)
    end)
end

local function DoStart(idx, useRep)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    WithUIModel(st, useRep, function(ui)
        local okC, c = pcall(function() return ui:CanStartMission() end)
        Log("CanStartMission до запуска: " .. (okC and tostring(c == true) or "FAIL"))
        Log("RequestStartMission …")
        ui:RequestStartMission()
    end)
    DelayCall(Config.VerifyMs + 200, function()
        SafeDo("проверка после запуска", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                local _, sname = GetState(st2)
                Logf("state станции %d после запуска: %s (ожидаем InProgress=2)", idx, tostring(sname))
            end
        end)
    end)
end

local function DoFallbackStart(idx)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    Log("ФОЛБЭК: ServerInternal напрямую, playerId=0 (только для синглплеера)")
    SafeDo("RequestSelectAuto_ServerInternal(0)", function() st:RequestSelectAuto_ServerInternal(0) end)
    DelayCall(Config.AutoStartMs, function()
        SafeDo("проверка авто-назначения", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                local ai = ReadField(st2, "AssignedInfo")
                local rep = ai and ReadField(ai, "RepInfoArray") or nil
                local items = rep and ReadField(rep, "Items") or nil
                local n = items and TryLen(items) or nil
                Log("AssignedInfo.RepInfoArray.Items: " .. tostring(n) .. " палов назначено")
            end
        end)
        SafeDo("RequestStartMission_ServerInternal(0)", function()
            local st3 = FindStations()[idx]
            if IsValidObj(st3) then st3:RequestStartMission_ServerInternal(0) end
        end)
        DelayCall(Config.VerifyMs + 200, function()
            SafeDo("проверка после фолбэк-запуска", function()
                local st4 = FindStations()[idx]
                if IsValidObj(st4) then
                    local _, sname = GetState(st4)
                    Logf("state станции %d после фолбэк-запуска: %s", idx, tostring(sname))
                end
            end)
        end)
    end)
end

-- ============================== КОМАНДЫ ==============================

local function CmdScan()
    local stations = FindStations()
    Logf("=== SCAN: станций экспедиций найдено: %d ===", #stations)
    for i, st in ipairs(stations) do
        local _, sname = GetState(st)
        local tmid = Str(ReadField(st, "TargetMissionId"))
        local base = GetBaseName(st) or "?"
        local loc = GetLoc(st)
        local locStr = loc and string.format("(%.0f, %.0f)", Num(loc.x) or 0, Num(loc.y) or 0) or "?"
        local disp = ReadField(st, "bDisposed")
        Logf("  [%d] state=%s | mission=%s | база=%q | %s | disposed=%s",
            i, tostring(sname), tostring(tmid), tostring(base), locStr, tostring(disp))
    end
    local net = GetNetComp()
    Log("NetworkPlayerComponent: " .. (net and ObjName(net) or "НЕ НАЙДЕН"))
    local guild = GetGuildMission()
    if guild then
        local cnt = Num(ReadField(guild, "GuildExpedtionCount"))
        local rel = ReadField(guild, "ReleasedMissionInfos")
        local rn = rel and TryLen(rel) or nil
        Logf("GuildCharacterTeamMission: одновременных экспедиций=%s, открыто миссий=%s", tostring(cnt), tostring(rn))
    else
        Log("GuildCharacterTeamMission: не найден")
    end
end

local function CmdInfo(idx)
    local stations = FindStations()
    local st = stations[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (всего: " .. #stations .. ", см. exh scan)")
        return
    end
    Log("=== INFO станции " .. idx .. " ===")
    Log("  объект: " .. ObjName(st))
    local sn, sname = GetState(st)
    Logf("  State: %s (%s)", tostring(sname), tostring(sn))
    Log("  TargetMissionId: " .. tostring(Str(ReadField(st, "TargetMissionId"))))
    Log("  InstanceId: " .. tostring(Str(ReadField(st, "InstanceId"))))
    Log("  ModelInstanceId: " .. tostring(Str(ReadField(st, "ModelInstanceId"))))
    Log("  bDisposed: " .. tostring(ReadField(st, "bDisposed")))
    Log("  база: " .. tostring(GetBaseName(st)))

    local loc, out = GetLoc(st)
    if loc then
        Logf("  локация: (%s, %s, %s)", tostring(Num(loc.x)), tostring(Num(loc.y)), tostring(Num(loc.z)))
    else
        local parts = {}
        for k, v in pairs(out or {}) do parts[#parts + 1] = tostring(k) end
        Log("  локация: не прочитана; ключи out-таблицы: " .. table.concat(parts, ","))
    end

    local startT = Num(ReadField(st, "MissionStartDateTime") and ReadField(ReadField(st, "MissionStartDateTime"), "Ticks"))
    local endT = Num(ReadField(ReadField(st, "MissionCompleteDateTime"), "Ticks"))
    if startT then
        local s, e = TicksToUTC(startT)
        Log("  старт: " .. tostring(s) .. " (ticks=" .. tostring(startT) .. ")")
    else
        Log("  MissionStartDateTime.Ticks: не читается (" .. tostring(Str(ReadField(st, "MissionStartDateTime"))) .. ")")
    end
    if endT then
        local s, e = TicksToUTC(endT)
        local remain = e and (e - NowEpoch()) or nil
        Logf("  финиш: %s (ticks=%s), осталось: %s сек", tostring(s), tostring(endT), tostring(remain))
    else
        Log("  MissionCompleteDateTime.Ticks: не читается (" .. tostring(Str(ReadField(st, "MissionCompleteDateTime"))) .. ")")
    end

    local ai = ReadField(st, "AssignedInfo")
    if IsValidObj(ai) then
        local rep = ReadField(ai, "RepInfoArray")
        local items = rep and ReadField(rep, "Items") or nil
        local n = items and TryLen(items) or nil
        Log("  назначено палов (AssignedInfo): " .. tostring(n))
    else
        Log("  AssignedInfo: nil")
    end

    local cont, why = GetStationContainer(st)
    if cont then
        Log("  сундук: " .. ObjName(cont))
        DumpContainer("  [chest]", cont)
    else
        Log("  сундук: " .. tostring(why))
    end
end

local function CmdChest(idx)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    local cont, why = GetStationContainer(st)
    if not cont then
        Err(tostring(why))
        return
    end
    Log("=== CHEST станции " .. idx .. " ===")
    DumpContainer("[chest]", cont)
end

local function CmdBases()
    local bases = {}
    SafeDo("FindAllOf(PalBaseCampModel)", function()
        local all = FindAllOf("PalBaseCampModel")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) and not ObjName(mo):find("Default__", 1, true) then
                bases[#bases + 1] = mo
            end
        end
    end)
    Logf("=== BASES: баз найдено: %d ===", #bases)
    for i, b in ipairs(bases) do
        local name
        local okN, n = pcall(function() return b:GetBaseCampName() end)
        if okN then name = Str(n) end
        if not name or name == "" then name = Str(ReadField(b, "BaseCampName")) or "?" end
        Logf("  [%d] %q | id=%s", i, tostring(name), tostring(Str(ReadField(b, "BaseCampId"))))
    end
end

local function CmdGuild()
    local guild = GetGuildMission()
    if not guild then
        Err("GuildCharacterTeamMission не найден")
        return
    end
    Log("=== GUILD ===")
    Log("  объект: " .. ObjName(guild))
    Log("  одновременных экспедиций (GuildExpedtionCount): " .. tostring(Num(ReadField(guild, "GuildExpedtionCount"))))
    local rel = ReadField(guild, "ReleasedMissionInfos")
    local n = rel and TryLen(rel) or nil
    Log("  открытых миссий: " .. tostring(n))
    if n then
        for i = 1, math.min(n, 80) do
            local el = ArrAt(rel, i)
            if el ~= nil then
                Logf("    [%d] %s (bEnableChallenge=%s)", i,
                    tostring(Str(ReadField(el, "MissionId"))), tostring(ReadField(el, "bEnableChallenge")))
            end
        end
    end
end

local function CmdSettings()
    Log("=== SETTINGS ===")
    local gs = nil
    SafeDo("FindFirstOf(PalGameSetting)", function()
        local g = FindFirstOf("PalGameSetting")
        g = Unwrap(g)
        if IsValidObj(g) then gs = g end
    end)
    if not gs then
        Log("  PalGameSetting не найден (FindFirstOf)")
        return
    end
    Log("  объект: " .. ObjName(gs))
    local cls = ReadField(gs, "ExpeditionStrengthSortFunctionsClass")
    if IsValidObj(cls) then
        Log("  ExpeditionStrengthSortFunctionsClass: " .. ObjName(cls))
    else
        Log("  ExpeditionStrengthSortFunctionsClass: nil/не класс")
    end
end

local function CmdUI(idx)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    Log("=== UI-ПРОБА станции " .. idx .. " (БЕЗ репликации) ===")
    WithUIModel(st, false, ProbeUIModelReads)
    Log("=== UI-ПРОБА станции " .. idx .. " (С репликацией) ===")
    WithUIModel(st, true, ProbeUIModelReads)
end

local function CmdMissions(idx)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    Log("=== MISSIONS станции " .. idx .. " ===")
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
        DumpMissionArray(arr, "GetSelectableMissionInfos")
    end)
end

local function CmdSelect(idx, missionId)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    Logf("=== SELECT станции %d: миссия '%s' ===", idx, tostring(missionId))
    WithUIModel(st, true, function(ui)
        local ok, res = pcall(function() ui:RequestSelectMission(missionId) end)
        Log("RequestSelectMission: " .. ((ok and "вызвана") or ("FAIL → " .. tostring(res))))
    end)
    DelayCall(Config.VerifyMs, function()
        SafeDo("проверка TargetMissionId", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                Log("TargetMissionId теперь: " .. tostring(Str(ReadField(st2, "TargetMissionId"))))
            end
        end)
    end)
end

local function CmdAuto(idx)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    Log("=== AUTO станции " .. idx .. " (RequestSelectAuto) ===")
    WithUIModel(st, true, function(ui)
        local ok, res = pcall(function() ui:RequestSelectAuto() end)
        Log("RequestSelectAuto: " .. ((ok and "вызвана") or ("FAIL → " .. tostring(res))))
    end)
    DelayCall(Config.VerifyMs, function()
        SafeDo("проверка назначенных", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                local ai = ReadField(st2, "AssignedInfo")
                local rep = ai and ReadField(ai, "RepInfoArray") or nil
                local items = rep and ReadField(rep, "Items") or nil
                local n = items and TryLen(items) or nil
                Log("назначено палов (AssignedInfo): " .. tostring(n))
            end
        end)
    end)
end

local function CmdRemain(idx)
    local st = FindStations()[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена (см. exh scan)")
        return
    end
    Log("=== REMAIN станции " .. idx .. " ===")
    local endT = Num(ReadField(ReadField(st, "MissionCompleteDateTime"), "Ticks"))
    if endT then
        local s, e = TicksToUTC(endT)
        Logf("  из модели: финиш=%s, осталось ≈ %s сек (сейчас UTC %s)",
            tostring(s), e and tostring(e - NowEpoch()) or "?", os.date("!%Y-%m-%d %H:%M:%S"))
    else
        Log("  MissionCompleteDateTime.Ticks не читается")
    end
    WithUIModel(st, true, function(ui)
        local ok, r = pcall(function() return ui:GetRemainMissionSeconds() end)
        Log("  из UI-модели GetRemainMissionSeconds: " .. (ok and tostring(Num(r)) or "FAIL"))
    end)
end

local function CmdCollectAll()
    local stations = FindStations()
    local targets = {}
    for i, st in ipairs(stations) do
        local sn = GetState(st)
        if sn == 3 then targets[#targets + 1] = i end
    end
    if #targets == 0 then
        Log("нет станций в состоянии Reward — собирать нечего")
        return
    end
    Logf("=== COLLECTALL: станций с наградой: %d (%s) ===", #targets, table.concat(targets, ", "))
    for k, i in ipairs(targets) do
        DelayCall(200 * k, function()
            SafeDo("collect ст." .. i, function()
                local st = FindStations()[i]
                if IsValidObj(st) then DoCollect(st, i) end
            end)
        end)
    end
end

local function CmdHelp()
    Log("ExpeditionHubTest v0.1 — команды:")
    Log("  exh scan                     — все станции + компоненты")
    Log("  exh info <N>                 — подробный дамп станции N")
    Log("  exh chest <N>                — слоты сундука станции N")
    Log("  exh bases                    — все базы (имена)")
    Log("  exh guild                    — открытые миссии гильдии")
    Log("  exh settings                 — ExpeditionStrengthSortFunctionsClass")
    Log("  exh ui <N>                   — проба UI-модели (без/с репликацией)")
    Log("  exh missions <N>             — доступные миссии станции N")
    Log("  exh select <N> <MissionId>   — выбрать миссию")
    Log("  exh auto <N>                 — авто-назначение палов")
    Log("  exh start <N>                — запуск экспедиции")
    Log("  exh remain <N>               — остаток времени")
    Log("  exh collect <N>              — забрать лут станции N")
    Log("  exh collectall               — забрать лут со всех станций (Reward)")
    Log("  exh fb <N>                   — ФОЛБЭК: ServerInternal напрямую (синглплеер)")
end

-- ============================== ОБРАБОТЧИК КОНСОЛИ ==============================

local function ParseIdx(params)
    local n = tonumber(params and params[2] and tostring(params[2]))
    if n == nil then
        Err("нужен номер станции (например: exh info 1; список: exh scan)")
        return nil
    end
    return math.floor(n)
end

local function cmdHandler(params)
    SafeDo("cmd:exh", function()
        local sub = (params and params[1] and tostring(params[1]):lower()) or "help"
        if sub == "scan" then
            CmdScan()
        elseif sub == "info" then
            local i = ParseIdx(params); if i then CmdInfo(i) end
        elseif sub == "chest" then
            local i = ParseIdx(params); if i then CmdChest(i) end
        elseif sub == "bases" then
            CmdBases()
        elseif sub == "guild" then
            CmdGuild()
        elseif sub == "settings" then
            CmdSettings()
        elseif sub == "ui" then
            local i = ParseIdx(params); if i then CmdUI(i) end
        elseif sub == "missions" then
            local i = ParseIdx(params); if i then CmdMissions(i) end
        elseif sub == "select" then
            local i = ParseIdx(params)
            local mid = params and params[3] and tostring(params[3])
            if i and mid and mid ~= "" then CmdSelect(i, mid) end
        elseif sub == "auto" then
            local i = ParseIdx(params); if i then CmdAuto(i) end
        elseif sub == "start" then
            local i = ParseIdx(params); if i then DoStart(i, true) end
        elseif sub == "remain" then
            local i = ParseIdx(params); if i then CmdRemain(i) end
        elseif sub == "collect" then
            local i = ParseIdx(params)
            if i then
                local st = FindStations()[i]
                if IsValidObj(st) then DoCollect(st, i) end
            end
        elseif sub == "collectall" then
            CmdCollectAll()
        elseif sub == "fb" then
            local i = ParseIdx(params); if i then DoFallbackStart(i) end
        elseif sub == "help" then
            CmdHelp()
        else
            Log("неизвестная подкоманда '" .. tostring(sub) .. "' — exh help")
        end
    end)
    return true
end

local okCmd = pcall(RegisterConsoleCommandHandler, "exh", cmdHandler)
if okCmd then
    Log("ExpeditionHubTest v0.1 загружен. Команды: `exh help` в консоли UE4SS.")
else
    Log("RegisterConsoleCommandHandler недоступен — команды не работают")
end
