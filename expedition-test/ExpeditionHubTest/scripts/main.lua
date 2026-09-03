-- ============================================================================================
-- ============================================================================================
-- ============================================================================================
-- ============================================================================================
-- ============================================================================================
-- ExpeditionHubTest v0.11 — ТЕСТОВЫЙ мод (UE4SS Lua) для Palworld 0.4.11
-- Менеджер экспедиций: панель на F6. ВСЕ станции со всех баз. Полный цикл из панели:
-- выбор миссии → НАЗНАЧЕНИЕ ПАЛОВ ВРУЧНУЮ (Palbox, слоты 0..100) или АВТО → запуск → сбор.
-- Игровой UI станции НЕ открываем вообще (v0.4/v0.5: ломает мышь + краш при перезаходе).
--
-- УРОКИ ЖИВОГО ТЕСТА v0.8 (нет краша, но архив приходил ПУСТЫМ):
--   • найден БАГ САМОГО UE4SS (LuaUObject.cpp, push_arrayproperty::lua_table_to_memory):
--     длина таблицы читается с захардкоженного стек-индекса 1, поэтому массив, ВЛОЖЕННЫЙ
--     в структуру-параметр ({Bytes={...}}), ВСЕГДА передаётся пустым; для ref-параметров
--     (WriteBlackboard) placement-new ещё и затирал указатель → краш 0x70 в v0.7;
--   • путь с TArray-USERDATA копирует честно (get_userdata<TArray> → поэлементный copy) —
--     поэтому в v0.9 занимаем живой байтовый массив у игрового объекта, пишем байты
--     (запись ud[i]=v авто-растит массив: TArray::prepare_to_handle → AddZeroed), передаём
--     {Bytes=ud}, содержимое восстанавливаем сразу после вызова (сервер читает архив
--     синхронно, внутри ProcessEvent). Кандидаты буфера с рантайм-проверкой размера
--     элемента (запись 511 → чтение 255 = ровно 1 байт): PalWorldMapUIData /
--     PalGameSetting / PalGroupGuildBase / PalMapObjectItemContainerModule;
--   • ванильные форматы (хук-дампы v0.7, байт-в-байт):
--       FName        → int32(len+1) + UTF-16LE + L'\0' ("DUNGEON_GRASS" → 32 байта)
--       FPalInstanceID → пустой FString DebugName + PlayerUId GUID + InstanceId GUID (36 байт)
--   • АВТО-заполнение и все int-параметры ServerInternal работают стабильно (v0.3/v0.7/v0.8).
--
-- МЕХАНИКА (SDK + ванила):
--   • флоу: список миссий → выбор → заполнение палов 0..100 → старт. Требование стихии ×N,
--     рекомендуемая сила; % награды = сила команды ÷ рекомендуемая; палы только из Palbox;
--   • все записи — через ServerInternal модели станции:
--       RequestSelectMission_ServerInternal(playerId, FPalNetArchive)
--       RequestSelectAssignedCharacter_ServerInternal(playerId, FPalNetArchive)
--       RequestUnselectAssignedCharacter_ServerInternal(playerId, FPalNetArchive)
--       RequestUnselectAll_ServerInternal(playerId) / RequestSelectAuto_ServerInternal(playerId)
--       RequestStartMission_ServerInternal(playerId) / RequestCancelInProgressMission_ServerInternal(playerId)
--   • действия со станцией — только в состоянии Ready (InProgress/Reward сервер отклонит).
--
-- БОРЬБА С КРАШАМИ (pcall НЕ ловит нативные краши):
--   1. НИ ОДНОЙ ссылки на UObject между действиями (S хранит только примитивы/таблицы);
--   2. панель строится ОДИН раз (buildView), обновления ТОЛЬКО на месте
--      (SetText/SetVisibility/цвет/перебинд обработчиков — refreshView);
--      НИКАКОГО destroy/recreate виджетов между открытием и закрытием панели
--      (полная пересборка на каждый клик = нативный краш 0x10, уроки v0.9/v0.10);
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
    bufferSrc = nil,        -- источник байтового буфера архива (строка для лога)
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
    pushLog("ERROR: " .. tostring(msg))
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
    if not pc then return nil, "no PlayerController" end
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
    return nil, "PlayerState not found"
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
                if s and s ~= "" then
                    -- дев-плейсхолдер имени базы (新規生成拠点テンプレート名 =
                    -- "new base template name") — показываем понятное имя
                    if s:find("新規生成拠点テンプレート名", 1, true) then return "Unnamed base" end
                    return s
                end
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
        if e.guid == instKey then return e.model, "InstanceId matched" end
    end
    for _, e in ipairs(bound) do
        if e.guid == modelKey then return e.model, "ModelInstanceId matched" end
    end
    local guids = {}
    for _, e in ipairs(bound) do guids[#guids + 1] = e.guid end
    if not quiet then
        Log(string.format("bound UI models: %d %s", #bound,
            (#bound > 0 and ("{" .. table.concat(guids, ", ") .. "}")) or "(none found)"))
        Log(string.format("station: InstanceId=%s | ModelInstanceId=%s", tostring(instKey), tostring(modelKey)))
    end
    return nil, "no bound model matched the station"
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
    return nil, "no container (normal for a station without reward)"
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
        Log(label .. ": container invalid")
        return
    end
    local slots = ArrayToTable(ReadField(cont, "ItemSlotArray"))
    if not slots then
        Log(label .. ": ItemSlotArray unreadable")
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
                Logf("%s: slot %d — %s x%s", label, i, tostring(sid), tostring(cnt))
            end
        end
    end
    if used == 0 then Log(label .. ": chest EMPTY (" .. tostring(#slots) .. " slots)") end
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

-- ================== БУФЕР АРХИВА (обход бага UE4SS с массивами в структурах) ==============
-- БАГ UE4SS: массив-поле внутри структуры-параметра ({Bytes={...}}) передаётся пустым
-- (lua_table_to_memory читает длину с неверного стек-индекса). Обход: путь с
-- TArray-USERDATA копирует честно. Занимаем живой 1-байтовый массив у игрового объекта,
-- пишем туда байты архива (запись ud[i]=v авто-растит массив), вызываем, восстанавливаем.
local BUFFER_CANDIDATES = {
    { class = "PalWorldMapUIData",               field = "CachedTextureRawData_ForV3Convert" },
    { class = "PalGameSetting",                  field = "BaseCampBuildingItemContainerTypes" },
    { class = "PalGroupGuildBase",               field = "GuildChestAllowedRoles" },
    { class = "PalMapObjectItemContainerModule", field = "AllSlotAttribute" },
}

local function RestoreBuffer(b)
    if not b then return end
    pcall(function()
        b.buf:Empty()
        for i = 1, #b.saved do b.buf[i] = b.saved[i] end
    end)
end

-- вернуть {buf=userdata, saved=байты, src=имя} для первого подходящего кандидата
local function BorrowByteBuffer()
    for _, cand in ipairs(BUFFER_CANDIDATES) do
        local okAll, all = pcall(FindAllOf, cand.class)
        if okAll and type(all) == "table" then
            for _, inst in ipairs(all) do
                local o = Unwrap(inst)
                if IsValidObj(o) and not ObjName(o):find("Default__", 1, true) then
                    local okF, buf = pcall(function() return o[cand.field] end)
                    if okF and buf ~= nil and type(buf) == "userdata" then
                        -- снимок содержимого ДО любых записей
                        local saved, n = {}, TryLen(buf)
                        if type(n) == "number" then
                            for i = 1, n do
                                local okR, v = pcall(function() return buf[i] end)
                                saved[i] = (okR and Num(v)) or 0
                            end
                        end
                        -- рантайм-проверка: элементы ровно 1 байт (511 → 255)
                        local okW = pcall(function() buf[1] = 511 end)
                        local okR2, back = pcall(function() return buf[1] end)
                        if okW and okR2 and back == 255 then
                            return { buf = buf, saved = saved, src = cand.class .. "." .. cand.field }
                        end
                        if S.bufferSrc == nil then
                            Logf("buffer: %s.%s — not 1-byte (test gave %s), skipping",
                                cand.class, cand.field, tostring(back))
                        end
                    elseif S.bufferSrc == nil and buf ~= nil then
                        Logf("buffer: %s.%s — not userdata (%s), skipping",
                            cand.class, cand.field, type(buf))
                    end
                end
            end
        end
    end
    return nil
end

-- вызов архивного ServerInternal через буфер: kind = mission | add | remove
local function CallServerInternalWithArchive(kind, st, pid, bytes)
    local b = BorrowByteBuffer()
    if not b then
        return nil, "no live byte buffer found (see 'buffer:' lines)"
    end
    local ok, err = pcall(function()
        b.buf:Empty()
        for i = 1, #bytes do b.buf[i] = bytes[i] end
        local ar = { Bytes = b.buf }
        if kind == "mission" then
            st:RequestSelectMission_ServerInternal(pid, ar)
        elseif kind == "add" then
            st:RequestSelectAssignedCharacter_ServerInternal(pid, ar)
        else
            st:RequestUnselectAssignedCharacter_ServerInternal(pid, ar)
        end
    end)
    RestoreBuffer(b)
    if not ok then return nil, tostring(err) end
    if S.bufferSrc ~= b.src then
        S.bufferSrc = b.src
        Log("archive buffer: " .. b.src)
    end
    return true
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
                name     = (info and Str(ReadField(info, "NickName"))) or "Pal",
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
    if not pc then return nil, "no PlayerController" end
    local ps = nil
    local ok, r = pcall(function() return pc:GetPalPlayerState() end)
    if ok then ps = Unwrap(r) end
    if not IsValidObj(ps) then ps = ReadField(pc, "PlayerState") end
    if not IsValidObj(ps) then return nil, "PlayerState not found" end
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

    local name, level, rank, species, excluded = "Pal", nil, nil, nil, false
    if IsValidObj(param) then
        local sp = ReadField(param, "SaveParameter")
        if sp ~= nil then
            local nick = Str(ReadField(sp, "NickName"))
            species = Str(ReadField(sp, "CharacterID"))
            name = (nick and nick ~= "" and nick) or species or "Pal"
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
    if not st then return { "NO STATIONS FOUND — build one or re-enter the world" }, 0 end
    local lines = {}
    local _, sname = GetState(st)
    local tmid = Str(ReadField(st, "TargetMissionId"))
    lines[#lines + 1] = string.format("STATE: %s     MISSION: %s", tostring(sname), tostring(tmid))
    local loc = GetLoc(st)
    local locStr = loc and string.format("     at: (%.0f, %.0f)", loc.x, loc.y) or ""
    lines[#lines + 1] = string.format("BASE: %s%s", tostring(GetBaseName(st) or "?"), locStr)
    local ai = ReadField(st, "AssignedInfo")
    local rep = ai and ReadField(ai, "RepInfoArray") or nil
    local items = rep and ArrayToTable(ReadField(rep, "Items")) or nil
    local cont = GetStationContainer(st)
    local used, totalSlots = 0, 0
    if cont then used, totalSlots = CountChest(cont) end
    lines[#lines + 1] = string.format("PALS: %s     CHEST: %s", tostring(items and #items or nil),
        (cont and string.format("used %d of %d", used, totalSlots)) or "none (normal, no reward yet)")
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
                    parts[#parts + 1] = string.format("element: %s %s/%s%s",
                        ELEMENT_NAMES[elT] or tostring(elT), tostring(curN), tostring(reqN),
                        ((sat == true or sat == 1) and " ✔") or "")
                end
            end
            if okT then parts[#parts + 1] = "power: " .. tostring(Num(team)) end
            if okR then parts[#parts + 1] = string.format("reward: %.0f%%", (Num(rate) or 0) * 100) end
            if sname == "InProgress" then
                local okL, rem = pcall(function() return bm:GetRemainMissionSeconds() end)
                local remN = okL and Num(rem) or nil
                if remN ~= nil and remN > 0 then
                    parts[#parts + 1] = string.format("left: %dh %02dm",
                        math.floor(remN / 3600), math.floor((remN % 3600) / 60))
                end
            end
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
        Log("START: expedition already running (InProgress) — wait or CANCEL (MODE: ASSIGNED)")
        return
    end
    if sname ~= "Ready" then
        Log("START: station state is " .. tostring(sname) .. " — start requires Ready")
        return
    end
    local tmid = Str(ReadField(st, "TargetMissionId"))
    if tmid == nil or tmid == "None" or tmid == "" then
        Log("START: no mission selected — pick one in the list (MODE: MISSIONS)")
        return
    end
    local nAssigned = #AssignedItemsOf(st)
    if nAssigned == 0 then
        Log("START: 0 pals assigned — empty team = 0% reward. Add pals (MODE: PALBOX) or use AUTO PALS.")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then
        Err("playerId unavailable: " .. tostring(psrc))
        return
    end
    Logf("START station %d: mission '%s', pals %d (playerId=%s)", S.sel, tmid, nAssigned, tostring(pid))
    SafeDo("RequestStartMission_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestStartMission_ServerInternal(pid) end
    end)
    DelayCall(Config.VerifyMs, function()
        SafeDo("check after start", function()
            local st2 = SelectedStation()
            if st2 then
                local _, sname = GetState(st2)
                Logf("result: state=%s, pals=%d", tostring(sname), #AssignedItemsOf(st2))
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
    if el == nil then res.text = "(nil element)"; return res end
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
            if mins >= 60 then timeStr = string.format("%dh%02d", math.floor(mins / 60), mins % 60)
            else timeStr = mins .. "m" end
        end
        line = string.format("%s | %s | %s | power %s | %s×%s | max %s",
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
    Log("=== MISSION LIST: station " .. S.sel .. " ===")
    local function LoadFrom(ui)
        local out = {}
        local ok, res = pcall(function() ui:GetSelectableMissionInfos(out) end)
        if not ok then
            Err("GetSelectableMissionInfos → " .. tostring(res))
            return
        end
        local t = MissionsFromOutTable(out) or ArrayToTable(out.OutInfos or out.outInfos)
        if not t or #t == 0 then
            Log("list is empty")
            return
        end
        S.missions = {}
        for i = 1, math.min(#t, 12) do
            local info = DumpMissionElem(t[i])
            S.missions[#S.missions + 1] = info
        end
        Logf("missions: %d — see the list (MODE: MISSIONS)", #t)
    end
    local bound = FindBoundModelForStation(st)
    if bound then
        Log("list: via live bound model")
        local ok, res = pcall(LoadFrom, bound)
        if not ok then Err("read via bound model → " .. tostring(res)) end
    else
        Log("list: no bound model — via fresh one (guild list)")
        local ui = CreateUIModel(st)
        if not ui then
            Err("failed to create model for list read")
            return
        end
        local ok, res = pcall(LoadFrom, ui)
        if not ok then Err("read via fresh model → " .. tostring(res)) end
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
        Err("missionId is empty")
        return
    end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err(string.format("SELECT: station state is %s — selection requires Ready%s",
            tostring(sname), (sname == "Reward" and " (collect the reward first)" or "")))
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then
        Err("playerId unavailable: " .. tostring(psrc))
        return
    end
    Logf("SELECT mission '%s' (playerId=%s, state=%s)", tostring(missionId), tostring(pid), tostring(sname))

    local bytes = FNameToArchiveBytes(missionId)
    Logf("mission archive (%d bytes): %s", #bytes, BytesToHex(bytes, 32))
    SafeDo("RequestSelectMission_ServerInternal", function()
        local st1 = SelectedStation()
        if not st1 then return end
        local ok, err = CallServerInternalWithArchive("mission", st1, pid, bytes)
        if not ok then Err("archive not delivered: " .. tostring(err)) end
    end)
    DelayCall(700, function()
        SafeDo("check mission selection", function()
            local st2 = SelectedStation()
            if not st2 then return end
            local now = Str(ReadField(st2, "TargetMissionId"))
            if now == missionId then
                Logf("OK: mission selected via archive (TargetMissionId=%s)", tostring(now))
            else
                Err(string.format("selection failed (TargetMissionId=%s). " ..
                    "Compare our bytes with the '>>> [hook] select mission' line in the log and send me the log.",
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
        Err(string.format("AUTO: station state is %s — requires Ready%s", tostring(sname),
            (sname == "Reward" and " (collect the reward first)" or "")))
        return
    end
    local tmid = Str(ReadField(st, "TargetMissionId"))
    if tmid == nil or tmid == "None" or tmid == "" then
        Err("AUTO: select a mission first")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then Err("playerId: " .. tostring(psrc)); return end
    local before = #AssignedItemsOf(st)
    Logf("AUTO PALS: %d assigned (state=%s) ...", before, tostring(sname))
    SafeDo("RequestSelectAuto_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestSelectAuto_ServerInternal(pid) end
    end)
    DelayCall(800, function()
        SafeDo("check auto", function()
            local st2 = SelectedStation()
            if not st2 then return end
            local after = #AssignedItemsOf(st2)
            if after > before then
                Logf("OK: AUTO assigned pals %d → %d", before, after)
            else
                Log("AUTO: roster unchanged")
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
        Err("REMOVE ALL: station state is " .. tostring(sname) .. " — requires Ready")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then Err("playerId: " .. tostring(psrc)); return end
    Log("REMOVE ALL: RequestUnselectAll_ServerInternal ...")
    SafeDo("RequestUnselectAll_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestUnselectAll_ServerInternal(pid) end
    end)
    DelayCall(700, function()
        SafeDo("check removal", function()
            local st2 = SelectedStation()
            if st2 then
                Logf("after removal: %d pals", #AssignedItemsOf(st2))
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
        Log("CANCEL: station state is " .. tostring(sname) .. " — only InProgress can be cancelled")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then Err("playerId: " .. tostring(psrc)); return end
    Log("CANCEL: RequestCancelInProgressMission_ServerInternal ...")
    SafeDo("RequestCancelInProgressMission_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestCancelInProgressMission_ServerInternal(pid) end
    end)
    DelayCall(700, function()
        SafeDo("check cancel", function()
            local st2 = SelectedStation()
            if st2 then
                local _, sn2 = GetState(st2)
                Logf("after cancel: state=%s", tostring(sn2))
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end


-- снимок Palbox: сортировка по силе (сила — через живую UI-модель, только чтение)
local function DoLoadPalbox()
    Log("=== PALBOX LIST ===")
    local cont, why = GetPalStorageContainer()
    if not cont then
        Err("Palbox: " .. tostring(why))
        return
    end
    local slots = ArrayToTable(ReadField(cont, "SlotArray"))
    if not slots then
        Err("Palbox: SlotArray unreadable")
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
    Logf("Palbox: %d pals (power: %s)", #list, bound and "shown" or "not shown — no live model")
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
        Err("pal " .. tostring(key) .. " not found — reload the list")
        return
    end

    local before = #AssignedItemsOf(st)
    local bytes = PalIdToArchiveBytes(idTable)
    Logf("%s pal: archive(%d bytes): %s",
        (kind == "add" and "ADD" or "REMOVE"), #bytes, BytesToHex(bytes, 40))

    SafeDo("RequestServerInternal", function()
        local st1 = SelectedStation()
        if not st1 then return end
        local ok, err = CallServerInternalWithArchive(kind, st1, pid, bytes)
        if not ok then Err("archive not delivered: " .. tostring(err)) end
    end)
    DelayCall(600, function()
        SafeDo("check " .. kind, function()
            local st2 = SelectedStation()
            if not st2 then return end
            local now = #AssignedItemsOf(st2)
            local ok = (kind == "add" and now > before) or (kind == "remove" and now < before)
            if ok then
                Logf("OK: pal %s (now %d pals)",
                    (kind == "add" and "added" or "removed"), now)
                if refreshIfOpen then refreshIfOpen() end
            else
                Err(string.format("%s failed (still %d pals). " ..
                    "Compare our bytes with the '>>> [hook] %s pal' line in the log and send me the log.",
                    (kind == "add" and "ADD" or "REMOVE"), now,
                    (kind == "add" and "ADD" or "REMOVE")))
            end
        end)
    end)
end


local function DoAddPal(key)
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err(string.format("ADD: station state is %s — roster changes require Ready%s",
            tostring(sname), (sname == "Reward" and " (collect the reward first)" or "")))
        return
    end
    local tmid = Str(ReadField(st, "TargetMissionId"))
    if tmid == nil or tmid == "None" or tmid == "" then
        Err("select a mission first, then add pals")
        return
    end
    local assigned = AssignedItemsOf(st)
    for _, item in ipairs(assigned) do
        if item.key == key then
            Log("this pal is already assigned to this station")
            return
        end
    end
    Logf("ADD pal %s (assigned %d, state=%s)", tostring(key), #assigned, tostring(sname))
    DoPalRequest("add", key)
end

local function DoRemovePal(key)
    local st = SelectedStation()
    if not st then return end
    local _, sname = GetState(st)
    if sname ~= "Ready" then
        Err("REMOVE: station state is " .. tostring(sname) .. " — roster changes require Ready")
        return
    end
    local assigned = AssignedItemsOf(st)
    if #assigned == 0 then
        Log("no assigned pals")
        return
    end
    Logf("REMOVE pal %s (assigned %d)", tostring(key), #assigned)
    DoPalRequest("remove", key)
end


-- сбор лута одной станции (переищивается по индексу)
local function DoCollectOne(idx)
    local stations = FindStations()
    local st = stations[idx]
    if not IsValidObj(st) then
        Err("station " .. idx .. " not found")
        return
    end
    local _, sname = GetState(st)
    if sname ~= "Reward" then
        Log("station " .. idx .. ": state=" .. tostring(sname) .. " — reward not ready (needs Reward)")
        return
    end
    local cont, why = GetStationContainer(st)
    if not cont then
        Err("station " .. idx .. ": " .. tostring(why))
        return
    end
    local net = GetNetComp()
    if not net then
        Err("PalNetworkPlayerComponent not found")
        return
    end
    DumpContainer("BEFORE (st." .. idx .. ")", cont)
    Log("RequestMoveItemToInventoryFromContainer ...")
    local ok, res = pcall(function() return net:RequestMoveItemToInventoryFromContainer(cont, false) end)
    if not ok then
        Err("RequestMoveItemToInventoryFromContainer → " .. tostring(res))
        return
    end
    DelayCall(600, function()
        SafeDo("check after collect", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                local cont2 = GetStationContainer(st2)
                if cont2 then DumpContainer("AFTER (st." .. idx .. ")", cont2) end
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end

local function DoCollect()
    local _, total = SelectedStation()
    if total == 0 then return end
    Log("=== COLLECT: station " .. S.sel .. " ===")
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
        Log("COLLECT ALL: no stations in Reward state")
        return
    end
    Logf("=== COLLECT ALL: stations with reward: %d (%s) ===", #targets, table.concat(targets, ", "))
    for k, i in ipairs(targets) do
        DelayCall(250 * k, function()
            SafeDo("collect st." .. i, function() DoCollectOne(i) end)
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

-- Постоянное представление: кнопки подписываются ОДИН раз, обработчик берётся
-- из Handlers[key] в момент клика (перебинд без пересоздания виджетов)
local Handlers = {}
local View     = { built = false }

local function createGameButton(hostCanvas, surface, tree, label, x, y, w, h, key, z)
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
    ClickDispatcher.Subscribe(target, function()
        local fn = Handlers[key]
        if type(fn) == "function" then SafeDo("btn:" .. tostring(key), fn) end
    end)

    return btn
end

-- ------------------------------- view (in-place) ----------------------------------
-- УРОК v0.9/v0.10: полное уничтожение и пересоздание виджетов на каждый клик
-- = нативный краш 0x10 (клик попадает в уничтожаемый виджет; анимации кнопок
-- ссылаются на мёртвые объекты). Новая схема: панель строится ОДИН раз
-- (buildView), любое обновление — ТОЛЬКО SetText / SetVisibility / смена цвета
-- / перебинд обработчика (refreshView). Никакого ClearChildren/destroy между
-- открытием и закрытием панели.

local function setTextW(w, s)
    if w ~= nil and IsValidObj(w) then
        pcall(function() w:SetText(FText(s == nil and "" or tostring(s))) end)
    end
end

local function setVisW(w, visible)
    if w ~= nil and IsValidObj(w) then
        pcall(function() w:SetVisibility(visible and 0 or 1) end)
    end
end

-- смена цвета текста на месте (FSlateColor.SpecifiedColor; цвета Theme линейные)
local function tintTextW(w, colorTuple)
    if w ~= nil and IsValidObj(w) and colorTuple then
        pcall(function()
            local c = w.ColorAndOpacity
            c.SpecifiedColor.R = colorTuple[1]
            c.SpecifiedColor.G = colorTuple[2]
            c.SpecifiedColor.B = colorTuple[3]
            w.ColorAndOpacity = c
        end)
    end
end

local MODE_TITLE = {
    missions = "MODE: MISSIONS ⟳",
    palbox   = "MODE: PALBOX ⟳",
    assigned = "MODE: ASSIGNED ⟳",
}
local EMPTY_HINTS = {
    missions = "List is empty. Click 'MODE: MISSIONS ⟳' to load available expeditions with element and power requirements. SELECT → PALBOX → add pals → START. Weak pals = 0% reward!",
    palbox   = "Click 'MODE: PALBOX ⟳' to load your Palbox (Palbox only: party and base workers are not eligible), sorted by power.",
    assigned = "No pals assigned. Select a mission, then add pals from PALBOX or use AUTO PALS.",
}

-- ================================ ПОСТРОЕНИЕ (один раз на открытие) ==================
local refreshView  -- назначается ниже (обработчики берут её как upvalue)

local function buildView()
    local surface    = State.activeSurface
    local tree       = State.widgetTree
    local hostCanvas = State.hostCanvas
    if not IsValidObj(surface) or not IsValidObj(tree) or not IsValidObj(hostCanvas) then return end

    local contentW = UI_W - PAD * 2
    View = { built = false, rows = {}, det = {}, logLines = {}, pages = 1, logFit = 10 }

    local function mkText(txt, size, color, bold, x, y, w, h)
        local t = Factory.CreateText(tree, txt, size, color, bold, 0)
        if t then Factory.AnchorWidget(surface, t, x, y, w, h, 7) end
        return t
    end
    local function mkBtn(label, key, x, y, w, h)
        return createGameButton(hostCanvas, surface, tree, label, x, y, w, h, key, 60)
    end
    local function mkBg(color, x, y, w, h, z)
        local b = Factory.CreateSolidBorder(tree, color)
        if b then Factory.AnchorWidget(surface, b, x, y, w, h, z) end
        return b
    end

    -- ===== header (16..62) ===== (фон/блюр уже созданы в assembleModalFrame)
    mkBg(Theme.PanelHeader, PAD, PAD, contentW, 46, 5)
    Factory.DrawFrame(surface, tree, PAD, PAD, contentW, 46, Theme.BorderDefault)
    mkBg(Theme.Gold, PAD, PAD + 44, contentW, 2, 6)
    mkText("EXPEDITION HUB", 16, Theme.TextPrimary, true, PAD + 16, PAD + 12, 380, 24)
    View.sub = mkText("", 12, Theme.TextSecond, false, PAD + contentW - 320, PAD + 15, 200, 16)
    mkBtn("REFRESH", "refresh", PAD + contentW - 110, PAD + 7, 94, 32)

    -- ===== станция (70..124) =====
    mkBg(Theme.PanelSection, PAD, 70, contentW, 54, 5)
    Factory.DrawFrame(surface, tree, PAD, 70, contentW, 54, Theme.Divider)
    mkBtn("<< PREV", "prev", PAD + 16, 80, 110, 34)
    View.selText = mkText("", 13, Theme.Gold, true, PAD + 140, 85, 240, 20)
    mkBtn("NEXT >>", "next", PAD + contentW - 126, 80, 110, 34)

    -- ===== детали (132..220) =====
    mkBg(Theme.PanelSection, PAD, 132, contentW, 88, 5)
    Factory.DrawFrame(surface, tree, PAD, 132, contentW, 88, Theme.Divider)
    for i = 1, 5 do
        View.det[i] = mkText("", 11, Theme.TextPrimary, false, PAD + 16, 140 + (i - 1) * 18, contentW - 32, 17)
    end

    -- ===== 4 кнопки (232..278) =====
    local bigW = (contentW - 32 - 3 * 10) / 4
    local defs = {
        { "AUTO PALS", "auto" }, { "START", "start" },
        { "COLLECT", "collect" }, { "COLLECT ALL", "collectall" },
    }
    for i, d in ipairs(defs) do
        mkBtn(d[1], d[2], PAD + 16 + (i - 1) * (bigW + 10), 232, bigW, 46)
    end

    -- ===== блок списка (290..556) =====
    local misY = 290
    mkBg(Theme.PanelSection, PAD, misY, contentW, 266, 5)
    Factory.DrawFrame(surface, tree, PAD, misY, contentW, 266, Theme.Divider)
    mkBtn("<", "modePrev", PAD + 16, misY + 3, 34, 22)
    View.modeTitle = mkBtn("MODE: MISSIONS ⟳", "modeTitle", PAD + 58, misY + 3, 320, 22)
    mkBtn(">", "modeNext", PAD + 386, misY + 3, 34, 22)
    View.pageHint = mkText("", 10, Theme.TextSecond, false, PAD + 440, misY + 8, 200, 14)
    for r = 1, 6 do
        local cy = misY + 30 + (r - 1) * 33
        local row = {}
        row.bgHi = mkBg(Theme.Gold,       PAD + 14, cy, contentW - 28, 30, 6)
        row.bgNo = mkBg(Theme.CardActive, PAD + 14, cy, contentW - 28, 30, 6)
        row.txt  = mkText("", 10, Theme.TextSecond, false, PAD + 24, cy + 8, 700, 15)
        row.btn  = mkBtn("", "row" .. r, PAD + contentW - 130, cy + 2, 112, 26)
        View.rows[r] = row
    end
    View.hint = mkText("", 10, Theme.TextDim, false, PAD + 16, misY + 48, contentW - 32, 80)
    local botY = misY + 234
    View.removeall = mkBtn("REMOVE ALL", "removeall", PAD + 16, botY, 150, 26)
    View.cancel    = mkBtn("CANCEL EXPEDITION", "cancel", PAD + 16, botY, 220, 26)
    View.reload    = mkBtn("RELOAD LIST", "reload", PAD + 16, botY, 190, 26)
    mkBtn("< PAGE", "pagePrev", PAD + contentW - 350, botY, 105, 26)
    mkBtn("PAGE >", "pageNext", PAD + contentW - 235, botY, 105, 26)

    -- ===== лог (566..744) =====
    mkBg(Theme.PanelSection, PAD, 566, contentW, 178, 5)
    Factory.DrawFrame(surface, tree, PAD, 566, contentW, 178, Theme.Divider)
    mkText("LOG:", 10, Theme.TextDim, true, PAD + 16, 571, 300, 13)
    View.logFit = math.floor((178 - 26) / 15)
    for k = 1, View.logFit do
        View.logLines[k] = mkText("", 10, Theme.TextSecond, false, PAD + 16, 588 + (k - 1) * 15, contentW - 32, 14)
    end

    -- ===== футер =====
    local footerY = UI_H - PAD - 32
    mkBg(Theme.Divider, PAD, footerY - 4, contentW, 1, 6)
    mkText(string.format("%s or ESC — close panel", Config.OpenKey), 10, Theme.TextDim, false, PAD + 10, footerY + 8, 400, 16)
    mkBtn("CLOSE [ESC]", "close", PAD + contentW - 166, footerY - 2, 150, 30)

    -- ===== статические обработчики (назначаются один раз) =====
    Handlers["refresh"] = function()
        if S.mode == "palbox" then SafeDo("reload palbox", DoLoadPalbox) end
        refreshView()
    end
    Handlers["prev"] = function()
        local _, total = SelectedStation()
        if total > 0 then S.sel = (S.sel - 2) % total + 1 end
        refreshView()
    end
    Handlers["next"] = function()
        local _, total = SelectedStation()
        if total > 0 then S.sel = S.sel % total + 1 end
        refreshView()
    end
    Handlers["modePrev"] = function()
        local order = { "missions", "palbox", "assigned" }
        local idx = 1
        for i, m in ipairs(order) do if m == S.mode then idx = i; break end end
        S.mode = order[(idx - 2) % 3 + 1]
        S.listPage = 1
        if S.mode == "palbox" then SafeDo("load palbox", DoLoadPalbox)
        elseif S.mode == "missions" and S.missions == nil then SafeDo("load missions", DoLoadMissions) end
        refreshView()
    end
    Handlers["modeNext"] = function()
        local order = { "missions", "palbox", "assigned" }
        local idx = 1
        for i, m in ipairs(order) do if m == S.mode then idx = i; break end end
        S.mode = order[idx % 3 + 1]
        S.listPage = 1
        if S.mode == "palbox" then SafeDo("load palbox", DoLoadPalbox)
        elseif S.mode == "missions" and S.missions == nil then SafeDo("load missions", DoLoadMissions) end
        refreshView()
    end
    Handlers["modeTitle"] = function()
        if S.mode == "missions" then SafeDo("refresh missions", DoLoadMissions)
        elseif S.mode == "palbox" then SafeDo("refresh palbox", DoLoadPalbox) end
        refreshView()
    end
    Handlers["auto"]       = DoAutoFill
    Handlers["start"]      = DoLaunchRepeat
    Handlers["collect"]    = DoCollect
    Handlers["collectall"] = DoCollectAll
    Handlers["removeall"]  = DoUnselectAllPals
    Handlers["cancel"]     = DoCancelMission
    Handlers["reload"] = function()
        SafeDo("reload palbox", DoLoadPalbox)
        refreshView()
    end
    Handlers["pagePrev"] = function()
        S.listPage = S.listPage - 1
        if S.listPage < 1 then S.listPage = View.pages or 1 end
        refreshView()
    end
    Handlers["pageNext"] = function()
        S.listPage = S.listPage + 1
        if S.listPage > (View.pages or 1) then S.listPage = 1 end
        refreshView()
    end
    Handlers["close"] = function() Presenter_Close() end

    View.built = true
end

-- ================================ ОБНОВЛЕНИЕ (только на месте) ======================
refreshView = function()
    if not View.built or not IsValidObj(State.activeSurface) then return end

    local st, total = SelectedStation()

    -- шапка / станция
    setTextW(View.sub, string.format("stations: %d", total))
    setTextW(View.selText, string.format("STATION  %d / %d", (total > 0 and S.sel) or 0, total))

    -- детали станции
    local lines = StationDetailLines()
    for i = 1, #View.det do
        local w = View.det[i]
        if lines[i] then setTextW(w, lines[i]); setVisW(w, true)
        else setVisW(w, false) end
    end

    -- данные списка
    local curMissionId
    if st then curMissionId = Str(ReadField(st, "TargetMissionId")) end
    local assignedItems = nil
    if S.mode == "assigned" then assignedItems = AssignedItemsOf(st) end
    local items = (S.mode == "missions" and S.missions)
        or (S.mode == "palbox" and S.palbox)
        or assignedItems
        or {}
    local rowsPerPage = 6
    local pages = math.max(1, math.ceil(#items / rowsPerPage))
    if S.listPage > pages then S.listPage = pages end
    if S.listPage < 1 then S.listPage = 1 end
    View.pages = pages
    setTextW(View.modeTitle, MODE_TITLE[S.mode] or "?")
    setTextW(View.pageHint, string.format("page %d/%d · total %d", S.listPage, pages, #items))

    -- строки списка
    local first = (S.listPage - 1) * rowsPerPage + 1
    for r = 1, rowsPerPage do
        local row = View.rows[r]
        local i = first + r - 1
        local it = items[i]
        if it then
            local hi, dim, txt, btnTxt
            if S.mode == "missions" then
                hi = (it.id == curMissionId)
                dim = false
                txt = string.format("%d. %s", i, it.text)
                btnTxt = hi and "SELECTED" or "SELECT"
                Handlers["row" .. r] = function() DoSelectMission(it.id) end
            elseif S.mode == "palbox" then
                local lvl = it.level and ("Lv" .. it.level) or "Lv?"
                local rk = (it.rank and it.rank > 0) and (" ★" .. it.rank) or ""
                local strn = it.strength and tostring(it.strength) or "?"
                local mark = it.busy and "  [on expedition]" or (it.excluded and "  [excluded]" or "")
                hi = false
                dim = it.busy
                txt = string.format("%d. %s %s%s | power %s%s", i, it.name, lvl, rk, strn, mark)
                btnTxt = it.busy and "BUSY" or "+ ADD"
                Handlers["row" .. r] = function() DoAddPal(it.key) end
            else
                local lvl = it.level and ("Lv" .. it.level) or ""
                local strn = it.strength and tostring(it.strength) or "?"
                hi = false
                dim = false
                txt = string.format("%d. %s %s | power %s", i, it.name, lvl, strn)
                btnTxt = "− REMOVE"
                Handlers["row" .. r] = function() DoRemovePal(it.key) end
            end
            setVisW(row.bgHi, hi)
            setVisW(row.bgNo, not hi)
            setVisW(row.txt, true)
            setVisW(row.btn, true)
            setTextW(row.txt, txt)
            tintTextW(row.txt, dim and Theme.TextDim or Theme.TextSecond)
            setTextW(row.btn, btnTxt)
        else
            setVisW(row.bgHi, false)
            setVisW(row.bgNo, false)
            setVisW(row.txt, false)
            setVisW(row.btn, false)
            Handlers["row" .. r] = nil
        end
    end

    -- подсказка пустого списка
    if #items == 0 then
        setTextW(View.hint, EMPTY_HINTS[S.mode] or "")
        setVisW(View.hint, true)
    else
        setVisW(View.hint, false)
    end

    -- нижняя строка блока (режимные кнопки)
    local _, stState = GetState(st)
    setVisW(View.removeall, S.mode == "assigned" and stState ~= "InProgress")
    setVisW(View.cancel, S.mode == "assigned" and stState == "InProgress")
    setVisW(View.reload, S.mode == "palbox")

    -- лог (последние влезающие строки)
    local maxShow = View.logFit or 10
    local startIdx = math.max(1, #S.logLines - maxShow + 1)
    for k = 1, #View.logLines do
        local lineTxt = S.logLines[startIdx + k - 1]
        if lineTxt then
            setTextW(View.logLines[k], lineTxt)
            setVisW(View.logLines[k], true)
            local color
            if lineTxt:find("ERROR", 1, true) then color = Theme.Red
            elseif lineTxt:find("InProgress", 1, true) or lineTxt:find("OK:", 1, true) then color = Theme.Green
            else color = Theme.TextSecond end
            tintTextW(View.logLines[k], color)
        else
            setVisW(View.logLines[k], false)
        end
    end
end

-- RequestRender: троттлинг обновлений (обновление на месте безопасно, но
-- незачем молотить чаще 200 мс — например, при COLLECT ALL по многим станциям)
local RequestRender
local lastRefreshAt, refreshPending = 0, false
RequestRender = function()
    if not State.isDisplayed then return end
    local now = os.clock() * 1000
    if now - lastRefreshAt >= 200 then
        lastRefreshAt = now
        refreshView()
        return
    end
    if refreshPending then return end
    refreshPending = true
    DelayCall(220, function()
        refreshPending = false
        if not State.isDisplayed then return end
        lastRefreshAt = os.clock() * 1000
        refreshView()
    end)
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
    View.built = false
    ClickDispatcher.Reset()
end

local function Presenter_Show()
    Presenter_Close()

    local layout = Engine.LocateMainLayout()
    if not IsValidObj(layout) then
        Log("layout not found — enter the world and open the panel again")
        return
    end
    local tree = layout.WidgetTree
    if not IsValidObj(tree) then
        Log("WidgetTree not found")
        return
    end
    local layoutName
    local okN, n = pcall(function() return tree:GetFullName() end)
    if okN and type(n) == "string" then layoutName = n end
    if not layoutName then Log("failed to get layout name"); return end

    local hostCanvas = Engine.FindHostCanvas(layoutName, Assets.HostPanelName)
    if not IsValidObj(hostCanvas) then
        Log("host canvas not found")
        return
    end

    local frame = assembleModalFrame(hostCanvas, tree, UI_W, UI_H)
    if not frame then return end

    State.activeShell   = frame.shell
    State.activeSurface = frame.surface
    State.widgetTree    = tree
    State.hostCanvas    = hostCanvas
    State.isDisplayed   = true

    buildView()
    refreshView()
    Log("panel opened")
end

local function Presenter_IsVisible()
    return State.isDisplayed
end

local function Presenter_Refresh()
    RequestRender()
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
        Err("RegisterKeyBind unavailable")
        return false
    end
    local keyEnum = Key[tostring(keyName):upper()]
    if keyEnum == nil then
        Err("unknown key: " .. tostring(keyName))
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
    Log("world loaded — panel closed")
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
            Logf(">>> [hook] %s: playerId=%s, archive(%d bytes): %s",
                label, tostring(pid), #t, BytesToHex(t, 64))
        else
            Logf(">>> [hook] %s: playerId=%s, archive not readable", label, tostring(pid))
        end
    end)
end

local function RegisterPassiveHooks()
    local hooks = {
        { "select mission",  "RequestSelectMission_ServerInternal",        true },
        { "add pal", "RequestSelectAssignedCharacter_ServerInternal", true },
        { "remove pal",    "RequestUnselectAssignedCharacter_ServerInternal", true },
    }
    for _, h in ipairs(hooks) do
        local label, fn = h[1], h[2]
        local ok, err = pcall(RegisterHook,
            "/Script/Pal.PalMapObjectCharacterTeamMissionModel:" .. fn,
            function(self, paramPid, paramArchive)
                DumpHookArchive(label, paramPid, paramArchive)
            end)
        if ok then
            Log("hook registered: " .. label)
        else
            Log("hook NOT registered: " .. label .. " → " .. tostring(err))
        end
    end
    local okS, errS = pcall(RegisterHook,
        "/Script/Pal.PalMapObjectCharacterTeamMissionModel:RequestStartMission_ServerInternal",
        function(self, paramPid)
            SafeDo("hook:start", function()
                Log(">>> [hook] expedition start: playerId=" .. tostring(Num(Unwrap(paramPid))))
            end)
        end)
    if okS then Log("start hook registered")
    else Log("start hook NOT registered → " .. tostring(errS)) end
end


-- ============================== INIT ==============================
local function init()
    bindKey(Config.OpenKey, toggleUI)
    bindKey("ESCAPE", function()
        if Presenter_IsVisible() then Presenter_Close() end
    end)
    registerWorldEnterHook()
    RegisterPassiveHooks()
    Log("ExpeditionHub v0.11 ready: in-place UI updates only — no widget destroy/recreate (0x10 crash fix).")
end

SafeDo(init)
