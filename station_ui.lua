-- ===========================================================================
--  Station Switch :: Workstation Control Panel UI
-- ===========================================================================

local StationUI = {
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
    print("[StationSwitch][UI] " .. tostring(text))
end

local function ellipsize(str, maxLen)
    str = tostring(str or "")
    if #str <= maxLen then return str end
    return str:sub(1, math.max(1, maxLen - 2)) .. ".."
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

local function withAlpha(col, a)
    return { col[1], col[2], col[3], a }
end

StationUI.Theme = {
    PanelBase     = hexToLinearColor("#131A1D", 0.95),
    PanelHeader   = hexToLinearColor("#26333A", 1.00),
    PanelSection  = hexToLinearColor("#192226", 0.90),
    PanelList     = hexToLinearColor("#0F1518", 0.75),
    CardBase      = hexToLinearColor("#1D262B", 0.96),
    CardActive    = hexToLinearColor("#1D2B24", 0.96),
    CardPaused    = hexToLinearColor("#2D1D1E", 0.96),
    Divider       = hexToLinearColor("#314046", 1.00),
    BorderDefault = hexToLinearColor("#42555C", 1.00),

    TextPrimary   = hexToLinearColor("#EAF2F6", 1.00),
    TextSecond    = hexToLinearColor("#9DB0B9", 1.00),
    TextDim       = hexToLinearColor("#6C808A", 1.00),

    Gold          = hexToLinearColor("#FFC53D", 1.00),
    Green         = hexToLinearColor("#4ADE80", 1.00),
    Red           = hexToLinearColor("#F87171", 1.00),
    Blue          = hexToLinearColor("#7DD3FC", 1.00),
    Cyan          = hexToLinearColor("#22D3EE", 1.00),
    Orange        = hexToLinearColor("#FB923C", 1.00),
    Purple        = hexToLinearColor("#C084FC", 1.00),
}

StationUI.Assets = {
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

function StationUI.Factory.CreateText(tree, message, fontSize, colorTuple, boldFont, justify)
    local cls = resolveStaticObject("/Script/UMG.TextBlock")
    if not cls then return nil end
    local widget = StaticConstructObject(cls, tree)
    if not isObjectValid(widget) then return nil end

    widget:SetText(FText(message or ""))
    widget:SetRenderOpacity(1.0)

    pcall(function()
        local fontInfo = widget.Font
        fontInfo.Size = fontSize or 11
        local fontAsset = resolveStaticObject(StationUI.Assets.DefaultFont)
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

function StationUI.Factory.CreateSolidBorder(tree, colorTuple)
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

function StationUI.Factory.CreateScrollArea(tree)
    local cls = resolveStaticObject("/Script/UMG.ScrollBox")
    if not cls then return nil end
    local scroll = StaticConstructObject(cls, tree)
    if not isObjectValid(scroll) then return nil end

    scroll:SetRenderOpacity(1.0)
    pcall(function()
        local thickness = scroll.ScrollbarThickness
        thickness.X, thickness.Y = 6, 6
        scroll.ScrollbarThickness = thickness
    end)
    return scroll
end

function StationUI.Factory.CreateContainerBox(tree, width, height, innerContent)
    local cls = resolveStaticObject("/Script/UMG.SizeBox")
    if not cls then return nil end
    local box = StaticConstructObject(cls, tree)
    if not isObjectValid(box) then return nil end

    if width then box:SetWidthOverride(width) end
    if height then box:SetHeightOverride(height) end
    if innerContent then box:SetContent(innerContent) end
    return box
end

function StationUI.Factory.AnchorWidget(parentCanvas, childWidget, x, y, w, h, zOrder)
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

function StationUI.Factory.AnchorCenter(parentCanvas, childWidget, w, h)
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

function StationUI.Factory.DrawFrame(canvas, tree, x, y, w, h, color)
    local function line(lx, ly, lw, lh)
        local b = StationUI.Factory.CreateSolidBorder(tree, color)
        if b then StationUI.Factory.AnchorWidget(canvas, b, lx, ly, lw, lh, 1) end
    end
    line(x, y, w, 1)
    line(x, y + h - 1, w, 1)
    line(x, y, 1, h)
    line(x + w - 1, y, 1, h)
end

function StationUI.Engine.LocateMainLayout()
    local ok, instances = pcall(FindAllOf, StationUI.Assets.OverallLayout)
    if ok and instances and #instances > 0 then return instances[1] end
    return nil
end

function StationUI.Engine.FindHostCanvas(outerFullName, panelName)
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

function StationUI.Engine.DiscoverNamedSlot(windowObj)
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

function StationUI.Engine.MuteUnusedChrome(windowObj)
    local slot = StationUI.Engine.DiscoverNamedSlot(windowObj)
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

function StationUI.Engine.AcquireModalSurface()
    local layout = StationUI.Engine.LocateMainLayout()
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
    local winCls     = resolveStaticObject(StationUI.Assets.WindowBlueprint)
    local canvasCls  = resolveStaticObject("/Script/UMG.CanvasPanel")
    local sizeBoxCls = resolveStaticObject("/Script/UMG.SizeBox")
    local widgetLib  = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    local modalHost  = StationUI.Engine.AcquireModalSurface()

    if not winCls or not canvasCls or not sizeBoxCls or not widgetLib or not modalHost then
        printLog("Core UMG classes missing for modal")
        return nil
    end

    local frameShell, contentSurface
    local ok, err = pcall(function()
        local player = panel:GetOwningPlayer()
        frameShell = modalHost:BP_AddWidget(winCls)
        if not isObjectValid(frameShell) then error("Modal host rejected widget") end

        StationUI.Engine.MuteUnusedChrome(frameShell)
        local shellSlot = StationUI.Engine.DiscoverNamedSlot(frameShell)
        if not shellSlot then error("Shell slot missing") end

        local innerWindow = widgetLib:Create(panel, winCls, player)
        if not isObjectValid(innerWindow) then error("Inner window failed") end

        local innerSlot = StationUI.Engine.DiscoverNamedSlot(innerWindow)
        if not innerSlot then error("Inner slot missing") end

        contentSurface = StaticConstructObject(canvasCls, tree)
        local frameBox = StaticConstructObject(sizeBoxCls, tree)
        frameBox:SetWidthOverride(frameWidth)
        frameBox:SetHeightOverride(frameHeight)
        frameBox:SetContent(contentSurface)
        innerSlot:SetContent(frameBox)

        local hostCanvas = StaticConstructObject(canvasCls, tree)
        shellSlot:SetContent(hostCanvas)
        StationUI.Factory.AnchorCenter(hostCanvas, innerWindow, frameWidth, frameHeight)
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
                StationUI.Factory.AnchorWidget(contentSurface, blur, 0, 0, frameWidth, frameHeight, 0)
            end
        end
        local base = StationUI.Factory.CreateSolidBorder(tree, StationUI.Theme.PanelBase)
        if base then StationUI.Factory.AnchorWidget(contentSurface, base, 0, 0, frameWidth, frameHeight, 1) end
    end)

    return { shell = frameShell, surface = contentSurface }
end

local function createGameButton(hostCanvas, surface, tree, label, x, y, w, h, onClick, z)
    local btnCls    = resolveStaticObject(StationUI.Assets.ButtonBlueprint)
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

    StationUI.Factory.AnchorWidget(surface, btn, x, y, w, h, z or 60)

    local target = btn
    local okIn, inner = pcall(function() return btn.WBP_PalInvisibleButton end)
    if okIn and isObjectValid(inner) then target = inner end
    ClickDispatcher.Subscribe(target, onClick)

    return btn
end

local UI_W = 960
local UI_H = 780
local PAD  = 16

local State = {
    activeShell   = nil,
    activeSurface = nil,
    widgetTree    = nil,
    hostCanvas    = nil,
    isDisplayed   = false,
    ctx           = nil,

    filterMode    = "all",
    scrollBox     = nil,
}

local FILTERS = {
    { key = "all",      label = "ALL" },
    { key = "paused",   label = "PAUSED" },
    { key = "active",   label = "ACTIVE" },
    { key = "mining",   label = "MINING/WOOD" },
    { key = "farm",     label = "FARMS" },
    { key = "crafting", label = "CRAFTING" },
}

local renderAllContent

local function drawStationCard(scrollBox, tree, hostCanvas, item, cardW, ctx)
    local canvasCls = resolveStaticObject("/Script/UMG.CanvasPanel")
    if not canvasCls then return end
    local card = StaticConstructObject(canvasCls, tree)
    if not isObjectValid(card) then return end
    card:SetRenderOpacity(1.0)

    local F, T = StationUI.Factory, StationUI.Theme
    local cardH = 58
    local isPaused = (item.isPaused == true)

    local bgColor = isPaused and T.CardPaused or T.CardActive
    local bg = F.CreateSolidBorder(tree, bgColor)
    if bg then F.AnchorWidget(card, bg, 0, 0, cardW, cardH, 0) end

    local barColor = isPaused and T.Red or T.Green
    local bar = F.CreateSolidBorder(tree, barColor)
    if bar then F.AnchorWidget(card, bar, 0, 0, 4, cardH, 1) end

    F.DrawFrame(card, tree, 0, 0, cardW, cardH, isPaused and T.Red or T.BorderDefault)

    local catIcon = "🔨"
    if item.category == "mining" then catIcon = "⛏"
    elseif item.category == "logging" then catIcon = "🪓"
    elseif item.category == "farm" then catIcon = "🌾"
    elseif item.category == "ranch" then catIcon = "🐑"
    end

    local iconTxt = F.CreateText(tree, catIcon, 14, isPaused and T.Red or T.Green, false, 1)
    if iconTxt then F.AnchorWidget(card, iconTxt, 12, 18, 24, 20, 2) end

    local nameTxt = F.CreateText(tree, ellipsize(item.name, 38), 13, T.TextPrimary, true, 0)
    if nameTxt then F.AnchorWidget(card, nameTxt, 44, 10, 360, 18, 2) end

    local catLabel = (item.category:upper()) .. "  |  " .. (item.modelId or "Station")
    local subTxt = F.CreateText(tree, ellipsize(catLabel, 48), 9, T.TextDim, false, 0)
    if subTxt then F.AnchorWidget(card, subTxt, 44, 32, 360, 14, 2) end

    local statusText = isPaused and "⏸ PAUSED (OFFLINE)" or "▶ ACTIVE (WORKING)"
    local statusCol  = isPaused and T.Red or T.Green
    local pillBg = F.CreateSolidBorder(tree, withAlpha(statusCol, 0.15))
    if pillBg then F.AnchorWidget(card, pillBg, cardW - 270, 15, 130, 26, 2) end

    local pillTxt = F.CreateText(tree, statusText, 9, statusCol, true, 1)
    if pillTxt then F.AnchorWidget(card, pillTxt, cardW - 270, 20, 130, 14, 3) end

    local btnLabel = isPaused and "▶ RESUME" or "⏸ PAUSE"
    createGameButton(hostCanvas, card, tree, btnLabel, cardW - 126, 11, 114, 34, function()
        if ctx.onToggleItem then
            ctx.onToggleItem(item, function()
                renderAllContent()
            end)
            renderAllContent()
        end
    end, 60)

    local wrap = F.CreateContainerBox(tree, cardW, cardH + 6, card)
    if wrap then pcall(function() scrollBox:AddChild(wrap) end) end
end

local function drawNoticeCard(scrollBox, tree, cardW, message)
    local canvasCls = resolveStaticObject("/Script/UMG.CanvasPanel")
    if not canvasCls then return end
    local canvas = StaticConstructObject(canvasCls, tree)
    if not isObjectValid(canvas) then return end

    local F, T = StationUI.Factory, StationUI.Theme
    local h = 90
    local bg = F.CreateSolidBorder(tree, T.CardBase)
    if bg then F.AnchorWidget(canvas, bg, 0, 0, cardW, h, 0) end
    local txt = F.CreateText(tree, message, 12, T.TextSecond, false, 1)
    if txt then F.AnchorWidget(canvas, txt, 0, h / 2 - 10, cardW, 20, 2) end

    local wrap = F.CreateContainerBox(tree, cardW, h + 6, canvas)
    if wrap then pcall(function() scrollBox:AddChild(wrap) end) end
end

renderAllContent = function()
    if not isObjectValid(State.activeSurface) or not isObjectValid(State.widgetTree) then return end

    local S   = State
    local F   = StationUI.Factory
    local T   = StationUI.Theme
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

    local allStations = (ctx.getStations and ctx.getStations()) or {}
    local pausedCount = 0
    for _, s in ipairs(allStations) do
        if s.isPaused then pausedCount = pausedCount + 1 end
    end

    local headerH = 46
    local headerBg = F.CreateSolidBorder(tree, T.PanelHeader)
    if headerBg then F.AnchorWidget(surface, headerBg, PAD, PAD, contentW, headerH, 5) end
    F.DrawFrame(surface, tree, PAD, PAD, contentW, headerH, T.BorderDefault)

    local cyanLine = F.CreateSolidBorder(tree, T.Cyan)
    if cyanLine then F.AnchorWidget(surface, cyanLine, PAD, PAD + headerH - 2, contentW, 2, 6) end

    local title = F.CreateText(tree, "STATION SWITCH :: WORKSTATION MANAGER", 16, T.TextPrimary, true, 0)
    if title then F.AnchorWidget(surface, title, PAD + 16, PAD + 12, 420, 24, 7) end

    local subText = string.format("Base Stations: %d  |  Paused: %d", #allStations, pausedCount)
    local sub = F.CreateText(tree, subText, 11, pausedCount > 0 and T.Orange or T.Green, false, 2)
    if sub then F.AnchorWidget(surface, sub, PAD + contentW - 320, PAD + 16, 304, 16, 7) end

    local actionsY = PAD + headerH + 10
    local actionsH = 50

    local actBg = F.CreateSolidBorder(tree, T.PanelSection)
    if actBg then F.AnchorWidget(surface, actBg, PAD, actionsY, contentW, actionsH, 5) end
    F.DrawFrame(surface, tree, PAD, actionsY, contentW, actionsH, T.Divider)

    local actLabel = F.CreateText(tree, "QUICK ACTIONS:", 11, T.TextDim, true, 0)
    if actLabel then F.AnchorWidget(surface, actLabel, PAD + 14, actionsY + 17, 110, 16, 7) end

    createGameButton(hostCanvas, surface, tree, "▶ RESUME ALL", PAD + 130, actionsY + 8, 160, 34, function()
        if ctx.onResumeAll then
            ctx.onResumeAll(function() renderAllContent() end)
            renderAllContent()
        end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "⛏ PAUSE MINING/WOOD", PAD + 300, actionsY + 8, 220, 34, function()
        if ctx.onPauseMiningWood then
            ctx.onPauseMiningWood(function() renderAllContent() end)
            renderAllContent()
        end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "🌾 PAUSE FARMS", PAD + 530, actionsY + 8, 170, 34, function()
        if ctx.onPauseFarms then
            ctx.onPauseFarms(function() renderAllContent() end)
            renderAllContent()
        end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "⚡ SCAN BASE", PAD + contentW - 146, actionsY + 8, 132, 34, function()
        renderAllContent()
    end, 60)

    local filterY = actionsY + actionsH + 10
    local filterH = 34
    local fx = PAD
    local fBtnW = 144
    local fGap = 12

    for _, def in ipairs(FILTERS) do
        local key = def.key
        local isSel = (S.filterMode == key)
        local count = 0
        for _, s in ipairs(allStations) do
            if key == "all" then count = count + 1
            elseif key == "paused" and s.isPaused then count = count + 1
            elseif key == "active" and not s.isPaused then count = count + 1
            elseif key == "mining" and (s.category == "mining" or s.category == "logging") then count = count + 1
            elseif key == "farm" and (s.category == "farm" or s.category == "ranch") then count = count + 1
            elseif key == "crafting" and s.category == "crafting" then count = count + 1
            end
        end

        local btnText = def.label .. " (" .. count .. ")"
        createGameButton(hostCanvas, surface, tree, btnText, fx, filterY, fBtnW, filterH, function()
            S.filterMode = key
            renderAllContent()
        end, 60)

        if isSel then
            local selMark = F.CreateSolidBorder(tree, T.Cyan)
            if selMark then F.AnchorWidget(surface, selMark, fx + 8, filterY + filterH - 3, fBtnW - 16, 3, 70) end
        end

        fx = fx + fBtnW + fGap
    end

    local listY = filterY + filterH + 10
    local listH = UI_H - listY - 56

    local listBg = F.CreateSolidBorder(tree, T.PanelList)
    if listBg then F.AnchorWidget(surface, listBg, PAD, listY, contentW, listH, 5) end
    F.DrawFrame(surface, tree, PAD, listY, contentW, listH, T.Divider)

    local scroll = F.CreateScrollArea(tree)
    if scroll then
        F.AnchorWidget(surface, scroll, PAD + 8, listY + 8, contentW - 16, listH - 16, 10)
    end

    local displayList = {}
    for _, s in ipairs(allStations) do
        local keep = true
        if S.filterMode == "paused" then keep = s.isPaused
        elseif S.filterMode == "active" then keep = not s.isPaused
        elseif S.filterMode == "mining" then keep = (s.category == "mining" or s.category == "logging")
        elseif S.filterMode == "farm" then keep = (s.category == "farm" or s.category == "ranch")
        elseif S.filterMode == "crafting" then keep = (s.category == "crafting")
        end
        if keep then displayList[#displayList + 1] = s end
    end

    local cardW = contentW - 28
    if #displayList == 0 then
        local emptyMsg = (#allStations == 0)
            and "No workstations detected. Make sure you are inside your Base Camp!"
            or "No stations match the selected filter."
        drawNoticeCard(scroll, tree, cardW, emptyMsg)
    else
        for _, item in ipairs(displayList) do
            drawStationCard(scroll, tree, hostCanvas, item, cardW, ctx)
        end
    end

    local footerY = UI_H - PAD - 38
    local footLine = F.CreateSolidBorder(tree, T.Divider)
    if footLine then F.AnchorWidget(surface, footLine, PAD, footerY - 4, contentW, 1, 6) end

    local tipTxt = F.CreateText(tree, "Tip: Look at any station & press F6 to toggle instantly | ESC to close", 10, T.TextDim, false, 0)
    if tipTxt then F.AnchorWidget(surface, tipTxt, PAD + 10, footerY + 8, 480, 16, 7) end

    local toastLabel = (ctx.config.EnableChatToast and "TOASTS: ON" or "TOASTS: OFF")
    createGameButton(hostCanvas, surface, tree, toastLabel, PAD + contentW - 300, footerY - 2, 136, 32, function()
        ctx.config.EnableChatToast = not ctx.config.EnableChatToast
        renderAllContent()
    end, 60)

    createGameButton(hostCanvas, surface, tree, "CLOSE [ESC]", PAD + contentW - 150, footerY - 2, 150, 32, function()
        StationUI.Presenter.Close()
    end, 60)
end

function StationUI.Presenter.Show(context)
    StationUI.Presenter.Close()

    local layout = StationUI.Engine.LocateMainLayout()
    if not isObjectValid(layout) then printLog("Layout instance not found"); return end

    local tree = layout.WidgetTree
    if not isObjectValid(tree) then printLog("WidgetTree not found"); return end

    local layoutName = safeCall(function() return tree:GetFullName() end)
    if not layoutName then printLog("Unable to resolve layout name"); return end

    local hostCanvas = StationUI.Engine.FindHostCanvas(layoutName, StationUI.Assets.HostPanelName)
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
    printLog("Workstation Manager opened")
end

function StationUI.Presenter.Close()
    local S = State
    if isObjectValid(S.activeShell) then
        local modalHost = StationUI.Engine.AcquireModalSurface()
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

function StationUI.Presenter.IsVisible()
    return State.isDisplayed
end

return {
    show       = StationUI.Presenter.Show,
    close      = StationUI.Presenter.Close,
    is_visible = StationUI.Presenter.IsVisible,
    Show       = StationUI.Presenter.Show,
    Close      = StationUI.Presenter.Close,
    IsVisible  = StationUI.Presenter.IsVisible,
}
