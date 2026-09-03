-- ============================================================================================
-- ============================================================================================
-- ============================================================================================
-- ============================================================================================
-- ExpeditionHubTest v0.8 — ТЕСТОВЫЙ мод (UE4SS Lua) для Palworld 0.4.11
-- Менеджер экспедиций: панель на F6. ВСЕ станции со всех баз. Полный цикл из панели:
-- выбор миссии → НАЗНАЧЕНИЕ ПАЛОВ ВРУЧНУЮ (Palbox, слоты 0..100) или АВТО → запуск → сбор.
-- Игровой UI станции НЕ открываем вообще (v0.4/v0.5: ломает мышь + краш при перезаходе).
--
-- УРОКИ ЖИВОГО ТЕСТА v0.7 (краш 0x70 при выборе миссии):
--   • вызов статических сериализаторов игры (WriteBlackboard/WritePlayerFeedItemTo на CDO)
--     САМ КРАШИТ 0x70 (ref-параметр архива) → в v0.8 НЕ вызываем их вообще;
--   • хуки с двоеточием работают и дали ВАНИЛЬНЫЕ ЭТАЛОНЫ байтов FPalNetArchive:
--       FName        → int32(len+1) + UTF-16LE + L'\0'
--         ("DUNGEON_GRASS" → 0E 00 00 00 44 00 55 00 … 53 00 00 00, 32 байта)
--       FPalInstanceID → FString(DebugName, пустая → 00 00 00 00)
--                        + PlayerUId GUID (16 байт raw LE) + InstanceId GUID (16 байт raw LE)
--         (итого 36 байт; SDK: FPalInstanceID{PlayerUId FGuid; InstanceId FGuid; DebugName FString});
--   • АВТО-заполнение подтверждено живьём (0 → 6 палов);
--   • байты теперь собираем ЧИСТЫМ LUA — никаких вызовов игровых сериализаторов.
--
-- МЕХАНИКА (SDK + ванила):
--   • флоу: список миссий → выбор → заполнение палов 0..100 → старт. Требование стихии ×N,
--     рекомендуемая сила; % награды = сила команды ÷ рекомендуемая; палы только из Palbox;
--   • все записи — через ServerInternal модели станции (подтверждено v0.3/v0.7):
--       RequestSelectMission_ServerInternal(playerId, FPalNetArchive)
--       RequestSelectAssignedCharacter_ServerInternal(playerId, FPalNetArchive)
--       RequestUnselectAssignedCharacter_ServerInternal(playerId, FPalNetArchive)
--       RequestUnselectAll_ServerInternal(playerId) / RequestSelectAuto_ServerInternal(playerId)
--       RequestStartMission_ServerInternal(playerId) / RequestCancelInProgressMission_ServerInternal(playerId)
--   • FPalNetArchive = { TArray<uint8> Bytes }, передаётся таблицей { Bytes = {…} };
--   • действия со станцией — только в состоянии Ready (InProgress/Reward сервер отклонит).
--
-- БОРЬБА С КРАШАМИ (pcall НЕ ловит нативные краши):
--   1. НИ ОДНОЙ ссылки на UObject между действиями (S хранит только примитивы/таблицы);
--   2. одна перерисовка на клик, все объекты переищиваются заново;
--   3. UI-модели — ТОЛЬКО ЧТЕНИЕ; записи только через ServerInternal станции;
--   4. НИКАКИХ прямых записей игровых полей и вызовов игровых сериализаторов (уроки v0.6/v0.7);
--   5. хуки ServerInternal только ЛОГИРУЮТ (дамп байтов — и наши, и ванильные вызовы).
--
-- УДАЛЕНИЕ: снести папку Mods/ExpeditionHubTest.
-- ============================================================================================
local TAG = "[ExpeditionHub]"

-- ============================== НАСТРОЙКИ (правь тут) ==============================
local Config = {
    OpenKey     = "F6",   -- открыть/закрыть панель
    VerifyMs    = 700,    -- задержка проверки состояния после запуска
    AutoStartMs = 400,    -- пауза между авто-назначением палов и стартом
    LogLines    = 20,     -- сколько строк лога видно в панели
    LogBuffer   = 120,    -- сколько строк храним всего
}

local STATE_NAMES = { [0] = "None", [1] = "Ready", [2] = "InProgress", [3] = "Reward" }
local UI_MODEL_CLASS = "/Script/Pal.PalUIMapObjectCharacterTeamMissionModel"
-- имена стихий (EPalElementType, Pal_enums.hpp)
local ELEMENT_NAMES = {
    [0] = "—", [1] = "Normal", [2] = "Fire", [3] = "Water", [4] = "Leaf",
    [5] = "Electricity", [6] = "Ice", [7] = "Earth", [8] = "Dark", [9] = "Dragon",
}
-- Статические сериализаторы игры (WriteBlackboard и пр.) НЕ вызываем: вызов на CDO
-- крашил 0x70 (живой тест v0.7). Байты архива собираем сами — см. сериализаторы ниже
-- (форматы подтверждены ванильными дампами из хуков).

-- ============================== СОСТОЯНИЕ (только примитивы, НИКАКИХ UObject) ============
local S = {
    sel       = 1,          -- выбранная станция (индекс в FindStations)
    logLines  = {},         -- кольцевой буфер лога (строки)
    missions  = nil,        -- список миссий { {id, text, secs, rec, el, elNum, max} } — примитивы
    mode      = "missions", -- режим блока списка: missions | palbox | assigned
    palbox    = nil,        -- снимок Palbox { {key, idTable, name, level, rank, strength, busy} }
    listPage  = 1,          -- страница списка
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

-- чтение свойства объекта/структуры — всегда безопасно (без IsValid-гейта:
-- он врёт на обёртках структур)
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
    return nil
end

local function ArrAt(arr, i)
    local ok, v = pcall(function() return arr[i] end)
    if not ok then return nil end
    return Unwrap(v)
end

-- массив → обычная Lua-таблица (или nil); LocalUnrealParam разворачивается
local function ArrayToTable(v)
    if v == nil then return nil end
    v = Unwrap(v)
    local n = TryLen(v)
    if n == nil then
        local t = {}
        local i = 1
        while i <= 200 do
            local ok, item = pcall(function() return v[i] end)
            if not ok or item == nil then break end
            t[i] = Unwrap(item)
            i = i + 1
        end
        if #t > 0 then return t end
        return nil
    end
    local t = {}
    for i = 1, n do
        t[i] = ArrAt(v, i)
    end
    return t
end

local function DelayCall(ms, fn)
    local ok, err = pcall(ExecuteWithDelay, ms, fn)
    if not ok then Err("ExecuteWithDelay → " .. tostring(err)) end
end

-- ============================== ПОИСК ОБЪЕКТОВ (каждый раз заново) ==============================
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

local function GetLocalPlayerController()
    local result = nil
    SafeDo("FindAllOf(PalPlayerController)", function()
        local all = FindAllOf("PalPlayerController")
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

-- playerId для ServerInternal-функций (подтверждено тестом: 259)
local function GetLocalPlayerId()
    local pc = GetLocalPlayerController()
    if not pc then return nil, "нет PlayerController" end
    local ok, ps = pcall(function() return pc:GetPalPlayerState() end)
    if ok and ps ~= nil then
        ps = Unwrap(ps)
        if IsValidObj(ps) then
            local okI, id = pcall(function() return ps:GetPlayerId() end)
            if okI then return Num(id), "PalPlayerState:GetPlayerId()" end
        end
    end
    local ps2 = ReadField(pc, "PlayerState")
    if IsValidObj(ps2) then
        local okI, id = pcall(function() return ps2:GetPlayerId() end)
        if okI then return Num(id), "PlayerState:GetPlayerId()" end
    end
    return nil, "PlayerState не найден"
end

local function GetLocalPawn()
    local pc = GetLocalPlayerController()
    if not pc then return nil end
    local ok, pawn = pcall(function() return pc:K2_GetPawn() end)
    if ok and pawn ~= nil then
        pawn = Unwrap(pawn)
        if IsValidObj(pawn) then return pawn end
    end
    return nil
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

local function GuidKeyFromParts(a, b, c, d)
    if a == nil or b == nil or c == nil or d == nil then return nil end
    return string.format("%d_%d_%d_%d", a, b, c, d)
end

-- GUID станции из поля InstanceId или ModelInstanceId (поля A/B/C/D отражены)
local function StationGuidKey(st, fieldName)
    local w = ReadField(st, fieldName)
    if w == nil then return nil end
    return GuidKeyFromParts(Num(ReadField(w, "A")), Num(ReadField(w, "B")),
                            Num(ReadField(w, "C")), Num(ReadField(w, "D")))
end

-- GUID из out-таблицы GetConcreteModelInstanceId
local function OutTableGuidKey(out)
    if type(out) ~= "table" then return nil end
    return GuidKeyFromParts(Num(out.A), Num(out.B), Num(out.C), Num(out.D))
end

-- ЖИВАЯ привязанная UI-модель станции: игра сама создаёт такие (WorldHUD-индикаторы)
-- на весь сеанс. Ищем заново ПРИ КАЖДОМ КЛИКЕ, ничего не храним.
local function FindBoundModelForStation(st, quiet)
    local instKey  = StationGuidKey(st, "InstanceId")
    local modelKey = StationGuidKey(st, "ModelInstanceId")
    local bound = {}
    SafeDo("FindAllOf(PalUIMapObjectCharacterTeamMissionModel)", function()
        local all = FindAllOf("PalUIMapObjectCharacterTeamMissionModel")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) and not ObjName(mo):find("Default__", 1, true) then
                local out = {}
                if pcall(function() mo:GetConcreteModelInstanceId(out) end) then
                    local g = OutTableGuidKey(out)
                    if g and g ~= "0_0_0_0" then
                        bound[#bound + 1] = { model = mo, guid = g }
                    end
                end
            end
        end
    end)
    for _, e in ipairs(bound) do
        if e.guid == instKey then return e.model, "совпал InstanceId" end
    end
    for _, e in ipairs(bound) do
        if e.guid == modelKey then return e.model, "совпал ModelInstanceId" end
    end
    local guids = {}
    for _, e in ipairs(bound) do guids[#guids + 1] = e.guid end
    if not quiet then
        Log(string.format("привязанные UI-модели: %d шт %s", #bound,
            (#bound > 0 and ("{" .. table.concat(guids, ", ") .. "}")) or "(не найдено)"))
        Log(string.format("станция: InstanceId=%s | ModelInstanceId=%s", tostring(instKey), tostring(modelKey)))
    end
    return nil, "ни одна привязанная модель не совпала со станцией"
end

-- сундук станции: прямое чтение поля TargetContainer, затем функции
local function GetStationContainer(st)
    local ok, mod = pcall(function() return st:GetItemContainerModule() end)
    if not ok then return nil, "GetItemContainerModule → " .. tostring(mod) end
    mod = Unwrap(mod)
    if not IsValidObj(mod) then return nil, "item container module = nil/invalid" end

    local tc = ReadField(mod, "TargetContainer")
    if IsValidObj(tc) then return tc, "module.TargetContainer" end

    local okC, cont = pcall(function() return mod:GetContainer() end)
    if okC and cont ~= nil then
        cont = Unwrap(cont)
        if IsValidObj(cont) then return cont, "GetContainer" end
    end

    local out = {}
    local okT = pcall(function() return mod:TryGetContainer(out) end)
    if okT then
        local c = Unwrap(out.OutContainer or out.outContainer or out[1])
        if IsValidObj(c) then return c, "TryGetContainer" end
    end
    return nil, "контейнера нет (у станции без награды это норма)"
end

local function CountChest(cont)
    if not IsValidObj(cont) then return 0, 0 end
    local slots = ArrayToTable(ReadField(cont, "ItemSlotArray"))
    local total = slots and #slots or 0
    local used = 0
    if slots then
        for i = 1, total do
            local slot = slots[i]
            if IsValidObj(slot) then
                local empty = true
                pcall(function() empty = (slot:IsEmpty() == true) end)
                if not empty then used = used + 1 end
            end
        end
    end
    return used, total
end

local function DumpContainer(label, cont)
    if not IsValidObj(cont) then
        Log(label .. ": контейнер невалиден")
        return
    end
    local slots = ArrayToTable(ReadField(cont, "ItemSlotArray"))
    if not slots then
        Log(label .. ": ItemSlotArray не читается")
        return
    end
    local used = 0
    for i = 1, #slots do
        local slot = slots[i]
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
    if used == 0 then Log(label .. ": сундук ПУСТ (" .. tostring(#slots) .. " слотов)") end
end

-- ============================== ПАЛЫ / БАЙТЫ АРХИВА ==============================
-- FGuid (структура/userdata) → {A=,B=,C=,D=} беззнаковые
local function ReadGuidTable(w)
    if w == nil then return nil end
    local function part(p)
        local n = Num(ReadField(w, p))
        if n == nil then return nil end
        n = math.floor(n)
        if n < 0 then n = n + 4294967296 end
        return n
    end
    local a, b, c, d = part("A"), part("B"), part("C"), part("D")
    if a == nil or b == nil or c == nil or d == nil then return nil end
    return { A = a, B = b, C = c, D = d }
end

-- FPalInstanceID (структура) → Lua-таблица {PlayerUId=…, InstanceId=…}
local function IdStructToTable(w)
    if w == nil then return nil end
    local pu = ReadGuidTable(ReadField(w, "PlayerUId"))
    local ii = ReadGuidTable(ReadField(w, "InstanceId"))
    if not ii then return nil end
    return { PlayerUId = pu or { A = 0, B = 0, C = 0, D = 0 }, InstanceId = ii }
end

local function PalKeyOf(idTable)
    if not idTable or not idTable.InstanceId then return nil end
    local g = idTable.InstanceId
    return string.format("I_%d.%d.%d.%d", g.A or 0, g.B or 0, g.C or 0, g.D or 0)
end

-- uint32 → 4 байта little-endian
local function U32Bytes(n)
    n = math.floor(n)
    if n < 0 then n = n + 4294967296 end
    return { n % 256, math.floor(n / 256) % 256, math.floor(n / 65536) % 256, math.floor(n / 16777216) % 256 }
end

local function GuidToBytes(g)
    local t = {}
    for _, partName in ipairs({ "A", "B", "C", "D" }) do
        local bs = U32Bytes(g[partName] or 0)
        for i = 1, 4 do t[#t + 1] = bs[i] end
    end
    return t
end

-- ================== СЕРИАЛИЗАТОРЫ FPalNetArchive (чистый Lua) ==================
-- Форматы подтверждены ВАНИЛЬНЫМИ ДАМПАМИ из хуков (живой тест v0.7):
--   строка/FName → int32(число символов С нулём) + UTF-16LE + L'\0';
--   FPalInstanceID → FString(DebugName, пустая) + PlayerUId(16 raw LE) + InstanceId(16 raw LE).

-- FString: int32(len+1) + UTF-16LE + завершающий L'\0' (ASCII-имена)
local function FStringBytes(text)
    local s = tostring(text or "")
    local out = U32Bytes(s:len() + 1)
    for i = 1, #s do
        local c = s:byte(i)
        out[#out + 1] = c
        out[#out + 1] = 0
    end
    out[#out + 1] = 0
    out[#out + 1] = 0
    return out
end

-- FName → байты архива ("DUNGEON_GRASS" → 0E 00 00 00 44 00 55 00 … 53 00 00 00)
local function FNameToArchiveBytes(name)
    return FStringBytes(name)
end

-- FPalInstanceID пала → 36 байт архива:
--   00 00 00 00 (пустой FString DebugName) + PlayerUId GUID + InstanceId GUID
local function PalIdToArchiveBytes(idTable)
    local out = U32Bytes(0)
    local p = GuidToBytes(idTable.PlayerUId or { A = 0, B = 0, C = 0, D = 0 })
    for i = 1, #p do out[#out + 1] = p[i] end
    local inst = GuidToBytes(idTable.InstanceId)
    for i = 1, #inst do out[#out + 1] = inst[i] end
    return out
end

local function BytesToHex(bytes, maxN)
    local hex = {}
    for i = 1, math.min(#bytes, maxN or 48) do
        hex[#hex + 1] = string.format("%02X", math.floor(Num(bytes[i]) or 0))
    end
    return table.concat(hex, " ")
end


-- назначенные палы станции (чтение AssignedInfo.RepInfoArray.Items) — примитивы/таблицы
local function AssignedItemsOf(st)
    local out = {}
    if not IsValidObj(st) then return out end
    local ai = ReadField(st, "AssignedInfo")
    local rep = ai and ReadField(ai, "RepInfoArray") or nil
    local items = rep and ArrayToTable(ReadField(rep, "Items")) or nil
    if not items then return out end
    for i = 1, #items do
        local it = items[i]
        if it ~= nil then
            local idT = IdStructToTable(ReadField(it, "IndividualId"))
            local info = ReadField(it, "IndividualInfo")
            out[#out + 1] = {
                key      = idT and PalKeyOf(idT) or ("idx" .. i),
                idTable  = idT,
                name     = (info and Str(ReadField(info, "NickName"))) or "пал",
                level    = (info and Num(ReadField(info, "Level"))) or nil,
                strength = (info and Num(ReadField(info, "Strength"))) or nil,
            }
        end
    end
    return out
end

-- ключи палов, занятых на ЛЮБЫХ станциях (для пометок в списке Palbox)
local function BusyPalKeys()
    local keys = {}
    for _, st in ipairs(FindStations()) do
        for _, item in ipairs(AssignedItemsOf(st)) do
            keys[item.key] = true
        end
    end
    return keys
end

-- контейнер Palbox игрока
local function GetPalStorageContainer()
    local pc = GetLocalPlayerController()
    if not pc then return nil, "нет PlayerController" end
    local ps = nil
    local ok, r = pcall(function() return pc:GetPalPlayerState() end)
    if ok then ps = Unwrap(r) end
    if not IsValidObj(ps) then ps = ReadField(pc, "PlayerState") end
    if not IsValidObj(ps) then return nil, "PlayerState не найден" end
    local storage
    local okS, s = pcall(function() return ps:GetPalStorage() end)
    if okS then storage = Unwrap(s) end
    if not IsValidObj(storage) then return nil, "GetPalStorage() → nil" end
    local cont = ReadField(storage, "TargetContainer")
    if not IsValidObj(cont) then return nil, "TargetContainer → nil" end
    return cont
end

-- слот Palbox → описание пала (nil = пустой слот)
local function ReadPalSlot(slot)
    if not IsValidObj(slot) then return nil end
    local empty = false
    pcall(function() empty = (slot:IsEmpty() == true) end)
    if empty then return nil end

    local idT = IdStructToTable(ReadField(slot, "ReplicateHandleID"))
    if not idT then
        local okH, h = pcall(function() return slot:GetHandle() end)
        if okH then
            h = Unwrap(h)
            if IsValidObj(h) then idT = IdStructToTable(ReadField(h, "ID")) end
        end
    end
    if not idT then return nil end

    local param = ReadField(slot, "ReplicateIndividualParameter")
    if not IsValidObj(param) then
        local okP, p2 = pcall(function()
            local h = Unwrap(slot:GetHandle())
            return h and h:TryGetIndividualParameter() or nil
        end)
        if okP then param = Unwrap(p2) end
    end

    local name, level, rank, species, excluded = "пал", nil, nil, nil, false
    if IsValidObj(param) then
        local sp = ReadField(param, "SaveParameter")
        if sp ~= nil then
            local nick = Str(ReadField(sp, "NickName"))
            species = Str(ReadField(sp, "CharacterID"))
            name = (nick and nick ~= "" and nick) or species or "пал"
            level = Num(ReadField(sp, "Level"))
            rank = Num(ReadField(sp, "Rank"))
        end
        local okE, ex = pcall(function() return param:IsExcludedFromTeamMission() end)
        if okE then excluded = (ex == true) end
    end

    return {
        key = PalKeyOf(idT), idTable = idT, name = name, species = species,
        level = level, rank = rank, excluded = excluded,
    }
end

-- ============================== ДЕЙСТВИЯ ==============================
local refreshIfOpen  -- назначается после сборки UI
local Presenter_Close -- forward declaration (используется GUI-секцией ниже)

local function SelectedStation()
    local stations = FindStations()
    if #stations == 0 then return nil, 0 end
    if S.sel < 1 or S.sel > #stations then S.sel = 1 end
    return stations[S.sel], #stations
end

local function StationDetailLines()
    local st, total = SelectedStation()
    if not st then return { "СТАНЦИЙ НЕ НАЙДЕНО — построй станцию или перезайди" }, 0 end
    local lines = {}
    local _, sname = GetState(st)
    local tmid = Str(ReadField(st, "TargetMissionId"))
    lines[#lines + 1] = string.format("СОСТОЯНИЕ: %s     МИССИЯ: %s", tostring(sname), tostring(tmid))
    local loc = GetLoc(st)
    local locStr = loc and string.format("     коорд: (%.0f, %.0f)", loc.x, loc.y) or ""
    lines[#lines + 1] = string.format("БАЗА: %s%s", tostring(GetBaseName(st) or "?"), locStr)
    local ai = ReadField(st, "AssignedInfo")
    local rep = ai and ReadField(ai, "RepInfoArray") or nil
    local items = rep and ArrayToTable(ReadField(rep, "Items")) or nil
    local cont = GetStationContainer(st)
    local used, totalSlots = 0, 0
    if cont then used, totalSlots = CountChest(cont) end
    lines[#lines + 1] = string.format("ПАЛЫ: %s     СУНДУК: %s", tostring(items and #items or nil),
        (cont and string.format("занято %d из %d", used, totalSlots)) or "нет (норма без награды)")
    -- требования стихии / сила команды / % награды — через живую UI-модель (ТОЛЬКО ЧТЕНИЕ)
    do
        local bm = FindBoundModelForStation(st, true)
        if bm then
            local out = {}
            local okE = pcall(function() bm:GetCurrentElementalRequiredInfo(out) end)
            local okR, rate = pcall(function() return bm:CalculateCurrentRewardRate() end)
            local okT, team = pcall(function() return bm:CalculateCharacterTeamStrength() end)
            local parts = {}
            if okE then
                local elT = Num(out.OutRequiredElementType or out.RequiredElementType)
                local curN = Num(out.CurrentAssignedNum)
                local reqN = Num(out.RequiredNum)
                local sat = out.bSatisfiedCondition
                if elT ~= nil then
                    parts[#parts + 1] = string.format("стихия: %s %s/%s%s",
                        ELEMENT_NAMES[elT] or tostring(elT), tostring(curN), tostring(reqN),
                        ((sat == true or sat == 1) and " ✔") or "")
                end
            end
            if okT then parts[#parts + 1] = "сила: " .. tostring(Num(team)) end
            if okR then parts[#parts + 1] = string.format("награда: %.0f%%", (Num(rate) or 0) * 100) end
            if #parts > 0 then
                lines[#lines + 1] = table.concat(parts, "   |   ")
            end
        end
    end
    return lines, total
end

-- ЗАПУСК: старт выбранной миссии с ТЕКУЩИМ составом (ручной состав НЕ трогаем —
-- в v0.5 selectAuto затирал ручной выбор; авто теперь отдельная кнопка)
local function DoLaunchRepeat()
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname == "InProgress" then
        Log("ЗАПУСК: экспедиция уже идёт (InProgress) — дождись или ОТМЕНИТЬ (режим НАЗНАЧЕНЫ)")
        return
    end
    if sname ~= "Ready" then
        Log("ЗАПУСК: станция в состоянии " .. tostring(sname) .. " — старт возможен только из Ready")
        return
    end
    local tmid = Str(ReadField(st, "TargetMissionId"))
    if tmid == nil or tmid == "None" or tmid == "" then
        Log("ЗАПУСК: у станции НЕ выбрана миссия — выбери её в списке (режим МИССИИ)")
        return
    end
    local nAssigned = #AssignedItemsOf(st)
    if nAssigned == 0 then
        Log("ЗАПУСК: назначено 0 палов — пустая команда = 0% награды. Добавь палов (режим PALBOX) или АВТО-ПАЛЫ.")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then
        Err("playerId не получен: " .. tostring(psrc))
        return
    end
    Logf("ЗАПУСК станции %d: миссия '%s', палов %d (playerId=%s)", S.sel, tmid, nAssigned, tostring(pid))
    SafeDo("RequestStartMission_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestStartMission_ServerInternal(pid) end
    end)
    DelayCall(Config.VerifyMs, function()
        SafeDo("проверка после запуска", function()
            local st2 = SelectedStation()
            if st2 then
                local _, sname = GetState(st2)
                Logf("итог: state=%s, палов=%d", tostring(sname), #AssignedItemsOf(st2))
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end


-- свежая UI-модель (только для чтения списка миссий; сразу отбрасывается)
local function CreateUIModel(st)
    local cls = StaticFindObject(UI_MODEL_CLASS)
    if not IsValidObj(cls) then return nil end
    local ok, ui = pcall(function() return StaticConstructObject(cls, st) end)
    if not ok then return nil end
    ui = Unwrap(ui)
    if not IsValidObj(ui) then return nil end
    return ui
end

-- элементы FPalCharacterTeamMissionInfo лежат прямо в out-таблице: out[1]..out[N]
local function MissionsFromOutTable(out)
    if type(out) ~= "table" then return nil end
    local t = {}
    local i = 1
    while i <= 100 do
        local v = out[i]
        if v == nil then break end
        t[i] = Unwrap(v)
        i = i + 1
    end
    if #t == 0 then return nil end
    return t
end

local function DumpMissionElem(el)
    local res = { id = nil, text = "", secs = nil, rec = nil, el = nil, elNum = nil, max = nil }
    if el == nil then res.text = "(элемент nil)"; return res end
    local mid = Str(ReadField(el, "MissionId"))
    res.id = mid
    local line = tostring(mid or "?")
    local md = ReadField(el, "MasterData")
    if md ~= nil then
        local secs  = Num(ReadField(md, "RequiredSeconds"))
        local rec   = Num(ReadField(md, "RecommendedStrength"))
        local diff  = Num(ReadField(md, "Difficulty"))
        local elT   = Num(ReadField(md, "RequiredElementType"))
        local elNum = Num(ReadField(md, "RequiredElementNum"))
        local maxN  = Num(ReadField(md, "MaxCharacterNum"))
        res.secs, res.rec, res.el, res.elNum, res.max = secs, rec, elT, elNum, maxN
        local diffName = (diff == 0 and "Easy") or (diff == 1 and "Normal") or (diff == 2 and "Hard")
            or (diff == 3 and "VeryHard") or tostring(diff)
        local timeStr = "?"
        if secs ~= nil then
            local mins = math.floor(secs / 60)
            if mins >= 60 then timeStr = string.format("%dч%02d", math.floor(mins / 60), mins % 60)
            else timeStr = mins .. "м" end
        end
        line = string.format("%s | %s | %s | сила %s | %s×%s | макс %s",
            tostring(mid or "?"), diffName, timeStr, tostring(rec),
            ELEMENT_NAMES[elT] or tostring(elT), tostring(elNum), tostring(maxN))
    end
    res.text = line
    return res
end


-- ВЫБРАТЬ МИССИЮ: загрузить список доступных миссий в панель
local function DoLoadMissions()
    local st = SelectedStation()
    if not st then return end
    Log("=== СПИСОК МИССИЙ станции " .. S.sel .. " ===")
    local function LoadFrom(ui)
        local out = {}
        local ok, res = pcall(function() ui:GetSelectableMissionInfos(out) end)
        if not ok then
            Err("GetSelectableMissionInfos → " .. tostring(res))
            return
        end
        local t = MissionsFromOutTable(out) or ArrayToTable(out.OutInfos or out.outInfos)
        if not t or #t == 0 then
            Log("список пуст")
            return
        end
        S.missions = {}
        for i = 1, math.min(#t, 12) do
            local info = DumpMissionElem(t[i])
            S.missions[#S.missions + 1] = info
        end
        Logf("миссий: %d — список ниже (режим МИССИИ)", #t)
    end
    local bound = FindBoundModelForStation(st)
    if bound then
        Log("список: через живую привязанную модель")
        local ok, res = pcall(LoadFrom, bound)
        if not ok then Err("чтение через привязанную модель → " .. tostring(res)) end
    else
        Log("список: привязанной модели нет — через свежую (гильдейский список)")
        local ui = CreateUIModel(st)
        if not ui then
            Err("не удалось создать модель для чтения списка")
            return
        end
        local ok, res = pcall(LoadFrom, ui)
        if not ok then Err("чтение через свежую модель → " .. tostring(res)) end
    end
    if refreshIfOpen then refreshIfOpen() end
end

-- ВЫБОР МИССИИ: ТОЛЬКО через ServerInternal с архивом (байты FName сериализует
-- сама игра через WriteBlackboard). Прямая запись TargetMissionId УДАЛЕНА после краша
-- 0x70 в v0.6: она обходила серверный флоу и оставляла станцию полуинициализированной.
local function DoSelectMission(missionId)
    local st = SelectedStation()
    if not st then return end
    if missionId == nil or missionId == "" then
        Err("missionId пуст")
        return
    end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err(string.format("ВЫБОР: станция в состоянии %s — выбор возможен только в Ready%s",
            tostring(sname), (sname == "Reward" and " (сначала СОБРАТЬ ЛУТ)" or "")))
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then
        Err("playerId не получен: " .. tostring(psrc))
        return
    end
    Logf("ВЫБОР миссии '%s' (playerId=%s, state=%s)", tostring(missionId), tostring(pid), tostring(sname))

    local bytes = FNameToArchiveBytes(missionId)
    Logf("архив миссии (%d байт): %s", #bytes, BytesToHex(bytes, 32))
    SafeDo("RequestSelectMission_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestSelectMission_ServerInternal(pid, { Bytes = bytes }) end
    end)
    DelayCall(700, function()
        SafeDo("проверка выбора миссии", function()
            local st2 = SelectedStation()
            if not st2 then return end
            local now = Str(ReadField(st2, "TargetMissionId"))
            if now == missionId then
                Logf("ГОТОВО: миссия выбрана через архив (TargetMissionId=%s)", tostring(now))
            else
                Err(string.format("выбор не сработал (TargetMissionId=%s). " ..
                    "Сравни в логе наши байты с «>>> [hook] выбор миссии» и пришли лог.",
                    tostring(now)))
            end
            if refreshIfOpen then refreshIfOpen() end
        end)
    end)
end


-- АВТО-заполнение слотов палов (подтверждено живьём в v0.3)
local function DoAutoFill()
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err(string.format("АВТО: станция в состоянии %s — нужно Ready%s", tostring(sname),
            (sname == "Reward" and " (сначала СОБРАТЬ ЛУТ)" or "")))
        return
    end
    local tmid = Str(ReadField(st, "TargetMissionId"))
    if tmid == nil or tmid == "None" or tmid == "" then
        Err("АВТО: сначала выбери миссию")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then Err("playerId: " .. tostring(psrc)); return end
    local before = #AssignedItemsOf(st)
    Logf("АВТО-ПАЛЫ: было назначено %d (state=%s) …", before, tostring(sname))
    SafeDo("RequestSelectAuto_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestSelectAuto_ServerInternal(pid) end
    end)
    DelayCall(800, function()
        SafeDo("проверка АВТО", function()
            local st2 = SelectedStation()
            if not st2 then return end
            local after = #AssignedItemsOf(st2)
            if after > before then
                Logf("ГОТОВО: АВТО назначил палов %d → %d", before, after)
            else
                Log("АВТО: состав не изменился")
            end
            if refreshIfOpen then refreshIfOpen() end
        end)
    end)
end


-- снять ВСЕХ назначенных палов станции
local function DoUnselectAllPals()
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err("СНЯТЬ ВСЕХ: станция в состоянии " .. tostring(sname) .. " — нужно Ready")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then Err("playerId: " .. tostring(psrc)); return end
    Log("СНЯТЬ ВСЕХ: RequestUnselectAll_ServerInternal …")
    SafeDo("RequestUnselectAll_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestUnselectAll_ServerInternal(pid) end
    end)
    DelayCall(700, function()
        SafeDo("проверка снятия", function()
            local st2 = SelectedStation()
            if st2 then
                Logf("после снятия: палов %d", #AssignedItemsOf(st2))
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end

-- отменить идущую экспедицию (станция вернётся в Ready, миссия останется выбранной)
local function DoCancelMission()
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname ~= "InProgress" then
        Log("ОТМЕНА: станция в состоянии " .. tostring(sname) .. " — отменять можно только InProgress")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then Err("playerId: " .. tostring(psrc)); return end
    Log("ОТМЕНА: RequestCancelInProgressMission_ServerInternal …")
    SafeDo("RequestCancelInProgressMission_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestCancelInProgressMission_ServerInternal(pid) end
    end)
    DelayCall(700, function()
        SafeDo("проверка отмены", function()
            local st2 = SelectedStation()
            if st2 then
                local _, sn2 = GetState(st2)
                Logf("после отмены: state=%s", tostring(sn2))
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end


-- снимок Palbox: сортировка по силе (сила — через живую UI-модель, только чтение)
local function DoLoadPalbox()
    Log("=== СПИСОК PALBOX ===")
    local cont, why = GetPalStorageContainer()
    if not cont then
        Err("Palbox: " .. tostring(why))
        return
    end
    local slots = ArrayToTable(ReadField(cont, "SlotArray"))
    if not slots then
        Err("Palbox: SlotArray не читается")
        return
    end
    local busy = BusyPalKeys()
    local st = SelectedStation()
    local bound = st and FindBoundModelForStation(st, true) or nil
    local list = {}
    for i = 1, #slots do
        local p = ReadPalSlot(slots[i])
        if p and p.key then
            if bound then
                local okS, s = pcall(function() return bound:CalculateCharacterStrength(p.idTable) end)
                if okS then p.strength = Num(s) end
            end
            p.busy = busy[p.key] or false
            list[#list + 1] = p
        end
    end
    table.sort(list, function(a, b)
        local sa, sb = a.strength or -1, b.strength or -1
        if sa ~= sb then return sa > sb end
        return (a.level or 0) > (b.level or 0)
    end)
    S.palbox = list
    S.listPage = 1
    Logf("Palbox: палов %d (сила: %s)", #list, bound and "показана" or "нет — без живой модели")
end

-- добавить/снять пала: байты по ванильному формату + проверка результата.
-- Наши вызовы тоже видны в хуках («>>> [hook] добавить/снять пала») — сверка в логе.
local function DoPalRequest(kind, key)
    local st = SelectedStation()
    if not st then return end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then Err("playerId: " .. tostring(psrc)); return end

    local idTable = nil
    if kind == "add" then
        if S.palbox then
            for _, p in ipairs(S.palbox) do
                if p.key == key then idTable = p.idTable; break end
            end
        end
    else
        for _, item in ipairs(AssignedItemsOf(st)) do
            if item.key == key then idTable = item.idTable; break end
        end
    end
    if not idTable then
        Err("пал " .. tostring(key) .. " не найден — обнови список")
        return
    end

    local before = #AssignedItemsOf(st)
    local bytes = PalIdToArchiveBytes(idTable)
    Logf("%s пала: архив(%d байт): %s",
        (kind == "add" and "добавить" or "снять"), #bytes, BytesToHex(bytes, 40))

    SafeDo("RequestServerInternal", function()
        local st1 = SelectedStation()
        if not st1 then return end
        local ar = { Bytes = bytes }
        if kind == "add" then
            st1:RequestSelectAssignedCharacter_ServerInternal(pid, ar)
        else
            st1:RequestUnselectAssignedCharacter_ServerInternal(pid, ar)
        end
    end)
    DelayCall(600, function()
        SafeDo("проверка " .. kind, function()
            local st2 = SelectedStation()
            if not st2 then return end
            local now = #AssignedItemsOf(st2)
            local ok = (kind == "add" and now > before) or (kind == "remove" and now < before)
            if ok then
                Logf("ГОТОВО: пал %s (палов теперь %d)",
                    (kind == "add" and "добавлен" or "снят"), now)
                if refreshIfOpen then refreshIfOpen() end
            else
                Err(string.format("%s не сработало (палов по-прежнему %d). " ..
                    "Сравни в логе байты «>>> [hook] %s пала» с нашими и пришли лог.",
                    (kind == "add" and "добавление" or "снятие"), now,
                    (kind == "add" and "добавить" or "снять")))
            end
        end)
    end)
end


local function DoAddPal(key)
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err(string.format("ДОБАВИТЬ: станция в состоянии %s — состав можно менять только в Ready%s",
            tostring(sname), (sname == "Reward" and " (сначала СОБРАТЬ ЛУТ)" or "")))
        return
    end
    local tmid = Str(ReadField(st, "TargetMissionId"))
    if tmid == nil or tmid == "None" or tmid == "" then
        Err("сначала выбери миссию — потом добавляй палов")
        return
    end
    local assigned = AssignedItemsOf(st)
    for _, item in ipairs(assigned) do
        if item.key == key then
            Log("этот пал уже назначен на эту станцию")
            return
        end
    end
    Logf("ДОБАВИТЬ пала %s (назначено %d, state=%s)", tostring(key), #assigned, tostring(sname))
    DoPalRequest("add", key)
end

local function DoRemovePal(key)
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err("СНЯТЬ: станция в состоянии " .. tostring(sname) .. " — состав можно менять только в Ready")
        return
    end
    local assigned = AssignedItemsOf(st)
    if #assigned == 0 then
        Log("назначенных палов нет")
        return
    end
    Logf("СНЯТЬ пала %s (назначено %d)", tostring(key), #assigned)
    DoPalRequest("remove", key)
end


-- сбор лута одной станции (переищивается по индексу)
local function DoCollectOne(idx)
    local stations = FindStations()
    local st = stations[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена")
        return
    end
    local _, sname = GetState(st)
    if sname ~= "Reward" then
        Log("станция " .. idx .. ": state=" .. tostring(sname) .. " — лут ещё не готов (нужен Reward)")
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
    DelayCall(600, function()
        SafeDo("проверка после сбора", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                local cont2 = GetStationContainer(st2)
                if cont2 then DumpContainer("ПОСЛЕ сбора (ст." .. idx .. ")", cont2) end
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end

local function DoCollect()
    local _, total = SelectedStation()
    if total == 0 then return end
    Log("=== СОБРАТЬ ЛУТ: станция " .. S.sel .. " ===")
    DoCollectOne(S.sel)
end

local function DoCollectAll()
    local stations = FindStations()
    local targets = {}
    for i, st in ipairs(stations) do
        local _, sname = GetState(st)
        if sname == "Reward" then targets[#targets + 1] = i end
    end
    if #targets == 0 then
        Log("СОБРАТЬ ВСЁ: нет станций в состоянии Reward")
        return
    end
    Logf("=== СОБРАТЬ ВСЁ: станций с наградой: %d (%s) ===", #targets, table.concat(targets, ", "))
    for k, i in ipairs(targets) do
        DelayCall(250 * k, function()
            SafeDo("collect ст." .. i, function() DoCollectOne(i) end)
        end)
    end
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
    Divider       = hexToLinearColor("#314046", 1.00),
    BorderDefault = hexToLinearColor("#42555C", 1.00),
    TextPrimary   = hexToLinearColor("#EAF2F6", 1.00),
    TextSecond    = hexToLinearColor("#9DB0B9", 1.00),
    TextDim       = hexToLinearColor("#6C808A", 1.00),
    Gold          = hexToLinearColor("#FFC53D", 1.00),
    Green         = hexToLinearColor("#4ADE80", 1.00),
    Red           = hexToLinearColor("#F87171", 1.00),
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
    local title = Factory.CreateText(tree, "EXPEDITION HUB", 16, Theme.TextPrimary, true, 0)
    if title then Factory.AnchorWidget(surface, title, PAD + 16, PAD + 12, 380, 24, 7) end
    local _, stationTotal = SelectedStation()
    local sub = Factory.CreateText(tree, string.format("станций: %d", stationTotal), 12, Theme.TextSecond, false, 2)
    if sub then Factory.AnchorWidget(surface, sub, PAD + contentW - 320, PAD + 15, 200, 16, 7) end
    createGameButton(hostCanvas, surface, tree, "ОБНОВИТЬ", PAD + contentW - 110, PAD + 7, 94, 32, function()
        if S.mode == "palbox" then
            SafeDo("reload palbox", DoLoadPalbox)
        end
        renderAllContent()
    end, 60)

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

    -- ===== детали станции (132..220) =====
    local detY, detH = 132, 88
    local detBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if detBg then Factory.AnchorWidget(surface, detBg, PAD, detY, contentW, detH, 5) end
    Factory.DrawFrame(surface, tree, PAD, detY, contentW, detH, Theme.Divider)
    local curMissionId
    do
        local stC = SelectedStation()
        if stC then curMissionId = Str(ReadField(stC, "TargetMissionId")) end
    end
    local detLines = StationDetailLines()
    for i, lineTxt in ipairs(detLines) do
        local t = Factory.CreateText(tree, lineTxt, 11, Theme.TextPrimary, false, 0)
        if t then Factory.AnchorWidget(surface, t, PAD + 16, detY + 8 + (i - 1) * 18, contentW - 32, 17, 7) end
    end

    -- ===== 4 кнопки одной строкой (232..278) =====
    local btnY = 232
    local bigW = (contentW - 32 - 3 * 10) / 4
    local bigH = 46
    local bigBtns = {
        { "АВТО-ПАЛЫ", DoAutoFill },
        { "ЗАПУСК", DoLaunchRepeat },
        { "СОБРАТЬ ЛУТ", DoCollect },
        { "СОБРАТЬ ВСЁ", DoCollectAll },
    }
    for i, def in ipairs(bigBtns) do
        local label, fn = def[1], def[2]
        createGameButton(hostCanvas, surface, tree, label,
            PAD + 16 + (i - 1) * (bigW + 10), btnY, bigW, bigH, function()
                SafeDo("btn:" .. tostring(label), fn)
                -- одна перерисовка на клик
                if State.isDisplayed then renderAllContent() end
            end, 60)
    end

    -- ===== блок списка (290..556): МИССИИ / PALBOX / НАЗНАЧЕНЫ =====
    local misY, misH = 290, 266
    local misBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if misBg then Factory.AnchorWidget(surface, misBg, PAD, misY, contentW, misH, 5) end
    Factory.DrawFrame(surface, tree, PAD, misY, contentW, misH, Theme.Divider)

    local MODE_TITLE = {
        missions = "РЕЖИМ: МИССИИ ⟳",
        palbox   = "РЕЖИМ: PALBOX ⟳",
        assigned = "РЕЖИМ: НАЗНАЧЕНЫ ⟳",
    }
    local assignedItems = nil
    if S.mode == "assigned" then
        assignedItems = AssignedItemsOf(SelectedStation())
    end
    local items = (S.mode == "missions" and S.missions)
        or (S.mode == "palbox" and S.palbox)
        or assignedItems
        or {}
    local rowsPerPage = 6
    local pages = math.max(1, math.ceil(#items / rowsPerPage))
    if S.listPage > pages then S.listPage = pages end
    if S.listPage < 1 then S.listPage = 1 end

    -- шапка блока: [<] [РЕЖИМ ⟳] [>]
    createGameButton(hostCanvas, surface, tree, "<", PAD + 16, misY + 3, 34, 22, function()
        local order = { "missions", "palbox", "assigned" }
        local idx = 1
        for i, m in ipairs(order) do if m == S.mode then idx = i; break end end
        S.mode = order[(idx - 2) % 3 + 1]
        S.listPage = 1
        if S.mode == "palbox" then SafeDo("загрузка palbox", DoLoadPalbox)
        elseif S.mode == "missions" and S.missions == nil then SafeDo("загрузка миссий", DoLoadMissions) end
        renderAllContent()
    end, 60)
    createGameButton(hostCanvas, surface, tree, MODE_TITLE[S.mode] or "?", PAD + 58, misY + 3, 320, 22, function()
        -- клик по текущему режиму = обновить список этого режима
        if S.mode == "missions" then
            SafeDo("обновление миссий", DoLoadMissions)
        elseif S.mode == "palbox" then
            SafeDo("обновление palbox", DoLoadPalbox)
        end
        renderAllContent()
    end, 60)
    createGameButton(hostCanvas, surface, tree, ">", PAD + 386, misY + 3, 34, 22, function()
        local order = { "missions", "palbox", "assigned" }
        local idx = 1
        for i, m in ipairs(order) do if m == S.mode then idx = i; break end end
        S.mode = order[idx % 3 + 1]
        S.listPage = 1
        if S.mode == "palbox" then SafeDo("загрузка palbox", DoLoadPalbox)
        elseif S.mode == "missions" and S.missions == nil then SafeDo("загрузка миссий", DoLoadMissions) end
        renderAllContent()
    end, 60)
    local listHint = Factory.CreateText(tree,
        string.format("стр %d/%d · всего %d", S.listPage, pages, #items), 10, Theme.TextSecond, false, 0)
    if listHint then Factory.AnchorWidget(surface, listHint, PAD + 440, misY + 8, 200, 14, 7) end

    -- строки списка (6 на страницу)
    local first = (S.listPage - 1) * rowsPerPage + 1
    for r = 1, rowsPerPage do
        local i = first + r - 1
        local it = items[i]
        local cy = misY + 30 + (r - 1) * 33
        if S.mode == "missions" and it then
            local cur = (it.id == curMissionId)
            local rowBg = Factory.CreateSolidBorder(tree, cur and Theme.Gold or Theme.CardActive)
            if rowBg then Factory.AnchorWidget(surface, rowBg, PAD + 14, cy, contentW - 28, 30, 6) end
            local t = Factory.CreateText(tree, string.format("%d. %s", i, it.text), 10,
                cur and Theme.TextPrimary or Theme.TextSecond, false, 0)
            if t then Factory.AnchorWidget(surface, t, PAD + 24, cy + 8, 700, 15, 7) end
            createGameButton(hostCanvas, surface, tree, cur and "ВЫБРАНА" or "ВЫБРАТЬ",
                PAD + contentW - 130, cy + 2, 112, 26, function()
                    SafeDo("select mission", function() DoSelectMission(it.id) end)
                    if State.isDisplayed then renderAllContent() end
                end, 60)
        elseif S.mode == "palbox" and it then
            local rowBg = Factory.CreateSolidBorder(tree, it.busy and Theme.Divider or Theme.CardActive)
            if rowBg then Factory.AnchorWidget(surface, rowBg, PAD + 14, cy, contentW - 28, 30, 6) end
            local lvl = it.level and ("Lv" .. it.level) or "Lv?"
            local rk = (it.rank and it.rank > 0) and (" ★" .. it.rank) or ""
            local strn = it.strength and tostring(it.strength) or "?"
            local mark = it.busy and "  [на экспедиции]" or (it.excluded and "  [искл.]" or "")
            local t = Factory.CreateText(tree,
                string.format("%d. %s %s%s | сила %s%s", i, it.name, lvl, rk, strn, mark), 10,
                it.busy and Theme.TextDim or Theme.TextSecond, false, 0)
            if t then Factory.AnchorWidget(surface, t, PAD + 24, cy + 8, 700, 15, 7) end
            createGameButton(hostCanvas, surface, tree, it.busy and "ЗАНЯТ" or "+ ДОБАВИТЬ",
                PAD + contentW - 130, cy + 2, 112, 26, function()
                    SafeDo("add pal", function() DoAddPal(it.key) end)
                    if State.isDisplayed then renderAllContent() end
                end, 60)
        elseif S.mode == "assigned" and it then
            local rowBg = Factory.CreateSolidBorder(tree, Theme.CardActive)
            if rowBg then Factory.AnchorWidget(surface, rowBg, PAD + 14, cy, contentW - 28, 30, 6) end
            local lvl = it.level and ("Lv" .. it.level) or ""
            local strn = it.strength and tostring(it.strength) or "?"
            local t = Factory.CreateText(tree,
                string.format("%d. %s %s | сила %s", i, it.name, lvl, strn), 10, Theme.TextSecond, false, 0)
            if t then Factory.AnchorWidget(surface, t, PAD + 24, cy + 8, 700, 15, 7) end
            createGameButton(hostCanvas, surface, tree, "− СНЯТЬ",
                PAD + contentW - 130, cy + 2, 112, 26, function()
                    SafeDo("remove pal", function() DoRemovePal(it.key) end)
                    if State.isDisplayed then renderAllContent() end
                end, 60)
        end
    end

    -- подсказка для пустого списка
    if #items == 0 then
        local hints = {
            missions = "Список пуст. Нажми «РЕЖИМ: МИССИИ ⟳» — загрузятся доступные экспедиции с требованием стихии и силы. ВЫБРАТЬ → PALBOX → добавь палов → ЗАПУСК. Слабые палы = 0% награды!",
            palbox   = "Нажми «РЕЖИМ: PALBOX ⟳» — загрузится твой Palbox (только Palbox: партия и рабочие базы не подходят), сортировка по силе.",
            assigned = "Назначенных палов нет. Выбери миссию, затем добавь палов из PALBOX или нажми АВТО-ПАЛЫ.",
        }
        local hint = Factory.CreateText(tree, hints[S.mode] or "", 10, Theme.TextDim, false, 0)
        if hint then Factory.AnchorWidget(surface, hint, PAD + 16, misY + 48, contentW - 32, 80, 7) end
    end

    -- нижняя строка блока: [СНЯТЬ ВСЕХ / ОБНОВИТЬ СПИСОК] … [paging]
    local botY = misY + 234
    if S.mode == "assigned" then
        local stNow = SelectedStation()
        local _, stState = GetState(stNow)
        if stState == "InProgress" then
            createGameButton(hostCanvas, surface, tree, "ОТМЕНИТЬ ЭКСПЕДИЦИЮ", PAD + 16, botY, 220, 26, function()
                SafeDo("cancel mission", DoCancelMission)
                if State.isDisplayed then renderAllContent() end
            end, 60)
        else
            createGameButton(hostCanvas, surface, tree, "СНЯТЬ ВСЕХ", PAD + 16, botY, 150, 26, function()
                SafeDo("unselect all", DoUnselectAllPals)
                if State.isDisplayed then renderAllContent() end
            end, 60)
        end
    elseif S.mode == "palbox" then
        createGameButton(hostCanvas, surface, tree, "ОБНОВИТЬ СПИСОК", PAD + 16, botY, 190, 26, function()
            SafeDo("reload palbox", DoLoadPalbox)
            renderAllContent()
        end, 60)
    end
    createGameButton(hostCanvas, surface, tree, "< СТР", PAD + contentW - 350, botY, 105, 26, function()
        S.listPage = S.listPage - 1
        if S.listPage < 1 then S.listPage = pages end
        renderAllContent()
    end, 60)
    createGameButton(hostCanvas, surface, tree, "СТР >", PAD + contentW - 235, botY, 105, 26, function()
        S.listPage = S.listPage + 1
        if S.listPage > pages then S.listPage = 1 end
        renderAllContent()
    end, 60)


    -- ===== лог (566..744) =====
    local logY, logH = 566, 178
    local logBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if logBg then Factory.AnchorWidget(surface, logBg, PAD, logY, contentW, logH, 5) end
    Factory.DrawFrame(surface, tree, PAD, logY, contentW, logH, Theme.Divider)
    local logTitle = Factory.CreateText(tree, "ЛОГ:", 10, Theme.TextDim, true, 0)
    if logTitle then Factory.AnchorWidget(surface, logTitle, PAD + 16, logY + 5, 300, 13, 7) end
    local startIdx = math.max(1, #S.logLines - Config.LogLines + 1)
    local shown = 0
    for i = startIdx, #S.logLines do
        shown = shown + 1
        local lineTxt = S.logLines[i]
        local color = Theme.TextSecond
        if lineTxt:find("ОШИБКА", 1, true) then color = Theme.Red
        elseif lineTxt:find("InProgress", 1, true) or lineTxt:find("ok", 1, true) then color = Theme.Green end
        local t = Factory.CreateText(tree, lineTxt, 10, color, false, 0)
        if t then Factory.AnchorWidget(surface, t, PAD + 16, logY + 22 + (shown - 1) * 15, contentW - 32, 14, 7) end
    end

    -- ===== футер (752..784) =====
    local footerY = UI_H - PAD - 32
    local footLine = Factory.CreateSolidBorder(tree, Theme.Divider)
    if footLine then Factory.AnchorWidget(surface, footLine, PAD, footerY - 4, contentW, 1, 6) end
    local escHint = Factory.CreateText(tree, "F6 или ESC — закрыть панель", 10, Theme.TextDim, false, 0)
    if escHint then Factory.AnchorWidget(surface, escHint, PAD + 10, footerY + 8, 400, 16, 7) end
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
    end
end

local function onWorldEnter()
    SafeDo(function()
        if Presenter_IsVisible() then Presenter_Close() end
    end)
    Log("мир загружен — панель закрыта")
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

-- ============================== ПАССИВНЫЕ ХУКИ (только лог) ==============================
-- Логируем все ServerInternal экспедиций: и наши вызовы, и ванильные (когда сам
-- выбираешь миссию/палов у станции в игре). Дамп байтов архива = сверка формата.
-- ВАЖНО: путь функции — с ДВОЕТОЧИЕМ (/Script/Pal.Класс:Функция); с точкой
-- RegisterHook молча не находит функцию (урок v0.6).
local function DumpHookArchive(label, paramPid, paramArchive)
    SafeDo("hook:" .. label, function()
        local pid = Num(Unwrap(paramPid))
        local arc = Unwrap(paramArchive)
        local bytes = arc and ReadField(arc, "Bytes") or nil
        local t = bytes and ArrayToTable(bytes) or nil
        if t and #t > 0 then
            Logf(">>> [hook] %s: playerId=%s, архив(%d байт): %s",
                label, tostring(pid), #t, BytesToHex(t, 64))
        else
            Logf(">>> [hook] %s: playerId=%s, архив не читается", label, tostring(pid))
        end
    end)
end

local function RegisterPassiveHooks()
    local hooks = {
        { "выбор миссии",  "RequestSelectMission_ServerInternal",        true },
        { "добавить пала", "RequestSelectAssignedCharacter_ServerInternal", true },
        { "снять пала",    "RequestUnselectAssignedCharacter_ServerInternal", true },
    }
    for _, h in ipairs(hooks) do
        local label, fn = h[1], h[2]
        local ok, err = pcall(RegisterHook,
            "/Script/Pal.PalMapObjectCharacterTeamMissionModel:" .. fn,
            function(self, paramPid, paramArchive)
                DumpHookArchive(label, paramPid, paramArchive)
            end)
        if ok then
            Log("hook установлен: " .. label)
        else
            Log("hook НЕ установлен: " .. label .. " → " .. tostring(err))
        end
    end
    local okS, errS = pcall(RegisterHook,
        "/Script/Pal.PalMapObjectCharacterTeamMissionModel:RequestStartMission_ServerInternal",
        function(self, paramPid)
            SafeDo("hook:старт", function()
                Log(">>> [hook] старт экспедиции: playerId=" .. tostring(Num(Unwrap(paramPid))))
            end)
        end)
    if okS then Log("hook старта установлен")
    else Log("hook старта НЕ установлен → " .. tostring(errS)) end
end


-- ============================== INIT ==============================
local function init()
    bindKey(Config.OpenKey, toggleUI)
    bindKey("ESCAPE", function()
        if Presenter_IsVisible() then Presenter_Close() end
    end)
    registerWorldEnterHook()
    RegisterPassiveHooks()
    Log("ExpeditionHub v0.8 готов: сериализаторы архива на чистом Lua по ванильным дампам, вызовы игровых статиков убраны (краш).")
end

SafeDo(init)
