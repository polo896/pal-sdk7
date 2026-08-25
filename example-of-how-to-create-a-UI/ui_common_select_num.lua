local primitives = require("ui_common_primitives")
local util = require("util")
local M = {}
local SELECT_NUM_CLASS_PATH = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_IngameCommonSelectNum.WBP_IngameCommonSelectNum_C"
function M.ConstructSelectNumWidget(panel, tree)
  local cls = primitives.get_cached_class_or_asset(SELECT_NUM_CLASS_PATH)
  if not cls then return nil end
  local library = primitives.get_widget_blueprint_library()
  if not library then return nil end
  local widget
  local ok, err = pcall(function()
    local owningPlayer = panel:GetOwningPlayer()
    widget = library:Create(panel, cls, owningPlayer)
    if not widget or not widget:IsValid() then error("WidgetBlueprintLibrary.Create for WBP_IngameCommonSelectNum failed") end
  end)
  if not ok or not widget then
    util.Log("ui_common_select_num", "select-num widget build failed: " .. tostring(err), "ERROR")
    return nil
  end
  return widget
end
function M.SetSelectNumRange(widget, minValue, maxValue)
  local ok, err = pcall(function() widget["Set Min Max Num"](widget, maxValue, minValue) end)
  if not ok then util.Log("ui_common_select_num", "select-num widget Set Min Max Num() failed: " .. tostring(err), "ERROR") end
end
function M.SetSelectNumValue(widget, value)
  local current = M.GetSelectNumValue(widget) or 0
  local delta = value - current
  local ok, err = pcall(function() widget:AddNum(delta) end)
  if not ok then util.Log("ui_common_select_num", "select-num widget AddNum() failed: " .. tostring(err), "ERROR") end
end
function M.GetSelectNumValue(widget)
  local ok, value = pcall(function() return widget.nowNum end)
  if ok and value ~= nil then return value end
  return nil
end
return M
