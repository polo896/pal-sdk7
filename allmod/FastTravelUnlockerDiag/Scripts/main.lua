-- ============================================================================
-- FAST TRAVEL UNLOCKER - ДИАГНОСТИКА (Palworld 1.0.4+ / SDK7)
-- ============================================================================
--  Тестовый мод. Сам ничего не разблокирует (кроме явных тестов), только
--  отвечает на команды и пишет в UE4SS.log.
--
--  ВАЖНО: команды РАЗДЕЛЕНЫ ПО СТЕПЕНИ ОПАСНОСТИ. Часть вызовов роняет игру
--  (EXCEPTION_ACCESS_VIOLATION) на некоторых сборках UE4SS - поэтому каждый
--  рискованный вызов обрамляется метками:
--      >>> ПЕРЕД ВЫЗОВОМ <имя>
--      <<< ВЫЖИЛИ ПОСЛЕ <имя>
--  Если игра упала - последняя строка ">>>" в UE4SS.log и есть виновник.
--
--  Команды:
--      !eaglediag              - безопасная часть: наличие функций, счётчики,
--                                чтение свойств (вызовов в игру почти нет)
--      !eaglediag record       - + чтение RecordData через struct-параметры
--                                (UPalPlayerRecordDataUtility::GetRecordData_Bool)
--      !eaglediag statue       - + OnTriggerInteract(Character, 26) на одной точке
--      !eaglediag cutscene     - + OnEndCutscene(...) на одной точке
--      !eaglediag write        - + SetRecordData_Bool_ForServer (запись флага)
--      !eaglediag all          - всё подряд (только если предыдущие выжили)
--      !eaglediag help         - подсказка
-- ============================================================================

local TAG = "[EagleDiag]"

local function Log(msg)
    print(TAG .. " " .. tostring(msg) .. "\n")
end

local function Sep(title)
    Log("--------------------------------------------------------------")
    if title then Log(title) end
end

-- Рискованный вызов: печатаем метку ДО и ПОСЛЕ, чтобы по логу видеть,
-- на чём именно игра умерла.
local function Risky(label, fn)
    Log(">>> ПЕРЕД ВЫЗОВОМ: " .. label)
    local results = { pcall(fn) }
    local ok = table.remove(results, 1)
    if not ok then
        Log("!!! ОШИБКА (Lua) в " .. label .. ": " .. tostring(results[1]))
        return nil
    end
    Log("<<< ВЫЖИЛИ ПОСЛЕ: " .. label .. " -> " .. tostring(results[1]))
    return results[1], results[2]
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
-- Доступ к игроку / RecordData
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

local function GetRecordData(worldContext, callLog)
    local util = StaticFindObject("/Script/Pal.Default__PalUtility")
    if util and worldContext then
        local rd = Risky("PalUtility::GetLocalRecordData(WorldContext)", function()
            return util:GetLocalRecordData(worldContext)
        end)
        if IsValid(rd) then return rd, "PalUtility::GetLocalRecordData" end
    end
    local ps = GetLocalPlayerState()
    if IsValid(ps) then
        local rd = Risky("PalPlayerState::GetRecordData()", function()
            return ps:GetRecordData()
        end)
        if IsValid(rd) then return rd, "PalPlayerState::GetRecordData" end
    end
    return nil, nil
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
-- ШАГ 1. Наличие классов и функций (только чтение, без вызовов в игру)
-- ---------------------------------------------------------------------------

local function CheckStaticObject(label, path)
    local obj = StaticFindObject(path)
    Log(string.format("%-58s : %s", label, (obj ~= nil) and "OK" or "НЕ НАЙДЕН"))
    return obj
end

-- ВАЖНО: в этой сборке UE4SS obj[name] возвращает "TrivialObject" даже для
-- несуществующих имён, поэтому проверять надо type(): настоящий UFUNCTION
-- приходит как function (иначе вызов падает с "attempt to call a TrivialObject").
local function CheckMethod(label, obj, name)
    if obj == nil then
        Log(string.format("%-58s : нет объекта", label))
        return false
    end
    local ok, val = pcall(function() return obj[name] end)
    if not ok then
        Log(string.format("%-58s : ошибка чтения: %s", label, tostring(val)))
        return false
    end
    if type(val) == "function" then
        Log(string.format("%-58s : OK (function)", label))
        return true
    end
    Log(string.format("%-58s : НЕ ФУНКЦИЯ (%s) -> вызывать нельзя", label, type(val)))
    return false
end

local function Stage1()
    Sep("ШАГ 1. НАЛИЧИЕ КЛАССОВ / ФУНКЦИЙ (чтение, без вызовов)")

    CheckStaticObject("PalUtility (CDO)", "/Script/Pal.Default__PalUtility")
    CheckStaticObject("PalPlayerRecordDataUtility (CDO)", "/Script/Pal.Default__PalPlayerRecordDataUtility")
    CheckStaticObject("PalCutsceneBindParameter_FasttravelPoint", "/Script/Pal.PalCutsceneBindParameter_FasttravelPoint")
    CheckStaticObject("PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud",
        "/Script/Pal.PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud")

    local pc = GetLocalPlayerController()
    local transmitter = IsValid(pc) and pc.Transmitter or nil
    local playerNet = (IsValid(transmitter) and IsValid(transmitter.Player)) and transmitter.Player or nil
    Log(string.format("%-58s : %s", "PlayerController / Transmitter / Player",
        (IsValid(pc) and "PC ok" or "PC НЕ НАЙДЕН") .. ", "
        .. (IsValid(transmitter) and "transmitter ok" or "transmitter НЕ НАЙДЕН") .. ", "
        .. (IsValid(playerNet) and "network ok" or "network НЕ НАЙДЕН")))
    if playerNet then
        CheckMethod("старый RPC RequestUnlockFastTravelPoint_ToServer", playerNet,
            "RequestUnlockFastTravelPoint_ToServer")
        -- КОНТРОЛЬ: заведомо несуществующее имя. Если и оно "OK", значит UE4SS
        -- возвращает что-то на любое имя и всем проверкам выше верить НЕЛЬЗЯ.
        CheckMethod("КОНТРОЛЬ (несуществующий метод)", playerNet,
            "ThisMethodSurelyDoesNotExist12345")
    end

    local statue = FindFirstOf("PalLevelObjectUnlockableFastTravelPoint")
    if IsValid(statue) then
        CheckMethod("...FastTravelPoint.OnTriggerInteract", statue, "OnTriggerInteract")
        CheckMethod("...FastTravelPoint.OnEndCutscene", statue, "OnEndCutscene")
        CheckMethod("...FastTravelPoint.OnCompleteSyncPlayer", statue, "OnCompleteSyncPlayer")
        CheckMethod("...FastTravelPoint.IsUnlocked", statue, "IsUnlocked")
        CheckMethod("...FastTravelPoint.OnUpdateFlagMapRecord", statue, "OnUpdateFlagMapRecord")
    else
        Log("PalLevelObjectUnlockableFastTravelPoint                 : НЕ НАЙДЕН НИ ОДИН ЭКЗЕМПЛЯР")
    end

    local loc = FindFirstOf("PalLocationPointFastTravel")
    if IsValid(loc) then
        CheckMethod("UPalLocationPointFastTravel.IsUnlockMapPoint", loc, "IsUnlockMapPoint")
        CheckMethod("UPalLocationPoint.IsEnableFastTravel", loc, "IsEnableFastTravel")
    else
        Log("UPalLocationPointFastTravel                             : НЕ НАЙДЕН НИ ОДИН ЭКЗЕМПЛЯР")
    end

    local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if util then
        CheckMethod("RecordDataUtility.SetRecordData_Bool_ForServer", util, "SetRecordData_Bool_ForServer")
        CheckMethod("RecordDataUtility.GetRecordData_Bool", util, "GetRecordData_Bool")
        CheckMethod("RecordDataUtility.GetRecordData_BoolCount", util, "GetRecordData_BoolCount")
    end

    local palUtil = StaticFindObject("/Script/Pal.Default__PalUtility")
    if palUtil then
        CheckMethod("PalUtility.GetPalDebugSetting", palUtil, "GetPalDebugSetting")
    end
end

-- ---------------------------------------------------------------------------
-- ШАГ 2. Счётчики (вызовы IsUnlocked/IsEnableFastTravel - дешёвые и безопасные)
-- ---------------------------------------------------------------------------

local function StatueIsUnlocked(statue)
    local ok, res = pcall(function() return statue:IsUnlocked() end)
    return ok and res == true
end

local function Stage2()
    Sep("ШАГ 2. СЧЁТЧИКИ (IsUnlocked / IsEnableFastTravel)")

    local statues = FindAllOf("PalLevelObjectUnlockableFastTravelPoint")
    local total, unlocked = 0, 0
    for _, s in ipairs(statues or {}) do
        if IsValid(s) then
            total = total + 1
            if StatueIsUnlocked(s) then unlocked = unlocked + 1 end
        end
    end
    Log(string.format("PalLevelObjectUnlockableFastTravelPoint: %d шт., IsUnlocked()=true: %d", total, unlocked))

    local locs = FindAllOf("PalLocationPointFastTravel")
    local enabled, disabled, pillars, statuesN = 0, 0, 0, 0
    for _, loc in ipairs(locs or {}) do
        if IsValid(loc) then
            local isPillar
            local ok, res = pcall(function() return loc:IsUnlockMapPoint() end)
            if ok then isPillar = (res == true) else isPillar = (loc.bUnlockMapPoint == true) end
            if isPillar then pillars = pillars + 1 else statuesN = statuesN + 1 end
            local okEn, en = pcall(function() return loc:IsEnableFastTravel() end)
            if okEn and en == true then enabled = enabled + 1 else disabled = disabled + 1 end
        end
    end
    Log(string.format("PalLocationPointFastTravel: %d шт. (статуи: %d, колонны: %d)",
        (locs and #locs) or 0, statuesN, pillars))
    Log(string.format("IsEnableFastTravel() = true: %d, false/не читается: %d", enabled, disabled))
end

-- ---------------------------------------------------------------------------
-- ШАГ 3. RecordData: чтение свойства + struct-вызовы (ОПАСНО)
-- ---------------------------------------------------------------------------

local function ReadFlagSafe(flags, keys)
    local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if not util or not flags then return nil end
    local anyOk = false
    for _, key in ipairs(keys) do
        local res = Risky("GetRecordData_Bool(flags, '" .. tostring(key) .. "')", function()
            return util:GetRecordData_Bool(flags, FName(key))
        end)
        if res ~= nil then
            anyOk = true
            if res == true then return true end
        end
    end
    if not anyOk then return nil end
    return false
end

local function Stage3(structCalls)
    Sep("ШАГ 3. RECORD DATA")

    local world = GetLocalPlayerController()
    if not IsValid(world) then
        Log("PlayerController не найден.")
        return nil
    end

    local recordData, src = GetRecordData(world)
    if not recordData then
        Log("UPalPlayerRecordData НЕ НАЙДЕН.")
        return nil
    end
    Log("RecordData получен через: " .. tostring(src))

    local okFlags, flags = pcall(function() return recordData.FastTravelPointUnlockFlag end)
    if not okFlags or flags == nil then
        Log("FastTravelPointUnlockFlag не читается.")
        return nil
    end
    Log("FastTravelPointUnlockFlag: свойство прочитано (тип struct).")

    -- Покажем ключи, если массив читается (это просто чтение свойства)
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
            Log("FastTravelPointUnlockFlag.Items: размер не читается (" .. tostring(num) .. ")")
        end
    else
        Log("FastTravelPointUnlockFlag.Items: не читается (" .. tostring(items) .. ")")
    end

    if not structCalls then
        Log("struct-вызовы пропущены (нужна команда !eaglediag record).")
        return flags
    end

    local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if util then
        Risky("GetRecordData_BoolCount(flags)", function() return util:GetRecordData_BoolCount(flags) end)
        Risky("GetRecordData_Bool(flags, 'None') - проба struct-параметра", function()
            return util:GetRecordData_Bool(flags, FName("None"))
        end)
    end
    return flags
end

-- ---------------------------------------------------------------------------
-- ШАГ 4. Тест способов разблокировки на ОДНОЙ закрытой точке
-- ---------------------------------------------------------------------------

local function FindTestTarget()
    local statues = FindAllOf("PalLevelObjectUnlockableFastTravelPoint")
    for _, s in ipairs(statues or {}) do
        if IsValid(s) and not StatueIsUnlocked(s) then return s end
    end
    return nil
end

local function KeysFor(statue)
    local keys = {}
    local idStr = ToStr(statue.FastTravelPointID)
    if idStr and idStr ~= "" and idStr ~= "None" then keys[#keys + 1] = idStr end
    local guidStr = GuidToHexStr(statue.LevelObjectInstanceId)
    if guidStr then keys[#keys + 1] = guidStr end
    return keys
end

local function TestMethod(target, flags, label, fn, readFlagAfter)
    Log("--- тест: " .. label)
    local before = nil
    if readFlagAfter and flags then before = ReadFlagSafe(flags, KeysFor(target)) end

    Risky(label, fn)

    local playerState = GetLocalPlayerState()
    if IsValid(playerState) then
        Risky("OnCompleteSyncPlayer(PlayerState)", function() return target:OnCompleteSyncPlayer(playerState) end)
    end

    local unlocked = StatueIsUnlocked(target)
    local after = nil
    if readFlagAfter and flags then after = ReadFlagSafe(flags, KeysFor(target)) end

    Log(string.format("    итог %-24s | IsUnlocked=%-5s | флаг до=%-5s после=%s",
        label, tostring(unlocked), tostring(before), tostring(after)))
    return (after == true)
end

-- ШАГ: сопоставление ключей флага со статуями (РЕШАЮЩИЙ ТЕСТ)
local function StageKeys()
    Sep("ШАГ 4. КЛЮЧИ ФЛАГА vs СТАТУИ")

    local flagKeys = {}
    local flags = GetFlagsTable()
    if flags then
        local ok, items = pcall(function() return flags.Items end)
        if ok and items ~= nil then
            local okN, num = pcall(function() return #items end)
            if okN then
                Log(string.format("FastTravelPointUnlockFlag.Items: %d шт.", num))
                for i = 1, num do
                    local okI, item = pcall(function() return items[i] end)
                    if okI and item then
                        local k
                        pcall(function() k = ToStr(item.Key) end)
                        local v
                        pcall(function() v = item.Value end)
                        k = tostring(k)
                        flagKeys[k:upper()] = true
                        Log(string.format("   ключ[%02d] = %s (Value=%s)", i, k, tostring(v)))
                    end
                end
            end
        end
    else
        Log("RecordData не получен, ключи читать неоткуда.")
        return
    end

    local statues = FindAllOf("PalLevelObjectUnlockableFastTravelPoint")
    local foundAny = false
    local samples = 0
    for _, s in ipairs(statues or {}) do
        if IsValid(s) then
            local id = tostring(ToStr(s.FastTravelPointID))
            local gid = tostring(GuidToHexStr(s.LevelObjectInstanceId))
            local unlocked = StatueIsUnlocked(s)
            local hitId = flagKeys[id:upper()] == true
            local hitGuid = flagKeys[gid:upper()] == true
            if unlocked or hitId or hitGuid then
                foundAny = true
                Log(string.format("   СОВПАДЕНИЕ: FastTravelPointID=%s | GUID=%s | IsUnlocked=%s "
                    .. "| id есть в ключах: %s | GUID есть в ключах: %s",
                    id, gid, tostring(unlocked), tostring(hitId), tostring(hitGuid)))
            elseif samples < 5 then
                samples = samples + 1
                Log(string.format("   пример: FastTravelPointID=%s | GUID=%s | IsUnlocked=%s",
                    id, gid, tostring(unlocked)))
            end
        end
    end
    if not foundAny then
        Log("Совпадений не найдено: ни у одной статуи ни FastTravelPointID, ни GUID "
            .. "LevelObjectInstanceId не совпали с ключами флага.")
    else
        Log("Смотри строку СОВПАДЕНИЕ выше: какое из полей отмечено 'есть в ключах' - "
            .. "то и есть настоящий ключ флага.")
    end
end

-- ШАГ: OnUpdateFlagMapRecord(Key, bFlag) - БЕЗ struct-параметров
local function StageFlagMap()
    Sep("ШАГ 4. ТЕСТ OnUpdateFlagMapRecord(FName Key, bool bFlag)")
    local target = FindTestTarget()
    if not target then
        Log("Нет закрытых точек для теста.")
        return
    end
    local keys = KeysFor(target)
    Log(string.format("Тестовая точка: FastTravelPointID=%s | GUID=%s", tostring(keys[1]), tostring(keys[2])))
    Log("До: IsUnlocked=" .. tostring(StatueIsUnlocked(target)))

    for _, key in ipairs(keys) do
        local res = Risky("OnUpdateFlagMapRecord('" .. tostring(key) .. "', true)", function()
            target:OnUpdateFlagMapRecord(FName(key), true)
            return true
        end)
        if res == nil then
            Log("    вызов не прошёл: функция отсутствует или не вызывается.")
            break
        end
        local ps = GetLocalPlayerState()
        if IsValid(ps) then
            Risky("OnCompleteSyncPlayer(PlayerState)", function() return target:OnCompleteSyncPlayer(ps) end)
        end
        Log(string.format("    ключ %-34s -> IsUnlocked=%s", tostring(key), tostring(StatueIsUnlocked(target))))
        if StatueIsUnlocked(target) then break end
    end
    local flags = GetFlagsTable()
    if flags then
        local ok, items = pcall(function() return flags.Items end)
        if ok and items ~= nil then
            local okN, num = pcall(function() return #items end)
            if okN then Log(string.format("FastTravelPointUnlockFlag.Items после теста: %d шт.", num)) end
        end
    end
end

-- ШАГ 4a. Старый RPC (если он ещё жив в этой сборке - это лучший путь)
local function StageRpc()
    Sep("ШАГ 4. ТЕСТ СТАРОГО RPC")

    local pc = GetLocalPlayerController()
    local net = (IsValid(pc) and IsValid(pc.Transmitter) and IsValid(pc.Transmitter.Player))
        and pc.Transmitter.Player or nil
    if not net then
        Log("PalNetworkPlayerComponent не найден.")
        return
    end
    if net.RequestUnlockFastTravelPoint_ToServer == nil then
        Log("RequestUnlockFastTravelPoint_ToServer отсутствует (nil) - это сборка 1.0.4.")
        return
    end

    local target = FindTestTarget()
    if not target then
        Log("Нет закрытых точек для теста.")
        return
    end
    local keys = KeysFor(target)
    Log(string.format("Тестовая точка: FastTravelPointID=%s, GUID=%s", tostring(keys[1]), tostring(keys[2])))

    local unlockedBefore = StatueIsUnlocked(target)
    for _, key in ipairs(keys) do
        local res = Risky("RequestUnlockFastTravelPoint_ToServer('" .. tostring(key) .. "')", function()
            net:RequestUnlockFastTravelPoint_ToServer(FName(key))
            return true
        end)
        if res == nil then break end
        local ps = GetLocalPlayerState()
        if IsValid(ps) then
            Risky("OnCompleteSyncPlayer(PlayerState)", function() return target:OnCompleteSyncPlayer(ps) end)
        end
        Log(string.format("    ключ %-34s -> IsUnlocked=%s", tostring(key), tostring(StatueIsUnlocked(target))))
        if StatueIsUnlocked(target) then break end
    end
    Log(string.format("ИТОГ RPC: было IsUnlocked=%s, стало %s",
        tostring(unlockedBefore), tostring(StatueIsUnlocked(target))))
end

-- ШАГ 4b. Перебор индикаторов: вдруг в этой сборке UnlockFastTravel != 26
local function StageBrute()
    Sep("ШАГ 4. ПЕРЕБОР ИНДИКАТОРОВ OnTriggerInteract(Other, N)")

    local target = FindTestTarget()
    if not target then
        Log("Нет закрытых точек для теста.")
        return
    end
    Log(string.format("Тестовая точка: FastTravelPointID=%s", tostring(KeysFor(target)[1])))
    Log("Эксперимент: перебираем N = 0..80, после каждого проверяем IsUnlocked().")

    local character = GetLocalPlayerCharacter()
    local pc = GetLocalPlayerController()
    local ps = GetLocalPlayerState()

    local function Pass(other, label)
        for i = 0, 80 do
            local ok, err = pcall(function() target:OnTriggerInteract(other, i) end)
            if not ok then
                Log(string.format("    N=%d -> ошибка: %s", i, tostring(err)))
            end
            if IsValid(ps) then
                pcall(function() target:OnCompleteSyncPlayer(ps) end)
            end
            if StatueIsUnlocked(target) then
                Log(string.format("!!! НАЙДЕНО: N=%d РАЗБЛОКИРОВАЛО точку (Other = %s)", i, label))
                return true
            end
        end
        return false
    end

    if not Pass(character, "PalPlayerCharacter") then
        Log("С Character ничего не открылось, пробуем Other = PlayerController.")
        if not Pass(pc, "PlayerController") then
            Log("Ни один индикатор 0..80 не открыл точку.")
        end
    end
end

-- ШАГ 4c. SendSystemAnnounce (подозреваемый в краше основного мода)
local function StageAnnounce()
    Sep("ШАГ 4. ТЕСТ SendSystemAnnounce")
    local util = StaticFindObject("/Script/Pal.Default__PalUtility")
    local pc = GetLocalPlayerController()
    if not util or not IsValid(pc) then
        Log("PalUtility или PlayerController не найдены.")
        return
    end
    Risky("PalUtility::SendSystemAnnounce(PC, 'eaglediag announce test')", function()
        util:SendSystemAnnounce(pc, "eaglediag announce test")
        return true
    end)
end

local function Stage4(kind, readFlagAfter)
    Sep("ШАГ 4. ТЕСТ СПОСОБА РАЗБЛОКИРОВКИ (одна точка)")

    local target = FindTestTarget()
    if not target then
        Log("Нет ни одной закрытой точки (или статуи не загружены).")
        return
    end

    local keys = KeysFor(target)
    Log(string.format("Тестовая точка: FastTravelPointID=%s, LevelObjectInstanceId=%s",
        tostring(keys[1]), tostring(keys[2])))
    local flags = readFlagAfter and GetFlagsTable() or nil

    pcall(function() target.EnableRequestUnlock = true end)

    if kind == "statue" then
        local character = GetLocalPlayerCharacter()
        TestMethod(target, flags, "OnTriggerInteract(Character, 26)", function()
            return target:OnTriggerInteract(character, 26)
        end, readFlagAfter)

    elseif kind == "cutscene" then
        TestMethod(target, flags, "OnEndCutscene(<BindParameter>)", function()
            local cls = StaticFindObject("/Script/Pal.PalCutsceneBindParameter_FasttravelPoint")
            local param = StaticConstructObject(cls, target)
            return target:OnEndCutscene(param)
        end, readFlagAfter)

    elseif kind == "write" then
        TestMethod(target, flags, "SetRecordData_Bool_ForServer", function()
            local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
            local world = GetLocalPlayerController()
            local f = GetFlagsTable()
            for _, key in ipairs(keys) do
                util:SetRecordData_Bool_ForServer(world, f, FName(key), true)
            end
            return true
        end, readFlagAfter)

    elseif kind == "cosmetic" then
        TestMethod(target, flags, "bUnlocked = true", function()
            target.bUnlocked = true
            return true
        end, readFlagAfter)
    end
end

-- ---------------------------------------------------------------------------
-- Диспетчер
-- ---------------------------------------------------------------------------

local HELP = {
    "!eaglediag          - наличие функций + счётчики + контрольная проверка",
    "!eaglediag rpc      - старый RPC RequestUnlockFastTravelPoint_ToServer",
    "!eaglediag keys     - РЕШАЮЩИЙ ТЕСТ: какие ключи в флаге и какому полю статуи они соответствуют",
    "!eaglediag flagmap  - OnUpdateFlagMapRecord(Key, true) (без struct-параметров)",
    "!eaglediag brute    - перебор индикаторов OnTriggerInteract(Other, 0..80)",
    "!eaglediag announce - тест SendSystemAnnounce (подозревается в краше)",
    "!eaglediag record   - + чтение RecordData через struct-параметры (ОПАСНО)",
    "!eaglediag statue   - + OnTriggerInteract(26) на одной точке",
    "!eaglediag cutscene - + OnEndCutscene на одной точке (ОПАСНО)",
    "!eaglediag write    - + запись флага SetRecordData_Bool_ForServer (ОПАСНО)",
    "!eaglediag cosmetic - + bUnlocked = true",
    "!eaglediag all      - всё подряд",
}

local function Run(kind)
    Log("==============================================================")
    Log("ДИАГНОСТИКА FAST TRAVEL UNLOCKER, режим: " .. tostring(kind))
    Log("==============================================================")
    for _, line in ipairs(HELP) do Log("  " .. line) end

    Stage1()
    Stage2()

    local structCalls = (kind == "record") or (kind == "all") or (kind == "write")
    Stage3(structCalls)

    if kind == "rpc" then StageRpc()
    elseif kind == "keys" then StageKeys()
    elseif kind == "flagmap" then StageFlagMap()
    elseif kind == "brute" then StageBrute()
    elseif kind == "announce" then StageAnnounce()
    elseif kind == "statue" then Stage4("statue", kind == "all")
    elseif kind == "cutscene" then Stage4("cutscene", kind == "all")
    elseif kind == "write" then Stage4("write", true)
    elseif kind == "cosmetic" then Stage4("cosmetic", false)
    elseif kind == "all" then
        StageRpc()
        Stage4("statue", true)
        Stage4("cutscene", true)
        Stage4("write", true)
        Stage4("cosmetic", true)
    end

    Sep("КОНЕЦ ДИАГНОСТИКИ (режим " .. tostring(kind) .. ")")
end

local ok, err = pcall(function()
    RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
        local received = message:get()
        if not received or not received.Message then return end
        local text = string.lower(received.Message:ToString())

        local kind = nil
        if text == "!eaglediag" then kind = "safe"
        elseif text == "!eaglediag rpc" then kind = "rpc"
        elseif text == "!eaglediag keys" then kind = "keys"
        elseif text == "!eaglediag flagmap" then kind = "flagmap"
        elseif text == "!eaglediag brute" then kind = "brute"
        elseif text == "!eaglediag announce" then kind = "announce"
        elseif text == "!eaglediag record" then kind = "record"
        elseif text == "!eaglediag statue" then kind = "statue"
        elseif text == "!eaglediag cutscene" then kind = "cutscene"
        elseif text == "!eaglediag write" then kind = "write"
        elseif text == "!eaglediag cosmetic" then kind = "cosmetic"
        elseif text == "!eaglediag all" then kind = "all"
        elseif text == "!eaglediag help" then
            Log("Команды диагностики:")
            for _, line in ipairs(HELP) do Log("  " .. line) end
            return
        end
        if not kind then return end

        local okRun, runErr = pcall(Run, kind)
        if not okRun then Log("Диагностика упала: " .. tostring(runErr)) end
    end)
end)

if ok then
    Log("Диагностический мод загружен. Начни с команды: !eaglediag")
else
    Log("Не удалось зарегистрировать чат-хук: " .. tostring(err))
end
