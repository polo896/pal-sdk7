local config = require("config")
local logistics_policy = require("logistics_policy")
local base_labels = require("base_labels")
local item_categories = require("item_categories")
local ui = require("ui")
local uc = require("ui_common")
local util = require("util")
local cfg = config.load()
if #cfg.routes == 0 then
  local created, path = config.ensure_default_file()
  if created then
    util.Log("main", "startup: settings.ini has no routes - wrote a template to " .. tostring(path))
  else
    util.Log("main", "startup: settings.ini has no routes (none found, template could not be written)", "WARN")
  end
else
  util.Log("main", "startup: loaded " .. #cfg.routes .. " route(s) from " .. tostring(cfg.loaded_path))
end
local function GuidKey(guid)
  local ok, key = pcall(function() return string.format("%d_%d_%d_%d", guid.A, guid.B, guid.C, guid.D) end)
  if ok then return key end
  return nil
end
local function IsCDO(obj)
  local okName, fullName = pcall(function() return obj:GetFullName() end)
  return okName and fullName ~= nil and fullName:find("Default__", 1, true) ~= nil
end
local PAL_UTILITY_PATH = "/Script/Pal.Default__PalUtility"
local function GetPalUtility()
  local ok, library = pcall(function() return StaticFindObject(PAL_UTILITY_PATH) end)
  if ok and library ~= nil and library:IsValid() then return library end
  return nil
end
local function FindLiveBaseCampManager()
  local managers = FindAllOf("PalBaseCampManager") or {}
  for i = 1, #managers do
    local m = managers[i]
    if m ~= nil and m:IsValid() and not IsCDO(m) then return m end
  end
  return nil
end
local function ForEachBaseGuid(mgr, fn)
  local outIds = {}
  local okCall = pcall(function() mgr:GetBaseCampIds(outIds) end)
  if not okCall then return false, nil end
  local okCount, idCount = pcall(function() return #outIds end)
  if not okCount or idCount == nil then return true, nil end
  for j = 1, idCount do
    local okGet, guid = pcall(function() return outIds[j]:get() end)
    if okGet and guid ~= nil then
      local key = GuidKey(guid)
      if key ~= nil then fn(key, guid) end
    end
  end
  return true, idCount
end
local function FindStorageAggregatorModule(base)
  local okModules, modules = pcall(function() return base.ModuleArray end)
  if not okModules or modules == nil then return nil end
  local okCount, modCount = pcall(function() return #modules end)
  if not okCount or modCount == nil then return nil end
  for mi = 1, modCount do
    local mod = modules[mi]
    if mod ~= nil then
      local okValid, isValid = pcall(function() return mod:IsValid() end)
      if okValid and isValid then
        local okFn, fn = pcall(function() return mod:GetFullName() end)
        if okFn and fn ~= nil and fn:find("PalBaseCampModuleItemStorage", 1, true) ~= nil then
          return mod
        end
      end
    end
  end
  return nil
end
local function GetSlotInfo(slot, wantMaxStack, wantIsMax)
  local okItem, itemId, count = pcall(function()
    return slot:GetItemId().StaticId:ToString(), slot.StackCount
  end)
  if not okItem then return nil end
  local info = { itemId = itemId, count = count }
  if wantMaxStack then
    local okMax, maxStack = pcall(function() return slot:GetMaxStack() end)
    info.maxStack = okMax and maxStack or nil
  end
  if wantIsMax then
    local okIsMax, isMax = pcall(function() return slot:IsMaxStack() end)
    info.isMax = okIsMax and isMax or nil
  end
  return info
end
local function RegisterFallbackStorage(state, storage, isFeeder)
  item_categories.EnsureCategoryTablesBuilt(GetPalUtility(), storage)
  local okContainer, containerModule = pcall(function() return storage:GetItemContainerModule() end)
  if not (okContainer and containerModule ~= nil and containerModule:IsValid()) then return end
  local okBase, base = pcall(function() return storage:GetBaseCampModelBelongTo() end)
  if not (okBase and base ~= nil and base:IsValid()) then return end
  local okGuid, guid = pcall(function() return base:GetId() end)
  local key = okGuid and GuidKey(guid) or nil
  if key == nil then return end
  local okContainerObj, containerObj = pcall(function() return containerModule:GetContainer() end)
  if not (okContainerObj and containerObj ~= nil and containerObj:IsValid()) then return end
  if state.storagesByBase[key] == nil then
    state.storagesByBase[key] = {}
    base_labels.label_for(key)
  end
  if state.storageAggregatorByBase[key] == nil then
    state.storageAggregatorByBase[key] = FindStorageAggregatorModule(base)
  end
  table.insert(state.storagesByBase[key], { module = containerModule, container = containerObj, isFeeder = isFeeder })
  state.recordSlots(key, containerObj)
end
local function Snapshot()
  local state = {
    stock = {}, storagesByBase = {}, maxStackByItem = {}, itemWeightById = {}, itemCategoryById = {},
    storageAggregatorByBase = {},
  }
  local function RecordSlots(key, container)
    local okSlots, slots = pcall(function() return container.ItemSlotArray end)
    if okSlots and slots ~= nil then
      state.stock[key] = state.stock[key] or {}
      for si = 1, #slots do
        local info = GetSlotInfo(slots[si], true, false)
        if info ~= nil and info.count ~= nil and info.count > 0 then
          local itemId, count = info.itemId, info.count
          state.stock[key][itemId] = (state.stock[key][itemId] or 0) + count
          if state.maxStackByItem[itemId] == nil and info.maxStack ~= nil and info.maxStack > 0 then
            state.maxStackByItem[itemId] = info.maxStack
          end
          if state.itemWeightById[itemId] == nil or state.itemCategoryById[itemId] == nil then
            local w, cat = item_categories.ResolveItemWeightAndCategory(itemId, slots[si])
            if state.itemWeightById[itemId] == nil then state.itemWeightById[itemId] = w end
            if state.itemCategoryById[itemId] == nil then state.itemCategoryById[itemId] = cat end
          end
        end
      end
    end
  end
  state.recordSlots = RecordSlots
  local usedPrimary = false
  local mgr = FindLiveBaseCampManager()
  if mgr ~= nil then
    local library = GetPalUtility()
    local mapMgr = nil
    if library ~= nil then
      local okMapMgr, m = pcall(function() return library:GetMapObjectManager(mgr) end)
      if okMapMgr and m ~= nil and m:IsValid() then mapMgr = m end
    end
    if mapMgr ~= nil then
      local okIds, idCount = ForEachBaseGuid(mgr, function(key, guid)
        local outModel = {}
        local okModel, modelBool = pcall(function() return mgr:TryGetModel(guid, outModel) end)
        local model = (okModel and modelBool and outModel.OutModel ~= nil and outModel.OutModel:IsValid())
          and outModel.OutModel or nil
        if model == nil then return end
        base_labels.label_for(key) 
        local mod = FindStorageAggregatorModule(model)
        if mod == nil then return end
        state.storageAggregatorByBase[key] = mod
        local okInfos, infos = pcall(function() return mod.ContainerInfos end)
        if not (okInfos and infos ~= nil) then return end
        local okInfoCount, infoCount = pcall(function() return #infos end)
        if not (okInfoCount and infoCount ~= nil) then return end
        for ii = 1, infoCount do
          local info = infos[ii]
          local okOwner, ownerGuid = pcall(function() return info.OwnerMapObjectConcreteModelInstanceId end)
          if okOwner and ownerGuid ~= nil then
            local okStorage, storage = pcall(function() return mapMgr:FindConcreteModel(ownerGuid) end)
            if okStorage and storage ~= nil and storage:IsValid() then
              local okContainer, containerModule = pcall(function() return storage:GetItemContainerModule() end)
              if okContainer and containerModule ~= nil and containerModule:IsValid() then
                item_categories.EnsureCategoryTablesBuilt(library, storage)
                local okContainerObj, containerObj = pcall(function() return containerModule:GetContainer() end)
                if okContainerObj and containerObj ~= nil and containerObj:IsValid() then
                  if state.storagesByBase[key] == nil then
                    state.storagesByBase[key] = {}
                  end
                  table.insert(state.storagesByBase[key], {
                    module = containerModule, container = containerObj, isFeeder = item_categories.IsFoodBoxModel(storage),
                  })
                  RecordSlots(key, containerObj)
                end
              end
            end
          end
        end
      end)
      usedPrimary = okIds and idCount ~= nil and idCount > 0
    end
  end
  if not usedPrimary then
    local storages = FindAllOf("PalMapObjectItemStorageModel") or {}
    for i = 1, #storages do
      if storages[i] ~= nil and storages[i]:IsValid() then
        RegisterFallbackStorage(state, storages[i], false)
      end
    end
    local foodBoxes = FindAllOf("PalMapObjectPalFoodBoxModel") or {}
    for i = 1, #foodBoxes do
      if foodBoxes[i] ~= nil and foodBoxes[i]:IsValid() then
        RegisterFallbackStorage(state, foodBoxes[i], true)
      end
    end
  end
  return {
    stock = state.stock, storagesByBase = state.storagesByBase, maxStackByItem = state.maxStackByItem,
    itemWeightById = state.itemWeightById, itemCategoryById = state.itemCategoryById,
    storageAggregatorByBase = state.storageAggregatorByBase,
  }
end
local function RefreshBases()
  local foundGuids = {}
  local count = 0
  local mgr = FindLiveBaseCampManager()
  local usedManager = false
  if mgr ~= nil then
    local okIds = ForEachBaseGuid(mgr, function(key)
      base_labels.label_for(key)
      if foundGuids[key] == nil then count = count + 1 end
      foundGuids[key] = true
    end)
    usedManager = okIds
  end
  if not usedManager then
    local bases = FindAllOf("PalBaseCampModel") or {}
    for i = 1, #bases do
      local base = bases[i]
      if base ~= nil and base:IsValid() and not IsCDO(base) then
        local okGuid, guid = pcall(function() return base:GetId() end)
        local key = okGuid and GuidKey(guid) or nil
        if key ~= nil then
          base_labels.label_for(key)
          if foundGuids[key] == nil then count = count + 1 end
          foundGuids[key] = true
        end
      end
    end
  end
  base_labels.mark_scan_result(foundGuids)
  local keepGuids = {}
  for _, route in ipairs(cfg.routes or {}) do
    if route.from ~= nil then keepGuids[route.from] = true end
    if route.to ~= nil then keepGuids[route.to] = true end
  end
  local purged = base_labels.purge_deleted(keepGuids)
  if purged > 0 then
    util.Log("main", "RefreshBases: purged " .. purged .. " deleted base(s) no route references any more")
  end
  return count
end
local FALLBACK_MAX_WEIGHT = 500
local function GetMaxTransportWeight()
  local okPc, pc = pcall(function() return FindFirstOf("PlayerController") end)
  if okPc and pc ~= nil and pc:IsValid() then
    local library = GetPalUtility()
    if library ~= nil then
      local okInv, inv = pcall(function() return library:GetLocalInventoryData(pc) end)
      if okInv and inv ~= nil and inv:IsValid() then
        local okW, w = pcall(function() return inv:GetMaxItemWeight() end)
        if okW and w ~= nil and w > 0 then
          return w, "player"
        end
      end
    end
  end
  return FALLBACK_MAX_WEIGHT, "fallback"
end
local function ResolveRoutes(routes, maxStackByItem)
  local resolved = {}
  for _, route in ipairs(routes) do
    local r = {}
    for k, v in pairs(route) do r[k] = v end
    if r.keep_max == nil then
      r.keep_max = maxStackByItem[r.item]
    end
    resolved[#resolved + 1] = r
  end
  return resolved
end
local function GatherSourceSlots(storagesByBase, guidKey, item, category)
  local list = {}
  for _, entry in ipairs(item_categories.OrderContainersByFeederPreference(storagesByBase, guidKey, category, false)) do
    if entry.container ~= nil and entry.container:IsValid() then
      local okSlots, slots = pcall(function() return entry.container.ItemSlotArray end)
      if okSlots and slots ~= nil then
        for i = 1, #slots do
          local info = GetSlotInfo(slots[i], false, false)
          if info ~= nil and info.itemId == item and info.count ~= nil and info.count > 0 then
            list[#list + 1] = { slot = slots[i], container = entry.container }
          end
        end
      end
    end
  end
  return list
end
local function BuildDestScanState(storagesByBase, guidKey, item, category)
  local candidates = {}
  for _, entry in ipairs(item_categories.OrderContainersByFeederPreference(storagesByBase, guidKey, category, true)) do
    if entry.container ~= nil and entry.container:IsValid() and item_categories.IsFeederAllowedForCategory(entry.isFeeder, category) then
      local okFilter, filterOffList = pcall(function() return entry.container.FilterPreference.FilterOffList end)
      if not (okFilter and not item_categories.IsItemAllowedByFilter(filterOffList, category)) then
        local okSlots, slots = pcall(function() return entry.container.ItemSlotArray end)
        if okSlots and slots ~= nil then
          for i = 1, #slots do
            candidates[#candidates + 1] = { slot = slots[i], container = entry.container }
          end
        end
      end
    end
  end
  return { candidates = candidates, cursor = 1, emptySlots = {}, lastMatch = nil }
end
local function NextDestSlot(state, item)
  if state.lastMatch ~= nil then
    local info = GetSlotInfo(state.lastMatch.slot, false, true)
    if info ~= nil and info.itemId == item and not info.isMax then
      return state.lastMatch
    end
    state.lastMatch = nil
  end
  while state.cursor <= #state.candidates do
    local cand = state.candidates[state.cursor]
    state.cursor = state.cursor + 1
    local info = GetSlotInfo(cand.slot, false, true)
    if info ~= nil then
      if info.itemId == item and not info.isMax then
        state.lastMatch = cand
        return cand
      elseif info.count == 0 then
        state.emptySlots[#state.emptySlots + 1] = cand
      end
    end
  end
  while #state.emptySlots > 0 do
    local cand = table.remove(state.emptySlots, 1)
    local okCount, count = pcall(function() return cand.slot.StackCount end)
    if okCount and count == 0 then
      state.lastMatch = cand
      return cand
    end
  end
  return nil
end
local function RealDestRoom(storagesByBase, guidKey, item, defaultMaxStack, category)
  local room = 0
  for _, entry in ipairs(storagesByBase[guidKey] or {}) do
    if entry.container ~= nil and entry.container:IsValid() and item_categories.IsFeederAllowedForCategory(entry.isFeeder, category) then
      local okFilter, filterOffList = pcall(function() return entry.container.FilterPreference.FilterOffList end)
      if not (okFilter and not item_categories.IsItemAllowedByFilter(filterOffList, category)) then
        local okSlots, slots = pcall(function() return entry.container.ItemSlotArray end)
        if okSlots and slots ~= nil then
          for i = 1, #slots do
            local info = GetSlotInfo(slots[i], true, false)
            if info ~= nil and info.count ~= nil then
              if info.count == 0 then
                room = room + (defaultMaxStack or 0)
              elseif info.itemId == item then
                local cap = (info.maxStack ~= nil and info.maxStack > 0) and info.maxStack or (defaultMaxStack or 0)
                room = room + math.max(cap - info.count, 0)
              end
            end
          end
        end
      end
    end
  end
  return room
end
local function ApplyRealCapacity(toTransfer, storagesByBase, maxStackByItem)
  local corrected = {}
  for src, dsts in pairs(toTransfer) do
    for dst, bucket in pairs(dsts) do
      local items, totalWeight = {}, 0
      for _, it in ipairs(bucket.items) do
        local room = RealDestRoom(storagesByBase, dst, it.item, maxStackByItem[it.item], it.category)
        local amount = math.min(it.amount, room)
        if amount > 0 then
          local weight = (it.item_weight ~= nil and it.item_weight > 0) and (amount * it.item_weight) or nil
          items[#items + 1] = {
            item = it.item, amount = amount, item_weight = it.item_weight, weight = weight, category = it.category,
          }
          totalWeight = totalWeight + (weight or 0)
        end
      end
      if #items > 0 then
        corrected[src] = corrected[src] or {}
        corrected[src][dst] = { items = items, totalWeight = totalWeight }
      end
    end
  end
  return corrected
end
local function ExecuteTransfer(storagesByBase, storageAggregatorByBase, planItem)
  local sourceEntries = GatherSourceSlots(storagesByBase, planItem.from, planItem.item, planItem.category)
  if #sourceEntries == 0 then
    return 0
  end
  local srcAggregator = storageAggregatorByBase[planItem.from]
  local dstAggregator = storageAggregatorByBase[planItem.to]
  local destScan = BuildDestScanState(storagesByBase, planItem.to, planItem.item, planItem.category)
  local remaining = planItem.amount
  local totalMoved = 0
  local outOfDestRoom = false
  for _, sourceEntry in ipairs(sourceEntries) do
    if remaining <= 0 or outOfDestRoom then break end
    local sourceSlot = sourceEntry.slot
    local okAvail, avail = pcall(function() return sourceSlot.StackCount end)
    local pull = (okAvail and avail ~= nil) and math.min(remaining, avail) or 0
    while pull > 0 do
      local destEntry = NextDestSlot(destScan, planItem.item)
      if destEntry == nil then
        outOfDestRoom = true
        break
      end
      local destSlot = destEntry.slot
      local okMove, moved = pcall(function()
        local wasEmpty = destSlot.StackCount == 0
        if wasEmpty then destSlot.ItemId = sourceSlot.ItemId end
        local capacity = destSlot:GetMaxStack() - destSlot.StackCount
        local m = math.min(pull, capacity)
        if m > 0 then
          destSlot.StackCount = destSlot.StackCount + m
          sourceSlot.StackCount = sourceSlot.StackCount - m
        end
        return m
      end)
      if not okMove or moved == nil or moved <= 0 then
        outOfDestRoom = true
        break
      end
      if srcAggregator ~= nil then
        local okSrcNotify, errSrcNotify = pcall(function() srcAggregator:OnUpdateItemContainer(sourceEntry.container) end)
        if not okSrcNotify then util.Log("main", "source OnUpdateItemContainer call failed: " .. tostring(errSrcNotify), "ERROR") end
      end
      if dstAggregator ~= nil then
        local okDstNotify, errDstNotify = pcall(function() dstAggregator:OnUpdateItemContainer(destEntry.container) end)
        if not okDstNotify then util.Log("main", "dest OnUpdateItemContainer call failed: " .. tostring(errDstNotify), "ERROR") end
      end
      pull = pull - moved
      remaining = remaining - moved
      totalMoved = totalMoved + moved
    end
  end
  return totalMoved
end
local courier = { current_base = nil, skipped = {}, lastLoggedKey = nil }
local Label = base_labels.label_for
local function ExecutePairTransfer(storagesByBase, storageAggregatorByBase, decision, maxWeight)
  local items = {}
  for _, it in ipairs(decision.pair.items) do items[#items + 1] = it end
  table.sort(items, function(a, b) return (a.weight or 0) < (b.weight or 0) end)
  local remaining = maxWeight
  local movedAmount = 0
  local movedWeight = 0
  local results = {}
  for _, it in ipairs(items) do
    local amount = it.amount
    if it.item_weight ~= nil and it.item_weight > 0 then
      amount = math.min(amount, math.floor(remaining / it.item_weight))
    end
    local moved = 0
    if amount > 0 then
      moved = ExecuteTransfer(storagesByBase, storageAggregatorByBase, {
        item = it.item, from = decision.src, to = decision.dst,
        amount = amount, item_weight = it.item_weight, category = it.category,
      }) or 0
      if moved > 0 then
        movedAmount = movedAmount + moved
        if it.item_weight ~= nil and it.item_weight > 0 then
          local weightMoved = moved * it.item_weight
          remaining = remaining - weightMoved
          movedWeight = movedWeight + weightMoved
        end
      end
    end
    results[#results + 1] = { item = it.item, moved = moved, planned = it.amount }
  end
  return movedAmount, movedWeight, results
end
local function DoCycle()
  local ok, result = pcall(function()
    local snap = Snapshot()
    if courier.current_base == nil or snap.storagesByBase[courier.current_base] == nil then
      for guidKey in pairs(snap.storagesByBase) do courier.current_base = guidKey break end
    end
    local routes = ResolveRoutes(cfg.routes, snap.maxStackByItem)
    local toTransfer = logistics_policy.build_transfer_map(snap.stock, routes, snap.itemWeightById, snap.itemCategoryById)
    toTransfer = ApplyRealCapacity(toTransfer, snap.storagesByBase, snap.maxStackByItem)
    local decision = logistics_policy.decide_next_hop(courier.current_base, toTransfer, courier.skipped)
    if decision.mode == logistics_policy.MODE.IDLE then
      if courier.lastLoggedKey ~= "idle" then
        courier.lastLoggedKey = "idle"
        util.Log("main", "idle - nothing pending across " .. #routes .. " configured route(s)")
      end
    elseif decision.mode == logistics_policy.MODE.REPOSITION then
      local key = "reposition:" .. tostring(decision.src) .. "->" .. tostring(decision.dst)
      if courier.lastLoggedKey ~= key then
        courier.lastLoggedKey = key
        util.Log("main", "heading to " .. Label(decision.src) .. " (needed at " .. Label(decision.dst) .. ")")
      end
      courier.skipped = logistics_policy.update_skipped(toTransfer, courier.skipped, nil)
      courier.current_base = decision.src
    elseif decision.mode == logistics_policy.MODE.DELIVER then
      courier.lastLoggedKey = nil
      local maxWeight, weightSource = GetMaxTransportWeight()
      local movedAmount, movedWeight, results = ExecutePairTransfer(snap.storagesByBase, snap.storageAggregatorByBase, decision, maxWeight)
      local itemParts = {}
      for _, r in ipairs(results) do
        itemParts[#itemParts + 1] = r.item .. " " .. r.moved .. "/" .. r.planned
      end
      local summary = "transfer " .. Label(decision.src) .. " -> " .. Label(decision.dst) .. ": " ..
        table.concat(itemParts, ", ") .. "; weight=" .. string.format("%.1f", movedWeight) .. "/" ..
        string.format("%.1f", maxWeight) .. " (" .. weightSource .. ")"
      if movedAmount > 0 then
        util.Log("main", summary)
        courier.skipped = logistics_policy.update_skipped(toTransfer, courier.skipped, decision.key)
        courier.current_base = decision.dst
      else
        util.Log("main", summary .. " - nothing fit at destination, staying at " .. Label(decision.src), "WARN")
        courier.skipped = logistics_policy.update_skipped(toTransfer, courier.skipped, nil)
      end
    end
    return decision.mode
  end)
  if not ok then
    util.Log("main", "cycle error: " .. tostring(result), "ERROR")
    return nil
  end
  return result
end
local REPOSITION_INTERVAL_SECONDS = 10
local CYCLE_INTERVAL_SECONDS = 30
local function NextIntervalSeconds(mode)
  if mode == logistics_policy.MODE.REPOSITION then return REPOSITION_INTERVAL_SECONDS end
  return CYCLE_INTERVAL_SECONDS
end
local function ScheduledLoop()
  local mode = nil
  if cfg.enabled then
    mode = DoCycle()
  end
  local seconds = math.max(5, NextIntervalSeconds(mode))
  local okDelay = pcall(function()
    ExecuteWithDelay(seconds * 1000, ScheduledLoop)
  end)
  if not okDelay then
    util.Log("main", "ExecuteWithDelay unavailable - cycle will not repeat automatically", "ERROR")
  end
end
local function SaveConfigAndLog(what)
  local okSave, savedPath = config.save(cfg)
  util.Log("main", what .. " saved=" .. tostring(okSave) .. (okSave and (" -> " .. tostring(savedPath)) or ""))
end
local function RouteSortLabel(guid)
  if guid == nil or base_labels.is_deleted(guid) then return "" end
  return base_labels.label_for(guid)
end
local function SortedRoutes(routes)
  local sorted = {}
  for i, r in ipairs(routes) do sorted[i] = r end
  table.sort(sorted, function(a, b)
    local aFrom, bFrom = RouteSortLabel(a.from), RouteSortLabel(b.from)
    if aFrom ~= bFrom then return aFrom < bFrom end
    local aTo, bTo = RouteSortLabel(a.to), RouteSortLabel(b.to)
    if aTo ~= bTo then return aTo < bTo end
    return tostring(a.item) < tostring(b.item)
  end)
  return sorted
end
local function RouteEditorDeps()
  return {
    get_snapshot = Snapshot,
    refresh_bases = RefreshBases,
    base_labels = base_labels,
    get_general = function()
      return { enabled = cfg.enabled }
    end,
    on_change_general = function(enabled)
      cfg.enabled = enabled
      SaveConfigAndLog("general settings updated from UI: enabled=" .. tostring(enabled))
    end,
    get_routes = function() return SortedRoutes(cfg.routes) end,
    on_change_routes = function(newRoutes)
      cfg.routes = newRoutes
      SaveConfigAndLog("routes updated from UI: " .. #newRoutes .. " route(s)")
    end,
  }
end
local ESCAPE_CLOSE_DELAY_MS = 180
RegisterKeyBind(Key.ESCAPE, function()
  pcall(function()
    ExecuteWithDelay(ESCAPE_CLOSE_DELAY_MS, function() ui.close() end)
  end)
end)
local INVENTORY_WINDOW_CLASS_PATH = "/Game/Pal/Blueprint/UI/UserInterface/MainMenu/InventoryEquipment/WBP_InventoryEquipment.WBP_InventoryEquipment_C"
local PRIMARY_BUTTON_CLASS_PATH = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_CommonButton.WBP_CommonButton_C"
local function get_primary_button_class()
  local cls = StaticFindObject(PRIMARY_BUTTON_CLASS_PATH)
  if cls and cls:IsValid() then return cls end
  pcall(function() LoadAsset(PRIMARY_BUTTON_CLASS_PATH) end)
  cls = StaticFindObject(PRIMARY_BUTTON_CLASS_PATH)
  if cls and cls:IsValid() then return cls end
  return nil
end
local actionBarButtonState = {
  button = nil,
  hookRegistered = false,
  realHooksRegistered = false,
}
local function EnsureActionBarButton(panel)
  if actionBarButtonState.button and actionBarButtonState.button:IsValid() then
    return actionBarButtonState.button
  end
  local cls = get_primary_button_class()
  if not cls then util.Log("main", "action-bar-button: WBP_CommonButton_C class not found", "ERROR"); return nil end
  local library = uc.get_widget_blueprint_library()
  if not library then util.Log("main", "action-bar-button: WidgetBlueprintLibrary not found", "ERROR"); return nil end
  local button
  local ok, err = pcall(function()
    local owningPlayer = panel:GetOwningPlayer()
    button = library:Create(panel, cls, owningPlayer)
    if not button or not button:IsValid() then error("WidgetBlueprintLibrary.Create for WBP_CommonButton_C failed") end
    button:Setup(false)
    button:SetText(FText("Auto Haul"))
  end)
  if not ok or not button then
    util.Log("main", "action-bar-button: build failed - " .. tostring(err), "ERROR")
    return nil
  end
  local clickTarget = button
  local okInner, inner = pcall(function() return button.WBP_PalInvisibleButton end)
  if okInner and inner and inner:IsValid() then clickTarget = inner end
  uc.WatchClickHook(clickTarget, "action-bar-button", function()
    util.Log("main", "action-bar-button: clicked - opening route editor")
    ui.toggle(RouteEditorDeps())
  end, true)
  uc.PlaceAt(panel, button, uc.ScreenPxToSlate(panel, -2000), uc.ScreenPxToSlate(panel, -2000),
    uc.ScreenPxToSlate(panel, 220), uc.ScreenPxToSlate(panel, 56))
  uc.SetWidgetVisible(button, false)
  actionBarButtonState.button = button
  return button
end
local BUTTON_W_SCREEN, BUTTON_H_SCREEN, BOTTOM_MARGIN_SCREEN = 220, 56, 30
local function ShowActionBarButton()
  local layout = uc.FindPersistentLayout()
  if not layout then util.Log("main", "action-bar-button: no persistent layout", "ERROR"); return end
  local tree = layout.WidgetTree
  local treeName = tree:GetFullName()
  local panel = uc.FindNamedCanvasPanel(treeName, uc.PERSISTENT_HOST_PANEL_NAME)
  if not panel then util.Log("main", "action-bar-button: no host panel", "ERROR"); return end
  local button = EnsureActionBarButton(panel)
  if not button then return end
  local w = uc.ScreenPxToSlate(panel, BUTTON_W_SCREEN)
  local h = uc.ScreenPxToSlate(panel, BUTTON_H_SCREEN)
  local margin = uc.ScreenPxToSlate(panel, BOTTOM_MARGIN_SCREEN)
  uc.PlaceBottomCenter(panel, button, w, h, margin)
  uc.SetWidgetVisible(button, true)
end
local function HideActionBarButton()
  if actionBarButtonState.button and actionBarButtonState.button:IsValid() then
    uc.SetWidgetVisible(actionBarButtonState.button, false)
  end
end
local function RegisterInventoryWatcher()
  if actionBarButtonState.hookRegistered then return end
  actionBarButtonState.hookRegistered = true
  local okNotify, errNotify = pcall(function()
    NotifyOnNewObject(INVENTORY_WINDOW_CLASS_PATH, function(_)
      if actionBarButtonState.realHooksRegistered then return end
      actionBarButtonState.realHooksRegistered = true
      local okOpen, errOpen = pcall(function()
        RegisterHook(INVENTORY_WINDOW_CLASS_PATH .. ":Construct", function(self)
          ShowActionBarButton()
        end)
      end)
      if not okOpen then util.Log("main", "action-bar-button: Construct hook FAILED - " .. tostring(errOpen), "ERROR") end
      local okClose, errClose = pcall(function()
        RegisterHook(INVENTORY_WINDOW_CLASS_PATH .. ":Destruct", function(self)
          HideActionBarButton()
        end)
      end)
      if not okClose then util.Log("main", "action-bar-button: Destruct hook FAILED - " .. tostring(errClose), "ERROR") end
    end)
  end)
  if not okNotify then
    util.Log("main", "action-bar-button: NotifyOnNewObject FAILED - " .. tostring(errNotify), "ERROR")
  end
end
RegisterInventoryWatcher()
local started = false
local function StartOnce()
  if started then return end
  started = true
  util.Log("main", "starting cycle loop, interval=" .. CYCLE_INTERVAL_SECONDS .. "s")
  ScheduledLoop()
end
RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", StartOnce)
util.Log("main", "loaded - open your inventory and click 'Auto Haul' at the bottom of the screen to manage routes")
