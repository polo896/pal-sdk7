-- ============================================================================
-- JumpDashTest v3 — ТЕСТОВЫЙ МОД (UE4SS Lua / Palworld)
--
--   AirDash (эффект 104)           -> ДИСТАНЦИЯ воздушного рывка (ваниль 400 см/0.5 c)
--   JumpCount_Increase (81)        -> ЧИСЛО доп. прыжков (ваниль +1/+2/+3)
--   JumpPower_Increase (80)        -> СИЛА (высота) прыжка — Anti-Gravity Belt
--
-- Эффект существует ТОЛЬКО пока у игрока есть пассивка (любой предмет в слоте
-- с этой пассивкой, включая выданную другим модом — проверка по компоненту
-- пассивок, не по ID предмета). Снял предмет -> ваниль.
--
-- v3 (по итогам полевого теста v2):
--   - УБРАН нативный хук PalCharacterMovementComponent:Jump — после хот-
--     релоада мода UnregisterHook оставлял нативную функцию прыжка мёртвой
--     («прыжок перестал работать»). Нативных хуков на движение больше НЕТ.
--   - Нативные хуки пассивок заменены на BP-хуки HUD-виджета игрока
--     WBP_PlayerSideInfo_Separated (OnStartPassiveSkill / OnEndPassiveSkill /
--     OnUpdatePlayerEquipment) — это script-хуки, тот же механизм, что хук
--     чата и хук рывка, которые работают у тебя стабильно.
--   - Конфиг: config.lua (Lua) в Scripts/ через require — конвенция UE4SS,
--     как в PalWarpUltimateTeleport и других твоих модах.
--   - Опросов/циклов нет: мод в простое не выполняет ни одной инструкции.
--     Отложенные перепроверки после смены экипировки — два одиночных
--     ExecuteWithDelay, привязанных к событию (ловят позднюю репликацию).
--
-- Все точки (каждая — одна задача):
--   ClientRestart                     — привязка к игроку (вход/респавн)
--   WBP_PlayerSideInfo:OnUpdatePlayerEquipment — надел/снял предмет
--   WBP_PlayerSideInfo:OnStartPassiveSkill     — пассивка появилась
--   WBP_PlayerSideInfo:OnEndPassiveSkill       — пассивка исчезла
--   BP_ActionAirDashBase:OnBeginAction         — параметры рывка (1 регистрация)
--   PalUIChat:OnReceivedChat                   — тест-команды «!jd ...»
-- ============================================================================

local MOD_NAME = "JumpDashTest"
local MOD_TAG  = "[JumpDashTest]"

-- ---------------------------------------------------------------------------
-- Конфиг: дефолты + config.lua (require, конвенция UE4SS)
-- ---------------------------------------------------------------------------
local Config = {
    Enabled = true,
    Debug   = false,

    AirDashDistanceMult = 5.0, -- 1.0 = ваниль (4 м). 10.0 = 40 м за те же 0.5 с
    AirDashTimeMult     = 1.0, -- 1.0 = ваниль (0.5 с). 0.5 = вдвое резче
    ExtraJumpCount      = 5,   -- доп. прыжки (Jump Boots), ваниль 1/2/3
    JumpPowerMult       = 2.0, -- сила прыжка (пояс), высота ~ x^2
}

-- ---------------------------------------------------------------------------
-- Константы из дампов (sdk-dumper-7 / FModel-PalSchema / CXXHeaderDump)
-- ---------------------------------------------------------------------------
local EFFECT_JUMPPOWER = 80   -- EPalPassiveSkillEffectType::JumpPower_Increase
local EFFECT_JUMPCOUNT = 81   -- EPalPassiveSkillEffectType::JumpCount_Increase
local EFFECT_AIRDASH   = 104  -- EPalPassiveSkillEffectType::AirDash

local VANILLA_DASH_DISTANCE = 400.0 -- BP_ActionAirDashBase.Const_MoveDistance (CDO)
local VANILLA_DASH_TIME     = 0.5   -- BP_ActionAirDashBase.StepTime (CDO)

local CLASS_AIRDASH_ACTION = "/Game/Pal/Blueprint/Action/Common/BP_ActionAirDashBase.BP_ActionAirDashBase_C"
local CLASS_AIRDASH_NOTIFY = "BP_ActionAirDashBase.BP_ActionAirDashBase_C" -- Пакет.Класс для NotifyOnNewObject
local CLASS_SIDEINFO       = "/Game/Pal/Blueprint/UI/PlayerSIdeUI/WBP_PlayerSideInfo_Separated.WBP_PlayerSideInfo_Separated_C"
local OUR_MULT_FLAG        = "JumpDashTest" -- имя нашего множителя в JumpZVelocityMultiplierMap

-- ---------------------------------------------------------------------------
-- Состояние
-- ---------------------------------------------------------------------------
local State = {
    controller = nil, -- локальный контроллер
    char       = nil, -- пешка игрока
    movement   = nil, -- её UPalCharacterMovementComponent
    passive    = nil, -- её UPalPassiveSkillComponent
    charAddr   = nil, -- адрес пешки (идентичность ТОЛЬКО по нему)

    overrideMaxJumps = nil, -- что МЫ записали в JumpMaxCount (nil = не трогали)
    appliedMult      = 1.0, -- множитель прыжка, который МЫ держим в карте

    dashHooked = false,     -- хук рывка зарегистрирован (ставится ОДИН раз)
    dashVia   = "",         -- каким путём встал хук (для !jd)
    scanGate  = 0,          -- троттлинг перепоиска (только по событиям)

    -- счётчики для !jd
    statDash = 0, statEquip = 0, statPassiveStart = 0, statPassiveEnd = 0,
    statRestarts = 0, lastDash = "—", configLoaded = false,
}

-- ---------------------------------------------------------------------------
-- Помощники
-- ---------------------------------------------------------------------------
local function Log(msg)  pcall(function() print(MOD_TAG .. " " .. tostring(msg) .. "\n") end) end
local function DLog(msg) if Config.Debug then Log(msg) end end

local function IsValidObj(o)
    if o == nil then return false end
    local ok, res = pcall(function() return o:IsValid() end)
    return ok and res == true
end

local function call(fn)
    local ok, res = pcall(fn)
    if ok then return res end
    return nil
end

local function UnwrapParam(p)
    if p == nil then return nil end
    local t = type(p)
    if t == "string" or t == "number" or t == "boolean" then return p end
    local ok, res = pcall(function()
        if type(p.get) == "function" then return p:get() end
        return p
    end)
    if ok and res ~= nil then return res end
    return nil
end

local function FNameToStr(v)
    if v == nil then return "nil" end
    if type(v) == "string" then return v end
    local res = call(function() return v:ToString() end)
    if res ~= nil then return tostring(res) end
    return tostring(v)
end

-- Идентичность UObject — только по адресу (обёртки UE4SS каждый раз новые)
local function AddrOf(o)
    if o == nil then return nil end
    return tonumber(call(function() return o:GetAddress() end))
end

local function SameUObject(a, b)
    if a == nil or b == nil then return false end
    if a == b then return true end
    local aa, bb = AddrOf(a), AddrOf(b)
    return aa ~= nil and bb ~= nil and aa == bb
end

local function EffectName(t)
    if t == EFFECT_JUMPCOUNT then return "JumpCount_Increase(81)" end
    if t == EFFECT_JUMPPOWER then return "JumpPower_Increase(80)" end
    if t == EFFECT_AIRDASH   then return "AirDash(104)" end
    return "EffectType_" .. tostring(t)
end

local function ArrCount(arr)
    if arr == nil then return 0 end
    return tonumber(call(function() return #arr end))
        or tonumber(call(function() return arr:Num() end))
        or 0
end

local function ArrAt(arr, i)
    if arr == nil then return nil end
    return call(function() return arr[i] end)
        or call(function() return arr:Get(i - 1) end)
end

-- Сумма EffectValue эффектов типа в SkillInfos (= ваниль-значение пассивки)
local function SumSkillValue(effectType)
    local pas = State.passive
    if not IsValidObj(pas) then return 0.0 end
    local infos = call(function() return pas.SkillInfos end)
    local n = ArrCount(infos)
    local sum = 0.0
    for i = 1, n do
        local info = ArrAt(infos, i)
        local effs = call(function() return info.SkillEffectArray end)
        local m = ArrCount(effs)
        for j = 1, m do
            local e = ArrAt(effs, j)
            local t = tonumber(UnwrapParam(call(function() return e.Type end)))
            if t == effectType then
                sum = sum + (tonumber(UnwrapParam(call(function() return e.Value end))) or 0.0)
            end
        end
    end
    return sum
end

-- ---------------------------------------------------------------------------
-- Загрузка/сохранение config.lua (require — конвенция UE4SS)
-- ---------------------------------------------------------------------------
local function LoadUserConfig()
    -- сброс кэша require, чтобы !jd reload перечитал файл
    if package and package.loaded then package.loaded["config"] = nil end
    local ok, userCfg = pcall(require, "config")
    if ok and type(userCfg) == "table" then
        local n = 0
        for k, v in pairs(userCfg) do
            if Config[k] ~= nil and type(Config[k]) == type(v) then
                Config[k] = v
                n = n + 1
            end
        end
        State.configLoaded = true
        Log("config.lua загружен (значений: " .. n .. ")")
        return true
    end
    State.configLoaded = false
    Log("config.lua не найден или содержит ошибку — работаю на встроенных значениях")
    return false
end

-- Папка со скриптами мода (для записи config.lua) из debug.getinfo
local function GetScriptDir()
    local ok, info = pcall(function() return debug.getinfo(1, "S") end)
    if ok and info and info.source then
        local src = tostring(info.source):gsub("^@", "")
        local dir = src:match("^(.*)[/\\][^/\\]+$")
        if dir and #dir > 0 then return dir end
    end
    return nil
end

local function SaveUserConfig()
    local dir = GetScriptDir()
    if not dir then Log("НЕ УДАЛОСЬ определить папку мода — конфиг не сохранён"); return end
    local path = dir .. "/config.lua"
    local file = call(function() return io.open(path, "w") end)
    if not file then Log("НЕ УДАЛОСЬ записать " .. path); return end
    file:write("-- " .. MOD_NAME .. " config (создан командой !jd save)\n")
    file:write("local config = {\n")
    file:write("    Enabled = " .. tostring(Config.Enabled) .. ",\n")
    file:write("    Debug = " .. tostring(Config.Debug) .. ",\n")
    file:write("    AirDashDistanceMult = " .. tostring(Config.AirDashDistanceMult) .. ",\n")
    file:write("    AirDashTimeMult = " .. tostring(Config.AirDashTimeMult) .. ",\n")
    file:write("    ExtraJumpCount = " .. tostring(Config.ExtraJumpCount) .. ",\n")
    file:write("    JumpPowerMult = " .. tostring(Config.JumpPowerMult) .. ",\n")
    file:write("}\nreturn config\n")
    file:close()
    Log("config.lua сохранён: " .. path)
end

-- ---------------------------------------------------------------------------
-- Пассивки: ТОЛЬКО по компоненту пассивок игрока (работает с предметами,
-- которым пассивку выдал другой мод)
-- ---------------------------------------------------------------------------
local function HasPassive(effectType)
    local pas = State.passive
    if not IsValidObj(pas) then return false end
    return call(function() return pas:HasSkill(effectType, true) end) == true
end

local function IsRidingNow()
    local ctrl = State.controller
    if not IsValidObj(ctrl) then return false end
    return call(function() return ctrl:IsRiding() end) == true
end

local function SetOurJumpMult(rate)
    local mv = State.movement
    if not IsValidObj(mv) then return false end
    local ok = pcall(function() mv:SetJumpZVelocityMultiplier(FName(OUR_MULT_FLAG), rate) end)
    if not ok then
        ok = pcall(function() mv:SetJumpZVelocityMultiplier(OUR_MULT_FLAG, rate) end)
    end
    return ok
end

-- ---------------------------------------------------------------------------
-- Привязка к игроку — ТОЛЬКО по событию ClientRestart (вход/респавн)
-- ---------------------------------------------------------------------------
local function BindContext(controller, pawn)
    -- откатить наш множитель со старого компонента движения
    if State.movement ~= nil and State.appliedMult ~= 1.0 then
        pcall(function() State.movement:SetJumpZVelocityMultiplier(FName(OUR_MULT_FLAG), 1.0) end)
    end

    State.controller = controller
    State.char, State.charAddr = nil, nil
    State.movement, State.passive = nil, nil
    State.overrideMaxJumps = nil
    State.appliedMult = 1.0

    if not (IsValidObj(controller) and IsValidObj(pawn)) then return end
    if call(function() return pawn:IsA("/Script/Pal.PalPlayerCharacter") end) ~= true then return end

    local mv = call(function() return pawn.CharacterMovement end)
    local ps = call(function() return pawn.PassiveSkillComponent end)
    if not (IsValidObj(mv) and IsValidObj(ps)) then return end

    State.char = pawn
    State.charAddr = AddrOf(pawn)
    State.movement = mv
    State.passive = ps
    local cls = call(function() return pawn:GetClass():GetName() end)
    Log("привязка к игроку: " .. tostring(cls or "пешка игрока") .. " @ 0x" ..
        string.format("%X", State.charAddr or 0))
end

local function ValidateContext()
    return State.char ~= nil
        and IsValidObj(State.controller)
        and IsValidObj(State.char)
        and IsValidObj(State.movement)
        and IsValidObj(State.passive)
end

-- Перепоиск контекста: ТОЛЬКО по событию и ТОЛЬКО пока контекст потерян
-- (каждая 10-я попытка), никаких таймеров
local function EnsureContext()
    if ValidateContext() then return true end
    State.scanGate = State.scanGate + 1
    if State.scanGate % 10 ~= 1 then return false end

    local controllers = call(function() return FindAllOf("BP_PalPlayerController_C") end)
    if not controllers then return false end
    local localCtrl, firstCtrl = nil, nil
    for _, c in ipairs(controllers) do
        if IsValidObj(c) then
            firstCtrl = firstCtrl or c
            if call(function() return c:IsLocalPlayerController() end) == true then
                localCtrl = c
                break
            end
        end
    end
    local ctrl = localCtrl or firstCtrl
    if not IsValidObj(ctrl) then return false end
    local pawn = call(function() return ctrl.Pawn end) or call(function() return ctrl.Character end)
    BindContext(ctrl, pawn)
    return ValidateContext()
end

-- ---------------------------------------------------------------------------
-- ЯДРО: сверка желаемого с текущими пассивками. Идемпотентна, пишет в лог
-- только реальные изменения. Вызывается ТОЛЬКО по событиям.
-- forceJumpReset: принудительно вернуть JumpMaxCount к ванили (событие
-- «пассивка JumpCount закончилась», в т.ч. после хот-релоада мода).
-- ---------------------------------------------------------------------------
local function Reconcile(reason, forceJumpReset)
    if not ValidateContext() then return end
    local mv = State.movement

    -- Jump Boots: количество доп. прыжков (JumpMaxCount)
    local wantJumps = (Config.Enabled and HasPassive(EFFECT_JUMPCOUNT) and not IsRidingNow())
        and (1 + Config.ExtraJumpCount)
        or nil

    if wantJumps ~= nil then
        local cur = tonumber(call(function() return mv.JumpMaxCount end))
        if cur ~= wantJumps then
            local ok = pcall(function() mv.JumpMaxCount = wantJumps end)
            if ok then
                State.overrideMaxJumps = wantJumps
                Log(string.format("ПРЫЖКИ: JumpMaxCount %s -> %d (JumpCount_Increase активна; %s)",
                    tostring(cur), wantJumps, reason))
            end
        end
    elseif State.overrideMaxJumps ~= nil or forceJumpReset then
        -- пассивки нет: вернуть ваниль = 1 + сумма оставшихся эффектов
        local vanilla = math.floor(1 + SumSkillValue(EFFECT_JUMPCOUNT) + 0.5)
        local cur = tonumber(call(function() return mv.JumpMaxCount end))
        if cur ~= vanilla then
            local ok = pcall(function() mv.JumpMaxCount = vanilla end)
            if ok then
                Log(string.format("ПРЫЖКИ: возврат к ванили, JumpMaxCount %s -> %d (%s)",
                    tostring(cur), vanilla, reason))
            end
        end
        State.overrideMaxJumps = nil
    end

    -- Anti-Gravity Belt: сила прыжка. Слот в карте движка именован нашим
    -- флагом, поэтому перезапись ВСЕГДА безопасна и самолечит случай
    -- «хот-релоад мода при надетом поясе» (множитель в карте пережил релоад,
    -- а состояние Lua обнулилось).
    local wantRate = (Config.Enabled and HasPassive(EFFECT_JUMPPOWER))
        and Config.JumpPowerMult
        or 1.0
    if SetOurJumpMult(wantRate) then
        if wantRate ~= State.appliedMult then
            State.appliedMult = wantRate
            if wantRate ~= 1.0 then
                Log(string.format("ПОЯС: множитель силы прыжка x%.2f применён (%s)", wantRate, reason))
            else
                Log(string.format("ПОЯС: множитель сброшен до x1.00 (%s)", reason))
            end
        end
    end
end

-- Отложенные перепроверки после смены экипировки: пассивки могут доехать
-- репликацией позже события UI. Два ОДИНОЧНЫХ таймера на событие, не цикл.
local function ScheduleLateChecks(reason)
    if type(ExecuteWithDelay) ~= "function" then return end
    pcall(ExecuteWithDelay, 400, function()
        pcall(function() Reconcile(reason .. " late0.4s") end)
    end)
    pcall(ExecuteWithDelay, 1500, function()
        pcall(function() Reconcile(reason .. " late1.5s") end)
    end)
end

-- ---------------------------------------------------------------------------
-- РЫВОК: параметры пишутся в объект действия в момент старта.
-- Рывок невозможен без активной пассивки AirDash (натив сам гейтит ввод),
-- мы всё равно перепроверяем пассивку — предметы из твоего мода-выдавателя
-- попадают под ту же проверку.
-- ---------------------------------------------------------------------------
local function ApplyDashParams(action)
    if not IsValidObj(action) then return end
    State.statDash = State.statDash + 1

    local isLocal = false
    if ValidateContext() then
        local owner = call(function() return action:GetActionCharacter() end)
        isLocal = SameUObject(owner, State.char)
    end

    local dist, dashTime = VANILLA_DASH_DISTANCE, VANILLA_DASH_TIME
    if Config.Enabled and isLocal and HasPassive(EFFECT_AIRDASH) then
        dist = VANILLA_DASH_DISTANCE * Config.AirDashDistanceMult
        dashTime = VANILLA_DASH_TIME * Config.AirDashTimeMult
    end

    local ok = pcall(function()
        action.Const_MoveDistance = dist
        action.StepTime = dashTime
    end)
    State.lastDash = string.format("дистанция %.0f см, время %.2f с", dist, dashTime)
    if ok then
        DLog(string.format("РЫВОК #%d: %s", State.statDash, State.lastDash))
    else
        Log("РЫВОК: ошибка записи Const_MoveDistance/StepTime")
    end
end

-- Регистрация хука рывка — РОВНО ОДИН РАЗ: загрузка -> ClientRestart ->
-- NotifyOnNewObject (полное имя Пакет.Класс). Ни одного таймера.
local function TryRegisterDashHook(via)
    if State.dashHooked then return true end
    local cls = call(function() return StaticFindObject(CLASS_AIRDASH_ACTION) end)
    if not IsValidObj(cls) then return false end
    local ok = pcall(function()
        RegisterHook(CLASS_AIRDASH_ACTION .. ":OnBeginAction", function(self)
            pcall(function() ApplyDashParams(UnwrapParam(self)) end)
        end)
    end)
    if ok then
        State.dashHooked = true
        State.dashVia = via
        Log("хук рывка зарегистрирован (" .. via .. "): " .. CLASS_AIRDASH_ACTION .. ":OnBeginAction")
    end
    return ok
end

pcall(function()
    NotifyOnNewObject(CLASS_AIRDASH_NOTIFY, function(obj)
        if State.dashHooked then return end
        TryRegisterDashHook("создание объекта")
        pcall(function() ApplyDashParams(UnwrapParam(obj)) end)
    end)
end)

-- ---------------------------------------------------------------------------
-- ХУК: вход в мир / респавн — единственная точка привязки к игроку
-- ---------------------------------------------------------------------------
pcall(function()
    RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(self, NewPawn)
        pcall(function()
            State.statRestarts = State.statRestarts + 1
            local controller = UnwrapParam(self)
            if not IsValidObj(controller) then return end
            if call(function() return controller:IsLocalPlayerController() end) == false then return end

            local pawn = UnwrapParam(NewPawn)
            if State.charAddr ~= nil and AddrOf(pawn) == State.charAddr then return end

            BindContext(controller, pawn)
            TryRegisterDashHook("ClientRestart")
            Reconcile("вход/респавн")
        end)
    end)
end)

-- ---------------------------------------------------------------------------
-- ХУКИ BP-виджета игрока (script-хуки, безопасны при хот-релоаде):
-- WBP_PlayerSideInfo_Separated — HUD игрока; сам биндится к делегатам
-- PalPassiveSkillComponent (OnStartSkillEffect/OnEndSkillEffect) и обновляет
-- слоты экипировки, значит эти функции зовутся при надевании/снятии.
-- ---------------------------------------------------------------------------
pcall(function()
    RegisterHook(CLASS_SIDEINFO .. ":OnUpdatePlayerEquipment", function(self, itemSlot, slotType)
        pcall(function()
            State.statEquip = State.statEquip + 1
            DLog("экипировка изменилась (OnUpdatePlayerEquipment)")
            if EnsureContext() then
                Reconcile("экипировка")
                ScheduleLateChecks("экипировка")
            end
        end)
    end)
end)

pcall(function()
    RegisterHook(CLASS_SIDEINFO .. ":OnStartPassiveSkill", function(self, effectType, value)
        pcall(function()
            State.statPassiveStart = State.statPassiveStart + 1
            local t = tonumber(UnwrapParam(effectType))
            if t == EFFECT_JUMPCOUNT or t == EFFECT_JUMPPOWER or t == EFFECT_AIRDASH then
                Log("пассивка СТАРТ: " .. EffectName(t) .. " = " .. tostring(tonumber(UnwrapParam(value))))
            end
            if EnsureContext() then Reconcile("пассивка start") end
        end)
    end)
end)

pcall(function()
    RegisterHook(CLASS_SIDEINFO .. ":OnEndPassiveSkill", function(self, effectType)
        pcall(function()
            State.statPassiveEnd = State.statPassiveEnd + 1
            local t = tonumber(UnwrapParam(effectType))
            if t == EFFECT_JUMPCOUNT or t == EFFECT_JUMPPOWER or t == EFFECT_AIRDASH then
                Log("пассивка КОНЕЦ: " .. EffectName(t))
            end
            if EnsureContext() then
                Reconcile("пассивка end", t == EFFECT_JUMPCOUNT)
            end
        end)
    end)
end)

-- ---------------------------------------------------------------------------
-- Статус / справка / дамп пассивок
-- ---------------------------------------------------------------------------
local function PrintStatus()
    Log("==================== " .. MOD_NAME .. " ====================")
    Log(string.format("мод: %s | дэш x%.2f (время x%.2f) | доп.прыжков %d | сила прыжка x%.2f",
        Config.Enabled and "ВКЛ" or "ВЫКЛ",
        Config.AirDashDistanceMult, Config.AirDashTimeMult,
        Config.ExtraJumpCount, Config.JumpPowerMult))
    Log("конфиг: " .. (State.configLoaded and "config.lua (Scripts/)" or "встроенные значения (config.lua не найден)"))
    if not ValidateContext() then
        Log("игрок не привязан (жду ClientRestart — вход в мир/респавн)")
    else
        Log(string.format("пассивки: AirDash=%s, JumpCount_Increase=%s, JumpPower_Increase=%s",
            tostring(HasPassive(EFFECT_AIRDASH)),
            tostring(HasPassive(EFFECT_JUMPCOUNT)),
            tostring(HasPassive(EFFECT_JUMPPOWER))))
        local jmc = call(function() return State.movement.JumpMaxCount end)
        local jzv = call(function() return State.movement.JumpZVelocity end)
        Log(string.format("движение: JumpMaxCount=%s, JumpZVelocity=%s, наш множитель=%s, верхом=%s",
            tostring(jmc), tostring(jzv), tostring(State.appliedMult), tostring(IsRidingNow())))
    end
    Log(string.format("хук рывка: %s%s | ClientRestart: %d",
        State.dashHooked and "зарегистрирован" or "НЕ установлен",
        State.dashHooked and (" (" .. State.dashVia .. ")") or "",
        State.statRestarts))
    Log(string.format("счётчики событий: рывков %d | экипировка %d | пассивка start %d | пассивка end %d",
        State.statDash, State.statEquip, State.statPassiveStart, State.statPassiveEnd))
    Log("последний рывок: " .. State.lastDash)
    Log("=====================================================")
end

local function PrintSkills()
    if not EnsureContext() then Log("игрок не привязан"); return end
    local infos = call(function() return State.passive.SkillInfos end)
    local n = ArrCount(infos)
    Log("---- активные пассивки игрока (SkillInfos, групп: " .. n .. ") ----")
    for i = 1, n do
        local info = ArrAt(infos, i)
        local effs = call(function() return info.SkillEffectArray end)
        local m = ArrCount(effs)
        for j = 1, m do
            local e = ArrAt(effs, j)
            local t = tonumber(UnwrapParam(call(function() return e.Type end)))
            local v = tonumber(UnwrapParam(call(function() return e.Value end)))
            local row = FNameToStr(call(function() return e.SourcePassiveSkillRowName end))
            Log(string.format("  [%d.%d] %s = %s  (%s)", i, j, EffectName(t), tostring(v), row))
        end
    end
    Log("------------------------------------------------------")
end

local function PrintHelp()
    Log("команды: !jd | !jd status | !jd on | !jd off | !jd dash <x> | !jd time <x>")
    Log("          !jd jumps <n> | !jd power <x> | !jd skills | !jd save | !jd reload | !jd debug")
end

-- ---------------------------------------------------------------------------
-- Тест-команды в чате
-- ---------------------------------------------------------------------------
local function HandleChat(rawMsg)
    local msg = tostring(rawMsg or "")
    local body = msg:match("^%s*(!jd.*)$")
    if not body then return end
    local parts = {}
    for w in body:gmatch("%S+") do parts[#parts + 1] = w end
    if (parts[1] or ""):lower() ~= "!jd" then return end
    local cmd = (parts[2] or "status"):lower()
    local arg = tonumber(parts[3])

    if cmd == "status" then
        PrintStatus()
    elseif cmd == "help" then
        PrintHelp()
    elseif cmd == "on" or cmd == "off" then
        Config.Enabled = (cmd == "on")
        Log("мод " .. (Config.Enabled and "ВКЛЮЧЁН" or "ВЫКЛЮЧЕН (возврат к ванили)"))
        if EnsureContext() then Reconcile("chat " .. cmd) end
    elseif cmd == "dash" then
        if arg then Config.AirDashDistanceMult = math.max(arg, 0.1) end
        Log(string.format("дистанция рывка: x%.2f = %.0f см (ваниль 400)",
            Config.AirDashDistanceMult, VANILLA_DASH_DISTANCE * Config.AirDashDistanceMult))
    elseif cmd == "time" then
        if arg then Config.AirDashTimeMult = math.max(arg, 0.05) end
        Log(string.format("время рывка: x%.2f = %.2f с (ваниль 0.5; >1.25 срезается)",
            Config.AirDashTimeMult, VANILLA_DASH_TIME * Config.AirDashTimeMult))
    elseif cmd == "jumps" then
        if arg then Config.ExtraJumpCount = math.max(math.floor(arg), 0) end
        Log("доп. прыжков (Jump Boots): " .. Config.ExtraJumpCount)
        if EnsureContext() then Reconcile("chat jumps") end
    elseif cmd == "power" then
        if arg then Config.JumpPowerMult = math.max(arg, 0.1) end
        Log(string.format("сила прыжка (пояс): x%.2f (1.0 = ваниль)", Config.JumpPowerMult))
        if EnsureContext() then Reconcile("chat power") end
    elseif cmd == "save" then
        SaveUserConfig()
    elseif cmd == "reload" then
        LoadUserConfig()
        if EnsureContext() then Reconcile("chat reload") end
    elseif cmd == "debug" then
        Config.Debug = not Config.Debug
        Log("Debug = " .. tostring(Config.Debug))
    elseif cmd == "skills" then
        PrintSkills()
    else
        Log("неизвестная команда: " .. tostring(parts[2]))
        PrintHelp()
    end
end

pcall(function()
    RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(self, message)
        local msg = call(function() return message:ToString() end)
        if msg then pcall(function() HandleChat(msg) end) end
    end)
end)

-- ---------------------------------------------------------------------------
-- Старт: конфиг + одна попытка хука рывка. Дальше мод спит до события.
-- ---------------------------------------------------------------------------
LoadUserConfig()
TryRegisterDashHook("загрузка")
Log("v3 загружен: событийный режим (BP-хуки виджета), нативных хуков движения нет. Команды: !jd, !jd help")
