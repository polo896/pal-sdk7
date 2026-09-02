-- by Wol4ara896

-- ============================================================
-- ICON SELECTION
-- ============================================================
-- 0 = First icon
-- 1 = Second icon
-- 2 = Third icon
-- ============================================================

local SELECTED_ICON = 0


-- ============================================================
-- FONT & STYLE SETTINGS
-- ============================================================

-- OVERRIDE_FONT:
--   false = USE THE FONT FROM .PAK (the widget font is not modified by the script)
--   true  = Replace the font with one of the presets below
local OVERRIDE_FONT = false

-- FONT_PRESET (works only if OVERRIDE_FONT = true):
--   "PalDefault" = Ft_PalDefaultFont (Main game font)
--   "Roboto"     = Roboto (Default engine font)
--   "DroidMono"  = DroidSansMono (Monospaced)
local FONT_PRESET = "PalDefault"

-- OVERRIDE_FONT_SIZE:
--   false = Use the font size from .pak
--   true  = Set your own font size in pixels (FONT_SIZE)
local OVERRIDE_FONT_SIZE = false
local FONT_SIZE = 24

-- OVERRIDE_COLOR:
--   false = Use the text color from .pak
--   true  = Change the text color to TEXT_COLOR
local OVERRIDE_COLOR = false
local TEXT_COLOR = { R = 1.0, G = 1.0, B = 1.0, A = 1.0 }

-- OVERRIDE_OUTLINE:
--   false = Use the outline settings from .pak
--   true  = Apply the outline settings below
local OVERRIDE_OUTLINE = false
local OUTLINE_SIZE = 1.5
local OUTLINE_COLOR = { R = 0.0, G = 0.0, B = 0.0, A = 0.9 }


-- ============================================================
-- POSITION SETTINGS
-- ============================================================
local OFFSET_X = 0
local OFFSET_Y = 0


-- ============================================================
-- HUD & ICON SIZE
-- ============================================================
local HUD_SCALE = 1.0
local ICON_SCALE = 1.0
local ICON_OFFSET_X = 0
local ICON_OFFSET_Y = 0


-- ============================================================
-- UPDATE INTERVAL
-- ============================================================
local TICK_INTERVAL = 1000

local cachedPC = nil
local cachedWidget = nil
local lastVisibility = nil
local lastText = nil

local knownStations = {}
local knownUIModels = {}
local hasScanned = false

local globalMinRemain = -1
local lastTickTime = 0

local function ApplyIcon(widget)
    if not widget or not widget:IsValid() then return end
    pcall(function()
        widget:SetIconByID(SELECTED_ICON)
    end)
end

local function ApplyFontSettings(widget)
    if not widget or not widget:IsValid() then return end

    if not OVERRIDE_FONT and not OVERRIDE_FONT_SIZE and not OVERRIDE_COLOR and not OVERRIDE_OUTLINE then
        return
    end

    pcall(function()
        local text = widget.TimeText
        if not text or not text:IsValid() then return end

        local fontInfo = text.Font
        if not fontInfo then return end

        if OVERRIDE_FONT then
            local fontPath = ""
            local isFontFace = false

            if FONT_PRESET == "PalDefault" then
                fontPath = "/Game/Pal/Font/Ft_PalDefaultFont.Ft_PalDefaultFont"
            elseif FONT_PRESET == "OxaniumBold" then
                fontPath = "/Game/Pal/Font/Number/Oxanium-Bold.Oxanium-Bold"
                isFontFace = true
            elseif FONT_PRESET == "OxaniumReg" then
                fontPath = "/Game/Pal/Font/Number/Oxanium-Regular.Oxanium-Regular"
                isFontFace = true
            elseif FONT_PRESET == "OxaniumMed" then
                fontPath = "/Game/Pal/Font/Number/Oxanium-Medium.Oxanium-Medium"
                isFontFace = true
            elseif FONT_PRESET == "Roboto" then
                fontPath = "/Engine/EngineFonts/Roboto.Roboto"
            elseif FONT_PRESET == "DroidMono" then
                fontPath = "/Engine/EngineFonts/DroidSansMono.DroidSansMono"
            elseif FONT_PRESET == "Custom" then
                fontPath = CUSTOM_FONT_PATH
            end

            local fontAsset = StaticFindObject(fontPath)
            if not fontAsset and StaticLoadObject then
                fontAsset = StaticLoadObject(fontPath)
            end

            if fontAsset and fontAsset:IsValid() then
                fontInfo.FontObject = fontAsset
                pcall(function()
                    fontInfo.TypefaceFontName = FName("")
                end)
            end
        end

        if OVERRIDE_FONT_SIZE then
            fontInfo.Size = FONT_SIZE
        end

        if OVERRIDE_OUTLINE then
            fontInfo.OutlineSettings.OutlineSize = OUTLINE_SIZE
            fontInfo.OutlineSettings.OutlineColor = {
                SpecifiedColor = {
                    R = OUTLINE_COLOR.R,
                    G = OUTLINE_COLOR.G,
                    B = OUTLINE_COLOR.B,
                    A = OUTLINE_COLOR.A
                }
            }
        end

        text.Font = fontInfo
        pcall(function() text:SetFont(fontInfo) end)

        if OVERRIDE_COLOR then
            pcall(function()
                text:SetColorAndOpacity({
                    SpecifiedColor = {
                        R = TEXT_COLOR.R,
                        G = TEXT_COLOR.G,
                        B = TEXT_COLOR.B,
                        A = TEXT_COLOR.A
                    }
                })
            end)
        end
    end)
end

local function ApplyTransform(widget)
    if not widget or not widget:IsValid() then return end

    pcall(function()
        widget:SetRenderTranslation({
            X = OFFSET_X,
            Y = OFFSET_Y
        })
    end)

    pcall(function()
        local text = widget.TimeText
        if text and text:IsValid() then
            text:SetRenderScale({
                X = HUD_SCALE,
                Y = HUD_SCALE
            })
        end
    end)

    pcall(function()
        local image = widget.Image_1
        if image and image:IsValid() then
            image:SetRenderScale({
                X = ICON_SCALE,
                Y = ICON_SCALE
            })

            image:SetRenderTranslation({
                X = ICON_OFFSET_X,
                Y = ICON_OFFSET_Y
            })
        end
    end)

    ApplyFontSettings(widget)
end

local function SetWidgetVisibility(widget, visibility)
    if lastVisibility == visibility then return end
    local ok = pcall(function() widget:SetVisibility(visibility) end)
    if ok then lastVisibility = visibility end
end

local function IsPlayerValid()
    if cachedPC and cachedPC:IsValid() then
        local ok, pawn = pcall(function() return cachedPC.Pawn end)
        if ok and pawn and pawn:IsValid() then return true end
    end

    cachedPC = FindFirstOf("PalPlayerController")
    if not cachedPC or not cachedPC:IsValid() then
        cachedPC = nil
        hasScanned = false
        knownStations = {}
        knownUIModels = {}
        globalMinRemain = -1
        return false
    end

    local ok, pawn = pcall(function() return cachedPC.Pawn end)
    if not ok or not pawn or not pawn:IsValid() then return false end

    return true
end

local function GetWidget()
    if cachedWidget and cachedWidget:IsValid() then return cachedWidget end
    local w = FindFirstOf("WBP_CustomTimer_C")
    if w and w:IsValid() then
        cachedWidget = w
        lastText = nil
        lastVisibility = nil
        ApplyTransform(cachedWidget)
        ApplyIcon(cachedWidget)
        return cachedWidget
    end
    return nil
end

pcall(function()
    NotifyOnNewObject("/Script/Pal.PalMapObjectCharacterTeamMissionModel", function(obj)
        if obj and obj:IsValid() then table.insert(knownStations, obj) end
    end)
end)
pcall(function()
    NotifyOnNewObject("/Script/Pal.PalUIMapObjectCharacterTeamMissionModel", function(obj)
        if obj and obj:IsValid() then table.insert(knownUIModels, obj) end
    end)
end)

local function EnsureInitialScan()
    if hasScanned then return end
    hasScanned = true
    
    local stations = FindAllOf("PalMapObjectCharacterTeamMissionModel")
    if stations then
        for i = 1, #stations do
            if stations[i] and stations[i]:IsValid() then table.insert(knownStations, stations[i]) end
        end
    end
    
    local uis = FindAllOf("PalUIMapObjectCharacterTeamMissionModel")
    if uis then
        for i = 1, #uis do
            if uis[i] and uis[i]:IsValid() then table.insert(knownUIModels, uis[i]) end
        end
    end
end

local function GetStateValue(model)
    if not model or not model:IsValid() then return nil end
    local ok, res = pcall(function() return model:GetCurrentState() end)
    if ok and res ~= nil then
        local num = tonumber(res)
        if num then return num end
        if type(res) == "number" then return res end
    end
    local okProp, st = pcall(function() return model.State end)
    if not okProp or st == nil then return nil end
    if type(st) == "number" then return st end
    local okGet, getVal = pcall(function() return st:get() end)
    if okGet and type(getVal) == "number" then return getVal end
    return tonumber(st)
end

local function GetExpeditionStatus()
    EnsureInitialScan()
    local completed = 0
    local running = 0
    local actualMinRemain = -1

    for i = #knownStations, 1, -1 do
        local m = knownStations[i]
        local isAlive = false
        if m then
            local ok, valid = pcall(function() return m:IsValid() end)
            if ok and valid then isAlive = true end
        end
        
        if not isAlive then
            table.remove(knownStations, i)
        else
            local st = GetStateValue(m)
            if st == 3 then completed = completed + 1
            elseif st == 2 then running = running + 1 end
        end
    end

    if running > 0 then
        for i = #knownUIModels, 1, -1 do
            local uim = knownUIModels[i]
            local isAlive = false
            if uim then
                local ok, valid = pcall(function() return uim:IsValid() end)
                if ok and valid then isAlive = true end
            end
            
            if not isAlive then
                table.remove(knownUIModels, i)
            else
                local st = GetStateValue(uim)
                if st == 2 then
                    local okTime, rem = pcall(function() return uim:GetRemainMissionSeconds() end)
                    if okTime and type(rem) == "number" and rem > 0 then
                        if actualMinRemain == -1 or rem < actualMinRemain then
                            actualMinRemain = rem
                        end
                    end
                end
            end
        end
    end

    return completed, running, actualMinRemain
end

LoopAsync(TICK_INTERVAL, function()
    ExecuteInGameThread(function()
        local widget = GetWidget()
        if not widget then return end

        if not IsPlayerValid() then
            SetWidgetVisibility(widget, 2)
            return
        end

        local now = os.clock()
        local dt = 0
        if lastTickTime > 0 then dt = now - lastTickTime end
        lastTickTime = now

        local completed, running, actualMinRemain = GetExpeditionStatus()

        if completed == 0 and running == 0 then
            SetWidgetVisibility(widget, 2)
            lastText = nil
            return
        end

        if actualMinRemain ~= -1 then
            globalMinRemain = actualMinRemain
        else
            if globalMinRemain > 0 then
                globalMinRemain = globalMinRemain - dt
            end
        end
        if globalMinRemain < 0 and running > 0 then globalMinRemain = 0 end

        local displayText = ""

        if running == 0 then
            displayText = string.format("[%d] Completed", completed)
        else
            if globalMinRemain >= 0 then
                local safeRemain = math.max(0, math.floor(globalMinRemain))
                local mins = math.floor(safeRemain / 60)
                local secs = math.floor(safeRemain % 60)
                displayText = string.format("[%d/%d] %02d:%02d", completed, running, mins, secs)
            else
                displayText = string.format("[%d/%d] --:--", completed, running)
            end
        end

        if lastText ~= displayText then
            SetWidgetVisibility(widget, 3)
            pcall(function() widget:UpdateTimer(displayText) end)
            lastText = displayText
        end
    end)
end)


