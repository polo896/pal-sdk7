-- ===========================================================================
--  Relic Collector :: Settings & Control UI
-- ===========================================================================

local RelicUI = {
    Theme     = {},
    Assets    = {},
    Factory   = {},
    Engine    = {},
    Presenter = {},
}

local function safeCall(func, ...)
    local ok, res = pcall(func, ...)
    if ok then return res end
    return nil
end

local function isObjectValid(obj)
    if not obj or type(obj) ~= "userdata" then return false end
    local ok, valid = pcall(function() return obj:IsValid() end)
    return ok and valid == true
end

local function printLog(text)
    print("[RelicCollector][UI] " .. tostring(text))
end

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

RelicUI.Theme = {
    PanelBase     = hexToLinearColor("#131A1D", 0.95),
    PanelHeader   = hexToLinearColor("#26333A", 1.00),
    PanelSection  = hexToLinearColor("#192226", 0.90),
    CardActive    = hexToLinearColor("#1D2D2A", 0.96),
    CardInactive  = hexToLinearColor("#241D1E", 0.85),
    Divider       = hexToLinearColor("#314046", 1.00),
    BorderDefault = hexToLinearColor("#42555C", 1.00),
    BarTrack      = hexToLinearColor("#293439", 1.00),

    TextPrimary   = hexToLinearColor("#EAF2F6", 1.00),
    TextSecond    = hexToLinearColor("#9DB0B9", 1.00),
    TextDim       = hexToLinearColor("#6C808A", 1.00),

    Gold          = hexToLinearColor("#FFC53D", 1.00),
    Green         = hexToLinearColor("#4ADE80", 1.00),
    GreenSoft     = hexToLinearColor("#A3E635", 1.00),
    Red           = hexToLinearColor("#F87171", 1.00),
    Blue          = hexToLinearColor("#7DD3FC", 1.00),
    Cyan          = hexToLinearColor("#22D3EE", 1.00),
    Purple        = hexToLinearColor("#C084FC", 1.00),
}

RelicUI.Assets = {
    WindowBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_PalCommonWindow.WBP_PalCommonWindow_C",
    ButtonBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_CommonButton_Activation.WBP_CommonButton_Activation_C",
    DefaultFont     = "/Game/Pal/Font/Ft_PalDefaultFont.Ft_PalDefaultFont",
    OverallLayout   = "WBP_PalOverallUILayout_C",
    HostPanelName   = "CanvasPanel_Root",
}

local ObjectCache = {}
local function resolveStaticObject(path)
    if ObjectCache[path] and isObjectValid(ObjectCache[path]) then
        return ObjectCache[path]
    end
    local obj = StaticFindObject(path)
    if not isObjectValid(obj) then
        pcall(LoadAsset, path)
        obj = StaticFindObject(path)
    end
    if isObjectValid(obj) then
        ObjectCache[path] = obj
        return obj
    end
    return nil
end

local RELIC_CATALOG = {
    { class = "BP_LevelObject_Relic_C",              name = "Lifmunk",    sub = "Effigy / Statue", color = RelicUI.Theme.Green },
    { class = "BP_LevelObject_Relic_FlameBambi_C",   name = "Rooby",      sub = "Flame Bambi",     color = RelicUI.Theme.Red },
    { class = "BP_LevelObject_Relic_GuardianDog_C",  name = "Yakumo",     sub = "Guardian Dog",    color = RelicUI.Theme.Gold },
    { class = "BP_LevelObject_Relic_IceCrocodile_C", name = "Munchill",   sub = "Ice Crocodile",   color = RelicUI.Theme.Cyan },
    { class = "BP_LevelObject_Relic_LazyDragon_C",   name = "Relaxaurus", sub = "Lazy Dragon",     color = RelicUI.Theme.Blue },
    { class = "BP_LevelObject_Relic_LeafMomonga_C",  name = "Bristla",    sub = "Leaf Momonga",    color = RelicUI.Theme.GreenSoft },
    { class = "BP_LevelObject_Relic_Monkey_C",       name = "Tanzee",     sub = "Monkey",          color = RelicUI.Theme.Green },
    { class = "BP_LevelObject_Relic_Mutant_C",       name = "Lunaris",    sub = "Mutant",          color = RelicUI.Theme.Purple },
    { class = "BP_LevelObject_Relic_NegativeKoala_C",name = "Depresso",   sub = "Negative Koala",  color = RelicUI.Theme.Blue },
    { class = "BP_LevelObject_Relic_Penguin_C",      name = "Pengullet",  sub = "Penguin",         color = RelicUI.Theme.Cyan },
    { class = "BP_LevelObject_Relic_PinkCat_C",      name = "Cattiva",    sub = "Pink Cat",        color = hexToLinearColor("#FF8AC4", 1.0) },
    { class = "BP_LevelObject_Relic_SheepBall_C",    name = "Lamball",    sub = "Sheep Ball",      color = RelicUI.Theme.TextPrimary },
}

function RelicUI.Factory.CreateText(tree, message, fontSize, colorTuple, boldFont, justify)
    local cls = resolveStaticObject("/Script/UMG.TextBlock")
    if not cls then return nil end
    local widget = StaticConstructObject(cls, tree)
    if not isObjectValid(widget) then return nil end

    widget:SetText(FText(message or ""))
    widget:SetRenderOpacity(1.0)

    pcall(function()
        local fontInfo = widget.Font
        fontInfo.Size = fontSize or 11
        local fontAsset = resolveStaticObject(RelicUI.Assets.DefaultFont)
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

function RelicUI.Factory.CreateSolidBorder(tree, colorTuple)
    local cls = resolveStaticObject("/Script/UMG.Border")
    if not cls then return nil end
    local border = StaticConstructObject(cls, tree)
    if not isObjectValid(border) then return nil end

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

function RelicUI.Factory.AnchorWidget(parentCanvas, childWidget, x, y, w, h, zOrder)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not isObjectValid(slot) then return end

    slot:SetAutoSize(false)
    local pos = slot:GetPosition()
    pos.X, pos.Y = math.floor(x), math.floor(y)
    slot:SetPosition(pos)

    local size = slot:GetSize()
    size.X, size.Y = math.floor(w), math.floor(h)
    slot:SetSize(size)
    slot:SetZOrder(zOrder or 0)
end

function RelicUI.Factory.AnchorCenter(parentCanvas, childWidget, w, h)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not isObjectValid(slot) then return end

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

function RelicUI.Factory.DrawFrame(canvas, tree, x, y, w, h, color)
    local function line(lx, ly, lw, lh)
        local b = RelicUI.Factory.CreateSolidBorder(tree, color)
        if b then RelicUI.Factory.AnchorWidget(canvas, b, lx, ly, lw, lh, 1) end
    end
    line(x, y, w, 1)
    line(x, y + h - 1, w, 1)
    line(x, y, 1, h)
    line(x + w - 1, y, 1, h)
end

function RelicUI.Engine.LocateMainLayout()
    local ok, instances = pcall(FindAllOf, RelicUI.Assets.OverallLayout)
    if ok and instances and #instances > 0 then return instances[1] end
    return nil
end

function RelicUI.Engine.FindHostCanvas(outerFullName, panelName)
    local ok, canvasList = pcall(FindAllOf, "CanvasPanel")
    if not ok or not canvasList then return nil end

    local needle = "." .. panelName
    for _, canvas in ipairs(canvasList) do
        if isObjectValid(canvas) then
            local okName, name = pcall(function() return canvas:GetFullName() end)
            if okName and name and name:sub(-#needle) == needle then
                local okOuter, outerObj = pcall(function() return canvas:GetOuter() end)
                if okOuter and isObjectValid(outerObj) then
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

function RelicUI.Engine.DiscoverNamedSlot(windowObj)
    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not isObjectValid(tree) then return nil end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not isObjectValid(root) then return nil end

    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return nil end

    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and isObjectValid(child) then
            local okName, name = pcall(function() return child:GetFullName() end)
            if okName and name and name:match("^NamedSlot%s") then
                return child
            end
        end
    end
    return nil
end

function RelicUI.Engine.MuteUnusedChrome(windowObj)
    local slot = RelicUI.Engine.DiscoverNamedSlot(windowObj)
    if not slot then return end
    local okName, slotFullName = pcall(function() return slot:GetFullName() end)
    if not okName then return end

    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not isObjectValid(tree) then return end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not isObjectValid(root) then return end

    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return end

    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and isObjectValid(child) then
            local okChildName, childName = pcall(function() return child:GetFullName() end)
            if okChildName and childName ~= slotFullName then
                pcall(function() child:SetVisibility(1) end)
            end
        end
    end
end

function RelicUI.Engine.AcquireModalSurface()
    local layout = RelicUI.Engine.LocateMainLayout()
    if not isObjectValid(layout) then return nil end
    local ok, modalLayer = pcall(function() return layout.Modal end)
    if ok and isObjectValid(modalLayer) then return modalLayer end
    return nil
end

local ClickDispatcher = {
    subscribers = {},
    hookActive  = false,
}

function ClickDispatcher.Subscribe(buttonWidget, callback)
    if not isObjectValid(buttonWidget) or not callback then return end

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

local function assembleModalFrame(panel, tree, frameWidth, frameHeight)
    local winCls     = resolveStaticObject(RelicUI.Assets.WindowBlueprint)
    local canvasCls  = resolveStaticObject("/Script/UMG.CanvasPanel")
    local sizeBoxCls = resolveStaticObject("/Script/UMG.SizeBox")
    local widgetLib  = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    local modalHost  = RelicUI.Engine.AcquireModalSurface()

    if not winCls or not canvasCls or not sizeBoxCls or not widgetLib or not modalHost then
        printLog("Core UMG classes missing for modal")
        return nil
    end

    local frameShell, contentSurface
    local ok, err = pcall(function()
        local player = panel:GetOwningPlayer()
        frameShell = modalHost:BP_AddWidget(winCls)
        if not isObjectValid(frameShell) then error("Modal host rejected widget") end

        RelicUI.Engine.MuteUnusedChrome(frameShell)
        local shellSlot = RelicUI.Engine.DiscoverNamedSlot(frameShell)
        if not shellSlot then error("Shell slot missing") end

        local innerWindow = widgetLib:Create(panel, winCls, player)
        if not isObjectValid(innerWindow) then error("Inner window failed") end

        local innerSlot = RelicUI.Engine.DiscoverNamedSlot(innerWindow)
        if not innerSlot then error("Inner slot missing") end

        contentSurface = StaticConstructObject(canvasCls, tree)
        local frameBox = StaticConstructObject(sizeBoxCls, tree)
        frameBox:SetWidthOverride(frameWidth)
        frameBox:SetHeightOverride(frameHeight)
        frameBox:SetContent(contentSurface)
        innerSlot:SetContent(frameBox)

        local hostCanvas = StaticConstructObject(canvasCls, tree)
        shellSlot:SetContent(hostCanvas)
        RelicUI.Factory.AnchorCenter(hostCanvas, innerWindow, frameWidth, frameHeight)
    end)

    if not ok or not isObjectValid(frameShell) then
        printLog("assembleModalFrame err: " .. tostring(err))
        return nil
    end

    pcall(function()
        local blurCls = resolveStaticObject("/Script/UMG.BackgroundBlur")
        if blurCls then
            local blur = StaticConstructObject(blurCls, tree)
            if isObjectValid(blur) then
                blur:SetRenderOpacity(1.0)
                pcall(function() blur:SetBlurStrength(6.0) end)
                RelicUI.Factory.AnchorWidget(contentSurface, blur, 0, 0, frameWidth, frameHeight, 0)
            end
        end
        local base = RelicUI.Factory.CreateSolidBorder(tree, RelicUI.Theme.PanelBase)
        if base then RelicUI.Factory.AnchorWidget(contentSurface, base, 0, 0, frameWidth, frameHeight, 1) end
    end)

    return { shell = frameShell, surface = contentSurface }
end

local function createGameButton(hostCanvas, surface, tree, label, x, y, w, h, onClick, z)
    local btnCls    = resolveStaticObject(RelicUI.Assets.ButtonBlueprint)
    local widgetLib = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    if not btnCls or not widgetLib then return nil end

    local ok, btn = pcall(function()
        local owner = hostCanvas:GetOwningPlayer()
        local b = widgetLib:Create(hostCanvas, btnCls, owner)
        if not isObjectValid(b) then error("button create failed") end
        pcall(function() b:Setup(false) end)
        pcall(function() b:SetText(FText(label)) end)
        return b
    end)
    if not ok or not isObjectValid(btn) then return nil end

    RelicUI.Factory.AnchorWidget(surface, btn, x, y, w, h, z or 60)

    local target = btn
    local okIn, inner = pcall(function() return btn.WBP_PalInvisibleButton end)
    if okIn and isObjectValid(inner) then target = inner end
    ClickDispatcher.Subscribe(target, onClick)

    return btn
end

local UI_W = 960
local UI_H = 760
local PAD  = 16

local State = {
    activeShell   = nil,
    activeSurface = nil,
    widgetTree    = nil,
    hostCanvas    = nil,
    isDisplayed   = false,
    ctx           = nil,
}

local function renderAllContent()
    if not isObjectValid(State.activeSurface) or not isObjectValid(State.widgetTree) then return end

    local S   = State
    local F   = RelicUI.Factory
    local T   = RelicUI.Theme
    local ctx = S.ctx

    local surface    = S.activeSurface
    local tree       = S.widgetTree
    local hostCanvas = S.hostCanvas
    local contentW   = UI_W - PAD * 2

    pcall(function() surface:ClearChildren() end)
    ClickDispatcher.Reset()

    local blurCls = resolveStaticObject("/Script/UMG.BackgroundBlur")
    if blurCls then
        local blur = StaticConstructObject(blurCls, tree)
        if isObjectValid(blur) then
            pcall(function() blur:SetBlurStrength(6.0) end)
            F.AnchorWidget(surface, blur, 0, 0, UI_W, UI_H, 0)
        end
    end
    local base = F.CreateSolidBorder(tree, T.PanelBase)
    if base then F.AnchorWidget(surface, base, 0, 0, UI_W, UI_H, 1) end

    local headerH = 46
    local headerBg = F.CreateSolidBorder(tree, T.PanelHeader)
    if headerBg then F.AnchorWidget(surface, headerBg, PAD, PAD, contentW, headerH, 5) end
    F.DrawFrame(surface, tree, PAD, PAD, contentW, headerH, T.BorderDefault)

    local greenLine = F.CreateSolidBorder(tree, T.Green)
    if greenLine then F.AnchorWidget(surface, greenLine, PAD, PAD + headerH - 2, contentW, 2, 6) end

    local title = F.CreateText(tree, "RELIC COLLECTOR CONTROL PANEL", 16, T.TextPrimary, true, 0)
    if title then F.AnchorWidget(surface, title, PAD + 16, PAD + 12, 380, 24, 7) end

    local countActive = 0
    for _, def in ipairs(RELIC_CATALOG) do
        if ctx.config.Relics[def.class] == true then countActive = countActive + 1 end
    end
    local subText = string.format("Active: %d/12 Types  |  World Scan Ready", countActive)
    local sub = F.CreateText(tree, subText, 11, T.TextSecond, false, 2)
    if sub then F.AnchorWidget(surface, sub, PAD + contentW - 350, PAD + 16, 334, 16, 7) end

    local actionsY = PAD + headerH + 10
    local actionsH = 50

    local actBg = F.CreateSolidBorder(tree, T.PanelSection)
    if actBg then F.AnchorWidget(surface, actBg, PAD, actionsY, contentW, actionsH, 5) end
    F.DrawFrame(surface, tree, PAD, actionsY, contentW, actionsH, T.Divider)

    local actLabel = F.CreateText(tree, "EXECUTE:", 11, T.TextDim, true, 0)
    if actLabel then F.AnchorWidget(surface, actLabel, PAD + 16, actionsY + 17, 74, 16, 7) end

    createGameButton(hostCanvas, surface, tree, "★ COLLECT ALL", PAD + 94, actionsY + 8, 230, 34, function()
        if ctx.onCollect then ctx.onCollect() end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "⚡ COLLECT (NO EXP)", PAD + 332, actionsY + 8, 240, 34, function()
        if ctx.onCollectNoExp then ctx.onCollectNoExp() end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "RESTORE EXP", PAD + 580, actionsY + 8, 170, 34, function()
        if ctx.onRestoreExp then ctx.onRestoreExp() end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "?", PAD + contentW - 46, actionsY + 8, 36, 34, function()
        if ctx.onHelp then ctx.onHelp() end
    end, 60)

    local confY = actionsY + actionsH + 10
    local confH = 88

    local confBg = F.CreateSolidBorder(tree, T.PanelSection)
    if confBg then F.AnchorWidget(surface, confBg, PAD, confY, contentW, confH, 5) end
    F.DrawFrame(surface, tree, PAD, confY, contentW, confH, T.Divider)

    local radLabel = F.CreateText(tree, "RADIUS:", 11, T.TextSecond, true, 0)
    if radLabel then F.AnchorWidget(surface, radLabel, PAD + 16, confY + 12, 60, 16, 7) end

    local currentRad = ctx.config.CollectRadius or 0
    local radValStr  = (currentRad == 0) and "Unlimited (All Map)" or string.format("%d u (~%d m)", currentRad, math.floor(currentRad / 100))
    local radValText = F.CreateText(tree, radValStr, 11, (currentRad == 0) and T.Gold or T.Cyan, true, 0)
    if radValText then F.AnchorWidget(surface, radValText, PAD + 80, confY + 12, 170, 16, 7) end

    local radPresets = {
        { label = "All Map", val = 0 },
        { label = "50m",     val = 5000 },
        { label = "100m",    val = 10000 },
        { label = "250m",    val = 25000 },
        { label = "500m",    val = 50000 },
    }
    local rx = PAD + 256
    for _, rp in ipairs(radPresets) do
        local isSel = (currentRad == rp.val)
        local prefix = isSel and "• " or ""
        createGameButton(hostCanvas, surface, tree, prefix .. rp.label, rx, confY + 6, 88, 28, function()
            ctx.config.CollectRadius = rp.val
            renderAllContent()
        end, 60)
        rx = rx + 94
    end

    createGameButton(hostCanvas, surface, tree, "- 50m", rx + 8, confY + 6, 68, 28, function()
        ctx.config.CollectRadius = math.max(0, currentRad - 5000)
        renderAllContent()
    end, 60)

    createGameButton(hostCanvas, surface, tree, "+ 50m", rx + 80, confY + 6, 68, 28, function()
        ctx.config.CollectRadius = currentRad + 5000
        renderAllContent()
    end, 60)

    local limLabel = F.CreateText(tree, "LIMIT:", 11, T.TextSecond, true, 0)
    if limLabel then F.AnchorWidget(surface, limLabel, PAD + 16, confY + 48, 60, 16, 7) end

    local currentLim = ctx.config.MaxPerType or 0
    local limValStr  = (currentLim == 0) and "Unlimited" or (tostring(currentLim) .. " / Pal")
    local limValText = F.CreateText(tree, limValStr, 11, (currentLim == 0) and T.Gold or T.Cyan, true, 0)
    if limValText then F.AnchorWidget(surface, limValText, PAD + 80, confY + 48, 170, 16, 7) end

    local limPresets = {
        { label = "All",     val = 0 },
        { label = "1 / Pal", val = 1 },
        { label = "5 / Pal", val = 5 },
        { label = "10 / Pal",val = 10 },
        { label = "25 / Pal",val = 25 },
    }
    local lx = PAD + 256
    for _, lp in ipairs(limPresets) do
        local isSel = (currentLim == lp.val)
        local prefix = isSel and "• " or ""
        createGameButton(hostCanvas, surface, tree, prefix .. lp.label, lx, confY + 44, 88, 28, function()
            ctx.config.MaxPerType = lp.val
            renderAllContent()
        end, 60)
        lx = lx + 94
    end

    createGameButton(hostCanvas, surface, tree, "- 1", lx + 8, confY + 44, 68, 28, function()
        ctx.config.MaxPerType = math.max(0, currentLim - 1)
        renderAllContent()
    end, 60)

    createGameButton(hostCanvas, surface, tree, "+ 1", lx + 80, confY + 44, 68, 28, function()
        ctx.config.MaxPerType = currentLim + 1
        renderAllContent()
    end, 60)

    local gridY = confY + confH + 12
    local gridH = 390

    local gridBg = F.CreateSolidBorder(tree, T.PanelSection)
    if gridBg then F.AnchorWidget(surface, gridBg, PAD, gridY, contentW, gridH, 5) end
    F.DrawFrame(surface, tree, PAD, gridY, contentW, gridH, T.Divider)

    local gTitle = F.CreateText(tree, "PAL STATUE FILTERS", 12, T.TextPrimary, true, 0)
    if gTitle then F.AnchorWidget(surface, gTitle, PAD + 16, gridY + 10, 200, 16, 7) end

    local bulkW = 126
    local bulkH = 26
    local bulkY = gridY + 6
    local disX  = PAD + contentW - bulkW - 14
    local enX   = disX - bulkW - 10

    createGameButton(hostCanvas, surface, tree, "[+] ENABLE ALL", enX, bulkY, bulkW, bulkH, function()
        for _, def in ipairs(RELIC_CATALOG) do ctx.config.Relics[def.class] = true end
        renderAllContent()
    end, 60)

    createGameButton(hostCanvas, surface, tree, "[-] DISABLE ALL", disX, bulkY, bulkW, bulkH, function()
        for _, def in ipairs(RELIC_CATALOG) do ctx.config.Relics[def.class] = false end
        renderAllContent()
    end, 60)

    local cardPadX   = PAD + 14
    local cardStartY = gridY + 38
    local cols       = 3
    local gapX       = 12
    local gapY       = 10
    local cardW      = math.floor((contentW - 28 - (cols - 1) * gapX) / cols)
    local cardH      = 74

    for i, def in ipairs(RELIC_CATALOG) do
        local col = (i - 1) % cols
        local row = math.floor((i - 1) / cols)
        local cx  = cardPadX + col * (cardW + gapX)
        local cy  = cardStartY + row * (cardH + gapY)

        local isEnabled = (ctx.config.Relics[def.class] == true)
        local cardColor = isEnabled and T.CardActive or T.CardInactive

        local cBg = F.CreateSolidBorder(tree, cardColor)
        if cBg then F.AnchorWidget(surface, cBg, cx, cy, cardW, cardH, 6) end

        local barCol = isEnabled and def.color or T.TextDim
        local cBar = F.CreateSolidBorder(tree, barCol)
        if cBar then F.AnchorWidget(surface, cBar, cx, cy, 4, cardH, 7) end

        F.DrawFrame(surface, tree, cx, cy, cardW, cardH, isEnabled and T.BorderDefault or T.Divider)

        local pName = F.CreateText(tree, def.name, 13, isEnabled and T.TextPrimary or T.TextDim, true, 0)
        if pName then F.AnchorWidget(surface, pName, cx + 14, cy + 10, 160, 18, 8) end

        local pSub = F.CreateText(tree, def.sub, 9, T.TextDim, false, 0)
        if pSub then F.AnchorWidget(surface, pSub, cx + 14, cy + 32, 160, 14, 8) end

        local stateStr = isEnabled and "ENABLED" or "DISABLED"
        local stateCol = isEnabled and T.Green or T.Red
        local pState = F.CreateText(tree, stateStr, 10, stateCol, true, 0)
        if pState then F.AnchorWidget(surface, pState, cx + 14, cy + 48, 100, 14, 8) end

        local toggleLabel = isEnabled and "TURN OFF" or "TURN ON"
        createGameButton(hostCanvas, surface, tree, toggleLabel, cx + cardW - 102, cy + 18, 94, 38, function()
            ctx.config.Relics[def.class] = not isEnabled
            renderAllContent()
        end, 60)
    end

    local footerY = UI_H - PAD - 44
    local footLine = F.CreateSolidBorder(tree, T.Divider)
    if footLine then F.AnchorWidget(surface, footLine, PAD, footerY - 4, contentW, 1, 6) end

    local escHint = F.CreateText(tree, "Tip: Press ESC or Chat '!scollect' to toggle window", 10, T.TextDim, false, 0)
    if escHint then F.AnchorWidget(surface, escHint, PAD + 10, footerY + 12, 400, 16, 7) end

    createGameButton(hostCanvas, surface, tree, "CLOSE [ESC]", PAD + contentW - 150, footerY + 2, 150, 36, function()
        RelicUI.Presenter.Close()
    end, 60)
end

function RelicUI.Presenter.Show(context)
    RelicUI.Presenter.Close()

    local layout = RelicUI.Engine.LocateMainLayout()
    if not isObjectValid(layout) then printLog("Layout instance not found"); return end

    local tree = layout.WidgetTree
    if not isObjectValid(tree) then printLog("WidgetTree not found"); return end

    local layoutName = safeCall(function() return tree:GetFullName() end)
    if not layoutName then printLog("Unable to resolve layout name"); return end

    local hostCanvas = RelicUI.Engine.FindHostCanvas(layoutName, RelicUI.Assets.HostPanelName)
    if not isObjectValid(hostCanvas) then printLog("Host canvas panel missing"); return end

    local frame = assembleModalFrame(hostCanvas, tree, UI_W, UI_H)
    if not frame then return end

    local S = State
    S.activeShell   = frame.shell
    S.activeSurface = frame.surface
    S.widgetTree    = tree
    S.hostCanvas    = hostCanvas
    S.ctx           = context
    S.isDisplayed   = true

    renderAllContent()
    printLog("Control panel opened")
end

function RelicUI.Presenter.Close()
    local S = State
    if isObjectValid(S.activeShell) then
        local modalHost = RelicUI.Engine.AcquireModalSurface()
        if modalHost then
            pcall(function() modalHost:RemoveWidget(S.activeShell) end)
        end
    end
    S.activeShell   = nil
    S.activeSurface = nil
    S.widgetTree    = nil
    S.hostCanvas    = nil
    S.isDisplayed   = false
    ClickDispatcher.Reset()
end

function RelicUI.Presenter.IsVisible()
    return State.isDisplayed
end

return {
    show       = RelicUI.Presenter.Show,
    close      = RelicUI.Presenter.Close,
    is_visible = RelicUI.Presenter.IsVisible,
    Show       = RelicUI.Presenter.Show,
    Close      = RelicUI.Presenter.Close,
    IsVisible  = RelicUI.Presenter.IsVisible,
}
