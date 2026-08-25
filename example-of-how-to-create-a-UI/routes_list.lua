local uc = require("ui_common")
local util = require("util")
local M = {}
local CARD_W = uc.ROUTES_LIST_CARD_W 
local ICON_SIZE = 40
local ICON_X = (CARD_W - ICON_SIZE) / 2
local DELETE_GAP = uc.ROUTES_LIST_DELETE_GAP 
local PADDING = 20
local NAME_TEXT_H = 24 
local MINMAX_FONT_SIZE = 9
local MINMAX_TEXT_H = 18 
local NAME_MINMAX_GAP = 4
local ROW_TEXT_INSET = 10
local ICON_TEXT_GAP = 8
local MAX_NAME_CHARS = 20
local DELETED_NAME_R, DELETED_NAME_G, DELETED_NAME_B = uc.SrgbToLinear(uc.HexColor("#FF4D4D"))
local MINMAX_R, MINMAX_G, MINMAX_B = uc.SrgbToLinear(uc.HexColor("#9CA2A2"))
local PANEL_H = 760
local HEADER_Y = PADDING
local SWITCH_W_SCREEN = 506
local SWITCH_H = 39
local SWITCH_VISIBLE_OFFSET_SCREEN = 96
local CARD_H_SCREEN = uc.QUEST_LIST_BUTTON_H_SCREEN 
local DELETE_ICON_SCREEN = uc.ROUTES_LIST_DELETE_ICON_SCREEN 
local ROW_SPACING_SCREEN = 8 
local ADD_BUTTON_W_SCREEN = 420 
local ADD_BUTTON_H_SCREEN = uc.NATIVE_BUTTON_H_SCREEN 
local MANAGE_BASES_BUTTON_W_SCREEN = 160
local MANAGE_BASES_BUTTON_H_SCREEN = 32
local MANAGE_BASES_BUTTON_TEXT_SIZE = 11 
local function ComputeLayout(panel)
  local rowH = uc.ScreenPxToSlate(panel, CARD_H_SCREEN)
  local switchW = uc.ScreenPxToSlate(panel, SWITCH_W_SCREEN)
  local switchVisibleOffset = uc.ScreenPxToSlate(panel, SWITCH_VISIBLE_OFFSET_SCREEN)
  local deleteButtonW = uc.ScreenPxToSlate(panel, DELETE_ICON_SCREEN)
  local rowSpacing = uc.ScreenPxToSlate(panel, ROW_SPACING_SCREEN)
  local totalRowW = CARD_W + DELETE_GAP + deleteButtonW
  local panelW = totalRowW + PADDING * 2
  local headerMetrics = uc.HeaderBlockMetrics(panel)
  local headerH = headerMetrics.h
  local addButtonW = uc.ScreenPxToSlate(panel, ADD_BUTTON_W_SCREEN)
  local addButtonH = uc.ScreenPxToSlate(panel, ADD_BUTTON_H_SCREEN)
  local manageBasesButtonW = uc.ScreenPxToSlate(panel, MANAGE_BASES_BUTTON_W_SCREEN)
  local manageBasesButtonH = uc.ScreenPxToSlate(panel, MANAGE_BASES_BUTTON_H_SCREEN)
  local manageBasesButtonMargin = (headerH - manageBasesButtonH) / 2
  local topHeaderY = HEADER_Y
  local switchY = topHeaderY + headerH + 16
  local routesHeaderY = switchY + SWITCH_H + 16
  local listY = routesHeaderY + headerH + 16
  return {
    rowH = rowH,
    switchW = switchW,
    switchVisibleOffset = switchVisibleOffset,
    deleteButtonW = deleteButtonW,
    rowSpacing = rowSpacing,
    totalRowW = totalRowW,
    panelW = panelW,
    scrollboxW = totalRowW,
    headerMetrics = headerMetrics,
    headerH = headerH,
    manageBasesButtonW = manageBasesButtonW,
    manageBasesButtonH = manageBasesButtonH,
    manageBasesButtonMargin = manageBasesButtonMargin,
    topHeaderY = topHeaderY,
    switchY = switchY,
    routesHeaderY = routesHeaderY,
    listY = listY,
    listH = PANEL_H - listY - PADDING - addButtonH - 8, 
    addButtonY = PANEL_H - PADDING - addButtonH,
    addButtonX = PADDING + (totalRowW - addButtonW) / 2, 
    addButtonW = addButtonW,
    addButtonH = addButtonH,
  }
end
local state = {
  built = false,
  visible = false,
  panel = nil,
  tree = nil,
  contentPanel = nil,
  decorations = {},
  scrollBox = nil,
  layout = nil, 
  general = { switch = nil, lastSwitchOn = nil },
  addButton = nil, addButtonClick = nil,
  manageBasesButton = nil, manageBasesButtonClick = nil,
  deps = nil,
  pollGeneration = 0,
}
local function FormatBaseName(rawName)
  return uc.TruncateWithEllipsis(rawName, MAX_NAME_CHARS)
end
local function BuildRowLabel(rowCanvas, text, isName, isDeleted, align, x, y, w, h)
  local opts = { justify = align }
  if isName then
    if isDeleted then opts.color = { DELETED_NAME_R, DELETED_NAME_G, DELETED_NAME_B } end
  else
    opts.fontSize = MINMAX_FONT_SIZE
    opts.color = { MINMAX_R, MINMAX_G, MINMAX_B }
  end
  return uc.ConstructOverlayLabel(state.tree, rowCanvas, text, x, y, w, h, opts)
end
local function ClearClickables()
  uc.ClearWatchedClicks()
end
local function AddClickable(name, widget, onClick)
  uc.WatchClickHook(widget, name, onClick)
end
local function RebuildRows(routes)
  for _, w in ipairs(state.decorations.rows or {}) do
    pcall(function() w:RemoveFromParent() end)
  end
  state.decorations.rows = {}
  local layout = state.layout
  local canvasClass = StaticFindObject("/Script/UMG.CanvasPanel")
  for i, route in ipairs(routes) do
    local ok, err = pcall(function()
      local rowCanvas = StaticConstructObject(canvasClass, state.tree)
      rowCanvas:SetRenderOpacity(1.0)
      local questButton, questClick = uc.ConstructBlankTitleCard(rowCanvas, state.tree)
      if not questButton then error("ConstructQuestListButton failed") end
      uc.PlaceAt(rowCanvas, questButton, 0, 0, CARD_W, layout.rowH)
      AddClickable("row_" .. i .. "_edit", questClick, function()
        state.deps.on_edit_route(i, route)
      end)
      local base_labels = state.deps.base_labels
      local blockH = NAME_TEXT_H + NAME_MINMAX_GAP + MINMAX_TEXT_H
      local blockY = (layout.rowH - blockH) / 2
      local nameY = blockY
      local minMaxY = blockY + NAME_TEXT_H + NAME_MINMAX_GAP
      local leftColX, leftColW = ROW_TEXT_INSET, ICON_X - ICON_TEXT_GAP - ROW_TEXT_INSET
      local rightColX = ICON_X + ICON_SIZE + ICON_TEXT_GAP
      local rightColW = CARD_W - rightColX - ROW_TEXT_INSET
      local LEFT, RIGHT = 0, 2 
      local minText = "Min: " .. tostring(math.floor(route.keep_min or 0))
      local maxText = route.keep_max ~= nil and ("Max: " .. tostring(math.floor(route.keep_max))) or "Max: \xE2\x80\x94" 
      local fromMissing = route.from == nil or base_labels.is_deleted(route.from)
      local toMissing = route.to == nil or base_labels.is_deleted(route.to)
      local fromText = fromMissing and "?" or FormatBaseName(base_labels.label_for(route.from))
      local toText = toMissing and "?" or FormatBaseName(base_labels.label_for(route.to))
      BuildRowLabel(rowCanvas, fromText, true, fromMissing, LEFT, leftColX, nameY, leftColW, NAME_TEXT_H)
      BuildRowLabel(rowCanvas, minText, false, false, LEFT, leftColX, minMaxY, leftColW, MINMAX_TEXT_H)
      BuildRowLabel(rowCanvas, toText, true, toMissing, RIGHT, rightColX, nameY, rightColW, NAME_TEXT_H)
      BuildRowLabel(rowCanvas, maxText, false, false, RIGHT, rightColX, minMaxY, rightColW, MINMAX_TEXT_H)
      local iconWidget = uc.ConstructItemIcon(rowCanvas, state.tree, route.item)
      if not iconWidget then error("ConstructItemIcon failed for " .. tostring(route.item)) end
      uc.PlaceAt(rowCanvas, iconWidget, ICON_X, (layout.rowH - ICON_SIZE) / 2, ICON_SIZE, ICON_SIZE)
      local deleteButton, deleteClick = uc.ConstructMenuButton(rowCanvas, state.tree)
      if not deleteButton then error("ConstructMenuButton failed") end
      local deleteX = CARD_W + DELETE_GAP
      uc.PlaceAt(rowCanvas, deleteButton, deleteX, (layout.rowH - layout.deleteButtonW) / 2, layout.deleteButtonW, layout.deleteButtonW)
      AddClickable("row_" .. i .. "_delete", deleteClick, function()
        local current = state.deps.get_routes()
        local newRoutes = {}
        for j, r in ipairs(current) do
          if j ~= i then newRoutes[#newRoutes + 1] = r end
        end
        state.deps.on_change_routes(newRoutes)
        M.refresh()
      end)
      local sizeBox, spacerBox = uc.AddScrollBoxRow(
        state.scrollBox, state.tree, rowCanvas, layout.totalRowW, layout.rowH, layout.rowSpacing,
        "routes_list: ", "row " .. i)
      state.decorations.rows[#state.decorations.rows + 1] = sizeBox
      state.decorations.rows[#state.decorations.rows + 1] = spacerBox
    end)
    if not ok then util.Log("routes_list", "failed to build row " .. i .. " - " .. tostring(err), "ERROR") end
  end
end
local function build(panel, tree)
  state.panel, state.tree = panel, tree
  state.decorations = { rows = {}, chrome = {} }
  ClearClickables()
  local layout = state.layout
  local host = uc.BuildCommonWindowHost(panel, tree, layout.panelW, PANEL_H)
  if not host then
    util.Log("routes_list", "build: BuildCommonWindowHost failed - aborting, no window to show", "ERROR")
    return
  end
  state.decorations.chrome[#state.decorations.chrome + 1] = host.window
  state.shell = host.window
  local contentPanel = host.contentPanel
  state.contentPanel = contentPanel
  local headerX = PADDING
  local headerW = layout.panelW - PADDING * 2
  local function BuildHeaderBlock(y, titleText)
    uc.ConstructHeaderBlock(tree, contentPanel, headerX, y, headerW, layout.headerMetrics, titleText, state.decorations.chrome)
  end
  BuildHeaderBlock(layout.topHeaderY, "Auto Haul: Base Logistics")
  local manageBasesButton, manageBasesClick = uc.ConstructNativeButton(
    contentPanel, tree, "Rename bases", false, MANAGE_BASES_BUTTON_TEXT_SIZE)
  local btnX = headerX + headerW - layout.manageBasesButtonW - layout.manageBasesButtonMargin
  local btnY = layout.topHeaderY + layout.manageBasesButtonMargin
  uc.PlaceOrLog(manageBasesButton, "\"Rename bases\" button", contentPanel, btnX, btnY, layout.manageBasesButtonW, layout.manageBasesButtonH)
  state.manageBasesButton, state.manageBasesButtonClick = manageBasesButton, manageBasesClick
  local switchWidget = uc.ConstructOnOffSwitch(contentPanel, tree, true)
  local switchX = PADDING + (layout.totalRowW - layout.switchW) / 2 - layout.switchVisibleOffset
  uc.PlaceOrLog(switchWidget, "enable toggle", contentPanel, switchX, layout.switchY, layout.switchW, SWITCH_H)
  state.general.switch = switchWidget
  BuildHeaderBlock(layout.routesHeaderY, "Routes")
  local scrollBox = uc.ConstructScrollBox(tree)
  uc.PlaceAt(contentPanel, scrollBox, PADDING, layout.listY, layout.scrollboxW, layout.listH)
  state.scrollBox = scrollBox
  local addButton, addClick = uc.ConstructNativeButton(contentPanel, tree, "New route")
  uc.PlaceOrLog(addButton, "\"New route\" button", contentPanel, layout.addButtonX, layout.addButtonY, layout.addButtonW, layout.addButtonH)
  state.addButton, state.addButtonClick = addButton, addClick
  AddClickable("add_new", addClick, function() state.deps.on_add_new() end)
  state.built = true
end
local function set_all_visible(visible)
  state.visible = visible
  uc.SetWidgetsVisible(state.decorations.chrome, {
    state.general.switch, state.scrollBox, state.addButton, state.manageBasesButton,
  }, visible)
  if visible then
    state.pollGeneration = state.pollGeneration + 1
    M.poll(state.pollGeneration)
  end
end
function M.refresh()
  if not state.built then return end
  local general = state.deps.get_general()
  if state.general.switch then
    uc.SetSwitchOn(state.general.switch, general.enabled)
    state.general.lastSwitchOn = general.enabled and true or false
  end
  ClearClickables()
  AddClickable("add_new", state.addButtonClick, function() state.deps.on_add_new() end)
  AddClickable("manage_bases", state.manageBasesButtonClick, function() state.deps.on_manage_bases() end)
  local routes = state.deps.get_routes()
  RebuildRows(routes)
end
function M.poll(generation)
  if generation ~= state.pollGeneration or not state.built or not state.visible then return end
  local ok, err = pcall(function()
    if state.general.switch then
      local isOn = uc.SwitchIsOn(state.general.switch)
      if isOn ~= nil and isOn ~= state.general.lastSwitchOn then
        util.Log("routes_list", "enable switch toggled: " .. tostring(state.general.lastSwitchOn) .. " -> " .. tostring(isOn))
        state.general.lastSwitchOn = isOn
        state.deps.on_change_general(isOn)
      end
    end
  end)
  if not ok then util.Log("routes_list", "poll error, will retry - " .. tostring(err), "ERROR") end
  ExecuteInGameThreadWithDelay(30, function() M.poll(generation) end)
end
function M.show(panel, tree, deps)
  state.deps = deps
  pcall(function() deps.refresh_bases() end)
  state.layout = ComputeLayout(panel)
  if not state.built then
    build(panel, tree)
  end
  M.refresh()
  set_all_visible(true)
end
function M.hide()
  uc.CloseShell(state)
  set_all_visible(false)
end
function M.is_built() return state.built end
function M.is_visible() return state.visible end
return M
