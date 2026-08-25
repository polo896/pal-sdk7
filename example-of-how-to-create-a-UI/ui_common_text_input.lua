local primitives = require("ui_common_primitives")
local util = require("util")
local M = {}
local PAL_EDITABLE_TEXT_BOX_CLASS_PATH = "/Script/Pal.PalEditableTextBox"
local REFERENCE_FONT_SIZE = 18
local REFERENCE_FONT_TYPEFACE = "Regular"
local REFERENCE_PADDING_LEFT, REFERENCE_PADDING_TOP, REFERENCE_PADDING_RIGHT, REFERENCE_PADDING_BOTTOM = 4, 2, 4, 2
function M.ConstructBaseNameTextInput(tree, initialText)
  local cls = StaticFindObject(PAL_EDITABLE_TEXT_BOX_CLASS_PATH)
  if not cls or not cls:IsValid() then
    util.Log("ui_common_text_input", "ConstructBaseNameTextInput: PalEditableTextBox class not found", "ERROR")
    return nil
  end
  local widget
  local ok, err = pcall(function()
    widget = StaticConstructObject(cls, tree)
    if not widget or not widget:IsValid() then error("StaticConstructObject for PalEditableTextBox failed") end
  end)
  if not ok or not widget then
    util.Log("ui_common_text_input", "ConstructBaseNameTextInput: build failed - " .. tostring(err), "ERROR")
    return nil
  end
  widget:SetRenderOpacity(1.0)
  pcall(function() widget:SetJustification(0) end) 
  pcall(function() widget:SetText(FText(initialText or "")) end)
  local okStyle, styleErr = pcall(function()
    local style = widget.WidgetStyle
    local padding = style.Padding
    padding.Left, padding.Top, padding.Right, padding.Bottom =
      REFERENCE_PADDING_LEFT, REFERENCE_PADDING_TOP, REFERENCE_PADDING_RIGHT, REFERENCE_PADDING_BOTTOM
    style.Padding = padding
    local textStyle = style.TextStyle
    local font = textStyle.Font
    font.Size = REFERENCE_FONT_SIZE
    font.TypefaceFontName = FName(REFERENCE_FONT_TYPEFACE)
    local fontAsset = primitives.get_header_font_asset()
    if fontAsset then font.FontObject = fontAsset end
    textStyle.Font = font
    style.TextStyle = textStyle
    local bgColor = style.BackgroundColor
    local bgSpecified = bgColor.SpecifiedColor
    bgSpecified.A = 0
    bgColor.SpecifiedColor = bgSpecified
    style.BackgroundColor = bgColor
    widget.WidgetStyle = style
  end)
  if not okStyle then util.Log("ui_common_text_input", "ConstructBaseNameTextInput: style apply failed - " .. tostring(styleErr), "ERROR") end
  return widget
end
return M
