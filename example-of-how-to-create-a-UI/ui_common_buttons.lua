local primitives = require("ui_common_primitives")
local util = require("util")
local M = {}
function M.ConstructBlueprintWidget(panel, tree, cls, label)
  local library = primitives.get_widget_blueprint_library()
  if not library then return nil end
  local widget
  local ok, err = pcall(function()
    local owningPlayer = panel:GetOwningPlayer()
    widget = library:Create(panel, cls, owningPlayer)
    if not widget or not widget:IsValid() then error("WidgetBlueprintLibrary.Create for " .. label .. " failed") end
  end)
  if not ok or not widget then
    util.Log("ui_common_buttons", label .. " build failed: " .. tostring(err), "ERROR")
    return nil
  end
  return widget
end
function M.ResolveInvisibleButtonClickTarget(widget)
  local okInner, inner = pcall(function() return widget.WBP_PalInvisibleButton end)
  if okInner and inner and inner:IsValid() then return inner end
  return widget
end
M.QUEST_LIST_BUTTON_H_SCREEN = 93 
M.NATIVE_BUTTON_H_SCREEN = 48 
M.ROUTES_LIST_CARD_W = 440
M.ROUTES_LIST_DELETE_GAP = 10
M.ROUTES_LIST_DELETE_ICON_SCREEN = 38 
local NATIVE_BUTTON_CLASS_PATH = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_CommonButton_Activation.WBP_CommonButton_Activation_C"
local NATIVE_BUTTON_BACKGROUND_FIELDS = { "Base" }
function M.ConstructNativeButton(panel, tree, label, noBackground, fontSize)
  local buttonClass = primitives.get_cached_class_or_asset(NATIVE_BUTTON_CLASS_PATH)
  if not buttonClass then return nil end
  local button = M.ConstructBlueprintWidget(panel, tree, buttonClass, "native button")
  if not button then return nil end
  primitives.TryCall("native button Setup()", function() button:Setup(false) end)
  primitives.TryCall("native button SetText()", function() button:SetText(FText(label or "")) end)
  if fontSize then
    primitives.TryCall("native button font size override", function()
      local font = button.Text_Main.Font
      font.Size = fontSize
      button.Text_Main.Font = font
    end)
  end
  if noBackground then
    for _, fieldName in ipairs(NATIVE_BUTTON_BACKGROUND_FIELDS) do
      pcall(function() button[fieldName]:SetVisibility(1) end) 
    end
  end
  return button, M.ResolveInvisibleButtonClickTarget(button)
end
local MENU_BUTTON_CLASS_PATH = "/Game/Pal/Blueprint/UI/UserInterface/MainMenu/WBP_Menu_btn.WBP_Menu_btn_C"
function M.ConstructMenuButton(panel, tree)
  local cls = primitives.get_cached_class_or_asset(MENU_BUTTON_CLASS_PATH)
  if not cls then return nil end
  local widget = M.ConstructBlueprintWidget(panel, tree, cls, "menu/close button")
  if not widget then return nil end
  return widget, M.ResolveInvisibleButtonClickTarget(widget)
end
local QUEST_LIST_BUTTON_CLASS_PATH = "/Game/Pal/Blueprint/UI/UserInterface/MainMenu/Quest/WBP_Quest_ListButton.WBP_Quest_ListButton_C"
function M.ConstructQuestListButton(panel, tree)
  local cls = primitives.get_cached_class_or_asset(QUEST_LIST_BUTTON_CLASS_PATH)
  if not cls then return nil end
  local widget = M.ConstructBlueprintWidget(panel, tree, cls, "quest list button")
  if not widget then return nil end
  for _, fieldName in ipairs({ "Canvas_Tracking", "Image_Icon_GuildQuest", "Text_Distance", "Image_CompleteCheck" }) do
    pcall(function() widget[fieldName]:SetVisibility(1) end)
  end
  return widget, M.ResolveInvisibleButtonClickTarget(widget)
end
function M.ConstructBlankTitleCard(panel, tree)
  local widget, clickTarget = M.ConstructQuestListButton(panel, tree)
  if widget then
    pcall(function() widget.RichText_QuestTitle:SetText(FText("")) end)
  end
  return widget, clickTarget
end
function M.SetQuestListButtonPicked(widget, picked)
  if widget == nil then return end
  local okAnim, anim = pcall(function() return widget.Anm_NormalToFocus end)
  if not okAnim or not anim then return end
  if picked then
    pcall(function() widget:PlayAnimationForward(anim, 1.0, false) end)
  else
    pcall(function() widget:PlayAnimationReverse(anim, 1.0, false) end)
  end
end
function M.SetQuestListButtonUnavailable(widget, unavailable)
  if widget == nil then return end
  pcall(function()
    widget:SetRenderOpacity(unavailable and 0.4 or 1.0)
    widget:SetVisibility(unavailable and 3 or 0)
  end)
end
local SWITCH_CLASS_PATH = "/Game/Pal/Blueprint/UI/UserInterface/MainMenu/Option/WBP_OptionSettings_ListContentSwitch.WBP_OptionSettings_ListContentSwitch_C"
function M.ConstructOnOffSwitch(panel, tree, isOn)
  local cls = primitives.get_cached_class_or_asset(SWITCH_CLASS_PATH)
  if not cls then return nil end
  local widget = M.ConstructBlueprintWidget(panel, tree, cls, "on/off switch")
  if not widget then return nil end
  primitives.TryCall("on/off switch Setup()", function() widget:Setup(isOn and true or false, true) end)
  return widget
end
function M.SetSwitchOn(widget, isOn)
  if widget == nil then return end
  local ok = pcall(function() widget:Setup(isOn and true or false, true) end)
  if not ok then pcall(function()
    if isOn then widget:SetForceOn() else widget:SetForceOff() end
  end) end
end
function M.SwitchIsOn(widget)
  local ok, isOn = pcall(function() return widget.CurrentIsOn end)
  if ok and isOn ~= nil then return isOn and true or false end
  return nil
end
return M
