-- ===========================================================================
--  TowerHunter :: Ancient Ruins Control UI
--  Framework adapted from the proven Relic Collector UI (relic_ui.lua)
-- ===========================================================================

local TowerUI = {
    Theme   = {},
    Assets  = {},
    Factory = {},
    Engine  = {},
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
    print("[TowerHunter][UI] " .. tostring(text) .. "\n")
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

TowerUI.Theme = {
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
    Orange        = hexToLinearColor("#FB923C", 1.00),
}

TowerUI.Assets = {
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

-- ------------------------------- Factory ---------------------------------

function TowerUI.Factory.CreateText(tree, message, fontSize, colorTuple, boldFont, justify)
    local cls = resolveStaticObject("/Script/UMG.TextBlock")
    if not cls then return nil end
    local widget = StaticConstructObject(cls, tree)
    if not isObjectValid(widget) then return nil end

    widget:SetText(FText(message or ""))
    widget:SetRenderOpacity(1.0)

    pcall(function()
        local fontInfo = widget.Font
        fontInfo.Size = fontSize or 11
        local fontAsset = resolveStaticObject(TowerUI.Assets.DefaultFont)
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

function TowerUI.Factory.CreateSolidBorder(tree, colorTuple)
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

function TowerUI.Factory.AnchorWidget(parentCanvas, childWidget, x, y, w, h, zOrder)
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

function TowerUI.Factory.AnchorCenter(parentCanvas, childWidget, w, h)
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

function TowerUI.Factory.DrawFrame(canvas, tree, x, y, w, h, color)
    local function line(lx, ly, lw, lh)
        local b = TowerUI.Factory.CreateSolidBorder(tree, color)
        if b then TowerUI.Factory.AnchorWidget(canvas, b, lx, ly, lw, lh, 1) end
    end
    line(x, y, w, 1)
    line(x, y + h - 1, w, 1)
    line(x, y, 1, h)
    line(x + w - 1, y, 1, h)
end

-- ------------------------------- Engine ----------------------------------

function TowerUI.Engine.LocateMainLayout()
    local ok, instances = pcall(FindAllOf, TowerUI.Assets.OverallLayout)
    if ok and instances and #instances > 0 then return instances[1] end
    return nil
end

function TowerUI.Engine.FindHostCanvas(outerFullName, panelName)
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

function TowerUI.Engine.DiscoverNamedSlot(windowObj)
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

function TowerUI.Engine.MuteUnusedChrome(windowObj)
    local slot = TowerUI.Engine.DiscoverNamedSlot(windowObj)
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

function TowerUI.Engine.AcquireModalSurface()
    local layout = TowerUI.Engine.LocateMainLayout()
    if not isObjectValid(layout) then return nil end
    local ok, modalLayer = pcall(function() return layout.Modal end)
    if ok and isObjectValid(modalLayer) then return modalLayer end
    return nil
end

local function assembleModalFrame(panel, tree, frameWidth, frameHeight)
    local winCls     = resolveStaticObject(TowerUI.Assets.WindowBlueprint)
    local canvasCls  = resolveStaticObject("/Script/UMG.CanvasPanel")
    local sizeBoxCls = resolveStaticObject("/Script/UMG.SizeBox")
    local widgetLib  = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    local modalHost  = TowerUI.Engine.AcquireModalSurface()

    if not winCls or not canvasCls or not sizeBoxCls or not widgetLib or not modalHost then
        printLog("Core UMG classes missing for modal")
        return nil
    end

    local frameShell, contentSurface
    local ok, err = pcall(function()
        local player = panel:GetOwningPlayer()
        frameShell = modalHost:BP_AddWidget(winCls)
        if not isObjectValid(frameShell) then error("Modal host rejected widget") end

        TowerUI.Engine.MuteUnusedChrome(frameShell)
        local shellSlot = TowerUI.Engine.DiscoverNamedSlot(frameShell)
        if not shellSlot then error("Shell slot missing") end

        local innerWindow = widgetLib:Create(panel, winCls, player)
        if not isObjectValid(innerWindow) then error("Inner window failed") end

        local innerSlot = TowerUI.Engine.DiscoverNamedSlot(innerWindow)
        if not innerSlot then error("Inner slot missing") end

        contentSurface = StaticConstructObject(canvasCls, tree)
        local frameBox = StaticConstructObject(sizeBoxCls, tree)
        frameBox:SetWidthOverride(frameWidth)
        frameBox:SetHeightOverride(frameHeight)
        frameBox:SetContent(contentSurface)
        innerSlot:SetContent(frameBox)

        local hostCanvas = StaticConstructObject(canvasCls, tree)
        shellSlot:SetContent(hostCanvas)
        TowerUI.Factory.AnchorCenter(hostCanvas, innerWindow, frameWidth, frameHeight)
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
                TowerUI.Factory.AnchorWidget(contentSurface, blur, 0, 0, frameWidth, frameHeight, 0)
            end
        end
        local base = TowerUI.Factory.CreateSolidBorder(tree, TowerUI.Theme.PanelBase)
        if base then TowerUI.Factory.AnchorWidget(contentSurface, base, 0, 0, frameWidth, frameHeight, 1) end
    end)

    return { shell = frameShell, surface = contentSurface }
end

local function createGameButton(hostCanvas, surface, tree, label, x, y, w, h, onClick, z)
    local btnCls    = resolveStaticObject(TowerUI.Assets.ButtonBlueprint)
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

    TowerUI.Factory.AnchorWidget(surface, btn, x, y, w, h, z or 60)

    local target = btn
    local okIn, inner = pcall(function() return btn.WBP_PalInvisibleButton end)
    if okIn and isObjectValid(inner) then target = inner end
    ClickDispatcher.Subscribe(target, onClick)

    return btn
end

-- ------------------------------ Rendering --------------------------------

local UI_W = 1000
local UI_H = 800
local PAD  = 16

local State = {
    activeShell   = nil,
    activeSurface = nil,
    widgetTree    = nil,
    hostCanvas    = nil,
    isDisplayed   = false,
    ctx           = nil,
}

local function fmtInt(n)
    return string.format("%.0f", n)
end

local function renderAllContent()
    if not isObjectValid(State.activeSurface) or not isObjectValid(State.widgetTree) then return end

    local S   = State
    local F   = TowerUI.Factory
    local T   = TowerUI.Theme
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

    -- ===== header =====
    local headerH = 46
    local headerBg = F.CreateSolidBorder(tree, T.PanelHeader)
    if headerBg then F.AnchorWidget(surface, headerBg, PAD, PAD, contentW, headerH, 5) end
    F.DrawFrame(surface, tree, PAD, PAD, contentW, headerH, T.BorderDefault)

    local goldLine = F.CreateSolidBorder(tree, T.Gold)
    if goldLine then F.AnchorWidget(surface, goldLine, PAD, PAD + headerH - 2, contentW, 2, 6) end

    local title = F.CreateText(tree, "TOWER HUNTER — ANCIENT RUINS", 16, T.TextPrimary, true, 0)
    if title then F.AnchorWidget(surface, title, PAD + 16, PAD + 12, 420, 24, 7) end

    local stats = ctx.getStats()
    local sub = F.CreateText(tree, stats, 11, T.TextSecond, false, 2)
    if sub then F.AnchorWidget(surface, sub, PAD + contentW - 420, PAD + 16, 404, 16, 7) end

    -- ===== action bar =====
    local actionsY = PAD + headerH + 10
    local actionsH = 50

    local actBg = F.CreateSolidBorder(tree, T.PanelSection)
    if actBg then F.AnchorWidget(surface, actBg, PAD, actionsY, contentW, actionsH, 5) end
    F.DrawFrame(surface, tree, PAD, actionsY, contentW, actionsH, T.Divider)

    local actLabel = F.CreateText(tree, "ACTIONS:", 11, T.TextDim, true, 0)
    if actLabel then F.AnchorWidget(surface, actLabel, PAD + 16, actionsY + 17, 84, 16, 7) end

    createGameButton(hostCanvas, surface, tree, "RESCAN", PAD + 104, actionsY + 8, 130, 34, function()
        if ctx.onRescan then ctx.onRescan() end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "TP NEAREST", PAD + 244, actionsY + 8, 150, 34, function()
        if ctx.onTpNearest then ctx.onTpNearest() end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "SORT: " .. (ctx.getSortLabel and ctx.getSortLabel() or "?"),
            PAD + 404, actionsY + 8, 150, 34, function()
        if ctx.onCycleSort then ctx.onCycleSort() end
    end, 60)

    createGameButton(hostCanvas, surface, tree, "?", PAD + contentW - 46, actionsY + 8, 36, 34, function()
        if ctx.onHelp then ctx.onHelp() end
    end, 60)

    -- ===== tower list =====
    local listY = actionsY + actionsH + 10
    local listH = 470

    local listBg = F.CreateSolidBorder(tree, T.PanelSection)
    if listBg then F.AnchorWidget(surface, listBg, PAD, listY, contentW, listH, 5) end
    F.DrawFrame(surface, tree, PAD, listY, contentW, listH, T.Divider)

    local gTitle = F.CreateText(tree, "TOWERS  (press F on a tower - the mod wins the mini-game for you; fights and rocks are yours)", 12, T.TextPrimary, true, 0)
    if gTitle then F.AnchorWidget(surface, gTitle, PAD + 16, listY + 10, 640, 16, 7) end

    local towers, page, pageSize = ctx.getTowers(), ctx.getPage(), ctx.getPageSize()
    local totalPages = math.max(1, math.ceil(#towers / pageSize))
    if page > totalPages then page = totalPages; ctx.setPage(page) end

    local rowH  = 56
    local rowX  = PAD + 14
    local rows  = math.min(pageSize, math.max(0, #towers - (page - 1) * pageSize))

    for i = 1, rows do
        local idx = (page - 1) * pageSize + i
        local tw  = towers[idx]
        if tw == nil then break end

        local cy = listY + 34 + (i - 1) * rowH
        local rowW = contentW - 28

        local st = ctx.getTowerState(tw)

        -- status colors by state kind
        local pal
        if st.stateKind == "done" then
            pal = { bg = T.CardActive, bar = T.Gold, text = T.Gold }
        elseif st.stateKind == "open" then
            pal = { bg = T.CardActive, bar = T.Green, text = T.Green }
        elseif st.stateKind == "locked" then
            pal = { bg = T.CardInactive, bar = T.Red, text = T.Red }
        else
            pal = { bg = T.CardInactive, bar = T.Purple, text = T.Purple }
        end

        local rowBg = F.CreateSolidBorder(tree, pal.bg)
        if rowBg then F.AnchorWidget(surface, rowBg, rowX, cy, rowW, rowH - 6, 6) end

        local bar = F.CreateSolidBorder(tree, pal.bar)
        if bar then F.AnchorWidget(surface, bar, rowX, cy, 4, rowH - 6, 7) end

        F.DrawFrame(surface, tree, rowX, cy, rowW, rowH - 6, T.Divider)

        local nameText = F.CreateText(tree, string.format("#%d  %s", idx, st.name), 13, T.TextPrimary, true, 0)
        if nameText then F.AnchorWidget(surface, nameText, rowX + 14, cy + 6, 330, 18, 8) end

        local locText = F.CreateText(tree, st.coords, 10, T.TextDim, false, 0)
        if locText then F.AnchorWidget(surface, locText, rowX + 14, cy + 30, 330, 14, 8) end

        local stateText = F.CreateText(tree, st.state, 10, pal.text, true, 0)
        if stateText then F.AnchorWidget(surface, stateText, rowX + 350, cy + 8, 190, 40, 8) end

        local bx = rowX + rowW - 190
        createGameButton(hostCanvas, surface, tree, st.done and "[v] DONE" or "[ ] MARK", bx, cy + 11, 110, 30, function()
            if ctx.onToggleDone then ctx.onToggleDone(tw) end
        end, 60)

        createGameButton(hostCanvas, surface, tree, "TP", bx + 116, cy + 11, 56, 30, function()
            if ctx.onTeleport then ctx.onTeleport(tw) end
        end, 60)
    end

    -- ===== pagination =====
    local pagY = listY + listH + 8
    local pagH = 44

    local pagBg = F.CreateSolidBorder(tree, T.PanelSection)
    if pagBg then F.AnchorWidget(surface, pagBg, PAD, pagY, contentW, pagH, 5) end
    F.DrawFrame(surface, tree, PAD, pagY, contentW, pagH, T.Divider)

    createGameButton(hostCanvas, surface, tree, "<< PREV", PAD + 16, pagY + 6, 110, 32, function()
        if ctx.onPrev then ctx.onPrev() end
    end, 60)

    local pageText = F.CreateText(tree, string.format("PAGE %d / %d   (%d towers)", page, totalPages, #towers), 12, T.TextSecond, true, 0)
    if pageText then F.AnchorWidget(surface, pageText, PAD + 180, pagY + 12, 300, 18, 7) end

    createGameButton(hostCanvas, surface, tree, "NEXT >>", PAD + contentW - 126, pagY + 6, 110, 32, function()
        if ctx.onNext then ctx.onNext() end
    end, 60)

    -- ===== footer =====
    local footerY = UI_H - PAD - 40
    local footLine = F.CreateSolidBorder(tree, T.Divider)
    if footLine then F.AnchorWidget(surface, footLine, PAD, footerY - 4, contentW, 1, 6) end

    local escHint = F.CreateText(tree, "F6 or ESC toggles this window  |  !th in chat", 10, T.TextDim, false, 0)
    if escHint then F.AnchorWidget(surface, escHint, PAD + 10, footerY + 10, 420, 16, 7) end

    createGameButton(hostCanvas, surface, tree, "CLOSE [ESC]", PAD + contentW - 150, footerY + 2, 150, 34, function()
        TowerUI.Presenter.Close()
    end, 60)
end

function TowerUI.Presenter.Refresh()
    if State.isDisplayed then
        renderAllContent()
    end
end

function TowerUI.Presenter.Show(context)
    TowerUI.Presenter.Close()

    local layout = TowerUI.Engine.LocateMainLayout()
    if not isObjectValid(layout) then printLog("Layout instance not found"); return end

    local tree = layout.WidgetTree
    if not isObjectValid(tree) then printLog("WidgetTree not found"); return end

    local layoutName = safeCall(function() return tree:GetFullName() end)
    if not layoutName then printLog("Unable to resolve layout name"); return end

    local hostCanvas = TowerUI.Engine.FindHostCanvas(layoutName, TowerUI.Assets.HostPanelName)
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

function TowerUI.Presenter.Close()
    local S = State
    if isObjectValid(S.activeShell) then
        local modalHost = TowerUI.Engine.AcquireModalSurface()
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

function TowerUI.Presenter.IsVisible()
    return State.isDisplayed
end

return {
    show       = TowerUI.Presenter.Show,
    close      = TowerUI.Presenter.Close,
    is_visible = TowerUI.Presenter.IsVisible,
    refresh    = TowerUI.Presenter.Refresh,
    Show       = TowerUI.Presenter.Show,
    Close      = TowerUI.Presenter.Close,
    IsVisible  = TowerUI.Presenter.IsVisible,
    Refresh    = TowerUI.Presenter.Refresh,
}
