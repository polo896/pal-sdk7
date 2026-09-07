-- ============================================================================
-- FAST TRAVEL UNLOCKER  (Palworld 1.0.4+ / SDK7)   By Wol4ara896
-- ============================================================================
--
--  ПОЧЕМУ СТАРАЯ ВЕРСИЯ ПЕРЕСТАЛА РАБОТАТЬ
--  ----------------------------------------
--  В патче 1.0.4 из UPalNetworkPlayerComponent выпилили RPC
--      RequestUnlockFastTravelPoint_ToServer()
--  Его больше нет в SDK (проверено: в Pal.hpp / Pal_classes.hpp / FunctionsInfo.json
--  нет ни одного упоминания). В Lua вызов несуществующего метода просто
--  падает, ошибка гасилась pcall(), а счётчик totalUnlocked увеличивался
--  в любом случае -> в логе красовалось "Unlocked 174 fast travel points"
--  при нулевом реальном эффекте. Вот и всё "молчаливое ничего".
--
--  ЧТО ИЗМЕНИЛОСЬ В ИГРЕ
--  ---------------------
--  1. Состояние "точка быстрого перемещения открыта" живёт в UPalPlayerRecordData:
--         FastTravelPointUnlockFlag : FPalPlayerRecordDataRepInfoArrayThreadSafe_BoolVal
--     (FFastArraySerializer, ключ = FName FastTravelPointID). Оно же пишется в сейв
--     (FPalLoggedinPlayerSaveDataRecordData::FastTravelPointUnlockFlag).
--  2. Пишется оно теперь из серверного кода через
--         UPalPlayerRecordDataUtility::SetRecordData_Bool_ForServer(...)
--     и раскатывается по сети через FastArraySerializer.
--  3. Вся разблокировка конкретной статуи живёт в самом акторе
--     APalLevelObjectUnlockableFastTravelPoint:
--         OnTriggerInteract(AActor* Other, EPalInteractiveObjectIndicatorType)
--             -- IndicatorType = 26 = UnlockFastTravel  (см. Pal_enums.hpp)
--         OnEndCutscene(UPalCutsceneBindParameter_FasttravelPoint*)
--             -- хендлер, который реально и открывает точку
--         OnCompleteSyncPlayer(APalPlayerState*)
--             -- перечитывает флаг из RecordData, обновляет визуал/делегаты
--         IsUnlocked()  -- проверка состояния
--
--  НОВАЯ ЛОГИКА МОДА
--  -----------------
--  Гоняем саму статую, как если бы игрок нажал F рядом с ней. Порядок попыток
--  на каждую точку (каждая проверяется через IsUnlocked()):
--      1) OnEndCutscene(<свой BindParameter>)  -- сразу хендлер разблокировки,
--                                                  без катсцены и без звука
--      2) OnTriggerInteract(PlayerCharacter, 26) -- "нажать F" (тут игра может
--                                                  сама включить катсцену)
--      3) прямая запись флага в FastTravelPointUnlockFlag
--         через UPalPlayerRecordDataUtility::SetRecordData_Bool_ForServer
--         (работает не во всех сборках UE4SS - зависит от поддержки struct-ref
--          параметров; ошибка не фатальная, просто попадает в лог)
--      4) косметика: bUnlocked = true (визуал, без записи в сейв)
--  После каждой попытки зовём OnCompleteSyncPlayer(PlayerState), чтобы статуя
--  перечитала флаг из RecordData.
--
--  Разблокировка идёт пачками (CONFIG.UnlockBatchSize за тик) - игра падает,
--  если скормить ей 174 катсцены/разблокировки в один кадр.
-- ============================================================================

local CONFIG = {
    ChatCommand          = "!collecteagle",
    ChatCommandNoExp     = "!collecteaglenoexp",
    ChatCommandMap       = "!collecteaglemapclear",
    ChatCommandStatues   = "!eagle statues",
    ChatCommandPillars   = "!eagle pillars",
    ChatCommandVerify    = "!eagle verify",
    ChatCommandBypass    = "!eagle bypass",

    RestoreDelayMs       = 3000,

    MapClearPaintSize    = 99999.0,
    MapClearDurationMs   = 10000,
    MapClearIntervalMs   = 250,

    -- разблокировка пачками: меньше шанс уронить игру
    UnlockBatchSize      = 3,
    UnlockBatchDelayMs   = 350,

    -- EPalInteractiveObjectIndicatorType::UnlockFastTravel (Pal_enums.hpp: 26)
    IndicatorUnlockFastTravel = 26,

    -- с какого способа начинать:
    --   "Interact"    - симитировать нажатие F (путь, проверенный сообществом,
    --                   статистически самый безопасный)   <-- по умолчанию
    --   "EndCutscene" - дёрнуть сразу хендлер завершения катсцены (эксперимент)
    --   "RecordData"  - писать флаг напрямую (нужна поддержка struct-параметров)
    PrimaryMethod = "Interact",

    -- какие способы разблокировки использовать.
    -- ВАЖНО: EndCutscene и RecordData по умолчанию ВЫКЛЮЧЕНЫ - это нетривиальные
    -- вызовы, на части сборок UE4SS они роняют игру (EXCEPTION_ACCESS_VIOLATION).
    -- Включаются одной командой в чате: !eagle method cutscene / record
    EnableInteractPath     = true,
    EnableRpcPath          = false,
    EnableCutsceneEndPath  = false,
    EnableRecordDataPath   = false,

    -- проверять результат по флагу FastTravelPointUnlockFlag (struct-параметры).
    -- Выключено по той же причине: чтение идёт через UPalPlayerRecordDataUtility.
    EnableStructVerification = false,

    -- косметический фолбэк (bUnlocked = true) ВЫКЛЮЧЕН: он делает вид, что точка
    -- открыта, хотя в RecordData ничего не записано - то есть воспроизводит ровно
    -- тот же самообман, что и старый мод ("Unlocked 174", а по факту ноль).
    EnableCosmeticFallback = false,

    -- APalLevelObjectUnlockableFastTravelPoint::OnUpdateFlagMapRecord(FName, bool)
    -- единственный найденный путь записи без struct-параметров
    EnableFlagMapPath      = false,

    -- печатать в лог каждую обрабатываемую точку (нужно, чтобы видеть, на какой
    -- именно статуе падает игра)
    LogEveryPoint          = true,

    -- писать ли сообщения в игровой чат-панель (PalUtility::SendSystemAnnounce).
    -- ВЫКЛЮЧЕНО: по логам именно этот вызов ронял UE4SS (падение происходило
    -- сразу после строки "начинаю разблокировку"). Включать осторожно.
    AnnounceInGame         = false,

    -- убирать облака над островами после разблокировки (старый код)
    EnableCloudRemoval     = true,
}

local TAG = "[EagleCollector]"

-- ---------------------------------------------------------------------------
-- Мелкие утилиты
-- ---------------------------------------------------------------------------

local function Log(msg)
    print(TAG .. " " .. tostring(msg) .. "\n")
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
    local function u32(val) return (val < 0) and (val + 4294967296) or val end
    local ok, res = pcall(function()
        return string.format("%08X%08X%08X%08X", u32(guid.A), u32(guid.B), u32(guid.C), u32(guid.D))
    end)
    if ok then return res end
    return nil
end

-- pcall, который НЕ глотает ошибку молча (иначе и получаются те самые
-- "Unlocked 174" при полном отсутствии эффекта)
local function SafeRun(label, fn)
    local ok, err = pcall(fn)
    if not ok then
        Log(string.format("ОШИБКА в [%s]: %s", tostring(label), tostring(err)))
    end
    return ok, err
end

local function Count(t)
    local n = 0
    for _ in pairs(t or {}) do n = n + 1 end
    return n
end

-- ---------------------------------------------------------------------------
-- Доступ к игроку / подсистемам
-- ---------------------------------------------------------------------------

local function GetOptionSubsystem()
    local instances = FindAllOf("PalOptionSubsystem")
    if instances then
        for _, inst in ipairs(instances) do
            if IsValid(inst) then return inst end
        end
    end
    return nil
end

local function SetExpRate(rate)
    local subsystem = GetOptionSubsystem()
    if not subsystem then return false end
    return pcall(function() subsystem.OptionWorldSettings.ExpRate = rate end)
end

local function GetExpRate()
    local subsystem = GetOptionSubsystem()
    if not subsystem then return nil end
    local ok, val = pcall(function() return subsystem.OptionWorldSettings.ExpRate end)
    return ok and val or nil
end

local function GetLocalPlayerController()
    local controllers = FindAllOf("BP_PalPlayerController_C")
    if controllers then
        for _, c in ipairs(controllers) do
            if IsValid(c) then
                local ok, res = pcall(function() return c:IsLocalPlayerController() end)
                if ok and res == true then return c end
            end
        end
        for _, c in ipairs(controllers) do
            if IsValid(c) then return c end
        end
    end
    local fallback = FindFirstOf("PalPlayerController")
    return IsValid(fallback) and fallback or nil
end

local function GetLocalPlayerCharacter()
    local pc = GetLocalPlayerController()
    if IsValid(pc) then
        if IsValid(pc.Pawn) then return pc.Pawn end
        if IsValid(pc.Character) then return pc.Character end
    end
    local fallback = FindFirstOf("PalPlayerCharacter")
    return IsValid(fallback) and fallback or nil
end

local function GetLocalPlayerState()
    local pc = GetLocalPlayerController()
    if IsValid(pc) and IsValid(pc.PlayerState) then return pc.PlayerState end
    local fallback = FindFirstOf("PalPlayerState")
    return IsValid(fallback) and fallback or nil
end

local function GetBPWorldMapUIData()
    local objects = FindAllOf("BP_PalWorldMapUIData_C")
    if objects then
        for _, obj in ipairs(objects) do
            if IsValid(obj) then return obj end
        end
    end
    return nil
end

local function Announce(message)
    if not CONFIG.AnnounceInGame then return end
    local okPC, pc = pcall(GetLocalPlayerController)
    local util = StaticFindObject("/Script/Pal.Default__PalUtility")
    if (not okPC or not pc) or not util then return end
    pcall(function() util:SendSystemAnnounce(pc, tostring(message)) end)
end

-- ---------------------------------------------------------------------------
-- RecordData: прямая запись флага разблокировки
-- ---------------------------------------------------------------------------

local function GetRecordDataUtility()
    local util = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if util then return util end
    return nil
end

local function GetRecordData(worldContext)
    -- 1) UPalUtility::GetLocalRecordData(WorldContextObject) - статик
    local util = StaticFindObject("/Script/Pal.Default__PalUtility")
    if util and worldContext then
        local ok, res = pcall(function() return util:GetLocalRecordData(worldContext) end)
        if ok and IsValid(res) then return res, "PalUtility::GetLocalRecordData" end
    end
    -- 2) APalPlayerState::GetRecordData()
    local ps = GetLocalPlayerState()
    if IsValid(ps) then
        local ok, res = pcall(function() return ps:GetRecordData() end)
        if ok and IsValid(res) then return res, "PalPlayerState::GetRecordData" end
    end
    return nil, nil
end

-- Ключи, которыми игра может помечать разблокированную точку.
-- Основной - FastTravelPointID (именно его сравнивает
-- APalLevelObjectUnlockableFastTravelPoint::OnUpdateFlagMapRecord).
local function CollectFlagKeys(statue)
    local keys = {}
    local seen = {}

    local function add(k)
        if k == nil then return end
        k = tostring(k)
        if k == "" or k == "None" or seen[k] then return end
        seen[k] = true
        keys[#keys + 1] = k
    end

    add(ToStr(statue.FastTravelPointID))
    add(GuidToHexStr(statue.LevelObjectInstanceId))
    return keys
end

-- Чтение флага - единственный способ убедиться, что разблокировка НАСТОЯЩАЯ
-- (попадёт в сейв), а не только косметическая (bUnlocked = true).
-- Требует поддержки struct-параметров в UE4SS; если её нет - вернёт nil.
local structAccess = {
    checked = false,
    works = false,
    lastError = nil
}

local function GetFlagsTable()
    local worldContext = GetLocalPlayerController()
    if not IsValid(worldContext) then return nil, nil end
    local recordData = GetRecordData(worldContext)
    if not recordData then return nil, nil end
    local ok, flags = pcall(function() return recordData.FastTravelPointUnlockFlag end)
    if not ok or flags == nil then return nil, nil end
    return flags, worldContext
end

local function ProbeStructAccess()
    if structAccess.checked then return structAccess.works end
    structAccess.checked = true

    local util = GetRecordDataUtility()
    local flags = GetFlagsTable()
    if not util or not flags then
        structAccess.works = false
        structAccess.lastError = "RecordData/FastTravelPointUnlockFlag недоступен"
        return false
    end

    local ok, err = pcall(function() return util:GetRecordData_Bool(flags, FName("None")) end)
    structAccess.works = ok
    structAccess.lastError = ok and nil or tostring(err)
    return structAccess.works
end

-- true / false / nil (nil = проверить не удалось)
local function RecordFlagIsSet(keys)
    if not CONFIG.EnableStructVerification then return nil end
    if not ProbeStructAccess() then return nil end
    local util = GetRecordDataUtility()
    local flags = GetFlagsTable()
    if not util or not flags then return nil end

    for _, key in ipairs(keys) do
        local ok, res = pcall(function() return util:GetRecordData_Bool(flags, FName(key)) end)
        if ok and res == true then return true end
    end
    return false
end

-- Прямая запись в UPalPlayerRecordData::FastTravelPointUnlockFlag.
-- ВНИМАНИЕ: параметр RecordData - это struct& (ReferenceParm). UE4SS не во всех
-- версиях умеет передавать struct по ссылке, поэтому всё в pcall и с отчётом.
local function WriteUnlockFlag(keys)
    if not CONFIG.EnableRecordDataPath then return false, "disabled" end

    local util = GetRecordDataUtility()
    if not util then return false, "PalPlayerRecordDataUtility CDO not found" end

    local worldContext = GetLocalPlayerController()
    if not IsValid(worldContext) then return false, "no world context" end

    local _, src = GetRecordData(worldContext)

    local flags = GetFlagsTable()
    if flags == nil then
        return false, "FastTravelPointUnlockFlag is nil/unreadable"
    end

    local lastErr = nil
    for _, key in ipairs(keys) do
        local ok, err = pcall(function()
            util:SetRecordData_Bool_ForServer(worldContext, flags, FName(key), true)
        end)
        if not ok then lastErr = tostring(err) end
    end

    if lastErr then
        return false, "SetRecordData_Bool_ForServer failed: " .. lastErr
    end
    return true, "ok (RecordData via " .. tostring(src) .. ", keys: " .. table.concat(keys, ", ") .. ")"
end

-- ---------------------------------------------------------------------------
-- Разблокировка одной статуи
-- ---------------------------------------------------------------------------

local function MakeCutsceneBindParameter(statue)
    local cls = StaticFindObject("/Script/Pal.PalCutsceneBindParameter_FasttravelPoint")
    if cls == nil then return nil end
    local ok, obj = pcall(function() return StaticConstructObject(cls, statue) end)
    if ok and obj ~= nil then return obj end
    return nil
end

local function StatueIsUnlocked(statue)
    local ok, res = pcall(function() return statue:IsUnlocked() end)
    return ok and res == true
end

local function SyncStatue(statue, playerState)
    if not IsValid(playerState) then return end
    pcall(function() statue:OnCompleteSyncPlayer(playerState) end)
end

-- Попытка №1: сразу дёрнуть хендлер завершения катсцены (без катсцены).
local function TryUnlock_CutsceneEnd(statue)
    local param = MakeCutsceneBindParameter(statue)
    if param == nil then return false, "PalCutsceneBindParameter_FasttravelPoint not constructable" end
    local ok, err = pcall(function() statue:OnEndCutscene(param) end)
    if not ok then return false, "OnEndCutscene error: " .. tostring(err) end
    return true, "ok"
end

-- Попытка №2: сымитировать нажатие F (индикатор UnlockFastTravel = 26).
local function TryUnlock_Interact(statue, character)
    if not IsValid(character) then return false, "no player character" end
    local ok, err = pcall(function()
        statue:OnTriggerInteract(character, CONFIG.IndicatorUnlockFastTravel)
    end)
    if not ok then return false, "OnTriggerInteract error: " .. tostring(err) end
    return true, "ok"
end

-- Попытка №0: старый RPC (в SDK 1.0.4 его НЕТ, но в части сборок он ещё жив).
-- Если он есть - это самый правильный и безопасный путь.
local function GetPlayerNetworkComponent()
    local pc = GetLocalPlayerController()
    if not IsValid(pc) then return nil end
    local transmitter = pc.Transmitter
    if not IsValid(transmitter) then return nil end
    local net = transmitter.Player
    return IsValid(net) and net or nil
end

local function TryUnlock_Rpc(statue)
    local net = GetPlayerNetworkComponent()
    if not net then return false, "PalNetworkPlayerComponent не найден" end
    if net.RequestUnlockFastTravelPoint_ToServer == nil then
        return false, "RPC RequestUnlockFastTravelPoint_ToServer отсутствует в этой сборке"
    end

    local keys = CollectFlagKeys(statue)
    local lastErr = nil
    local called = 0
    for _, key in ipairs(keys) do
        local ok, err = pcall(function()
            net:RequestUnlockFastTravelPoint_ToServer(FName(key))
        end)
        if ok then called = called + 1 else lastErr = tostring(err) end
    end
    if called == 0 then return false, "RPC не вызывался: " .. tostring(lastErr) end
    return true, "ok (RPC, ключей: " .. called .. ")"
end

-- Попытка №2.5: OnUpdateFlagMapRecord(FName Key, bool bFlag) - без struct-параметров,
-- значит не зависит от кривой передачи структур в UE4SS.
local function TryUnlock_FlagMap(statue)
    local keys = CollectFlagKeys(statue)
    if #keys == 0 then return false, "ключи точки не читаются" end
    local lastErr = nil
    local called = 0
    for _, key in ipairs(keys) do
        local ok, err = pcall(function() statue:OnUpdateFlagMapRecord(FName(key), true) end)
        if ok then called = called + 1 else lastErr = tostring(err) end
    end
    if called == 0 then return false, "OnUpdateFlagMapRecord не вызвался: " .. tostring(lastErr) end
    return true, "ok (FlagMap)"
end

-- Попытка №3: записать флаг напрямую.
local function TryUnlock_RecordData(statue)
    return WriteUnlockFlag(CollectFlagKeys(statue))
end

-- Попытка №4: только визуал (в сейв не попадёт).
local function TryUnlock_Cosmetic(statue)
    if not CONFIG.EnableCosmeticFallback then return false, "disabled" end
    pcall(function()
        statue.bUnlocked = true
        statue.EnableRequestUnlock = true
    end)
    return false, "cosmetic only (flag was NOT written)"
end

-- Успех пытаемся подтвердить по-настоящему: флаг в RecordData выставлен.
-- IsUnlocked() может отставать (репликация/делегаты), поэтому флаг - главный.
-- Возвращает: успех (bool), подтверждено (bool - флаг реально выставлен)|nil (не удалось проверить)
-- Возвращает: realUnlock, flagSet, isUnlocked, travelEnabled, cosmetic
--   realUnlock    - точка действительно открыта (флаг выставлен или телепорт разрешён)
--   cosmetic      - IsUnlocked()=true, но телепорт по-прежнему запрещён
-- FastTravelPointID -> UPalLocationPointFastTravel.
-- IsUnlocked() у статуи бывает косметикой, а IsEnableFastTravel() у точки телепорта
-- поднимается только когда флаг реально записан, - поэтому проверяем и его.
local LOC_BY_ID = {}

local function CheckUnlocked(statue, keys)
    local flag = RecordFlagIsSet(keys)
    local unlocked = StatueIsUnlocked(statue)

    local travel = nil
    local loc = LOC_BY_ID[tostring(ToStr(statue.FastTravelPointID))]
    if IsValid(loc) then
        local ok, v = pcall(function() return loc:IsEnableFastTravel() end)
        if ok then travel = (v == true) end
    end

    local cosmetic = (unlocked == true) and (travel == false)
    local real = (flag == true) or ((unlocked == true) and (travel == true))
    return real, flag, unlocked, travel, cosmetic
end

-- Возвращает: имя способа (или nil), подробности, состояние флага (true/false/nil)
local function UnlockStatue(statue, ctx)
    if not IsValid(statue) then return nil, "invalid statue", nil end

    -- разрешить запрос на разблокировку (как это делает игра при подключении)
    pcall(function() statue.EnableRequestUnlock = true end)

    local keys = CollectFlagKeys(statue)

    local opened, flag = CheckUnlocked(statue, keys)
    if opened then
        return "already", nil, flag
    end

    local all = {}
    if CONFIG.EnableRpcPath then
        all[#all + 1] = { name = "Rpc", fn = function() return TryUnlock_Rpc(statue) end }
    end
    if CONFIG.EnableFlagMapPath then
        all[#all + 1] = { name = "FlagMap", fn = function() return TryUnlock_FlagMap(statue) end }
    end
    if CONFIG.EnableCutsceneEndPath then
        all[#all + 1] = { name = "OnEndCutscene", fn = function() return TryUnlock_CutsceneEnd(statue) end }
    end
    if CONFIG.EnableInteractPath then
        all[#all + 1] = { name = "OnTriggerInteract", fn = function() return TryUnlock_Interact(statue, ctx.character) end }
    end
    if CONFIG.EnableRecordDataPath then
        all[#all + 1] = { name = "RecordData", fn = function() return TryUnlock_RecordData(statue) end }
    end

    -- выбранный способ идёт первым
    local attempts = {}
    for _, a in ipairs(all) do
        if a.name == CONFIG.PrimaryMethod then attempts[#attempts + 1] = a end
    end
    for _, a in ipairs(all) do
        if a.name ~= CONFIG.PrimaryMethod then attempts[#attempts + 1] = a end
    end

    local notes = {}
    local fallbackMethod, fallbackNote, fallbackFlag = nil, nil, nil

    for _, attempt in ipairs(attempts) do
        local ok, detail = attempt.fn()
        notes[#notes + 1] = attempt.name .. ": " .. tostring(detail)
        SyncStatue(statue, ctx.playerState)

        local openedNow, flagNow, _, travelNow, cosmeticNow = CheckUnlocked(statue, keys)
        if openedNow then
            -- реальный успех: флаг выставлен или телепорт у точки разрешён
            return attempt.name, table.concat(notes, " | "), flagNow
        end
        if cosmeticNow and not fallbackMethod then
            -- IsUnlocked()=true, но IsEnableFastTravel()=false -> это косметика.
            -- Запоминаем как фолбэк и пробуем следующий способ.
            fallbackMethod = attempt.name
            fallbackNote = table.concat(notes, " | ") .. " (только косметика, IsEnableFastTravel=false)"
            fallbackFlag = flagNow
        end
    end

    local ok, detail = TryUnlock_Cosmetic(statue)
    notes[#notes + 1] = "cosmetic: " .. tostring(detail)
    SyncStatue(statue, ctx.playerState)

    local openedCosmetic, flagCosmetic, _, _, cosmeticOnly = CheckUnlocked(statue, keys)
    if openedCosmetic then
        return "cosmetic", table.concat(notes, " | "), flagCosmetic, cosmeticOnly == true
    end
    if fallbackMethod then
        return "cosmetic:" .. fallbackMethod, fallbackNote, fallbackFlag, true
    end
    if openedCosmetic then
        return "cosmetic", table.concat(notes, " | "), flagCosmetic
    end
    return nil, table.concat(notes, " | "), flagCosmetic
end

-- Последний рубеж для соло: отладочный флаг UPalDebugSetting::bIgnoreFastTravelLock.
-- Если он читается игрой, можно пользоваться быстрым перемещением даже без записи
-- флагов (но в сейв это не попадёт).
local function SetIgnoreFastTravelLock(value)
    local util = StaticFindObject("/Script/Pal.Default__PalUtility")
    if not util then return false, "PalUtility CDO не найден" end

    local ok, setting = pcall(function() return util:GetPalDebugSetting() end)
    if not ok or setting == nil then return false, "GetPalDebugSetting не найден" end

    local okRead, before = pcall(function() return setting.bIgnoreFastTravelLock end)
    local okWrite, err = pcall(function() setting.bIgnoreFastTravelLock = value end)
    if not okWrite then return false, "запись не удалась: " .. tostring(err) end

    local okAfter, after = pcall(function() return setting.bIgnoreFastTravelLock end)
    return true, string.format("bIgnoreFastTravelLock: %s -> %s",
        tostring(okRead and before), tostring(okAfter and after))
end

-- ---------------------------------------------------------------------------
-- Сбор целей + фильтры (statues / pillars)
-- ---------------------------------------------------------------------------

local function BuildIdFilter(filterMode)
    local ids = {}
    local total, pillars, statues = 0, 0, 0

    local locationPoints = FindAllOf("PalLocationPointFastTravel")
    for _, loc in ipairs(locationPoints or {}) do
        if IsValid(loc) then
            total = total + 1
            local isPillar
            local ok, res = pcall(function() return loc:IsUnlockMapPoint() end)
            if ok then
                isPillar = (res == true)
            else
                isPillar = (loc.bUnlockMapPoint == true)
            end
            if isPillar then pillars = pillars + 1 else statues = statues + 1 end

            local want = (filterMode == "all")
                or (filterMode == "statues" and not isPillar)
                or (filterMode == "pillars" and isPillar)

            if want then
                local idStr = ToStr(loc.FastTravelPointID)
                if idStr and idStr ~= "" and idStr ~= "None" then
                    ids[idStr] = true
                end
            end
        end
    end

    return ids, total, statues, pillars
end

-- FastTravelPointID -> UPalLocationPointFastTravel (см. RebuildLocMap ниже)
local function RebuildLocMap()
    LOC_BY_ID = {}
    local locs = FindAllOf("PalLocationPointFastTravel")
    for _, loc in ipairs(locs or {}) do
        if IsValid(loc) then
            local idStr = ToStr(loc.FastTravelPointID)
            if idStr then LOC_BY_ID[tostring(idStr)] = loc end
        end
    end
    return #(locs or {})
end

local function CollectTargets(filterMode)
    local ids, locTotal, locStatues, locPillars = BuildIdFilter(filterMode)
    RebuildLocMap()

    local targets = {}
    local statues = FindAllOf("PalLevelObjectUnlockableFastTravelPoint")
    for _, statue in ipairs(statues or {}) do
        if IsValid(statue) then
            if filterMode == "all" then
                targets[#targets + 1] = statue
            else
                local idStr = ToStr(statue.FastTravelPointID)
                if idStr and ids[idStr] then
                    targets[#targets + 1] = statue
                end
            end
        end
    end

    if filterMode ~= "all" and Count(ids) == 0 and #targets == 0 then
        Log(string.format(
            "[%s] Не нашёл ни одной PalLocationPointFastTravel для фильтра - "
            .. "различить статуи/колонны не могу. Используй %s, чтобы открыть всё.",
            filterMode, CONFIG.ChatCommand))
    end

    Log(string.format("[%s] Location points: %d (statues: %d, pillars: %d). Кандидатов-статуй: %d",
        filterMode, locTotal, locStatues, locPillars, #targets))

    return targets
end

-- ---------------------------------------------------------------------------
-- Fog of war / облака (без изменений - в 1.0.4 API на месте)
-- ---------------------------------------------------------------------------

local function TriggerCloudRemoval()
    local triggerClass = StaticFindObject("/Script/Pal.PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud")
    local outer = GetOptionSubsystem()
    if triggerClass == nil or not IsValid(outer) then return end

    local ok, triggerObj = pcall(function() return StaticConstructObject(triggerClass, outer) end)
    if ok and IsValid(triggerObj) then
        pcall(function() triggerObj:TriggerEvent() end)
    end
end

local function RemoveMaskAtPlayerPosition()
    local mapUIData = GetBPWorldMapUIData()
    local player = GetLocalPlayerCharacter()
    if not mapUIData or not IsValid(player) then return false end

    local okLoc, location = pcall(function() return player:K2_GetActorLocation() end)
    if not okLoc or not location then return false end

    return pcall(function() mapUIData:RemoveMaskByLocation(player, location) end)
end

local mapClearState = {
    active = false,
    originalPaintSize = nil
}

local function RestoreMapPaintSize()
    if not mapClearState.active and mapClearState.originalPaintSize == nil then return end

    local original = mapClearState.originalPaintSize
    mapClearState.active = false
    mapClearState.originalPaintSize = nil

    ExecuteInGameThread(function()
        local mapUIData = GetBPWorldMapUIData()
        if mapUIData then
            pcall(function() mapUIData.MapMaskPaintSize = original end)
            Log(string.format("[MAP] Размер ластика восстановлен: %.2f", original or 0))
        end
    end)
end

local function RunMapClearPulse(endTime)
    if not mapClearState.active then return end

    if os.clock() >= endTime then
        RestoreMapPaintSize()
        return
    end

    ExecuteInGameThread(function()
        if mapClearState.active then
            RemoveMaskAtPlayerPosition()
        end
    end)

    ExecuteWithDelay(CONFIG.MapClearIntervalMs, function()
        RunMapClearPulse(endTime)
    end)
end

local function CollectEaglesMapClear()
    if mapClearState.active then
        Log("[MAP] Очистка карты уже идёт.")
        return
    end

    mapClearState.active = true

    ExecuteInGameThread(function()
        local mapUIData = GetBPWorldMapUIData()
        if not mapUIData then
            mapClearState.active = false
            Log("[MAP] Ошибка: BP_PalWorldMapUIData_C не найден.")
            return
        end

        local okRead, oldVal = pcall(function() return mapUIData.MapMaskPaintSize end)
        if not okRead then
            mapClearState.active = false
            Log("[MAP] Ошибка: не читается MapMaskPaintSize.")
            return
        end

        mapClearState.originalPaintSize = tonumber(oldVal)

        local okWrite = pcall(function() mapUIData.MapMaskPaintSize = CONFIG.MapClearPaintSize end)
        if not okWrite then
            mapClearState.active = false
            Log("[MAP] Ошибка: не записался MapMaskPaintSize.")
            return
        end

        RemoveMaskAtPlayerPosition()
        Log(string.format("[MAP] Ластик активен %d мс.", CONFIG.MapClearDurationMs))

        local endTime = os.clock() + (CONFIG.MapClearDurationMs / 1000.0)
        ExecuteWithDelay(CONFIG.MapClearIntervalMs, function()
            RunMapClearPulse(endTime)
        end)
    end)
end

-- ---------------------------------------------------------------------------
-- Пакетная разблокировка
-- ---------------------------------------------------------------------------

local pendingRestoreRate = nil
local unlockState = {
    busy = false
}

local function CountTravelEnabled()
    local total, enabled = 0, 0
    local locs = FindAllOf("PalLocationPointFastTravel")
    for _, loc in ipairs(locs or {}) do
        if IsValid(loc) then
            total = total + 1
            local ok, v = pcall(function() return loc:IsEnableFastTravel() end)
            if ok and v == true then enabled = enabled + 1 end
        end
    end
    return total, enabled
end

local function ReportUnlocked(filterMode)
    local total, unlocked = 0, 0
    local statues = FindAllOf("PalLevelObjectUnlockableFastTravelPoint")
    for _, statue in ipairs(statues or {}) do
        if IsValid(statue) then
            total = total + 1
            if StatueIsUnlocked(statue) then unlocked = unlocked + 1 end
        end
    end
    local locTotal, locEnabled = CountTravelEnabled()
    Log(string.format("[%s] Проверка: статуй всего %d, IsUnlocked()=true: %d; "
        .. "точек телепорта %d, IsEnableFastTravel()=true: %d (это и есть настоящий признак)",
        tostring(filterMode or "all"), total, unlocked, locTotal, locEnabled))
    Announce(string.format("FastTravel: unlocked %d / %d", unlocked, total))
    return total, unlocked
end

local function RunUnlock(filterMode)
    if unlockState.busy then
        Log("Предыдущая разблокировка ещё не закончилась - подожди.")
        Announce("FastTravel: предыдущая разблокировка ещё идёт")
        return
    end

    filterMode = filterMode or "all"

    local pc = GetLocalPlayerController()
    if not IsValid(pc) then
        Log("Ошибка: локальный PlayerController не найден.")
        return
    end

    local targets = CollectTargets(filterMode)
    if #targets == 0 then
        Log("Ошибка: не нашёл ни одной PalLevelObjectUnlockableFastTravelPoint "
            .. "(возможно, точки просто не загружены стримингом - подойди ближе).")
        Announce("FastTravel: статуи не найдены (стриминг?)")
        return
    end

    unlockState.busy = true

    local ctx = {
        character   = GetLocalPlayerCharacter(),
        playerState = GetLocalPlayerState(),
        worldContext = pc
    }

    local stats = {
        total = #targets,
        done = 0,
        already = 0,
        unlocked = 0,
        cosmetic = 0,     -- IsUnlocked()=true, но IsEnableFastTravel()=false
        confirmed = 0,     -- флаг в RecordData выставлен - разблокировка настоящая
        unconfirmed = 0,   -- IsUnlocked() = true, но флаг не выставлен (косметика?)
        unknown = 0,       -- проверить флаг не удалось (нет struct-параметров в UE4SS)
        failed = 0,
        methods = {}
    }

    local function Account(method, flag)
        if flag == true then
            stats.confirmed = stats.confirmed + 1
        elseif flag == false then
            stats.unconfirmed = stats.unconfirmed + 1
        else
            stats.unknown = stats.unknown + 1
        end
        if method and method ~= "already" then
            stats.methods[method] = (stats.methods[method] or 0) + 1
        end
    end

    local function Step()
        local last = math.min(stats.done + CONFIG.UnlockBatchSize, #targets)
        for i = stats.done + 1, last do
            local statue = targets[i]
            if CONFIG.LogEveryPoint then
                Log(string.format("[%s] точка #%d/%d: id=%s guid=%s", filterMode, i, #targets,
                    tostring(ToStr(statue.FastTravelPointID)),
                    tostring(GuidToHexStr(statue.LevelObjectInstanceId))))
            end
            local method, note, flag, isCosmetic = UnlockStatue(statue, ctx)
            if method == "already" then
                stats.already = stats.already + 1
                Account(method, flag)
            elseif isCosmetic then
                stats.cosmetic = stats.cosmetic + 1
                if stats.cosmetic <= 3 then
                    Log(string.format("Только косметика (%s): %s", ToStr(statue.FastTravelPointID), tostring(note)))
                end
            elseif method then
                stats.unlocked = stats.unlocked + 1
                Account(method, flag)
            else
                stats.failed = stats.failed + 1
                if stats.failed <= 3 then
                    Log(string.format("Не открылось (%s): %s", ToStr(statue.FastTravelPointID), tostring(note)))
                end
            end
        end
        stats.done = last

        if (stats.done % 25) < CONFIG.UnlockBatchSize or stats.done == #targets then
            Log(string.format("[%s] прогресс: %d/%d (открыто %d, косметика %d, не открылось %d)",
                filterMode, stats.done, #targets, stats.unlocked, stats.cosmetic, stats.failed))
        end

        if stats.done < #targets then
            ExecuteWithDelay(CONFIG.UnlockBatchDelayMs, Step)
            return
        end

        -- финал
        if CONFIG.EnableCloudRemoval and (filterMode == "all" or filterMode == "statues") then
            TriggerCloudRemoval()
        end

        -- Часть разблокировок в Palworld асинхронна (катсцена/стриминг), поэтому
        -- считаем итог ещё раз через 5 секунд - вдруг точки "доехали".
        local beforeTotal, beforeEnabled = CountTravelEnabled()
        ExecuteWithDelay(5000, function()
            local afterTotal, afterEnabled = CountTravelEnabled()
            local stTotal, stUnlocked = 0, 0
            for _, st in ipairs(FindAllOf("PalLevelObjectUnlockableFastTravelPoint") or {}) do
                if IsValid(st) then
                    stTotal = stTotal + 1
                    if StatueIsUnlocked(st) then stUnlocked = stUnlocked + 1 end
                end
            end
            Log(string.format("[%s] ПОВТОРНАЯ ПРОВЕРКА через 5с: IsUnlocked()=%d/%d, "
                .. "IsEnableFastTravel()=%d/%d (было %d/%d)",
                filterMode, stUnlocked, stTotal, afterEnabled, afterTotal,
                beforeEnabled, beforeTotal))
        end)

        local methods = {}
        for name, n in pairs(stats.methods) do
            methods[#methods + 1] = string.format("%s=%d", name, n)
        end
        table.sort(methods)

        Log(string.format(
            "Mode [%s]: обработано %d, уже было открыто %d, открыто сейчас %d, только косметика %d, "
            .. "не открылось %d. Способы: %s",
            filterMode, stats.total, stats.already, stats.unlocked, stats.cosmetic, stats.failed,
            (#methods > 0) and table.concat(methods, ", ") or "нет"))

        Log(string.format("Подтверждение: флаг в RecordData выставлен у %d точек, "
            .. "не подтверждён у %d, проверить не удалось у %d.",
            stats.confirmed, stats.unconfirmed, stats.unknown))

        if not CONFIG.EnableStructVerification then
            Log("Проверка по флагу RecordData отключена (CONFIG.EnableStructVerification = false): "
                .. "считаем только IsUnlocked(). Включить можно командой !eagle method record.")
        elseif ProbeStructAccess() then
            if stats.unconfirmed > 0 then
                Log(string.format(
                    "ВНИМАНИЕ: у %d точек IsUnlocked() = true, но флаг в RecordData не выставлен. "
                    .. "Значит сработал косметический путь (bUnlocked) - после перезапуска игры точки "
                    .. "снова закроются. Поставь CONFIG.PrimaryMethod = \"Interact\" (или \"RecordData\") "
                    .. "и повтори; подробности по одной точке даёт мод-диагностика (!eaglediag).",
                    stats.unconfirmed))
            elseif stats.confirmed > 0 then
                Log("Флаг FastTravelPointUnlockFlag подтверждён - разблокировка настоящая, уезжает в сейв.")
            end
        else
            Log("Прямое чтение RecordData недоступно в этой сборке UE4SS (struct-параметры): "
                .. tostring(structAccess.lastError)
                .. ". Проверка шла только через IsUnlocked().")
        end

        ReportUnlocked(filterMode)
        unlockState.busy = false
    end

    Log(string.format("Mode [%s]: начинаю разблокировку %d точек пачками по %d.",
        filterMode, #targets, CONFIG.UnlockBatchSize))
    Announce(string.format("FastTravel: unlocking %d points...", #targets))

    ExecuteInGameThread(Step)
end

-- ---------------------------------------------------------------------------
-- Команды
-- ---------------------------------------------------------------------------

-- Переключение способа разблокировки на ходу (без правки файла)
local function SetPrimaryMethod(name)
    if name == "rpc" then
        CONFIG.PrimaryMethod = "Rpc"
        CONFIG.EnableRpcPath = true
        return "Основной способ: старый RPC RequestUnlockFastTravelPoint_ToServer "
            .. "(в SDK 1.0.4 его нет, но эта сборка, похоже, его ещё содержит)."
    elseif name == "interact" then
        CONFIG.PrimaryMethod = "Interact"
        CONFIG.EnableInteractPath = true
        return "Основной способ: OnTriggerInteract(Character, 26) - симуляция нажатия F."
    elseif name == "cutscene" then
        CONFIG.PrimaryMethod = "EndCutscene"
        CONFIG.EnableCutsceneEndPath = true
        return "Основной способ: OnEndCutscene(<BindParameter>). ЭКСПЕРИМЕНТ - может ронять игру."
    elseif name == "flagmap" then
        CONFIG.PrimaryMethod = "FlagMap"
        CONFIG.EnableFlagMapPath = true
        return "Основной способ: OnUpdateFlagMapRecord(FName Key, true) - путь БЕЗ "
            .. "struct-параметров."
    elseif name == "record" then
        CONFIG.PrimaryMethod = "RecordData"
        CONFIG.EnableRecordDataPath = true
        CONFIG.EnableStructVerification = true
        return "Основной способ: прямая запись FastTravelPointUnlockFlag. "
            .. "Требует struct-параметры в UE4SS - может ронять игру."
    elseif name == "cosmetic" then
        CONFIG.PrimaryMethod = "cosmetic"
        CONFIG.EnableInteractPath = false
        CONFIG.EnableCutsceneEndPath = false
        CONFIG.EnableRecordDataPath = false
        CONFIG.EnableStructVerification = false
        return "Все вызовы в игру ОТКЛЮЧЕНЫ: только bUnlocked = true (визуал, в сейв не идёт). "
            .. "Нужно лишь понять, падает игра на вызовах статуи или нет."
    end
    return nil
end

local function CurrentMethodInfo()
    local flags = {}
    if CONFIG.EnableRpcPath then flags[#flags + 1] = "Rpc" end
    if CONFIG.EnableInteractPath then flags[#flags + 1] = "Interact" end
    if CONFIG.EnableFlagMapPath then flags[#flags + 1] = "FlagMap" end
    if CONFIG.EnableCutsceneEndPath then flags[#flags + 1] = "EndCutscene" end
    if CONFIG.EnableRecordDataPath then flags[#flags + 1] = "RecordData" end
    return string.format("способ=%s, разрешено: %s, проверка по флагу=%s",
        tostring(CONFIG.PrimaryMethod), table.concat(flags, "+"),
        tostring(CONFIG.EnableStructVerification))
end


local function CollectEagles(filterMode)
    RunUnlock(filterMode)
end

local function CollectEaglesNoExp(filterMode)
    filterMode = filterMode or "all"

    local originalRate = GetExpRate()
    if originalRate == nil or not SetExpRate(0.0) then
        Log("Предупреждение: не смог обнулить EXP rate - разблокирую как есть (EXP будет начислен).")
        RunUnlock(filterMode)
        return
    end

    pendingRestoreRate = originalRate
    Log(string.format("EXP rate = 0.0 (было: %.2f)", originalRate))

    RunUnlock(filterMode)

    ExecuteWithDelay(CONFIG.RestoreDelayMs, function()
        if pendingRestoreRate ~= nil then
            SetExpRate(pendingRestoreRate)
            Log(string.format("EXP rate восстановлен: %.2f", pendingRestoreRate))
            pendingRestoreRate = nil
        end
    end)
end

local function RegisterChatHook()
    local success, err = pcall(function()
        RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
            local received = message:get()
            if not received or not received.Message then return end

            local text = received.Message:ToString()
            local textLower = string.lower(text)

            if textLower == CONFIG.ChatCommand or textLower == "!eagle all" then
                SafeRun("collecteagle", function() CollectEagles("all") end)

            elseif textLower == CONFIG.ChatCommandStatues then
                SafeRun("statues", function() CollectEagles("statues") end)

            elseif textLower == CONFIG.ChatCommandPillars then
                SafeRun("pillars", function() CollectEagles("pillars") end)

            elseif textLower == CONFIG.ChatCommandNoExp or textLower == "!eagle all noexp" then
                SafeRun("noexp", function() CollectEaglesNoExp("all") end)

            elseif textLower == "!eagle statues noexp" then
                SafeRun("statues noexp", function() CollectEaglesNoExp("statues") end)

            elseif textLower == "!eagle pillars noexp" then
                SafeRun("pillars noexp", function() CollectEaglesNoExp("pillars") end)

            elseif textLower == CONFIG.ChatCommandVerify then
                SafeRun("verify", function() ReportUnlocked("all") end)

            elseif textLower == "!eagle method" then
                Log("Текущий режим: " .. CurrentMethodInfo())

            elseif textLower == "!eagle method interact"
                or textLower == "!eagle method cutscene"
                or textLower == "!eagle method record"
                or textLower == "!eagle method cosmetic"
                or textLower == "!eagle method rpc"
                or textLower == "!eagle method flagmap" then
                local name = textLower:match("!eagle method (%a+)")
                local info = SetPrimaryMethod(name)
                if info then
                    Log("Режим переключён. " .. info)
                else
                    Log("Неизвестный режим: " .. tostring(name))
                end

            elseif textLower == "!eagle verifystruct" then
                SafeRun("verifystruct", function()
                    CONFIG.EnableStructVerification = true
                    local ok = ProbeStructAccess()
                    Log(string.format("struct-параметры UE4SS: %s (%s)",
                        tostring(ok), tostring(structAccess.lastError)))
                    if not ok then
                        CONFIG.EnableStructVerification = false
                        Log("Проверка по флагу снова отключена, чтобы не ронять игру.")
                    end
                end)

            elseif textLower == CONFIG.ChatCommandBypass or textLower == CONFIG.ChatCommandBypass .. " on" then
                SafeRun("bypass", function()
                    local ok, info = SetIgnoreFastTravelLock(true)
                    Log(string.format("bypass: %s", tostring(info)))
                end)

            elseif textLower == CONFIG.ChatCommandBypass .. " off" then
                SafeRun("bypass", function()
                    local ok, info = SetIgnoreFastTravelLock(false)
                    Log(string.format("bypass: %s", tostring(info)))
                end)

            elseif textLower == CONFIG.ChatCommandMap then
                SafeRun("mapclear", CollectEaglesMapClear)

            elseif textLower == "!restore" then
                local rateToRestore = pendingRestoreRate or 1.0
                if SetExpRate(rateToRestore) then
                    Log(string.format("EXP rate восстановлен вручную: %.2f", rateToRestore))
                end
                pendingRestoreRate = nil
            end
        end)
    end)

    if success then
        Log("Режим по умолчанию: " .. CurrentMethodInfo())
        Log("Опасные способы (EndCutscene / прямая запись флага) отключены до команды "
            .. "!eagle method cutscene|record.")
        Log(string.format("Мод загружен. Команды: %s, %s, %s, %s, %s, %s, %s",
            CONFIG.ChatCommand, CONFIG.ChatCommandStatues, CONFIG.ChatCommandPillars,
            CONFIG.ChatCommandNoExp, CONFIG.ChatCommandMap, CONFIG.ChatCommandVerify,
            CONFIG.ChatCommandBypass))
    else
        Log("Не удалось зарегистрировать чат-хук: " .. tostring(err))
    end
end

RegisterChatHook()
