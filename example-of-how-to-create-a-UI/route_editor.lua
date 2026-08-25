local uc = require("ui_common")
local util = require("util")
local M = {}
local PANEL_W = 1200
local PANEL_H = 700
local PADDING = 20
local COLUMN_GAP = 30
local COLUMN_TOP = 20
local HEADER_GAP = 16
local LEFT_X, LEFT_W = PADDING, 300
local BLOCK_GAP = 30
local CENTER_X, CENTER_W = LEFT_X + LEFT_W + COLUMN_GAP, 500
local GRID_CELL = 76
local GRID_GAP = 6
local GRID_COLS = 6 
local RIGHT_X = CENTER_X + CENTER_W + COLUMN_GAP
local RIGHT_W = PANEL_W - RIGHT_X - PADDING
local BASE_ROW_W = LEFT_W
local BASE_ROW_H_SCREEN = uc.QUEST_LIST_BUTTON_H_SCREEN 
local BASE_ROW_SPACING_SCREEN = 8
local MAX_NAME_CHARS = 26
local NATIVE_BUTTON_H_SCREEN = uc.NATIVE_BUTTON_H_SCREEN 
local BUTTON_GAP = 12
local NATIVE_BUTTON_W = (RIGHT_W - BUTTON_GAP) / 2
local SLIDER_MAX_FALLBACK = 9999 
local SELECT_NUM_H = 130
local function ComputeLayout(panel)
  local headerMetrics = uc.HeaderBlockMetrics(panel)
  local headerH = headerMetrics.h
  local baseRowH = uc.ScreenPxToSlate(panel, BASE_ROW_H_SCREEN)
  local baseRowSpacing = uc.ScreenPxToSlate(panel, BASE_ROW_SPACING_SCREEN)
  local nativeButtonH = uc.ScreenPxToSlate(panel, NATIVE_BUTTON_H_SCREEN)
  local fromHeaderY = COLUMN_TOP
  local fromListY = fromHeaderY + headerH + HEADER_GAP
  local availableListH = (PANEL_H - PADDING) - fromListY - (headerH + HEADER_GAP + BLOCK_GAP)
  local fromListH = math.floor(availableListH / 2)
  local toHeaderY = fromListY + fromListH + BLOCK_GAP
  local toListY = toHeaderY + headerH + HEADER_GAP
  local toListH = (PANEL_H - PADDING) - toListY
  local gridHeaderY = COLUMN_TOP
  local gridListY = gridHeaderY + headerH + HEADER_GAP
  local minHeaderY = COLUMN_TOP
  local minSelectNumY = minHeaderY + headerH + HEADER_GAP
  local maxHeaderY = minSelectNumY + SELECT_NUM_H + BLOCK_GAP
  local maxSelectNumY = maxHeaderY + headerH + HEADER_GAP
  return {
    headerMetrics = headerMetrics,
    headerH = headerH,
    baseRowH = baseRowH,
    baseRowSpacing = baseRowSpacing,
    nativeButtonH = nativeButtonH,
    fromHeaderY = fromHeaderY,
    fromListY = fromListY,
    fromListH = fromListH,
    toHeaderY = toHeaderY,
    toListY = toListY,
    toListH = toListH,
    gridHeaderY = gridHeaderY,
    gridListY = gridListY,
    minHeaderY = minHeaderY,
    minSelectNumY = minSelectNumY,
    maxHeaderY = maxHeaderY,
    maxSelectNumY = maxSelectNumY,
  }
end
local state = {
  built = false,
  visible = false,
  panel = nil,
  tree = nil,
  contentPanel = nil,
  decorations = {},
  fromScrollBox = nil,
  toScrollBox = nil,
  gridScrollBox = nil,
  gridPanel = nil,
  minSelectNum = nil,
  maxSelectNum = nil,
  saveButton = nil, saveClick = nil,
  cancelButton = nil, cancelClick = nil,
  baseRowButtons = { from = {}, to = {} },
  baseRowLabels = { from = {}, to = {} },
  baseRowPicked = { from = nil, to = nil },
  deps = nil,
  editingIndex = nil, 
  fromGuid = nil, toGuid = nil,
  selectedItem = nil,
  itemMaxStack = SLIDER_MAX_FALLBACK,
  lastSnapshot = nil,
  gridBuildGeneration = 0,
  gridCellWidgets = {},
}
local function BuildRepresentativeSlotMap(storagesByBase, guidKey)
  local map = {}
  for _, entry in ipairs(storagesByBase[guidKey] or {}) do
    local okSlots, slots = pcall(function() return entry.module:GetContainer().ItemSlotArray end)
    if okSlots and slots ~= nil then
      for i = 1, #slots do
        local slot = slots[i]
        local okItem, itemId, count = pcall(function()
          return slot:GetItemId().StaticId:ToString(), slot.StackCount
        end)
        if okItem and count ~= nil and count > 0 and map[itemId] == nil then
          map[itemId] = slot
        end
      end
    end
  end
  return map
end
local function RemoveChildren(list)
  for _, w in ipairs(list) do pcall(function() w:RemoveFromParent() end) end
end
local function BuildBaseList(scrollBox, rowsKey, onPick, rowH, rowSpacing)
  RemoveChildren(state.decorations.baseRows[rowsKey] or {})
  state.decorations.baseRows[rowsKey] = {}
  state.baseRowButtons[rowsKey] = {}
  state.baseRowLabels[rowsKey] = {}
  local canvasClass = StaticFindObject("/Script/UMG.CanvasPanel")
  local allLabels = state.deps.base_labels.all()
  local labels = {}
  for _, entry in ipairs(allLabels) do
    if not state.deps.base_labels.is_deleted(entry.guid) then
      labels[#labels + 1] = entry
    end
  end
  for i, entry in ipairs(labels) do
    local ok, err = pcall(function()
      local rowCanvas = StaticConstructObject(canvasClass, state.tree)
      rowCanvas:SetRenderOpacity(1.0)
      local button, clickTarget = uc.ConstructBlankTitleCard(state.panel, state.tree)
      if not button then error("ConstructQuestListButton failed") end
      uc.PlaceAt(rowCanvas, button, 0, 0, BASE_ROW_W, rowH)
      local labelH = 28
      local label = uc.ConstructOverlayLabel(
        state.tree, rowCanvas, uc.TruncateWithEllipsis(entry.label, MAX_NAME_CHARS),
        0, (rowH - labelH) / 2, BASE_ROW_W, labelH, { fontSize = 14, justify = 1 })
      local sizeBox, spacerBox = uc.AddScrollBoxRow(
        scrollBox, state.tree, rowCanvas, BASE_ROW_W, rowH, rowSpacing,
        "route_editor: ", "base row " .. i)
      state.decorations.baseRows[rowsKey][#state.decorations.baseRows[rowsKey] + 1] = sizeBox
      state.decorations.baseRows[rowsKey][#state.decorations.baseRows[rowsKey] + 1] = spacerBox
      state.baseRowButtons[rowsKey][entry.guid] = button
      state.baseRowLabels[rowsKey][entry.guid] = label
      uc.WatchClickHook(clickTarget, "base_" .. rowsKey .. "_" .. i, function() onPick(entry.guid) end)
    end)
    if not ok then util.Log("route_editor", "failed to build base row " .. i .. " - " .. tostring(err), "ERROR") end
  end
end
local function RefreshBaseRowSelection(rowsKey, currentGuid, selectCurrent)
  if selectCurrent == nil then selectCurrent = true end
  local buttons = state.baseRowButtons[rowsKey] or {}
  local previousPick = state.baseRowPicked[rowsKey]
  if previousPick and previousPick ~= currentGuid and buttons[previousPick] then
    uc.SetQuestListButtonPicked(buttons[previousPick], false)
  end
  if selectCurrent and currentGuid and buttons[currentGuid] then
    uc.SetQuestListButtonPicked(buttons[currentGuid], true)
  end
  state.baseRowPicked[rowsKey] = currentGuid
end
local CATEGORY_ORDER = {}
for i, category in ipairs({
  "PalSphere", "Ammo", "Weapon", "Armor", "Accessory", "Glider", "Meal",
  "Food", "ComsumeUpgrade", "Ore", "Stone", "Wood", "Monster",
  "MaterialOther", "Proccessing", "Ingot", "Palegg", "WazaMachine",
  "ConsumeOther", "Blueprint", "Essential",
}) do
  CATEGORY_ORDER[category] = i
end
local UNKNOWN_CATEGORY_ORDER = 999
local GRID_BUILD_BATCH_SIZE = 15
local function ComputeMissingSelectionError()
  local missing = {}
  if state.fromGuid == nil then missing[#missing + 1] = "a source base" end
  if state.toGuid == nil then missing[#missing + 1] = "a destination base" end
  if state.selectedItem == nil then missing[#missing + 1] = "an item" end
  if #missing == 0 then return nil end
  if #missing == 1 then return "Select " .. missing[1] end
  if #missing == 2 then return "Select " .. missing[1] .. " and " .. missing[2] end
  return "Select " .. missing[1] .. ", " .. missing[2] .. " and " .. missing[3]
end
local function ComputeSaveValidationError()
  local missingError = ComputeMissingSelectionError()
  if missingError ~= nil then return missingError end
  local routes = (state.deps and state.deps.get_routes) and state.deps.get_routes() or {}
  for i, r in ipairs(routes) do
    if i ~= state.editingIndex and r.from == state.fromGuid and r.to == state.toGuid and r.item == state.selectedItem then
      return "A route for this base pair and item already exists"
    end
  end
  return nil
end
local function RefreshSaveTooltip()
  if not state.saveButton then return end
  local err = ComputeSaveValidationError()
  if err == nil then
    pcall(function() state.saveButton:SetToolTip(nil) end)
    return
  end
  if not state.saveTooltipWidget then
    state.saveTooltipWidget, state.saveTooltipLabel = uc.ConstructErrorTooltip(state.tree, state.saveButton, err, RIGHT_W)
  end
  if not state.saveTooltipWidget then return end 
  if state.saveTooltipLabel then
    pcall(function() state.saveTooltipLabel:SetText(FText(err)) end)
  end
  pcall(function() state.saveButton:SetToolTip(state.saveTooltipWidget) end)
end
local function RebuildGrid()
  RemoveChildren(state.decorations.gridCells or {})
  state.decorations.gridCells = {}
  state.gridCellWidgets = {}
  uc.ClearWatchedItemSlotClicks()
  state.gridBuildGeneration = (state.gridBuildGeneration or 0) + 1
  local generation = state.gridBuildGeneration
  local guid = state.fromGuid
  local snap = state.lastSnapshot
  if guid == nil or snap == nil then return end
  local itemCounts = snap.stock[guid] or {}
  local itemCategoryById = snap.itemCategoryById or {}
  local items = {}
  for itemId, count in pairs(itemCounts) do items[#items + 1] = { id = itemId, count = count } end
  table.sort(items, function(a, b)
    local catA = CATEGORY_ORDER[itemCategoryById[a.id]] or UNKNOWN_CATEGORY_ORDER
    local catB = CATEGORY_ORDER[itemCategoryById[b.id]] or UNKNOWN_CATEGORY_ORDER
    if catA ~= catB then return catA < catB end
    return a.id < b.id
  end)
  local slotByItemId = BuildRepresentativeSlotMap(snap.storagesByBase, guid)
  local row, col = 0, 0
  local nextIndex = 1
  local function BuildBatch()
    if generation ~= state.gridBuildGeneration then
      return
    end
    local processed = 0
    while nextIndex <= #items and processed < GRID_BUILD_BATCH_SIZE do
      local entry = items[nextIndex]
      nextIndex = nextIndex + 1
      processed = processed + 1
      local slot = slotByItemId[entry.id]
      if slot ~= nil then
        local widget = uc.ConstructItemSlotButton(state.gridPanel, state.tree, slot, entry.count)
        if widget ~= nil then
          local ok = pcall(function()
            local gridSlot = state.gridPanel:AddChildToUniformGrid(widget, row, col)
            gridSlot:SetHorizontalAlignment(0) 
          end)
          if ok then
            state.decorations.gridCells[#state.decorations.gridCells + 1] = widget
            local itemId = entry.id
            state.gridCellWidgets[itemId] = widget
            if itemId == state.selectedItem then
              uc.SetItemSlotSelected(widget, true)
            end
            uc.WatchItemSlotClickHook(widget, "grid_cell_" .. itemId, function()
              local previousItem = state.selectedItem
              if previousItem ~= nil and previousItem ~= itemId then
                local previousWidget = state.gridCellWidgets[previousItem]
                if previousWidget ~= nil then uc.SetItemSlotSelected(previousWidget, false) end
              end
              uc.SetItemSlotSelected(widget, true)
              state.selectedItem = itemId
              local maxStack = snap.maxStackByItem[itemId]
              state.itemMaxStack = (maxStack ~= nil and maxStack > 0) and maxStack or SLIDER_MAX_FALLBACK
              uc.SetSelectNumRange(state.minSelectNum, 0, state.itemMaxStack)
              uc.SetSelectNumRange(state.maxSelectNum, 0, state.itemMaxStack)
              local clampedMin = math.max(0, math.min(uc.GetSelectNumValue(state.minSelectNum) or 0, state.itemMaxStack))
              local clampedMax = math.max(0, math.min(uc.GetSelectNumValue(state.maxSelectNum) or state.itemMaxStack, state.itemMaxStack))
              uc.SetSelectNumValue(state.minSelectNum, clampedMin)
              uc.SetSelectNumValue(state.maxSelectNum, clampedMax)
              RefreshSaveTooltip()
            end)
            col = col + 1
            if col >= GRID_COLS then col = 0 row = row + 1 end
          else
            util.Log("route_editor", "AddChildToUniformGrid failed for " .. entry.id, "ERROR")
          end
        else
          util.Log("route_editor", "ConstructItemSlotButton failed for " .. entry.id, "ERROR")
        end
      end
    end
    if nextIndex <= #items then
      ExecuteInGameThreadWithDelay(1, BuildBatch)
    else
      if col > 0 then
        while col < GRID_COLS do
          local placeholder = uc.ConstructEmptyGridCell(state.tree, GRID_CELL)
          if placeholder ~= nil then
            local ok = pcall(function()
              local gridSlot = state.gridPanel:AddChildToUniformGrid(placeholder, row, col)
              gridSlot:SetHorizontalAlignment(0) 
            end)
            if ok then state.decorations.gridCells[#state.decorations.gridCells + 1] = placeholder end
          end
          col = col + 1
        end
      end
    end
  end
  BuildBatch()
end
local function RefreshBaseRowAvailability(rowsKey, excludeGuid)
  local buttons = state.baseRowButtons[rowsKey] or {}
  local labels = state.baseRowLabels[rowsKey] or {}
  for guid, button in pairs(buttons) do
    local unavailable = guid == excludeGuid
    uc.SetQuestListButtonUnavailable(button, unavailable)
    uc.SetWidgetOpacity(labels[guid], unavailable and 0.4 or 1.0)
  end
end
local function SetFromBase(guid)
  if guid == state.toGuid then
    state.toGuid = nil
    RefreshBaseRowSelection("to", nil, false)
  end
  state.fromGuid = guid
  RefreshBaseRowSelection("from", guid, false)
  RefreshBaseRowAvailability("to", guid)
  RebuildGrid()
  RefreshSaveTooltip()
end
local function SetToBase(guid)
  if guid == state.fromGuid then return end
  state.toGuid = guid
  RefreshBaseRowSelection("to", guid, false)
  RefreshSaveTooltip()
end
local function build(panel, tree)
  state.panel, state.tree = panel, tree
  state.decorations = { chrome = {}, baseRows = {}, gridCells = {} }
  state.baseRowButtons = { from = {}, to = {} }
  state.baseRowLabels = { from = {}, to = {} }
  state.baseRowPicked = { from = nil, to = nil }
  state.saveTooltipWidget, state.saveTooltipLabel = nil, nil
  uc.ClearWatchedClicks() 
  uc.ClearWatchedItemSlotClicks() 
  local host = uc.BuildCommonWindowHost(panel, tree, PANEL_W, PANEL_H)
  if not host then
    util.Log("route_editor", "build: BuildCommonWindowHost failed - aborting, no window to show", "ERROR")
    return
  end
  state.decorations.chrome[#state.decorations.chrome + 1] = host.window
  state.shell = host.window
  local contentPanel = host.contentPanel
  state.contentPanel = contentPanel
  local layout = ComputeLayout(panel)
  uc.ConstructHeaderBlock(tree, contentPanel, LEFT_X, layout.fromHeaderY, LEFT_W, layout.headerMetrics, "Source base", state.decorations.chrome)
  local fromScrollBox = uc.ConstructScrollBox(tree)
  uc.PlaceAt(contentPanel, fromScrollBox, LEFT_X, layout.fromListY, LEFT_W, layout.fromListH)
  state.fromScrollBox = fromScrollBox
  uc.ConstructHeaderBlock(tree, contentPanel, LEFT_X, layout.toHeaderY, LEFT_W, layout.headerMetrics, "Destination base", state.decorations.chrome)
  local toScrollBox = uc.ConstructScrollBox(tree)
  uc.PlaceAt(contentPanel, toScrollBox, LEFT_X, layout.toListY, LEFT_W, layout.toListH)
  state.toScrollBox = toScrollBox
  uc.ConstructHeaderBlock(tree, contentPanel, CENTER_X, layout.gridHeaderY, CENTER_W, layout.headerMetrics, "Items on source base", state.decorations.chrome)
  local gridScrollBox = uc.ConstructScrollBox(tree)
  uc.PlaceAt(contentPanel, gridScrollBox, CENTER_X, layout.gridListY, CENTER_W, PANEL_H - layout.gridListY - PADDING, 10)
  state.gridScrollBox = gridScrollBox
  local gridPanelClass = StaticFindObject("/Script/UMG.UniformGridPanel")
  local gridPanel = StaticConstructObject(gridPanelClass, tree)
  pcall(function() gridPanel:SetMinDesiredSlotWidth(GRID_CELL) end)
  pcall(function() gridPanel:SetMinDesiredSlotHeight(GRID_CELL) end)
  pcall(function()
    local padding = gridPanel.SlotPadding
    padding.Bottom = GRID_GAP
    gridPanel.SlotPadding = padding
  end)
  pcall(function() gridScrollBox:AddChild(gridPanel) end)
  state.gridPanel = gridPanel
  uc.ConstructHeaderBlock(tree, contentPanel, RIGHT_X, layout.minHeaderY, RIGHT_W, layout.headerMetrics, "Keep min at source", state.decorations.chrome)
  local minSelectNum = uc.ConstructSelectNumWidget(contentPanel, tree)
  uc.PlaceOrLog(minSelectNum, "route_editor build: min keep-num picker", contentPanel, RIGHT_X, layout.minSelectNumY, RIGHT_W, SELECT_NUM_H)
  state.minSelectNum = minSelectNum
  uc.ConstructHeaderBlock(tree, contentPanel, RIGHT_X, layout.maxHeaderY, RIGHT_W, layout.headerMetrics, "Keep max at destination", state.decorations.chrome)
  local maxSelectNum = uc.ConstructSelectNumWidget(contentPanel, tree)
  uc.PlaceOrLog(maxSelectNum, "route_editor build: max keep-num picker", contentPanel, RIGHT_X, layout.maxSelectNumY, RIGHT_W, SELECT_NUM_H)
  state.maxSelectNum = maxSelectNum
  local buttonY = PANEL_H - PADDING - layout.nativeButtonH
  local saveButton, saveClick = uc.ConstructNativeButton(contentPanel, tree, "Save")
  uc.PlaceOrLog(saveButton, "route_editor build: \"Save\" button", contentPanel, RIGHT_X, buttonY, NATIVE_BUTTON_W, layout.nativeButtonH)
  state.saveButton, state.saveClick = saveButton, saveClick
  local cancelButton, cancelClick = uc.ConstructNativeButton(contentPanel, tree, "Cancel")
  uc.PlaceOrLog(cancelButton, "route_editor build: \"Cancel\" button", contentPanel, RIGHT_X + NATIVE_BUTTON_W + BUTTON_GAP, buttonY, NATIVE_BUTTON_W, layout.nativeButtonH)
  state.cancelButton, state.cancelClick = cancelButton, cancelClick
  uc.WatchClickHook(saveClick, "save", function() M.do_save() end)
  uc.WatchClickHook(cancelClick, "cancel", function() state.deps.on_cancel() end)
  BuildBaseList(fromScrollBox, "from", SetFromBase, layout.baseRowH, layout.baseRowSpacing)
  BuildBaseList(toScrollBox, "to", SetToBase, layout.baseRowH, layout.baseRowSpacing)
  state.built = true
end
local function set_all_visible(visible)
  state.visible = visible
  uc.SetWidgetsVisible(state.decorations.chrome, {
    state.fromScrollBox, state.toScrollBox, state.gridScrollBox,
    state.minSelectNum, state.maxSelectNum, state.saveButton, state.cancelButton,
  }, visible)
end
function M.do_save()
  local validationError = ComputeSaveValidationError()
  if validationError ~= nil then
    util.Log("route_editor", "Save blocked - " .. validationError, "WARN")
    return
  end
  local routes = state.deps.get_routes()
  local minValue = uc.GetSelectNumValue(state.minSelectNum) or 0
  local maxValue = uc.GetSelectNumValue(state.maxSelectNum) or state.itemMaxStack
  local route = {
    item = state.selectedItem,
    from = state.fromGuid, to = state.toGuid,
    keep_min = math.floor(minValue), keep_max = math.floor(maxValue),
  }
  local newRoutes = {}
  for i, r in ipairs(routes) do newRoutes[i] = r end
  if state.editingIndex ~= nil then
    newRoutes[state.editingIndex] = route
  else
    newRoutes[#newRoutes + 1] = route
  end
  state.deps.on_change_routes(newRoutes)
  state.deps.on_done()
end
function M.show(panel, tree, deps, editingIndex, route)
  state.deps = deps
  pcall(function() deps.refresh_bases() end)
  if not state.built then
    build(panel, tree)
  end
  state.editingIndex = editingIndex
  state.lastSnapshot = deps.get_snapshot()
  state.fromGuid = route and route.from or nil
  state.toGuid = route and route.to or nil
  if state.fromGuid ~= nil and deps.base_labels.is_deleted(state.fromGuid) then state.fromGuid = nil end
  if state.toGuid ~= nil and deps.base_labels.is_deleted(state.toGuid) then state.toGuid = nil end
  state.selectedItem = route and route.item or nil
  state.itemMaxStack = (route and state.lastSnapshot.maxStackByItem[route.item]) or SLIDER_MAX_FALLBACK
  RefreshSaveTooltip()
  RefreshBaseRowSelection("from", state.fromGuid)
  RefreshBaseRowSelection("to", state.toGuid)
  RefreshBaseRowAvailability("to", state.fromGuid)
  uc.SetSelectNumRange(state.minSelectNum, 0, state.itemMaxStack)
  uc.SetSelectNumValue(state.minSelectNum, (route and route.keep_min) or 0)
  uc.SetSelectNumRange(state.maxSelectNum, 0, state.itemMaxStack)
  uc.SetSelectNumValue(state.maxSelectNum, (route and route.keep_max) or state.itemMaxStack)
  set_all_visible(true)
  RebuildGrid()
end
function M.hide()
  uc.CloseShell(state)
  state.gridBuildGeneration = state.gridBuildGeneration + 1
  set_all_visible(false)
end
function M.is_built() return state.built end
function M.is_visible() return state.visible end
return M
