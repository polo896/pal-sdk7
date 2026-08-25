local colors = require("ui_common_colors")
local layout = require("ui_common_layout")
local primitives = require("ui_common_primitives")
local util = require("util")
local M = {}
local HEADER_BLOCK_BORDER_R, HEADER_BLOCK_BORDER_G, HEADER_BLOCK_BORDER_B = colors.SrgbToLinear(colors.HexColor("#9CA2A2"))
local HEADER_BLOCK_FILL_R, HEADER_BLOCK_FILL_G, HEADER_BLOCK_FILL_B = colors.SrgbToLinear(colors.HexColor("#394445"))
local HEADER_BLOCK_TEXT_R, HEADER_BLOCK_TEXT_G, HEADER_BLOCK_TEXT_B = colors.SrgbToLinear(colors.HexColor("#E5FBFF"))
function M.ApplyHeaderTitleColor(textBlock)
  primitives.SetTextColor(textBlock, HEADER_BLOCK_TEXT_R, HEADER_BLOCK_TEXT_G, HEADER_BLOCK_TEXT_B)
end
local HEADER_BLOCK_H_SCREEN = 42
local HEADER_BLOCK_BORDER_SCREEN = 1
local HEADER_BLOCK_DOT_SCREEN = 2
function M.HeaderBlockMetrics(panel)
  return {
    h = layout.ScreenPxToSlate(panel, HEADER_BLOCK_H_SCREEN),
    border = layout.ScreenPxToSlate(panel, HEADER_BLOCK_BORDER_SCREEN),
    dot = layout.ScreenPxToSlate(panel, HEADER_BLOCK_DOT_SCREEN),
  }
end
local function DrawBorderEdges(Panel, x, y, w, h, thickness)
  Panel(x, y, w, thickness) 
  Panel(x, y + h - thickness, w, thickness) 
  Panel(x, y, thickness, h) 
  Panel(x + w - thickness, y, thickness, h) 
end
function M.ConstructHeaderBlock(tree, contentPanel, x, y, w, metrics, titleText, decorations)
  local function track(widget)
    if decorations then decorations[#decorations + 1] = widget end
    return widget
  end
  local function Panel(r, g, b, px, py, pw, ph)
    local p = primitives.ConstructColorPanel(tree, r, g, b, 1.0)
    layout.PlaceAt(contentPanel, p, px, py, pw, ph)
    track(p)
    return p
  end
  Panel(HEADER_BLOCK_FILL_R, HEADER_BLOCK_FILL_G, HEADER_BLOCK_FILL_B, x, y, w, metrics.h)
  DrawBorderEdges(function(px, py, pw, ph)
    Panel(HEADER_BLOCK_BORDER_R, HEADER_BLOCK_BORDER_G, HEADER_BLOCK_BORDER_B, px, py, pw, ph)
  end, x, y, w, metrics.h, metrics.border)
  local hd = metrics.dot
  for _, corner in ipairs({
    { x = x, y = y },
    { x = x + w - hd, y = y },
    { x = x, y = y + metrics.h - hd },
    { x = x + w - hd, y = y + metrics.h - hd },
  }) do
    Panel(1.0, 1.0, 1.0, corner.x, corner.y, hd, hd)
  end
  local title = primitives.ConstructTextBlock(tree, titleText)
  primitives.ApplyHeaderTitleFont(title)
  M.ApplyHeaderTitleColor(title)
  local TITLE_TEXT_H = 24
  layout.PlaceAt(contentPanel, title, x + 12, y + (metrics.h - TITLE_TEXT_H) / 2, w - 24, TITLE_TEXT_H)
  track(title)
  return title
end
function M.ConstructOverlayLabel(tree, panel, text, x, y, w, h, opts)
  opts = opts or {}
  local label = primitives.ConstructTextBlock(tree, text)
  primitives.ApplyHeaderTitleFont(label)
  if opts.fontSize then
    primitives.TryCall("overlay label font size override", function()
      local font = label.Font
      font.Size = opts.fontSize
      label.Font = font
    end)
  end
  if opts.color then
    primitives.SetTextColor(label, opts.color[1], opts.color[2], opts.color[3])
  end
  pcall(function() label:SetJustification(opts.justify or 0) end)
  pcall(function() label:SetClipping(1) end) 
  pcall(function() label:SetTextOverflowPolicy(1) end) 
  pcall(function() label:SetVisibility(3) end) 
  layout.PlaceAt(panel, label, x, y, w, h)
  return label
end
function M.ConstructFramedBackground(panel, tree, contentPanel, x, y, w, h, fillR, fillG, fillB, fillA, decorations)
  local function track(widget)
    if decorations then decorations[#decorations + 1] = widget end
    return widget
  end
  local function Panel(r, g, b, a, px, py, pw, ph)
    local p = primitives.ConstructColorPanel(tree, r, g, b, a)
    layout.PlaceAt(contentPanel, p, px, py, pw, ph)
    track(p)
    return p
  end
  Panel(fillR, fillG, fillB, fillA, x, y, w, h)
  local hb = layout.ScreenPxToSlate(panel, HEADER_BLOCK_BORDER_SCREEN)
  DrawBorderEdges(function(px, py, pw, ph)
    Panel(HEADER_BLOCK_BORDER_R, HEADER_BLOCK_BORDER_G, HEADER_BLOCK_BORDER_B, 1.0, px, py, pw, ph)
  end, x, y, w, h, hb)
end
local ERROR_TOOLTIP_PADDING_SCREEN = 12
local ERROR_TOOLTIP_FILL_R, ERROR_TOOLTIP_FILL_G, ERROR_TOOLTIP_FILL_B = colors.SrgbToLinear(colors.HexColor("#B0201F"))
local ERROR_TOOLTIP_FILL_A = 0.85
local ERROR_TOOLTIP_TEXT_R, ERROR_TOOLTIP_TEXT_G, ERROR_TOOLTIP_TEXT_B = colors.SrgbToLinear(colors.HexColor("#FFFFFF"))
local function ConstructPaddedBorder(tree, r, g, b, a, pad)
  local borderClass = StaticFindObject("/Script/UMG.Border")
  if not borderClass or not borderClass:IsValid() then error("UMG.Border class not found") end
  local border = StaticConstructObject(borderClass, tree)
  if not border or not border:IsValid() then error("StaticConstructObject for Border failed") end
  local color = border.BrushColor
  color.R, color.G, color.B, color.A = r, g, b, a
  border:SetBrushColor(color)
  local margin = border.Padding
  margin.Left, margin.Top, margin.Right, margin.Bottom = pad, pad, pad, pad
  border:SetPadding(margin)
  return border
end
function M.ConstructErrorTooltip(tree, worldContextObject, text, maxWidth)
  local overlayClass = StaticFindObject("/Script/UMG.Overlay")
  local sizeBoxClass = StaticFindObject("/Script/UMG.SizeBox")
  if not overlayClass or not overlayClass:IsValid() or not sizeBoxClass or not sizeBoxClass:IsValid() then
    util.Log("ui_common_chrome", "error tooltip: Overlay/SizeBox class not found", "ERROR")
    return nil
  end
  local hb = layout.ScreenPxToSlate(worldContextObject, HEADER_BLOCK_BORDER_SCREEN)
  local hd = layout.ScreenPxToSlate(worldContextObject, HEADER_BLOCK_DOT_SCREEN)
  local padding = layout.ScreenPxToSlate(worldContextObject, ERROR_TOOLTIP_PADDING_SCREEN)
  local wrapAt = maxWidth - 2 * padding
  local overlay, fillBorder, label
  local ok, err = pcall(function()
    overlay = StaticConstructObject(overlayClass, tree)
    if not overlay or not overlay:IsValid() then error("StaticConstructObject for tooltip Overlay failed") end
    fillBorder = ConstructPaddedBorder(tree, ERROR_TOOLTIP_FILL_R, ERROR_TOOLTIP_FILL_G, ERROR_TOOLTIP_FILL_B, ERROR_TOOLTIP_FILL_A, padding)
    overlay:AddChildToOverlay(fillBorder)
    for _, strip in ipairs({
      { h = 0, v = 1, w = nil, ht = hb }, 
      { h = 0, v = 3, w = nil, ht = hb }, 
      { h = 1, v = 0, w = hb, ht = nil }, 
      { h = 3, v = 0, w = hb, ht = nil }, 
    }) do
      local stripBorder = ConstructPaddedBorder(tree, HEADER_BLOCK_BORDER_R, HEADER_BLOCK_BORDER_G, HEADER_BLOCK_BORDER_B, 1.0, 0)
      local stripBox = StaticConstructObject(sizeBoxClass, tree)
      if not stripBox or not stripBox:IsValid() then error("StaticConstructObject for tooltip strip SizeBox failed") end
      if strip.w then stripBox:SetWidthOverride(strip.w) end
      if strip.ht then stripBox:SetHeightOverride(strip.ht) end
      stripBox:SetContent(stripBorder)
      local stripSlot = overlay:AddChildToOverlay(stripBox)
      stripSlot:SetHorizontalAlignment(strip.h)
      stripSlot:SetVerticalAlignment(strip.v)
    end
    for _, corner in ipairs({
      { h = 1, v = 1 }, { h = 3, v = 1 }, { h = 1, v = 3 }, { h = 3, v = 3 }, 
    }) do
      local dotBorder = ConstructPaddedBorder(tree, 1.0, 1.0, 1.0, 1.0, 0)
      local dotBox = StaticConstructObject(sizeBoxClass, tree)
      if not dotBox or not dotBox:IsValid() then error("StaticConstructObject for tooltip dot SizeBox failed") end
      dotBox:SetWidthOverride(hd)
      dotBox:SetHeightOverride(hd)
      dotBox:SetContent(dotBorder)
      local dotSlot = overlay:AddChildToOverlay(dotBox)
      dotSlot:SetHorizontalAlignment(corner.h)
      dotSlot:SetVerticalAlignment(corner.v)
    end
  end)
  if not ok or not overlay then
    util.Log("ui_common_chrome", "error tooltip build failed: " .. tostring(err), "ERROR")
    return nil
  end
  label = primitives.ConstructTextBlock(tree, text)
  primitives.ApplyHeaderTitleFont(label)
  primitives.SetTextColor(label, ERROR_TOOLTIP_TEXT_R, ERROR_TOOLTIP_TEXT_G, ERROR_TOOLTIP_TEXT_B)
  pcall(function()
    label.WrapTextAt = wrapAt
    label:SetAutoWrapText(true)
  end)
  fillBorder:SetContent(label)
  return overlay, label
end
return M
