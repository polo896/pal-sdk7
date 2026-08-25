local uc = require("ui_common")
local util = require("util")
local M = {}
local PADDING = 20
local ROUTES_LIST_CARD_W = uc.ROUTES_LIST_CARD_W
local ROUTES_LIST_DELETE_GAP = uc.ROUTES_LIST_DELETE_GAP
local ROUTES_LIST_DELETE_ICON_SCREEN = uc.ROUTES_LIST_DELETE_ICON_SCREEN
local PANEL_H = 760
local HEADER_Y = PADDING
local HEADER_GAP = 16
local ROW_SPACING_SCREEN = 8
local BUTTON_H_SCREEN = uc.NATIVE_BUTTON_H_SCREEN 
local INPUT_H_SCREEN = BUTTON_H_SCREEN
local INPUT_BG_R, INPUT_BG_G, INPUT_BG_B, INPUT_BG_A = 0.0, 0.0, 0.0, 0.7
local BUTTON_GAP = 12
local function ComputeLayout(panel)
  local rowSpacing = uc.ScreenPxToSlate(panel, ROW_SPACING_SCREEN)
  local inputH = uc.ScreenPxToSlate(panel, INPUT_H_SCREEN)
  local rowH = inputH
  local buttonH = uc.ScreenPxToSlate(panel, BUTTON_H_SCREEN)
  local cardW = ROUTES_LIST_CARD_W + ROUTES_LIST_DELETE_GAP + uc.ScreenPxToSlate(panel, ROUTES_LIST_DELETE_ICON_SCREEN)
  local panelW = cardW + PADDING * 2
  local headerMetrics = uc.HeaderBlockMetrics(panel)
  local headerH = headerMetrics.h
  local headerY = HEADER_Y
  local listY = headerY + headerH + HEADER_GAP
  local buttonY = PANEL_H - PADDING - buttonH
  local buttonW = (cardW - BUTTON_GAP) / 2
  return {
    rowH = rowH,
    rowSpacing = rowSpacing,
    inputH = inputH,
    cardW = cardW,
    panelW = panelW,
    scrollboxW = cardW,
    headerMetrics = headerMetrics,
    headerH = headerH,
    headerY = headerY,
    listY = listY,
    listH = buttonY - 8 - listY, 
    buttonY = buttonY,
    buttonH = buttonH,
    buttonW = buttonW,
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
  rows = {}, 
  saveButton = nil, saveButtonClick = nil,
  cancelButton = nil, cancelButtonClick = nil,
  deps = nil,
}
local function ClearClickables()
  uc.ClearWatchedClicks()
end
local function AddClickable(name, widget, onClick)
  uc.WatchClickHook(widget, name, onClick)
end
local function RebuildRows()
  for _, w in ipairs(state.decorations.rows or {}) do
    pcall(function() w:RemoveFromParent() end)
  end
  state.decorations.rows = {}
  state.rows = {}
  local layout = state.layout
  local canvasClass = StaticFindObject("/Script/UMG.CanvasPanel")
  local base_labels = state.deps.base_labels
  local labels = {}
  for _, entry in ipairs(base_labels.all()) do
    if not base_labels.is_deleted(entry.guid) then
      labels[#labels + 1] = entry
    end
  end
  for i, entry in ipairs(labels) do
    local ok, err = pcall(function()
      local rowCanvas = StaticConstructObject(canvasClass, state.tree)
      rowCanvas:SetRenderOpacity(1.0)
      uc.ConstructFramedBackground(state.panel, state.tree, rowCanvas, 0, 0, layout.cardW, layout.rowH,
        INPUT_BG_R, INPUT_BG_G, INPUT_BG_B, INPUT_BG_A, nil)
      local input = uc.ConstructBaseNameTextInput(state.tree, entry.label)
      if not input then error("ConstructBaseNameTextInput failed") end
      uc.PlaceAt(rowCanvas, input, 0, 0, layout.cardW, layout.rowH)
      local sizeBox, spacerBox = uc.AddScrollBoxRow(
        state.scrollBox, state.tree, rowCanvas, layout.cardW, layout.rowH, layout.rowSpacing,
        "base_rename: ", "row " .. i)
      state.decorations.rows[#state.decorations.rows + 1] = sizeBox
      state.rows[#state.rows + 1] = { guid = entry.guid, widget = input }
      state.decorations.rows[#state.decorations.rows + 1] = spacerBox
    end)
    if not ok then util.Log("base_rename", "failed to build row " .. i .. " - " .. tostring(err), "ERROR") end
  end
end
local function build(panel, tree)
  state.panel, state.tree = panel, tree
  state.decorations = { rows = {}, chrome = {} }
  ClearClickables()
  local layout = state.layout
  local host = uc.BuildCommonWindowHost(panel, tree, layout.panelW, PANEL_H)
  if not host then
    util.Log("base_rename", "build: BuildCommonWindowHost failed - aborting, no window to show", "ERROR")
    return
  end
  state.decorations.chrome[#state.decorations.chrome + 1] = host.window
  state.shell = host.window
  local contentPanel = host.contentPanel
  state.contentPanel = contentPanel
  local headerX = PADDING
  local headerW = layout.panelW - PADDING * 2
  uc.ConstructHeaderBlock(tree, contentPanel, headerX, layout.headerY, headerW, layout.headerMetrics, "Rename Bases", state.decorations.chrome)
  local scrollBox = uc.ConstructScrollBox(tree)
  uc.PlaceAt(contentPanel, scrollBox, PADDING, layout.listY, layout.scrollboxW, layout.listH)
  state.scrollBox = scrollBox
  local saveButton, saveClick = uc.ConstructNativeButton(contentPanel, tree, "Save")
  uc.PlaceOrLog(saveButton, "base_rename build: \"Save\" button", contentPanel, PADDING, layout.buttonY, layout.buttonW, layout.buttonH)
  state.saveButton, state.saveButtonClick = saveButton, saveClick
  local cancelButton, cancelClick = uc.ConstructNativeButton(contentPanel, tree, "Cancel")
  uc.PlaceOrLog(cancelButton, "base_rename build: \"Cancel\" button", contentPanel, PADDING + layout.buttonW + BUTTON_GAP, layout.buttonY, layout.buttonW, layout.buttonH)
  state.cancelButton, state.cancelButtonClick = cancelButton, cancelClick
  state.built = true
end
local function set_all_visible(visible)
  state.visible = visible
  uc.SetWidgetsVisible(state.decorations.chrome, { state.scrollBox, state.saveButton, state.cancelButton }, visible)
end
local function OnSave()
  local changes = {}
  for _, row in ipairs(state.rows) do
    local okText, text = pcall(function() return row.widget:GetText():ToString() end)
    if okText and text ~= nil then
      local current = state.deps.base_labels.label_for(row.guid)
      if text ~= current then
        changes[#changes + 1] = { guid = row.guid, label = text }
      end
    end
  end
  local changed = state.deps.base_labels.rename_many(changes)
  util.Log("base_rename", "Save - " .. changed .. " base(s) renamed")
  state.deps.on_done()
end
local function OnCancel()
  state.deps.on_cancel()
end
function M.refresh()
  if not state.built then return end
  ClearClickables()
  AddClickable("save", state.saveButtonClick, OnSave)
  AddClickable("cancel", state.cancelButtonClick, OnCancel)
  RebuildRows()
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
