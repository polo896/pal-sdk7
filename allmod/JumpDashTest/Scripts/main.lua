-- ============================================================================
-- JumpDashTest — ТЕСТОВЫЙ МОД (UE4SS Lua / Palworld)
--
-- Цель: проверить работоспособность точек внедрения ПЕРЕД интеграцией
-- в основной мод. Тестируем три пассивки:
--
--   1) Air Dash Boots    (пассивка AirDash, Accessory_AirDash1..3 и др.)
--      -> настраиваемая ДИСТАНЦИЯ воздушного рывка (Ctrl в воздухе).
--         Ваниль: 400 см (4 м) за 0.5 с. Кривая рывка НЕ меняется, поэтому
--         при увеличении дистанции скорость растёт пропорционально —
--         рывок остаётся резким «выстрелом-пружиной», просто длиннее.
--   2) Jump Boots        (пассивка JumpCount_Increase, Accessory_JumpCount_Increase1..3)
--      -> настраиваемое ЧИСЛО доп. прыжков (ваниль даёт только счёт: 1/2/3,
--         высоту доп. прыжка отдельно менять нельзя — он прыгает как обычный).
--   3) Anti-Gravity Belt (пассивка JumpPower_Increase, Accessory_JumpPower_Increase)
--      -> настраиваемая СИЛА (высота) прыжка. Именно пояс меняет высоту.
--
-- ГЛАВНОЕ УСЛОВИЕ (по ТЗ): мод меняет параметры ТОЛЬКО когда у игрока
-- АКТИВНА соответствующая пассивка (предмет надет). Снял предмет —
-- ванильное поведение. Без пассивок мод ничего не трогает.
--
-- Точки внедрения (минимум, без дублирующих хуков):
--   ХУК 1  BP_ActionAirDashBase_C:OnBeginAction (BP)       — рывок: дистанция/время
--   ХУК 2  PalPassiveSkillComponent:OnStartSkillEffect      — мгновенная реакция на надевание
--   ХУК 3  PalPassiveSkillComponent:OnEndSkillEffect        — мгновенная реакция на снятие
--   ХУК 4  PalCharacterMovementComponent:SetJumpZVelocityMultiplier — только ЛОГ
--          (показывает, как ваниль применяет пояс; для интеграции удаляется)
--   ХУК 5  PalUIChat:OnReceivedChat — тест-команды «!jd ...»
--   + ОПРОС раз в ReconcileMs — страховка: ловит вход в мир с уже надетыми
--     предметами и случаи, когда натив зовёт свои функции мимо ProcessEvent
--     (тогда хуки 2/3 могут молчать — это нормально, опрос всё применит).
--
-- Данные из дампов (sdk-dumper-7 / FModel-PalSchema / CXXHeaderDump):
--   EPalPassiveSkillEffectType: JumpPower_Increase=80, JumpCount_Increase=81, AirDash=104
--   BP_ActionAirDashBase (CDO): Const_MoveDistance=400, StepTime=0.5
--   UCharacterMovementComponent.JumpMaxCount (engine, 0x0424) — счётчик прыжков
--   UPalCharacterMovementComponent.SetJumpZVelocityMultiplier(FName, float)
-- ============================================================================

local MOD_NAME = "JumpDashTest"
local MOD_TAG  = "[JumpDashTest]"

-- ---------------------------------------------------------------------------
-- КОНФИГ (значения по умолчанию; переопределяются файлом config.txt)
-- ---------------------------------------------------------------------------
local Config = {
    Enabled = true,   -- false = мод выключен, всё возвращается к ванили
    Debug   = true,   -- подробный лог (для теста оставь true)

    -- 1) Air Dash Boots
    AirDashDistanceMult = 5.0, -- 1.0 = ваниль (4 м). 10.0 = 40 м за те же 0.5 с
    AirDashTimeMult     = 1.0, -- 1.0 = ваниль (0.5 с). 0.5 = вдвое резче. >1.25 не ставить

    -- 2) Jump Boots: число ДОПОЛНИТЕЛЬНЫХ прыжков (ваниль: 1/2/3)
    ExtraJumpCount = 5,

    -- 3) Anti-Gravity Belt: множитель СИЛЫ прыжка (1.0 = ваниль).
    --    Высота ~ квадрат: x2.0 силы = ~x4 высоты.
    JumpPowerMult = 2.0,

    ReconcileMs = 1000, -- период страховочной синхронизации (мс)
    HookRetryMs = 2000, -- как часто пробовать повесить хук рывка (мс)
}

-- ---------------------------------------------------------------------------
-- Константы из дампов
-- ---------------------------------------------------------------------------
local EFFECT_JUMPPOWER = 80   -- EPalPassiveSkillEffectType::JumpPower_Increase
local EFFECT_JUMPCOUNT = 81   -- EPalPassiveSkillEffectType::JumpCount_Increase
local EFFECT_AIRDASH   = 104  -- EPalPassiveSkillEffectType::AirDash

local VANILLA_DASH_DISTANCE = 400.0 -- BP_ActionAirDashBase.Const_MoveDistance (CDO)
local VANILLA_DASH_TIME     = 0.5   -- BP_ActionAirDashBase.StepTime (CDO)

local CLASS_AIRDASH_ACTION = "/Game/Pal/Blueprint/Action/Common/BP_ActionAirDashBase.BP_ActionAirDashBase_C"
local OUR_MULT_FLAG        = "JumpDashTest" -- имя нашего множителя в JumpZVelocityMultiplierMap

-- ---------------------------------------------------------------------------
-- Состояние
-- ---------------------------------------------------------------------------
local State = {
    controller = nil, -- локальный BP_PalPlayerController_C
    char       = nil, -- пешка игрока (BP_Player_Female/Male_C -> PalPlayerCharacter)
    movement   = nil, -- UPalCharacterMovementComponent
    passive    = nil, -- UPalPassiveSkillComponent

    overrideMaxJumps = nil,   -- что МЫ записали в JumpMaxCount (nil = не трогали)
    ourMultApplied   = false, -- наш множитель прыжка сейчас != 1.0
    lastWantRate     = 1.0,
    dashHooked       = false,
    configPath       = nil,

    -- счётчики для теста
    statDash = 0, statPassiveStart = 0, statPassiveEnd = 0, statSetJump = 0,
    lastDash = "—",
}

-- ---------------------------------------------------------------------------
-- Мелкие помощники
-- ---------------------------------------------------------------------------
local function Log(msg)  pcall(function() print(MOD_TAG .. " " .. tostring(msg) .. "\n") end) end
local function DLog(msg) if Config.Debug then Log(msg) end end

local function IsValidObj(o)
    if o == nil then return false end
    local ok, res = pcall(function() return o:IsValid() end)
    return ok and res == true
end

-- безопасный вызов: возвращает результат или nil
local function call(fn)
    local ok, res = pcall(fn)
    if ok then return res end
    return nil
end

-- Достаём значение/UObject из RemoteUnrealParam (паттерн из bbbChatsave)
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

-- Сравнение двух UObject по адресу (надёжнее, чем == на обёртках)
local function SameUObject(a, b)
    if a == nil or b == nil then return false end
    if a == b then return true end
    local aa, bb = -1, -2
    pcall(function() aa = a:GetAddress() end)
    pcall(function() bb = b:GetAddress() end)
    return aa == bb
end

local function EffectName(t)
    if t == EFFECT_JUMPCOUNT then return "JumpCount_Increase(81)" end
    if t == EFFECT_JUMPPOWER then return "JumpPower_Increase(80)" end
    if t == EFFECT_AIRDASH   then return "AirDash(104)" end
    return "EffectType_" .. tostring(t)
end

-- ---------------------------------------------------------------------------
-- Чтение TArray (несколько вариантов доступа, как в других модах репозитория)
-- ---------------------------------------------------------------------------
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

-- Сумма EffectValue всех эффектов данного типа в SkillInfos (= ваниль-значение)
local function SumSkillValue(passive, effectType)
    local infos = call(function() return passive.SkillInfos end)
    local n = ArrCount(infos)
    local sum, cnt = 0.0, 0
    for i = 1, n do
        local info = ArrAt(infos, i)
        local effs = call(function() return info.SkillEffectArray end)
        local m = ArrCount(effs)
        for j = 1, m do
            local e = ArrAt(effs, j)
            local t = tonumber(UnwrapParam(call(function() return e.Type end)))
            if t == effectType then
                local v = tonumber(UnwrapParam(call(function() return e.Value end)))
                sum = sum + (v or 0.0)
                cnt = cnt + 1
            end
        end
    end
    return sum, cnt
end

-- ---------------------------------------------------------------------------
-- Конфиг-файл (key = value)
-- ---------------------------------------------------------------------------
local CONFIG_CANDIDATES = {
    "Mods/" .. MOD_NAME .. "/config.txt",          -- стандартный UE4SS
    "../../Mods/" .. MOD_NAME .. "/config.txt",    -- если CWD = Pal/
    "../../../Mods/" .. MOD_NAME .. "/config.txt", -- если CWD = Pal/Binaries/
    MOD_NAME .. "_config.txt",                     -- запасной: рядом с игрой
}

local function ParseValue(raw)
    raw = raw:gsub("^[;%s]+", ""):gsub("%s+$", "")
    if raw == "true" then return true end
    if raw == "false" then return false end
    return tonumber(raw)
end

local function LoadConfig()
    for _, path in ipairs(CONFIG_CANDIDATES) do
        local file = call(function() return io.open(path, "r") end)
        if file then
            State.configPath = path
            local applied = 0
            for line in file:lines() do
                local k, v = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
                if k and v and Config[k] ~= nil and type(Config[k]) ~= "table" then
                    local parsed = ParseValue(v)
                    if parsed ~= nil then
                        if type(Config[k]) == "boolean" then
                            if type(parsed) == "boolean" then Config[k] = parsed; applied = applied + 1 end
                        elseif type(parsed) == "number" then
                            Config[k] = parsed; applied = applied + 1
                        end
                    end
                end
            end
            file:close()
            Log("конфиг загружен: " .. path .. " (параметров: " .. applied .. ")")
            return true
        end
    end
    Log("config.txt не найден (искал: " .. table.concat(CONFIG_CANDIDATES, "; ") .. ") — работаю на встроенных значениях")
    return false
end

local function SaveConfig()
    local path = State.configPath or CONFIG_CANDIDATES[1]
    local file = call(function() return io.open(path, "w") end)
    if not file then
        for _, p in ipairs(CONFIG_CANDIDATES) do
            file = call(function() return io.open(p, "w") end)
            if file then path = p; State.configPath = p; break end
        end
    end
    if not file then
        Log("НЕ УДАЛОСЬ сохранить конфиг (нет доступа ни по одному пути)")
        return
    end
    file:write("; " .. MOD_NAME .. " config (комментарии после ';')\n")
    file:write("Enabled = " .. tostring(Config.Enabled) .. "\n")
    file:write("Debug = " .. tostring(Config.Debug) .. "\n")
    file:write("AirDashDistanceMult = " .. tostring(Config.AirDashDistanceMult) .. "\n")
    file:write("AirDashTimeMult = " .. tostring(Config.AirDashTimeMult) .. "\n")
    file:write("ExtraJumpCount = " .. tostring(Config.ExtraJumpCount) .. "\n")
    file:write("JumpPowerMult = " .. tostring(Config.JumpPowerMult) .. "\n")
    file:write("ReconcileMs = " .. tostring(Config.ReconcileMs) .. "\n")
    file:close()
    Log("конфиг сохранён: " .. path)
end

-- ---------------------------------------------------------------------------
-- Поиск локального игрока (кэшируется, переживает респавн/перезаход)
-- ---------------------------------------------------------------------------
local function GetContext()
    if not IsValidObj(State.controller) then
        State.controller = nil
        local controllers = call(function() return FindAllOf("BP_PalPlayerController_C") end)
        if controllers then
            for _, c in ipairs(controllers) do
                if IsValidObj(c) then
                    local isLocal = call(function() return c:IsLocalPlayerController() end)
                    if isLocal then State.controller = c; break end
                end
            end
            if not State.controller and #controllers > 0 and IsValidObj(controllers[1]) then
                State.controller = controllers[1] -- одиночная игра: контроллер один
            end
        end
    end
    if not IsValidObj(State.controller) then return nil end

    local pawn = call(function() return State.controller.Pawn end)
    if not IsValidObj(pawn) then pawn = call(function() return State.controller.Character end) end

    if pawn ~= State.char or not IsValidObj(State.movement) or not IsValidObj(State.passive) then
        State.char, State.movement, State.passive = nil, nil, nil
        State.overrideMaxJumps = nil
        State.ourMultApplied = false
        State.lastWantRate = 1.0
        if IsValidObj(pawn) then
            local isPlayer = call(function() return pawn:IsA("/Script/Pal.PalPlayerCharacter") end)
            if isPlayer then
                State.char = pawn
                State.movement = call(function() return pawn.CharacterMovement end)
                State.passive = call(function() return pawn.PassiveSkillComponent end)
                if not (IsValidObj(State.movement) and IsValidObj(State.passive)) then
                    State.char = nil
                else
                    local cls = call(function() return pawn:GetClass():GetName() end)
                    Log("игрок найден: " .. tostring(cls) .. " @ 0x" .. string.format("%X", pawn:GetAddress() or 0))
                end
            end
        end
    end

    if not State.char then return nil end
    return State
end

local function HasPassive(effectType)
    if not IsValidObj(State.passive) then return false end
    return call(function() return State.passive:HasSkill(effectType, true) end) == true
end

local function IsRidingNow()
    if not IsValidObj(State.controller) then return false end
    return call(function() return State.controller:IsRiding() end) == true
end

local function SetOurJumpMult(rate)
    if not IsValidObj(State.movement) then return false end
    local ok = pcall(function() State.movement:SetJumpZVelocityMultiplier(FName(OUR_MULT_FLAG), rate) end)
    if not ok then
        ok = pcall(function() State.movement:SetJumpZVelocityMultiplier(OUR_MULT_FLAG, rate) end)
    end
    return ok
end

-- ---------------------------------------------------------------------------
-- ЯДРО: синхронизация модификаторов с текущими пассивками.
-- Вызывается по событию пассивки (отложенно, ПОСЛЕ натива) и страховочным
-- опросом. Идемпотентна: повторный вызов ничего не ломает и не спамит.
-- ---------------------------------------------------------------------------
local function Reconcile(reason)
    if not GetContext() then return end
    local mv, pas = State.movement, State.passive
    local riding = IsRidingNow()

    -- === 2) Jump Boots: количество доп. прыжков (JumpMaxCount) ===
    local hasJC = HasPassive(EFFECT_JUMPCOUNT)
    if Config.Enabled and hasJC and not riding then
        local want = 1 + Config.ExtraJumpCount
        local cur = tonumber(call(function() return mv.JumpMaxCount end))
        if cur ~= want then
            local ok = pcall(function() mv.JumpMaxCount = want end)
            if ok then
                State.overrideMaxJumps = want
                Log(string.format("ПРЫЖКИ: JumpMaxCount %s -> %d (JumpCount_Increase активна; %s)",
                    tostring(cur), want, reason))
            end
        end
    elseif State.overrideMaxJumps ~= nil then
        -- пассивку сняли / мод выключили: вернуть ваниль = 1 + остаток эффектов
        local vanilla = math.floor(1 + SumSkillValue(pas, EFFECT_JUMPCOUNT) + 0.5)
        local ok = pcall(function() mv.JumpMaxCount = vanilla end)
        if ok then
            State.overrideMaxJumps = nil
            Log(string.format("ПРЫЖКИ: возврат к ванили, JumpMaxCount = %d (%s)", vanilla, reason))
        end
    end

    -- === 3) Anti-Gravity Belt: сила прыжка (свой множитель в карте) ===
    local hasJP = HasPassive(EFFECT_JUMPPOWER)
    local wantRate = (Config.Enabled and hasJP) and Config.JumpPowerMult or 1.0
    if wantRate ~= State.lastWantRate then
        if SetOurJumpMult(wantRate) then
            if wantRate ~= 1.0 then
                State.ourMultApplied = true
                Log(string.format("ПОЯС: наш множитель силы прыжка x%.2f применён (%s)", wantRate, reason))
            else
                State.ourMultApplied = false
                Log(string.format("ПОЯС: наш множитель сброшен до x1.00 (%s)", reason))
            end
            State.lastWantRate = wantRate
        end
    elseif wantRate ~= 1.0 then
        -- переподтверждаем (на случай, если натив почистил нашу запись в карте)
        SetOurJumpMult(wantRate)
    end
end

-- ---------------------------------------------------------------------------
-- ХУК 1: начало воздушного рывка -> дистанция/время
-- (дэш начинается только если пассивка AirDash активна — натив сам гейтит)
-- ---------------------------------------------------------------------------
local function OnAirDashBegin(self)
    local action = UnwrapParam(self)
    if not IsValidObj(action) then return end
    State.statDash = State.statDash + 1

    local isLocal = false
    if GetContext() then
        local owner = call(function() return action:GetActionCharacter() end)
        isLocal = SameUObject(owner, State.char)
    end

    -- если мод выключен / это не наш игрок / пассивки нет — пишем ВАНИЛЬ
    -- (заодно сбрасываем свои значения, оставшиеся на переиспользуемом объекте)
    local dist, dashTime, tag = VANILLA_DASH_DISTANCE, VANILLA_DASH_TIME, "ваниль"
    if Config.Enabled and isLocal and HasPassive(EFFECT_AIRDASH) then
        dist = VANILLA_DASH_DISTANCE * Config.AirDashDistanceMult
        dashTime = VANILLA_DASH_TIME * Config.AirDashTimeMult
        tag = string.format("x%.2f", Config.AirDashDistanceMult)
    end

    local ok = pcall(function()
        action.Const_MoveDistance = dist
        action.StepTime = dashTime
    end)

    State.lastDash = string.format("дистанция %.0f см, время %.2f с", dist, dashTime)
    if ok then
        Log(string.format("РЫВОК #%d: %s (%s)", State.statDash, State.lastDash, tag))
        if Config.Debug then
            ExecuteInGameThread(function()
                local v = call(function() return State.movement.Velocity end)
                if v then
                    local speed = math.sqrt((v.X or 0) ^ 2 + (v.Y or 0) ^ 2 + (v.Z or 0) ^ 2)
                    DLog(string.format("  скорость игрока после рывка: %.0f см/с", speed))
                end
            end)
        end
    else
        Log("РЫВОК: ОШИБКА записи в BP_ActionAirDashBase (Const_MoveDistance/StepTime)")
    end
end

-- Регистрация хука рывка отложенно: класс BP грузится вместе с миром
local function TryRegisterDashHook()
    if State.dashHooked then return end
    local cls = call(function() return StaticFindObject(CLASS_AIRDASH_ACTION) end)
    if not IsValidObj(cls) then return end -- мир ещё не загрузил класс
    local ok = pcall(function()
        RegisterHook(CLASS_AIRDASH_ACTION .. ":OnBeginAction", function(self)
            pcall(function() OnAirDashBegin(self) end)
        end)
    end)
    if ok then
        State.dashHooked = true
        Log("хук рывка зарегистрирован: " .. CLASS_AIRDASH_ACTION .. ":OnBeginAction")
    else
        DLog("не удалось зарегистрировать хук рывка, повторю через " .. Config.HookRetryMs .. " мс")
    end
end

-- ---------------------------------------------------------------------------
-- ХУК 2/3: старт/конец пассивки у игрока -> мгновенная синхронизация.
-- ВАЖНО: натив может звать эти функции напрямую (мимо ProcessEvent) — тогда
-- хук молчит и всё ловит страховочный опрос. Счётчики в «!jd» покажут.
-- ---------------------------------------------------------------------------
local function ScheduleReconcile(reason)
    ExecuteInGameThread(function()
        pcall(function() Reconcile(reason) end)
    end)
end

pcall(function()
    RegisterHook("/Script/Pal.PalPassiveSkillComponent:OnStartSkillEffect", function(self, effectType, value)
        local comp = UnwrapParam(self)
        if not GetContext() then return end
        if not SameUObject(comp, State.passive) then return end -- не наш игрок
        State.statPassiveStart = State.statPassiveStart + 1
        local t = tonumber(UnwrapParam(effectType))
        local v = tonumber(UnwrapParam(value))
        if t == EFFECT_JUMPCOUNT or t == EFFECT_JUMPPOWER or t == EFFECT_AIRDASH then
            Log(string.format("пассивка СТАРТ: %s = %s", EffectName(t), tostring(v)))
            ScheduleReconcile("passive start")
        else
            DLog("пассивка СТАРТ: " .. EffectName(t) .. " = " .. tostring(v))
        end
    end)
end)

pcall(function()
    RegisterHook("/Script/Pal.PalPassiveSkillComponent:OnEndSkillEffect", function(self, effectType)
        local comp = UnwrapParam(self)
        if not GetContext() then return end
        if not SameUObject(comp, State.passive) then return end
        State.statPassiveEnd = State.statPassiveEnd + 1
        local t = tonumber(UnwrapParam(effectType))
        if t == EFFECT_JUMPCOUNT or t == EFFECT_JUMPPOWER or t == EFFECT_AIRDASH then
            Log("пассивка КОНЕЦ: " .. EffectName(t))
            ScheduleReconcile("passive end")
        else
            DLog("пассивка КОНЕЦ: " .. EffectName(t))
        end
    end)
end)

-- ---------------------------------------------------------------------------
-- ХУК 4 (ТОЛЬКО ДЛЯ ТЕСТА): логируем, как ваниль применяет множитель прыжка.
-- По этим строкам станет ясно, через что работает пояс (+25%).
-- При интеграции в основной мод этот хук удаляется.
-- ---------------------------------------------------------------------------
pcall(function()
    RegisterHook("/Script/Pal.PalCharacterMovementComponent:SetJumpZVelocityMultiplier", function(self, flagName, rate)
        local mv = UnwrapParam(self)
        if not GetContext() then return end
        if not SameUObject(mv, State.movement) then return end
        State.statSetJump = State.statSetJump + 1
        Log(string.format("ваниль: SetJumpZVelocityMultiplier('%s', %s)",
            FNameToStr(UnwrapParam(flagName)), tostring(tonumber(UnwrapParam(rate)))))
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
    if not GetContext() then
        Log("игрок ещё не найден — зайди в мир")
        Log("=====================================================")
        return
    end
    Log(string.format("пассивки: AirDash=%s, JumpCount_Increase=%s, JumpPower_Increase=%s",
        tostring(HasPassive(EFFECT_AIRDASH)),
        tostring(HasPassive(EFFECT_JUMPCOUNT)),
        tostring(HasPassive(EFFECT_JUMPPOWER))))
    local jmc = call(function() return State.movement.JumpMaxCount end)
    local jzv = call(function() return State.movement.JumpZVelocity end)
    local mult = call(function() return State.movement:GetJumpZVelocityMultiplier() end)
    local riding = IsRidingNow()
    Log(string.format("движение: JumpMaxCount=%s, JumpZVelocity=%s, множитель прыжка (итог)=%s, верхом=%s",
        tostring(jmc), tostring(jzv), tostring(mult), tostring(riding)))
    Log(string.format("счётчики: рывков %d | passive start %d | passive end %d | SetJumpZVelocityMultiplier %d",
        State.statDash, State.statPassiveStart, State.statPassiveEnd, State.statSetJump))
    Log("последний рывок: " .. State.lastDash)
    Log("хук рывка: " .. (State.dashHooked and "зарегистрирован" or "ЕЩЁ НЕТ (класс не загружен?)"))
    Log("конфиг: " .. (State.configPath or "встроенные значения"))
    Log("=====================================================")
end

local function PrintSkills()
    if not GetContext() then
        Log("игрок не найден")
        return
    end
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
-- ХУК 5: тест-команды в игровом чате
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
        pcall(function() Reconcile("chat " .. cmd) end)
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
        pcall(function() Reconcile("chat jumps") end)
    elseif cmd == "power" then
        if arg then Config.JumpPowerMult = math.max(arg, 0.1) end
        Log(string.format("сила прыжка (пояс): x%.2f (1.0 = ваниль)", Config.JumpPowerMult))
        pcall(function() Reconcile("chat power") end)
    elseif cmd == "save" then
        SaveConfig()
    elseif cmd == "reload" then
        LoadConfig()
        pcall(function() Reconcile("chat reload") end)
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
-- Старт
-- ---------------------------------------------------------------------------
LoadConfig()
Log("тестовый мод загружен. Команды в чате: !jd (статус), !jd help")
Log("жду входа в мир — дальше смотри консоль UE4SS")

local function Tick()
    pcall(function()
        Reconcile("poll")
        if not State.dashHooked then TryRegisterDashHook() end
    end)
end

if type(LoopInGameThreadWithDelay) == "function" then
    -- основной вариант: цикл прямо в игровом потоке
    local ok = pcall(function()
        LoopInGameThreadWithDelay(Config.ReconcileMs, Tick)
    end)
    if not ok and type(LoopAsync) == "function" then
        pcall(LoopAsync, Config.ReconcileMs, function()
            ExecuteInGameThread(Tick)
        end)
    end
elseif type(LoopAsync) == "function" then
    pcall(LoopAsync, Config.ReconcileMs, function()
        ExecuteInGameThread(Tick)
    end)
else
    Log("ОШИБКА: нет ни LoopInGameThreadWithDelay, ни LoopAsync — опрос недоступен")
end
