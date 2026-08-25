local primitives = require("ui_common_primitives")
local util = require("util")
local M = {}
function M.SetItemSlotSelected(widget, selected)
  if widget == nil then return end
  local okAnim, anim = pcall(function() return widget.Anm_UnselectToSelect end)
  if not okAnim or not anim then return end
  if selected then
    pcall(function() widget:PlayAnimationForward(anim, 1.0, false) end)
  else
    pcall(function() widget:PlayAnimationReverse(anim, 1.0, false) end)
  end
end
local ITEM_SLOT_BUTTON_CLASS_PATH = "/Game/Pal/Blueprint/UI/Thumbnails/Item/WBP_PalInGameMenuItemSlotButton.WBP_PalInGameMenuItemSlotButton_C"
function M.ConstructItemSlotButton(panel, tree, targetSlot, displayCount)
  local cls = primitives.get_cached_class_or_asset(ITEM_SLOT_BUTTON_CLASS_PATH)
  if not cls then return nil end
  local library = primitives.get_widget_blueprint_library()
  if not library then return nil end
  local widget
  local ok, err = pcall(function()
    local owningPlayer = panel:GetOwningPlayer()
    widget = library:Create(panel, cls, owningPlayer)
    if not widget or not widget:IsValid() then error("WidgetBlueprintLibrary.Create for item slot button failed") end
  end)
  if not ok or not widget then
    util.Log("ui_common_item_grid", "item slot button build failed: " .. tostring(err), "ERROR")
    return nil
  end
  local okItemId, itemId = pcall(function() return targetSlot:GetItemId() end)
  if not okItemId or itemId == nil then
    util.Log("ui_common_item_grid", "item slot button: targetSlot:GetItemId() failed", "ERROR")
    return nil
  end
  local okSetupByNum, errSetupByNum = pcall(function()
    widget:SetupByItemAndNum({ ItemId = itemId, Num = displayCount })
  end)
  if not okSetupByNum then
    util.Log("ui_common_item_grid", "item slot button: SetupByItemAndNum failed: " .. tostring(errSetupByNum), "ERROR")
    return nil
  end
  pcall(function() widget.IsEnableDragDrop = false end)
  pcall(function() widget.IsEnableSpreadLift = false end)
  pcall(function() widget.bIsLongPressUsableSLot = false end)
  return widget
end
function M.ConstructEmptyGridCell(tree, size)
  local sizeBoxClass = StaticFindObject("/Script/UMG.SizeBox")
  if not sizeBoxClass or not sizeBoxClass:IsValid() then return nil end
  local widget
  local ok, err = pcall(function()
    widget = StaticConstructObject(sizeBoxClass, tree)
    if not widget or not widget:IsValid() then error("StaticConstructObject for empty grid cell SizeBox failed") end
    widget:SetWidthOverride(size)
    widget:SetHeightOverride(size)
    widget:SetVisibility(2) 
  end)
  if not ok or not widget then
    util.Log("ui_common_item_grid", "empty grid cell build failed: " .. tostring(err), "ERROR")
    return nil
  end
  return widget
end
local ITEM_ICON_CLASS_PATH = "/Game/Pal/Blueprint/UI/Thumbnails/Item/WBP_PalCommonItemIcon.WBP_PalCommonItemIcon_C"
function M.ConstructItemIcon(panel, tree, itemId)
  local cls = primitives.get_cached_class_or_asset(ITEM_ICON_CLASS_PATH)
  if not cls then return nil end
  local library = primitives.get_widget_blueprint_library()
  if not library then return nil end
  local widget
  local ok, err = pcall(function()
    local owningPlayer = panel:GetOwningPlayer()
    widget = library:Create(panel, cls, owningPlayer)
    if not widget or not widget:IsValid() then error("WidgetBlueprintLibrary.Create for WBP_PalCommonItemIcon failed") end
  end)
  if not ok or not widget then
    util.Log("ui_common_item_grid", "item icon build failed: " .. tostring(err), "ERROR")
    return nil
  end
  local okSetup, errSetup = pcall(function() widget:Setup(FName(itemId)) end)
  if not okSetup then
    util.Log("ui_common_item_grid", "item icon Setup() failed: " .. tostring(errSetup), "ERROR")
    return nil
  end
  return widget
end
return M
