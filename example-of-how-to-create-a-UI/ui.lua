local uc = require("ui_common")
local routes_list = require("routes_list")
local route_editor = require("route_editor")
local base_rename = require("base_rename")
local util = require("util")
local M = {}
local MODE = {
  LIST = "list",
  EDITOR = "editor",
  RENAME_BASES = "rename_bases",
}
local state = {
  hostFullName = nil,
  panel = nil,
  tree = nil,
  mode = nil, 
  deps = nil, 
}
local WINDOWS = {
  [MODE.LIST] = { hide = function() routes_list.hide() end },
  [MODE.EDITOR] = { hide = function() route_editor.hide() end },
  [MODE.RENAME_BASES] = { hide = function() base_rename.hide() end },
}
local function NavigateTo(newMode, showFn)
  local current = WINDOWS[state.mode]
  if current then current.hide() end
  state.mode = newMode
  showFn()
end
local function ListDeps()
  return {
    base_labels = state.deps.base_labels, 
    refresh_bases = state.deps.refresh_bases, 
    get_general = state.deps.get_general,
    on_change_general = state.deps.on_change_general,
    get_routes = state.deps.get_routes,
    on_change_routes = state.deps.on_change_routes,
    on_add_new = function()
      NavigateTo(MODE.EDITOR, function() route_editor.show(state.panel, state.tree, M.EditorDeps(), nil, nil) end)
    end,
    on_edit_route = function(index, route)
      NavigateTo(MODE.EDITOR, function() route_editor.show(state.panel, state.tree, M.EditorDeps(), index, route) end)
    end,
    on_manage_bases = function()
      NavigateTo(MODE.RENAME_BASES, function() base_rename.show(state.panel, state.tree, M.RenameDeps()) end)
    end,
  }
end
local function ShowList()
  routes_list.show(state.panel, state.tree, ListDeps())
end
function M.RenameDeps()
  return {
    base_labels = state.deps.base_labels,
    refresh_bases = state.deps.refresh_bases,
    on_done = function() NavigateTo(MODE.LIST, ShowList) end,
    on_cancel = function() NavigateTo(MODE.LIST, ShowList) end,
  }
end
function M.EditorDeps()
  return {
    base_labels = state.deps.base_labels,
    refresh_bases = state.deps.refresh_bases, 
    get_snapshot = state.deps.get_snapshot,
    get_routes = state.deps.get_routes,
    on_change_routes = state.deps.on_change_routes,
    on_done = function() NavigateTo(MODE.LIST, ShowList) end,
    on_cancel = function() NavigateTo(MODE.LIST, ShowList) end,
  }
end
function M.close()
  local layout = uc.FindPersistentLayout()
  if layout == nil then return false end
  local okName, layoutName = pcall(function() return layout:GetFullName() end)
  if not okName then return false end
  if state.hostFullName == layoutName and state.mode ~= nil then
    local current = WINDOWS[state.mode]
    if current then current.hide() end
    state.mode = nil
    util.Log("ui", "route editor closed")
    return true
  end
  return false
end
function M.toggle(deps)
  if M.close() then return end
  local layout = uc.FindPersistentLayout()
  if layout == nil then
    util.Log("ui", "no live persistent layout found - not fully in-world yet", "WARN")
    return
  end
  local okName, layoutName = pcall(function() return layout:GetFullName() end)
  if not okName then
    util.Log("ui", "could not read persistent layout widget name", "ERROR")
    return
  end
  local ok, err = pcall(function()
    local tree = layout.WidgetTree
    local treeName = tree:GetFullName()
    local panel = uc.FindNamedCanvasPanel(treeName, uc.PERSISTENT_HOST_PANEL_NAME)
    if panel == nil then error("could not find " .. uc.PERSISTENT_HOST_PANEL_NAME .. " under the persistent layout widget") end
    state.deps = deps
    state.panel, state.tree = panel, tree
    state.hostFullName = layoutName
    state.mode = MODE.LIST
    routes_list.show(panel, tree, ListDeps())
  end)
  if ok then
    util.Log("ui", "route editor opened")
  else
    util.Log("ui", "failed to open route editor: " .. tostring(err), "ERROR")
  end
end
return M
