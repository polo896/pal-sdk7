-- ============================================================================
-- PALWORLD SAFE NOCLIP / FREECAM MOD (UE4SS)
-- ============================================================================

-- ==========================================
-- CONFIGURATION
-- ==========================================
local BASE_SPEED       = 3500.0          -- Обычная скорость полета
local TURBO_MULTIPLIER = 18.0             -- Множитель скорости при Shift
local TOGGLE_KEY       = Key.XBUTTON_TWO -- Клавиша переключения (Mouse5 / XButton2)
local LOOP_DELAY_MS    = 16              -- ~60 FPS

-- ==========================================
-- STATE
-- ==========================================
local NoclipActive      = false
local SavedGravityScale = 1.0
local TargetLocation    = nil

-- Клавиши ввода
local Keys = {
    W     = { KeyName = FName("W") },
    A     = { KeyName = FName("A") },
    S     = { KeyName = FName("S") },
    D     = { KeyName = FName("D") },
    Space = { KeyName = FName("SpaceBar") },
    Ctrl  = { KeyName = FName("LeftControl") },
    Shift = { KeyName = FName("LeftShift") }
}

-- ==========================================
-- DYNAMIC SAFE CONTEXT GETTER
-- ==========================================
local function GetPlayerContext()
    local controller = FindFirstOf("PalPlayerController")
    if not controller or not controller:IsValid() then 
        return nil 
    end

    local character = controller.Pawn
    if not character or not character:IsValid() then
        character = FindFirstOf("PalPlayerCharacter")
        if not character or not character:IsValid() then 
            return nil 
        end
    end

    local movement = character.CharacterMovement
    if not movement or not movement:IsValid() then 
        return nil 
    end

    return {
        Controller = controller,
        Character  = character,
        Movement   = movement
    }
end

-- ==========================================
-- FUNCTION TO TOGGLE NOCLIP STATE
-- ==========================================
local function ToggleNoclip()
    ExecuteInGameThread(function()
        local ctx = GetPlayerContext()
        if not ctx then
            print("[NoClip] Ошибка: Игрок или Контроллер не найдены в памяти!\n")
            return
        end

        NoclipActive = not NoclipActive

        if NoclipActive then
            -- 1. Сохраняем исходную гравитацию и отключаем её в 0
            SavedGravityScale = ctx.Movement.GravityScale or 1.0
            ctx.Movement.GravityScale = 0.0

            -- 2. Переводим движение в нативный MOVE_Flying (5)
            ctx.Movement:SetMovementMode(5, 0)

            -- 3. Нативно отключаем все коллизии актора
            ctx.Character:SetActorEnableCollision(false)

            -- 4. Сбрасываем инерцию
            ctx.Movement.Velocity = { X = 0.0, Y = 0.0, Z = 0.0 }

            -- 5. Фиксируем начальную точку зависания в пространстве
            TargetLocation = ctx.Character:K2_GetActorLocation()

            print("[NoClip] Enabled (Flying mode, Gravity = 0)\n")
        else
            -- 1. Восстанавливаем гравитацию
            ctx.Movement.GravityScale = SavedGravityScale or 1.0

            -- 2. Возвращаем режим ходьбы MOVE_Walking (1)
            ctx.Movement:SetMovementMode(1, 0)

            -- 3. Включаем коллизии обратно
            ctx.Character:SetActorEnableCollision(true)

            -- 4. Сбрасываем инерцию
            ctx.Movement.Velocity = { X = 0.0, Y = 0.0, Z = 0.0 }

            TargetLocation = nil

            print("[NoClip] Disabled\n")
        end
    end)
end

-- Регистрация хоткея переключения
RegisterKeyBind(TOGGLE_KEY, function()
    ToggleNoclip()
end)

-- ==========================================
-- SAFE TICK LOOP
-- ==========================================
LoopInGameThreadWithDelay(LOOP_DELAY_MS, function()
    if not NoclipActive then return end

    local ctx = GetPlayerContext()
    if not ctx then
        NoclipActive = false
        TargetLocation = nil
        return
    end

    -- Если позиция еще не инициализирована
    if not TargetLocation then
        TargetLocation = ctx.Character:K2_GetActorLocation()
    end

    -- Обнуляем вектор скорости каждый кадр, чтобы движок не двигал персонажа сам
    ctx.Movement.Velocity = { X = 0.0, Y = 0.0, Z = 0.0 }

    -- Получение направления взгляда камеры
    local Pitch = 0.0
    local Yaw = 0.0

    local CameraManager = ctx.Controller.PlayerCameraManager
    if CameraManager and CameraManager:IsValid() then
        local CameraRot = CameraManager:GetCameraRotation()
        Pitch = CameraRot.Pitch
        Yaw = CameraRot.Yaw
    else
        Yaw = ctx.Character.PlayerCameraYaw or 0.0
        Pitch = ctx.Character.PlayerCameraPitch or 0.0
    end

    -- Расчет векторов Forward и Right
    local pitchRad = math.rad(Pitch)
    local yawRad   = math.rad(Yaw)

    local cosPitch = math.cos(pitchRad)
    local sinPitch = math.sin(pitchRad)
    local cosYaw   = math.cos(yawRad)
    local sinYaw   = math.sin(yawRad)

    local Forward = {
        X = cosPitch * cosYaw,
        Y = cosPitch * sinYaw,
        Z = sinPitch
    }

    local yawRightRad = math.rad(Yaw + 90.0)
    local Right = {
        X = math.cos(yawRightRad),
        Y = math.sin(yawRightRad),
        Z = 0.0
    }

    -- Вектор смещения
    local moveVec = { X = 0.0, Y = 0.0, Z = 0.0 }

    if ctx.Controller:IsInputKeyDown(Keys.W) then
        moveVec.X = moveVec.X + Forward.X
        moveVec.Y = moveVec.Y + Forward.Y
        moveVec.Z = moveVec.Z + Forward.Z
    end
    if ctx.Controller:IsInputKeyDown(Keys.S) then
        moveVec.X = moveVec.X - Forward.X
        moveVec.Y = moveVec.Y - Forward.Y
        moveVec.Z = moveVec.Z - Forward.Z
    end
    if ctx.Controller:IsInputKeyDown(Keys.A) then
        moveVec.X = moveVec.X - Right.X
        moveVec.Y = moveVec.Y - Right.Y
    end
    if ctx.Controller:IsInputKeyDown(Keys.D) then
        moveVec.X = moveVec.X + Right.X
        moveVec.Y = moveVec.Y + Right.Y
    end
    if ctx.Controller:IsInputKeyDown(Keys.Space) then
        moveVec.Z = moveVec.Z + 1.0
    end
    if ctx.Controller:IsInputKeyDown(Keys.Ctrl) then
        moveVec.Z = moveVec.Z - 1.0
    end

    -- Нормализация вектора движения
    local length = math.sqrt(moveVec.X * moveVec.X + moveVec.Y * moveVec.Y + moveVec.Z * moveVec.Z)
    if length > 0.0 then
        moveVec.X = moveVec.X / length
        moveVec.Y = moveVec.Y / length
        moveVec.Z = moveVec.Z / length
    end

    -- Расчет скорости
    local speed = BASE_SPEED
    if ctx.Controller:IsInputKeyDown(Keys.Shift) then
        speed = BASE_SPEED * TURBO_MULTIPLIER
    end

    local DeltaTime = LOOP_DELAY_MS / 1000.0

    -- Обновляем целевую точку
    TargetLocation = {
        X = TargetLocation.X + (moveVec.X * speed * DeltaTime),
        Y = TargetLocation.Y + (moveVec.Y * speed * DeltaTime),
        Z = TargetLocation.Z + (moveVec.Z * speed * DeltaTime)
    }

    local currentRot = ctx.Character:K2_GetActorRotation()

    -- Безопасная телепортация в целевую точку
    ctx.Character:K2_TeleportTo(TargetLocation, currentRot)
end)
