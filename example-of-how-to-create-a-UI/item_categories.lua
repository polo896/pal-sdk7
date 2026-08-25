local util = require("util")
local M = {}
local CATEGORY_BY_TYPE_B = {
  [23] = "Ore",           
  [25] = "Ingot",         
  [26] = "Wood",          
  [27] = "Stone",         
  [28] = "Proccessing",   
  [29] = "Monster",       
  [30] = "Palegg",        
  [34] = "WazaMachine",   
  [35] = "ComsumeUpgrade", 
  [36] = "ComsumeUpgrade", 
  [37] = "ConsumeOther",  
  [38] = "ComsumeUpgrade", 
  [39] = "ComsumeUpgrade", 
  [40] = "ComsumeUpgrade", 
  [41] = "ComsumeUpgrade", 
  [42] = "ComsumeUpgrade", 
  [43] = "ConsumeOther",  
  [44] = "ComsumeUpgrade", 
  [45] = "ConsumeOther",  
  [71] = "ComsumeUpgrade", 
  [72] = "ConsumeOther",  
  [47] = "Food",          
  [48] = "Food",          
  [49] = "Food",          
  [50] = "Meal",          
  [51] = "Meal",          
  [52] = "Meal",          
  [53] = "Food",          
  [67] = "Accessory",     
}
local CATEGORY_BY_TYPE_A = {
  [1] = "Weapon",
  [2] = "PalSphere",      
  [3] = "Armor",
  [4] = "Accessory",
  [5] = "MaterialOther",  
  [6] = "ConsumeOther",   
  [7] = "Ammo",
  [8] = "Food",           
  [9] = "Essential",
  [10] = "Glider",
  [12] = "Blueprint",
}
local function ItemFilterCategory(typeA, typeB)
  return CATEGORY_BY_TYPE_B[typeB] or CATEGORY_BY_TYPE_A[typeA]
end
local itemResolveWarned = {}
function M.ResolveItemWeightAndCategory(itemId, slot)
  if slot ~= nil then
    local outTable = {}
    local okCall, boolReturn = pcall(function() return slot:TryGetStaticItemData(outTable) end)
    if okCall and boolReturn and outTable.OutStaticItemData ~= nil and outTable.OutStaticItemData:IsValid() then
      local staticData = outTable.OutStaticItemData
      local okW, w = pcall(function() return staticData.Weight end)
      local okT, typeA, typeB = pcall(function() return staticData.TypeA, staticData.TypeB end)
      local weight = (okW and w ~= nil) and w or nil
      local category = okT and ItemFilterCategory(typeA, typeB) or nil
      return weight, category
    end
  end
  if not itemResolveWarned[itemId] then
    itemResolveWarned[itemId] = true
    util.Log("item_categories", "weight/category lookup failed for " .. tostring(itemId) .. " (TryGetStaticItemData returned nothing) - this item moves uncapped by weight and ignores chest filters", "WARN")
  end
  return nil, nil
end
function M.IsItemAllowedByFilter(filterOffList, category)
  if filterOffList == nil or #filterOffList == 0 then return true end
  if category == nil then return true end
  for i = 1, #filterOffList do
    local okS, s = pcall(function() return filterOffList[i]:ToString() end)
    if okS and s == category then return false end
  end
  return true
end
local MIN_EXPECTED_CATEGORY_COUNT = 15
local function TryBuildLiveCategoryTables(library, worldContextObject)
  if library == nil then return false end
  local okGs, gs = pcall(function() return library:GetGameSetting(worldContextObject) end)
  if not (okGs and gs ~= nil and gs:IsValid()) then return false end
  local okPm, pm = pcall(function() return gs.ItemFilterPreference.PreferenceMap end)
  if not (okPm and pm ~= nil) then return false end
  local newA, newB, count = {}, {}, 0
  local okForEach = pcall(function()
    pm:ForEach(function(key, value)
      local okK, keyUnwrapped = pcall(function() return key:get() end)
      local okKs, name = false, nil
      if okK and keyUnwrapped ~= nil then
        okKs, name = pcall(function() return keyUnwrapped:ToString() end)
      end
      local okV, valUnwrapped = pcall(function() return value:get() end)
      if okKs and name ~= nil and okV and valUnwrapped ~= nil then
        local okB, typeB = pcall(function() return valUnwrapped.TypeB end)
        local lenB = (okB and typeB ~= nil) and select(2, pcall(function() return #typeB end)) or nil
        if lenB ~= nil and lenB > 0 then
          for i = 1, lenB do
            local okE, e = pcall(function() return typeB[i] end)
            if okE and e ~= nil then newB[e] = name end
          end
          count = count + 1
        else
          local okA, typeA = pcall(function() return valUnwrapped.TypeA end)
          local lenA = (okA and typeA ~= nil) and select(2, pcall(function() return #typeA end)) or nil
          if lenA ~= nil and lenA > 0 then
            for i = 1, lenA do
              local okE, e = pcall(function() return typeA[i] end)
              if okE and e ~= nil then newA[e] = name end
            end
            count = count + 1
          end
        end
      end
    end)
  end)
  if not okForEach or count < MIN_EXPECTED_CATEGORY_COUNT then return false end
  for k in pairs(CATEGORY_BY_TYPE_A) do CATEGORY_BY_TYPE_A[k] = nil end
  for k, v in pairs(newA) do CATEGORY_BY_TYPE_A[k] = v end
  for k in pairs(CATEGORY_BY_TYPE_B) do CATEGORY_BY_TYPE_B[k] = nil end
  for k, v in pairs(newB) do CATEGORY_BY_TYPE_B[k] = v end
  return true, count
end
local categoryTablesLiveAttempted = false
function M.EnsureCategoryTablesBuilt(library, candidate)
  if categoryTablesLiveAttempted or candidate == nil or not candidate:IsValid() then return end
  categoryTablesLiveAttempted = true
  local liveOk, liveCount = TryBuildLiveCategoryTables(library, candidate)
  if liveOk then
    util.Log("item_categories", "chest-filter categories: built live from PreferenceMap (" .. tostring(liveCount) .. " categories)")
  else
    util.Log("item_categories", "chest-filter categories: live build failed, using verified static fallback table", "WARN")
  end
end
function M.IsFoodBoxModel(storage)
  local okFn, fn = pcall(function() return storage:GetFullName() end)
  return okFn and fn ~= nil and fn:find("PalMapObjectPalFoodBoxModel", 1, true) ~= nil
end
local function IsFoodCategory(category)
  return category == "Food" or category == "Meal"
end
function M.IsFeederAllowedForCategory(isFeeder, category)
  return not isFeeder or IsFoodCategory(category)
end
function M.OrderContainersByFeederPreference(storagesByBase, guidKey, category, feederFirst)
  local entries = storagesByBase[guidKey] or {}
  if not IsFoodCategory(category) then return entries end
  local feeders, others = {}, {}
  for _, entry in ipairs(entries) do
    if entry.isFeeder then feeders[#feeders + 1] = entry else others[#others + 1] = entry end
  end
  local ordered = {}
  local firstGroup = feederFirst and feeders or others
  local secondGroup = feederFirst and others or feeders
  for _, e in ipairs(firstGroup) do ordered[#ordered + 1] = e end
  for _, e in ipairs(secondGroup) do ordered[#ordered + 1] = e end
  return ordered
end
return M
