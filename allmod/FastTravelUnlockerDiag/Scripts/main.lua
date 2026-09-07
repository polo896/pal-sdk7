-- ============================================================================
-- FAST TRAVEL UNLOCKER - ДИАГНОСТИКА (Palworld 1.0.4+ / SDK7)
-- ============================================================================
--  Отдельный тестовый мод. Ничего не делает сам, только отвечает на команду
--      !eaglediag
--  и вываливает в UE4SS.log всё, что нужно, чтобы понять, почему разблокировка
--  не работает именно в этой сборке игры/UE4SS:
--    * какие функции/классы из SDK реально находятся;
--    * есть ли ещё старый RPC RequestUnlockFastTravelPoint_ToServer (должен быть
--      выпилен в 1.0.4 - если он есть, значит патч другой);
--    * умеет ли UE4SS передавать struct-параметры (нужно для записи флага
--      через UPalPlayerRecordDataUtility);
--    * какими ключами игра реально помечает открытые точки в
--      UPalPlayerRecordData::FastTravelPointUnlockFlag;
--    * прогоняет по ОДНОЙ закрытой точке все способы разблокировки и пишет,
--      какой из них реально выставляет флаг.
-- ----------------------------------------------------------------------------

local TAG = "[EagleDiag]"
local DIAG_COMMAND = "!eaglediag"

local function Log(msg)
    print(TAG .. " " .. tostring(msg) .. "\n")
end

local function Sep(title)
    Log("--------------------------------------------------------------")
    if title then Log(title) end
end

local function IsValid(obj)
    if obj == nil then return false end
    local ok, res = pcall(function() return obj:IsValid() end)
    return ok and res == true
end

local function ToStr(value)
    if value == nil then return nil end
    local ok, s = pcall(function() return value:ToString() end)
    if ok and type(s) == "string" then return s end
    return tostring(value)
end

local function GuidToHexStr(guid)
    if not guid then return nil end
    local function u32(v) return (v < 0) and (v + 4294967296) or v end
    local ok, res = pcall(function()
        return string.format("%08X%08X%08X%08X", u32(guid.A), u32(guid.B), u32(guid.C), u32(guid.D))
    end)
    return ok and res or nil
end

-- ---------------------------------------------------------------------------
-- Поиск объектов
-- ---------------------------------------------------------------------------

local function GetLocalPlayerController()
    local controllers = FindAllOf("BP_PalPlayerController_C")
    if controllers then
        for _, c in ipairs(controllers) do
            if IsValid(c) then
                local ok, res = pcall(function() return c:IsLocalPlayerController() end)
                if ok and res == true then return c end
            end
        end
        for _, c in ipairs(controllers) do if IsValid(c) then return c end end
    end
    local f = FindFirstOf("PalPlayerController")
    return IsValid(f) and f or nil
end

local function GetLocalPlayerCharacter()
    local pc = GetLocalPlayerController()
    if IsValid(pc) then
        if IsValid(pc.Pawn) then return pc.Pawn end
        if IsValid(pc.Character) then return pc.Character end
    end
    local f = FindFirstOf("PalPlayerCharacter")
    return IsValid(f) and f or nil
end

local function GetLocalPlayerState()
    local pc = GetLocalPlayerController()
    if IsValid(pc) and IsValid(pc.PlayerState) then return pc.PlayerState end
    local f = FindFirstOf("PalPlayerState")
    return IsValid(f) and f or nil
end

local function GetRecordData(worldContext)
    local util = StaticFindObject("/Script/Pal.Default__PalUtility")
    local src = nil
    if util and worldContext then
        local ok, res = pcall(function() return util:GetLocalRecordData(worldContext) end)
        if ok and IsValid(res) then return res, "PalUtility::GetLocalRecordData" end
    end
    local ps = GetLocalPlayerState()
    if IsValid(ps) then
        local ok, res = pcall(function() return ps:GetRecordData() end)
        if ok and IsValid(res) then return res, "PalPlayerState::GetRecordData" end
    end
    return nil, src
end

local function GetFlagsTable()
    local world = GetLocalPlayerController()
    if not IsValid(world) then return nil end
    local recordData = GetRecordData(world)
    if not recordData then return nil end
    local ok, flags = pcall(function() return recordData.FastTravelPointUnlockFlag end)
    if not ok or flags == nil then return nil end
    return flags
end

-- ---------------------------------------------------------------------------
-- Проверки наличия
-- ---------------------------------------------------------------------------

local function CheckStaticObject(label, path)
    local obj = StaticFindObject(path)
    Log(string.format("%-58s : %s", label, (obj ~= nil) and "OK" or "НЕ НАЙДЕН"))
    return obj
end

local function CheckMethod(label, obj, name)
    if obj == nil then
        Log(string.format("%-58s : нет объекта", label))
        return false
    end
    local ok, val = pcall(function() return obj[name] end)
    local present = ok and (val ~= nil)
    Log(string.format("%-58s : %s", label, present and "OK" or "ОТСУТСТВУЕТ"))
    return present
end

local function DumpPresence()
    Sep("1. НАЛИЧИЕ КЛАССОВ / ФУНКЦИЙ (SDK 1.0.4)")

    CheckStaticObject("PalUtility (CDO)", "/Script/Pal.Default__PalUtility")
    CheckStaticObject("PalPlayerRecordDataUtility (CDO)", "/Script/Pal.Default__PalPlayerRecordDataUtility")
    CheckStaticObject("PalCutsceneBindParameter_FasttravelPoint", "/Script/Pal.PalCutsceneBindParameter_FasttravelPoint")
    CheckStaticObject("PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud",
        "/Script/Pal.PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud")

    -- Старый RPC: в 1.0.4 его быть не должно.
    local pc = GetLocalPlayerController()
    local transmitter = nil
    local playerNet = nil
    if IsValid(pc) then
        transmitter = pc.Transmitter
        if IsValid(transmitter) and IsValid(transmitter.Player) then playerNet = transmitter.Player end
    end
    Log(string.format("%-58s : %s", "PalPlayerController / Transmitter / Player",
        (IsValid(pc) and "PC ok" or "PC НЕ НАЙДЕН") .. ", "
        .. (IsValid(transmitter) and "transmitter ok" or "transmitter НЕ НАЙДЕН") .. ", "
        .. (IsValid(playerNet) and "network component ok" or "network component НЕ НАЙДЕН")))
    if playerNet then
        CheckMethod("старый RPC RequestUnlockFastTravelPoint_ToServer", playerNet, "RequestUnlockFastTravelPoint_ToServer")
    end

    -- Методы статуи
    local statue = FindFirstOf("PalLevelObjectUnlockableFastTravelPoint")
    if IsValid(statue) then
        CheckMethod("APalLevelObjectUnlockableFastTravelPoint.OnTriggerInteract", statue, "OnTriggerInteract")
        CheckMethod("APalLevelObjectUnlockableFastTravelPoint.OnEndCutscene", statue, "OnEndCutscene")
        CheckMethod("APalLevelObjectUnlockableFastTravelPoint.OnCompleteSyncPlayer", statue, "OnCompleteSyncPlayer")
        CheckMethod("APalLevelObjectUnlockableFastTravelPoint.IsUnlocked", statue, "IsUnlocked")
        CheckMethod("APalLevelObjectUnlockableFastTravelPoint.OnUpdateFlagMapRecord", statue, "OnUpdateFlagMapRecord")
    else
        Log("APalLevelObjectUnlockableFastTravelPoint                : НЕ НАЙДЕН НИ ОДИН ЭКЗЕМПЛЯР")
    end

    -- Точки на карте / локейшены
    local loc = FindFirstOf("PalLocationPointFastTravel")
    if IsValid(loc) then
        CheckMethod("UPalLocationPointFastTravel.IsUnlockMapPoint", loc, "IsUnlockMapPoint")
        CheckMethod("UPalLocationPoint.IsEnableFastTravel", loc, "IsEnableFastTravel")
    else
        Log("UPalLocationPointFastTravel                             : НЕ НАЙДЕН НИ ОДИН ЭКЗЕМПЛЯР")
    end

    -- RecordData
    local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if util then
        CheckMethod("PalPlayerRecordDataUtility.SetRecordData_Bool_ForServer", util, "SetRecordData_Bool_ForServer")
        CheckMethod("PalPlayerRecordDataUtility.GetRecordData_Bool", util, "GetRecordData_Bool")
        CheckMethod("PalPlayerRecordDataUtility.GetRecordData_BoolCount", util, "GetRecordData_BoolCount")
    end

    -- Отладочный флаг "игнорировать блокировку быстрого перемещения"
    local palUtil = StaticFindObject("/Script/Pal.Default__PalUtility")
    if palUtil then
        local ok, debugSetting = pcall(function() return palUtil:GetPalDebugSetting() end)
        if ok and debugSetting ~= nil then
            local okFlag, val = pcall(function() return debugSetting.bIgnoreFastTravelLock end)
            Log(string.format("%-58s : %s (сейчас = %s)", "UPalDebugSetting.bIgnoreFastTravelLock",
                okFlag and "OK" or "НЕ ЧИТАЕТСЯ", tostring(val)))
        else
            Log(string.format("%-58s : %s", "UPalDebugSetting (GetPalDebugSetting)", "НЕ НАЙДЕН"))
        end
    end
end

-- ---------------------------------------------------------------------------
-- Struct-параметры и ключи флагов
-- ---------------------------------------------------------------------------

local function DumpRecordData()
    Sep("2. RECORD DATA / ФЛАГИ ОТКРЫТЫХ ТОЧЕК")

    local world = GetLocalPlayerController()
    if not IsValid(world) then
        Log("PlayerController не найден - дальше некуда.")
        return nil
    end

    local recordData, src = GetRecordData(world)
    if not recordData then
        Log("UPalPlayerRecordData НЕ НАЙДЕН (ни через PalUtility, ни через PlayerState).")
        return nil
    end
    Log("RecordData получен через: " .. tostring(src))

    local flags = GetFlagsTable()
    if flags == nil then
        Log("FastTravelPointUnlockFlag не читается - прямая запись/чтение флага невозможна.")
        return nil
    end
    Log("FastTravelPointUnlockFlag: прочитан.")

    -- Поддержка struct-параметров в этой сборке UE4SS
    local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if util then
        local ok, err = pcall(function() return util:GetRecordData_Bool(flags, FName("None")) end)
        Log(string.format("struct-параметры UE4SS (GetRecordData_Bool)      : %s",
            ok and "ПОДДЕРЖИВАЮТСЯ" or ("НЕ ПОДДЕРЖИВАЮТСЯ -> " .. tostring(err))))

        local okCount, count = pcall(function() return util:GetRecordData_BoolCount(flags) end)
        if okCount then
            Log(string.format("Открытых точек по версии RecordData (GetRecordData_BoolCount): %s", tostring(count)))
        end
    end

    -- Пробуем вытащить сами ключи - так видно, чем игра реально помечает точки
    local okItems, items = pcall(function() return flags.Items end)
    if okItems and items ~= nil then
        local okNum, num = pcall(function() return #items end)
        if okNum then
            Log(string.format("FastTravelPointUnlockFlag.Items: %d шт.", num))
            for i = 1, math.min(num, 25) do
                local okItem, item = pcall(function() return items[i] end)
                if okItem and item then
                    local k, v
                    pcall(function() k = ToStr(item.Key) end)
                    pcall(function() v = item.Value end)
                    Log(string.format("   [%02d] Key=%s Value=%s", i, tostring(k), tostring(v)))
                end
            end
        else
            Log("FastTravelPointUnlockFlag.Items: прочитать размер не удалось (" .. tostring(num) .. ")")
        end
    else
        Log("FastTravelPointUnlockFlag.Items: не читается (" .. tostring(items) .. ")")
    end

    return flags
end

-- ---------------------------------------------------------------------------
-- Тест способов разблокировки на одной закрытой точке
-- ---------------------------------------------------------------------------

local function StatueIsUnlocked(statue)
    local ok, res = pcall(function() return statue:IsUnlocked() end)
    return ok and res == true
end

local function KeysFor(statue)
    local keys = {}
    local idStr = ToStr(statue.FastTravelPointID)
    if idStr and idStr ~= "" and idStr ~= "None" then keys[#keys + 1] = idStr end
    local guidStr = GuidToHexStr(statue.LevelObjectInstanceId)
    if guidStr then keys[#keys + 1] = guidStr end
    return keys
end

local function ReadFlag(flags, keys)
    local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if not util or not flags then return nil end
    local anyOk = false
    for _, key in ipairs(keys) do
        local ok, res = pcall(function() return util:GetRecordData_Bool(flags, FName(key)) end)
        if ok then
            anyOk = true
            if res == true then return true end
        end
    end
    if not anyOk then return nil end
    return false
end

local function DumpStatueTest()
    Sep("3. ТЕСТ СПОСОБОВ РАЗБЛОКИРОВКИ (на одной закрытой точке)")

    local statues = FindAllOf("PalLevelObjectUnlockableFastTravelPoint")
    if not statues or #statues == 0 then
        Log("Не найдено ни одной PalLevelObjectUnlockableFastTravelPoint (стриминг?).")
        return
    end

    local total, unlockedCount = 0, 0
    for _, s in ipairs(statues) do
        if IsValid(s) then
            total = total + 1
            if StatueIsUnlocked(s) then unlockedCount = unlockedCount + 1 end
        end
    end
    Log(string.format("Статуй загружено: %d, из них IsUnlocked() = true: %d", total, unlockedCount))

    local target = nil
    for _, s in ipairs(statues) do
        if IsValid(s) and not StatueIsUnlocked(s) then target = s break end
    end
    if not target then
        Log("Все загруженные точки уже открыты - тест выполнять не на ком.")
        return
    end

    local idStr = ToStr(target.FastTravelPointID)
    local keys = KeysFor(target)
    Log(string.format("Тестовая точка: FastTravelPointID=%s, LevelObjectInstanceId=%s",
        tostring(idStr), tostring(keys[2])))
    Log("Проверочные ключи флага: " .. table.concat(keys, ", "))

    local character = GetLocalPlayerCharacter()
    local playerState = GetLocalPlayerState()
    local flags = GetFlagsTable()

    local function Report(methodName, fn)
        local before = ReadFlag(flags, keys)
        local ok, err = pcall(fn)
        pcall(function() target:OnCompleteSyncPlayer(playerState) end)
        local unlocked = StatueIsUnlocked(target)
        local after = ReadFlag(flags, keys)
        Log(string.format("  %-22s | вызов: %-28s | IsUnlocked=%-5s | флаг до=%-5s после=%-5s",
            methodName,
            ok and "ok" or ("ОШИБКА: " .. tostring(err)),
            tostring(unlocked), tostring(before), tostring(after)))
        return (after == true)
    end

    pcall(function() target.EnableRequestUnlock = true end)

    local worked = false

    -- 1) хендлер завершения катсцены (без самой катсцены)
    worked = Report("OnEndCutscene", function()
        local cls = StaticFindObject("/Script/Pal.PalCutsceneBindParameter_FasttravelPoint")
        local param = StaticConstructObject(cls, target)
        target:OnEndCutscene(param)
    end) or worked

    -- если первым сработал этот способ, дальше проверять нечего
    if not StatueIsUnlocked(target) or ReadFlag(flags, keys) ~= true then
        -- 2) симуляция нажатия F (индикатор UnlockFastTravel = 26)
        worked = Report("OnTriggerInteract(26)", function()
            target:OnTriggerInteract(character, 26)
        end) or worked
    end

    -- 3) прямая запись флага
    if ReadFlag(flags, keys) ~= true then
        worked = Report("SetRecordData_Bool", function()
            local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
            local world = GetLocalPlayerController()
            for _, key in ipairs(keys) do
                util:SetRecordData_Bool_ForServer(world, flags, FName(key), true)
            end
        end) or worked
    end

    -- 4) косметика
    if ReadFlag(flags, keys) ~= true then
        worked = Report("bUnlocked=true", function()
            target.bUnlocked = true
        end) or worked
    end

    if worked then
        Log("ИТОГ: флаг FastTravelPointUnlockFlag выставлен - разблокировка настоящая, попадёт в сейв.")
    else
        Log("ИТОГ: ни один способ не выставил флаг в RecordData (или ключ флага отличается "
            .. "от FastTravelPointID / LevelObjectInstanceId).")
        Log("      Пришли в лог раздел 2 (список Items с ключами) - там видно, какими ключами "
            .. "игра реально помечает открытые точки.")
    end
end

-- ---------------------------------------------------------------------------
-- Точки на карте: что доступно для быстрого перемещения
-- ---------------------------------------------------------------------------

local function DumpLocationPoints()
    Sep("4. ЛОКЕЙШЕНЫ (что видит карта)")

    local locs = FindAllOf("PalLocationPointFastTravel")
    if not locs or #locs == 0 then
        Log("PalLocationPointFastTravel не найдены.")
        return
    end

    local enabled, disabled, pillars, statues = 0, 0, 0, 0
    for _, loc in ipairs(locs) do
        if IsValid(loc) then
            local isPillar
            local ok, res = pcall(function() return loc:IsUnlockMapPoint() end)
            if ok then isPillar = (res == true) else isPillar = (loc.bUnlockMapPoint == true) end
            if isPillar then pillars = pillars + 1 else statues = statues + 1 end

            local okEn, en = pcall(function() return loc:IsEnableFastTravel() end)
            if okEn and en == true then enabled = enabled + 1 else disabled = disabled + 1 end
        end
    end
    Log(string.format("PalLocationPointFastTravel: %d шт. (статуи: %d, колонны/мап-поинты: %d)",
        #locs, statues, pillars))
    Log(string.format("IsEnableFastTravel() = true: %d, false/не читается: %d", enabled, disabled))
end

-- ---------------------------------------------------------------------------
-- Команда
-- ---------------------------------------------------------------------------

local function RunDiag()
    Log("==============================================================")
    Log("ДИАГНОСТИКА FAST TRAVEL UNLOCKER")
    Log("==============================================================")
    DumpPresence()
    DumpRecordData()
    DumpLocationPoints()
    DumpStatueTest()
    Sep("КОНЕЦ ДИАГНОСТИКИ")
end

local ok, err = pcall(function()
    RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
        local received = message:get()
        if not received or not received.Message then return end
        local text = string.lower(received.Message:ToString())
        if text == DIAG_COMMAND then
            local okRun, runErr = pcall(RunDiag)
            if not okRun then Log("Диагностика упала: " .. tostring(runErr)) end
        end
    end)
end)

if ok then
    Log(string.format("Диагностический мод загружен. Команда: %s", DIAG_COMMAND))
else
    Log("Не удалось зарегистрировать чат-хук: " .. tostring(err))
end
