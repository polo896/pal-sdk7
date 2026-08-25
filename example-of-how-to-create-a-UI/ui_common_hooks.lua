local util = require("util")
local M = {}
local function MakeClickHookSystem(hookKey, logPrefix)
  local watched = {}
  local persistent = {}
  local registered = false
  local function register()
    if registered then return end
    registered = true
    local ok, err = pcall(function()
      RegisterHook(hookKey, function(self)
        local okGet, widget = pcall(function() return self:get() end)
        if not okGet or not widget then return end
        local okName, fullName = pcall(function() return widget:GetFullName() end)
        if not okName or not fullName then return end
        local entry = watched[fullName] or persistent[fullName]
        if not entry then return end
        util.Log("ui_common_hooks", logPrefix .. entry.label .. " clicked")
        local okCall, callErr = pcall(entry.onClick)
        if not okCall then util.Log("ui_common_hooks", logPrefix .. "onClick error for '" .. entry.label .. "': " .. tostring(callErr), "ERROR") end
      end)
    end)
    if not ok then
      util.Log("ui_common_hooks", logPrefix .. "RegisterHook failed for " .. hookKey .. ": " .. tostring(err), "ERROR")
    end
  end
  local function watch(widget, label, onClick, isPersistent)
    if not widget then return end
    register()
    local okName, fullName = pcall(function() return widget:GetFullName() end)
    if not okName or not fullName then
      util.Log("ui_common_hooks", logPrefix .. "Watch: GetFullName() failed for '" .. tostring(label) .. "': " .. tostring(fullName), "ERROR")
      return
    end
    local entry = { label = label, onClick = onClick }
    if isPersistent then
      persistent[fullName] = entry
    else
      watched[fullName] = entry
    end
  end
  local function clear()
    watched = {}
  end
  return { Watch = watch, Clear = clear }
end
local clickHooks = MakeClickHookSystem("/Script/CommonUI.CommonButtonBase:HandleButtonClicked", "[click-hook] ")
M.WatchClickHook = clickHooks.Watch
M.ClearWatchedClicks = clickHooks.Clear
local ITEM_SLOT_BUTTON_BASE_CLASS_PATH = "/Game/Pal/Blueprint/UI/Thumbnails/Item/Base/WBP_PalItemSlotButtonBase.WBP_PalItemSlotButtonBase_C"
local itemSlotClickHooks = MakeClickHookSystem(ITEM_SLOT_BUTTON_BASE_CLASS_PATH .. ":OnClicked_Internal", "[item-slot-click-hook] ")
function M.WatchItemSlotClickHook(widget, label, onClick)
  itemSlotClickHooks.Watch(widget, label, onClick, false)
end
M.ClearWatchedItemSlotClicks = itemSlotClickHooks.Clear
return M
