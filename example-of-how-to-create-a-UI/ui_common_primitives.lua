local util = require("util")
local M = {}
function M.get_cached_class_or_asset(path)
  local obj = StaticFindObject(path)
  if obj and obj:IsValid() then return obj end
  pcall(function() LoadAsset(path) end)
  obj = StaticFindObject(path)
  if obj and obj:IsValid() then return obj end
  return nil
end
function M.TryCall(label, fn)
  local ok, err = pcall(fn)
  if not ok then util.Log("ui_common_primitives", label .. " failed - " .. tostring(err), "ERROR") end
  return ok
end
local WIDGET_BLUEPRINT_LIBRARY_PATH = "/Script/UMG.Default__WidgetBlueprintLibrary"
function M.get_widget_blueprint_library()
  local library = StaticFindObject(WIDGET_BLUEPRINT_LIBRARY_PATH)
  if library and library:IsValid() then return library end
  return nil
end
function M.ConstructTextBlock(tree, text)
  local textBlockClass = StaticFindObject("/Script/UMG.TextBlock")
  if not textBlockClass or not textBlockClass:IsValid() then error("TextBlock class not found") end
  local block = StaticConstructObject(textBlockClass, tree)
  if not block or not block:IsValid() then error("StaticConstructObject for text block failed") end
  block:SetText(FText(text or ""))
  block:SetRenderOpacity(1.0)
  return block
end
function M.Utf8Truncate(text, maxChars)
  local charCount = 0
  for i = 1, #text do
    local b = text:byte(i)
    if b < 0x80 or b >= 0xC0 then
      charCount = charCount + 1
      if charCount > maxChars then
        return text:sub(1, i - 1), true
      end
    end
  end
  return text, false
end
function M.TruncateWithEllipsis(text, maxChars)
  local truncated, wasTruncated = M.Utf8Truncate(text, maxChars)
  if wasTruncated then return truncated .. "\xE2\x80\xA6" end
  return text
end
local HEADER_FONT_ASSET_PATH = "/Game/Pal/Font/Ft_PalDefaultFont.Ft_PalDefaultFont"
local HEADER_TITLE_TYPEFACE = "Medium"
local HEADER_TITLE_FONT_SIZE = 12
local function get_header_font_asset()
  return M.get_cached_class_or_asset(HEADER_FONT_ASSET_PATH)
end
M.get_header_font_asset = get_header_font_asset
function M.ApplyHeaderTitleFont(textBlock)
  local fontAsset = get_header_font_asset()
  M.TryCall("header title font set", function()
    local font = textBlock.Font
    font.Size = HEADER_TITLE_FONT_SIZE
    if fontAsset then
      font.FontObject = fontAsset
      font.TypefaceFontName = FName(HEADER_TITLE_TYPEFACE)
    end
    textBlock.Font = font
  end)
end
function M.ConstructColorPanel(tree, r, g, b, a)
  local borderClass = StaticFindObject("/Script/UMG.Border")
  if not borderClass or not borderClass:IsValid() then error("UMG.Border class not found") end
  local panel = StaticConstructObject(borderClass, tree)
  if not panel or not panel:IsValid() then error("StaticConstructObject for color panel failed") end
  panel:SetRenderOpacity(1.0)
  M.TryCall("color panel color set", function()
    local color = panel.BrushColor
    color.R, color.G, color.B, color.A = r, g, b, (a or 1.0)
    panel:SetBrushColor(color)
  end)
  return panel
end
local BACKGROUND_BLUR_DEFAULTS = {
  BlurStrength = 8.0,
  BlurRadius = 0,
  bApplyAlphaToBlur = true,
  CornerRadius = { X = 0.0, Y = 0.0, Z = 0.0, W = 0.0 },
}
M.FULLSCREEN_BLUR_DEFAULTS = {
  BlurStrength = 3.0,
  BlurRadius = 0,
  bApplyAlphaToBlur = false,
  CornerRadius = { X = 0.0, Y = 0.0, Z = 0.0, W = 0.0 },
}
function M.ConstructBackgroundBlur(tree, profile)
  profile = profile or BACKGROUND_BLUR_DEFAULTS
  local blurClass = StaticFindObject("/Script/UMG.BackgroundBlur")
  if not blurClass or not blurClass:IsValid() then
    util.Log("ui_common_primitives", "background blur: UMG.BackgroundBlur class not found", "ERROR")
    return nil
  end
  local blur = StaticConstructObject(blurClass, tree)
  if not blur or not blur:IsValid() then
    util.Log("ui_common_primitives", "background blur: StaticConstructObject failed", "ERROR")
    return nil
  end
  blur:SetRenderOpacity(1.0)
  M.TryCall("background blur: SetBlurStrength", function() blur:SetBlurStrength(profile.BlurStrength) end)
  M.TryCall("background blur: SetBlurRadius", function() blur:SetBlurRadius(profile.BlurRadius) end)
  M.TryCall("background blur: SetApplyAlphaToBlur", function() blur:SetApplyAlphaToBlur(profile.bApplyAlphaToBlur) end)
  M.TryCall("background blur: SetCornerRadius", function() blur:SetCornerRadius(profile.CornerRadius) end)
  return blur
end
function M.SetTextColor(textBlock, r, g, b)
  M.TryCall("text color set", function()
    local color = textBlock.ColorAndOpacity
    color.SpecifiedColor.R, color.SpecifiedColor.G, color.SpecifiedColor.B = r, g, b
    textBlock.ColorAndOpacity = color
  end)
end
M.SCROLLBAR_THICKNESS = 8
M.SCROLLBAR_RIGHT_OFFSET = -10
function M.ConstructScrollBox(tree)
  local scrollClass = StaticFindObject("/Script/UMG.ScrollBox")
  if not scrollClass or not scrollClass:IsValid() then error("UMG.ScrollBox class not found") end
  local scrollBox = StaticConstructObject(scrollClass, tree)
  if not scrollBox or not scrollBox:IsValid() then error("StaticConstructObject for scroll box failed") end
  scrollBox:SetRenderOpacity(1.0)
  pcall(function()
    local thickness = scrollBox.ScrollbarThickness
    thickness.X, thickness.Y = M.SCROLLBAR_THICKNESS, M.SCROLLBAR_THICKNESS
    scrollBox.ScrollbarThickness = thickness
  end)
  pcall(function()
    local padding = scrollBox.ScrollbarPadding
    padding.Right = M.SCROLLBAR_RIGHT_OFFSET
    scrollBox.ScrollbarPadding = padding
  end)
  return scrollBox
end
function M.SetWidgetVisible(widget, visible)
  if widget == nil then return end
  pcall(function()
    widget:SetIsEnabled(visible)
    widget:SetRenderOpacity(visible and 1.0 or 0.0)
    widget:SetVisibility(visible and 0 or 1)
  end)
end
function M.SetWidgetsVisible(chromeArray, namedWidgets, visible)
  for _, w in ipairs(chromeArray or {}) do M.SetWidgetVisible(w, visible) end
  for _, w in pairs(namedWidgets or {}) do M.SetWidgetVisible(w, visible) end
end
function M.SetWidgetOpacity(widget, opacity)
  if widget == nil then return end
  pcall(function() widget:SetRenderOpacity(opacity) end)
end
return M
