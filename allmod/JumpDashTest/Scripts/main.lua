-- ============================================================================
-- JumpDashTest v2 — ТЕСТОВЫЙ МОД (UE4SS Lua / Palworld)
--
-- Что проверяем (перед интеграцией в основной мод):
--   AirDash (эффект 104)            -> ДИСТАНЦИЯ воздушного рывка (ваниль 400 см/0.5 c)
--   JumpCount_Increase (эффект 81)  -> ЧИСЛО доп. прыжков (ваниль +1/+2/+3)
--   JumpPower_Increase (эффект 80)  -> СИЛА (высота) прыжка — Anti-Gravity Belt
--
-- ПРИНЦИПЫ v2 (по итогам теста v1):
--   - НИКАКИХ циклов/опросов/периодических попыток хука. В простое мод не
--     выполняет НИ ОДНОЙ инструкции. Всё событийное:
--       ClientRestart (вход/респавн) -> привязка к игроку + однократный Reconcile
--       OnStart/OnEndSkillEffect     -> надел/снял предмет с пассивкой
--       Jump (перед прыжком)         -> мгновенная сверка/откат (страховка от
--                                       «прыгаю в космос» если событие снятия
--                                       пролетело мимо хуков)
--       OnBeginAction (BP рывка)     -> параметры рывка (хук ставится ОДИН раз)
--   - Объекты сравниваются по АДРЕСУ (GetAddress), а не по идентичности
--     обёрток — обёртки UE4SS каждый раз новые.
--   - Эффект существует ТОЛЬКО пока у игрока есть пассивка (предмет в слоте,
--     с выданной хоть каким модом пассивкой — проверка по компоненту пассивок,
--     а не по ID предмета). Снял предмет -> ваниль немедленно.
-- ============================================================================

local MOD_NAME = "JumpDashTest"
local MOD_TAG  = "[JumpDashTest]"

-- ---------------------------------------------------------------------------
-- КОНФИГ (по умолчанию; переопределяется config.txt рядом с main.lua)
-- ---------------------------------------------------------------------------
local Config = {
    Enabled = true,
    Debug   = false,   -- подробный лог (для теста можно включить: !jd debug)

    -- 1) Air Dash Boots: дистанция рывка. 1.0 = ваниль (4 м за 0.5 с).
    --    Скорость растёт пропорционально: x10 = 40 м за те же полсекунды.
    AirDashDistanceMult = 5.0,
    -- Время рывка. 1.0 = ваниль (0.5 с). 0.5 = вдвое резче. >1.25 не ставить
    -- (срежется внутренним Const_MaxAirborneTime = 0.4 с).
    AirDashTimeMult     = 1.0,

    -- 2) Jump Boots: число ДОПОЛНИТЕЛЬНЫХ прыжков (ваниль 1/2/3).
    ExtraJumpCount = 5,

    -- 3) Anti-Gravity Belt: множитель силы прыжка (1.0 = ваниль).
    --    Высота ~ квадрат: x2.0 силы = ~x4 высоты.
    JumpPowerMult = 2.0,
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
local CLASS_AIRDASH_SHORT  = "BP_ActionAirDashBase_C"
local OUR_MULT_FLAG        = "JumpDashTest" -- имя нашего множителя в JumpZVelocityMultiplierMap

-- ---------------------------------------------------------------------------
-- Состояние
-- ---------------------------------------------------------------------------
local State = {
    controller = nil, -- локальный контроллер
    char       = nil, -- пешка игрока
    movement   = nil, -- её UPalCharacterMovementComponent
    passive    = nil, -- её UPalPassiveSkillComponent
    charAddr   = nil, -- адрес пешки (идентичность проверяем по нему!)

    overrideMaxJumps = nil,  -- что МЫ записали в JumpMaxCount (nil = не трогали)
    appliedMult      = 1.0,  -- множитель прыжка, который МЫ сейчас держим в карте

    dashHooked  = false,     -- хук рывка зарегистрирован (ставится ОДИН раз)
    dashVia     = "",        -- каким путём встал хук (для !jd status)
    scanGate    = 0,         -- троттлинг аварийного перепоиска (только по событиям!)

    -- счётчики для !jd status
    statDash = 0, statJump = 0, statPassiveStart = 0, statPassiveEnd = 0,
    statRestarts = 0, lastDash = "—", configPath = nil,
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

-- Достаём UObject из RemoteUnrealParam (обёртки UE4SS)
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

-- АДРЕС объекта — единственная надёжная «идентичность» в UE4SS Lua
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

-- TArray (несколько вариантов доступа, как в других модах репозитория)
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

-- Сумма EffectValue эффектов данного типа в SkillInfos (= ваниль-значение)
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
-- Конфиг-файл (key = value, комментарии после ';')
-- ---------------------------------------------------------------------------
local CONFIG_CANDIDATES = {
    "Mods/" .. MOD_NAME .. "/config.txt",
    "../../Mods/" .. MOD_NAME .. "/config.txt",
    "../../../Mods/" .. MOD_NAME .. "/config.txt",
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
            Log("конфиг загружен: " .. path)
            return true
        end
    end
    Log("config.txt не найден — работаю на встроенных значениях")
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
    if not file then Log("НЕ УДАЛОСЬ сохранить конфиг"); return end
    file:write("; " .. MOD_NAME .. " config (комментарии после ';')\n")
    file:write("Enabled = " .. tostring(Config.Enabled) .. "\n")
    file:write("Debug = " .. tostring(Config.Debug) .. "\n")
    file:write("AirDashDistanceMult = " .. tostring(Config.AirDashDistanceMult) .. "\n")
    file:write("AirDashTimeMult = " .. tostring(Config.AirDashTimeMult) .. "\n")
    file:write("ExtraJumpCount = " .. tostring(Config.ExtraJumpCount) .. "\n")
    file:write("JumpPowerMult = " .. tostring(Config.JumpPowerMult) .. "\n")
    file:close()
    Log("конфиг сохранён: " .. path)
end

-- ---------------------------------------------------------------------------
-- Проверка пассивок: ТОЛЬКО по компоненту пассивок игрока.
-- Работает для ЛЮБЫХ предметов с этой пассивкой (ванильных или выданных
-- другим модом) — пассивка предмета в слое попадает именно туда.
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
-- Привязка к игроку. Вызывается ТОЛЬКО по событию ClientRestart
-- (вход в мир / респавн / смена пешки) — не из циклов!
-- ---------------------------------------------------------------------------
local function BindContext(controller, pawn)
    -- best-effort: снять наш множитель со СТАРОГО компонента движения
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
    Log("привязка к игроку: " .. tostring(cls) .. " @ 0x" ..
        string.format("%X", State.charAddr or 0))
end

local function ValidateContext()
    return State.char ~= nil
        and IsValidObj(State.controller)
        and IsValidObj(State.char)
        and IsValidObj(State.movement)
        and IsValidObj(State.passive)
end

-- Аварийный перепоиск: ТОЛЬКО когда контекст потерян (смерть/респавн мимо
-- ClientRestart) и ТОЛЬКО по факту события (прыжок/дэш/пассивка).
-- Каждая 10-я незакреплённая попытка максимум, никаких таймеров.
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
-- ЯДРО: сверка желаемого состояния с текущими пассивками.
-- Вызывается ТОЛЬКО по событиям. Идемпотентна, логирует только реальные
-- изменения состояния (никакого спама).
-- ---------------------------------------------------------------------------
local function Reconcile(reason)
    if not ValidateContext() then return end
    local mv = State.movement

    -- === Jump Boots: количество доп. прыжков (JumpMaxCount) ===
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
    elseif State.overrideMaxJumps ~= nil then
        -- пассивки нет (или мод выключен): вернуть ваниль = 1 + сумма оставшихся эффектов
        local vanilla = math.floor(1 + SumSkillValue(EFFECT_JUMPCOUNT) + 0.5)
        local ok = pcall(function() mv.JumpMaxCount = vanilla end)
        if ok then
            State.overrideMaxJumps = nil
            Log(string.format("ПРЫЖКИ: возврат к ванили, JumpMaxCount = %d (%s)", vanilla, reason))
        end
    end

    -- === Anti-Gravity Belt: сила прыжка (наш множитель в карте) ===
    local wantRate = (Config.Enabled and HasPassive(EFFECT_JUMPPOWER))
        and Config.JumpPowerMult
        or 1.0
    if wantRate ~= State.appliedMult then
        if SetOurJumpMult(wantRate) then
            State.appliedMult = wantRate
            if wantRate ~= 1.0 then
                Log(string.format("ПОЯС: множитель силы прыжка x%.2f применён (%s)", wantRate, reason))
            else
                Log(string.format("ПОЯС: множитель сброшен до x1.00 (%s)", reason))
            end
        end
    end
end

-- ---------------------------------------------------------------------------
-- РЫВОК: параметры пишутся в объект действия в момент его старта.
-- Рывок в принципе невозможен без активной пассивки AirDash — натив сам
-- гейтит ввод, но мы всё равно перепроверяем пассивку (твой мод-выдаватель
-- пассивок тоже попадает под проверку: пассивка есть -> дэш усилен).
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

-- Регистрация хука рывка — РОВНО ОДИН РАЗ (флаг dashHooked).
-- Путь: при загрузке мода -> при ClientRestart -> (страховка) при создании
-- первого объекта действия через NotifyOnNewObject. Ни одного таймера.
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

-- Страховка: если класс ещё не искался при загрузке/ClientRestart — хук
-- встанет в момент создания первого объекта рывка (класс уже точно загружен).
-- После установки колбэк мгновенно выходит (стоимость ~один if).
pcall(function()
    NotifyOnNewObject(CLASS_AIRDASH_SHORT, function(obj)
        if State.dashHooked then return end
        TryRegisterDashHook("создание объекта")
        pcall(function() ApplyDashParams(UnwrapParam(obj)) end)
    end)
end)

-- ---------------------------------------------------------------------------
-- ХУК: вход в мир / респавн / смена пешки — единственная точка привязки
-- ---------------------------------------------------------------------------
pcall(function()
    RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(self, NewPawn)
        pcall(function()
            State.statRestarts = State.statRestarts + 1
            local controller = UnwrapParam(self)
            if not IsValidObj(controller) then return end
            -- только локальный игрок (на хосте/co-op чужие контроллеры игнорируем)
            if call(function() return controller:IsLocalPlayerController() end) == false then return end

            local pawn = UnwrapParam(NewPawn)
            -- та же самая пешка (по адресу!) — ничего не делаем, никакого спама
            if State.charAddr ~= nil and AddrOf(pawn) == State.charAddr then return end

            BindContext(controller, pawn)
            TryRegisterDashHook("ClientRestart")
            Reconcile("вход/респавн")
        end)
    end)
end)

-- ---------------------------------------------------------------------------
-- ХУКИ: надел / снял предмет с пассивкой
-- ---------------------------------------------------------------------------
pcall(function()
    RegisterHook("/Script/Pal.PalPassiveSkillComponent:OnStartSkillEffect", function(self, effectType, value)
        pcall(function()
            if not EnsureContext() then return end
            if not SameUObject(UnwrapParam(self), State.passive) then return end
            State.statPassiveStart = State.statPassiveStart + 1
            local t = tonumber(UnwrapParam(effectType))
            if t == EFFECT_JUMPCOUNT or t == EFFECT_JUMPPOWER or t == EFFECT_AIRDASH then
                Log("пассивка СТАРТ: " .. EffectName(t) .. " = " .. tostring(tonumber(UnwrapParam(value))))
                Reconcile("пассивка start")
            end
        end)
    end)
end)

pcall(function()
    RegisterHook("/Script/Pal.PalPassiveSkillComponent:OnEndSkillEffect", function(self, effectType)
        pcall(function()
            if not EnsureContext() then return end
            if not SameUObject(UnwrapParam(self), State.passive) then return end
            State.statPassiveEnd = State.statPassiveEnd + 1
            local t = tonumber(UnwrapParam(effectType))
            if t == EFFECT_JUMPCOUNT or t == EFFECT_JUMPPOWER or t == EFFECT_AIRDASH then
                Log("пассивка КОНЕЦ: " .. EffectName(t))
                Reconcile("пассивка end")
            end
        end)
    end)
end)

-- ---------------------------------------------------------------------------
-- ХУК-СТРАХОВКА: срабатывает в момент прыжка (ДО его выполнения).
-- Если снятие предмета пролетело мимо хуков пассивок — именно здесь
-- гарантированно откатим «прыжок в космос». В простое не вызывается вообще.
-- ---------------------------------------------------------------------------
pcall(function()
    RegisterHook("/Script/Pal.PalCharacterMovementComponent:Jump", function(self)
        pcall(function()
            if not EnsureContext() then return end
            if not SameUObject(UnwrapParam(self), State.movement) then return end
            State.statJump = State.statJump + 1
            Reconcile("прыжок")
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
    Log(string.format("счётчики событий: рывков %d | прыжков %d | пассивка start %d | пассивка end %d",
        State.statDash, State.statJump, State.statPassiveStart, State.statPassiveEnd))
    Log("последний рывок: " .. State.lastDash)
    Log("конфиг: " .. (State.configPath or "встроенные значения"))
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
-- ХУК: тест-команды в чате
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
        SaveConfig()
    elseif cmd == "reload" then
        LoadConfig()
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
-- Старт: конфиг + одна попытка хука (класс может быть уже загружен).
-- Никаких циклов: дальше мод спит до первого события.
-- ---------------------------------------------------------------------------
LoadConfig()
TryRegisterDashHook("загрузка")
Log("v2 загружен: событийный режим, опросов нет. Команды: !jd (статус), !jd help")
