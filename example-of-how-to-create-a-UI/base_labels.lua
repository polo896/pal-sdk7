local util = require("util")
local M = {}
local mod_file_candidates = util.mod_file_candidates
local trim = util.trim
local FILE_NAME = "base_labels.ini"
local function parse_labels_file(path)
  local file = io.open(path, "r")
  if file == nil then return nil end
  local guidToLabel = {}
  for raw_line in file:lines() do
    local line = trim((raw_line:gsub("[;#].*$", "")))
    local guid, label = line:match("^([^=]+)=(.*)$")
    if guid ~= nil then
      guid, label = trim(guid), trim(label)
      guidToLabel[guid] = label
    end
  end
  file:close()
  return guidToLabel
end
local function load_raw()
  local paths = mod_file_candidates(FILE_NAME)
  local guidToLabel, path = util.load_first_existing(paths, parse_labels_file)
  return guidToLabel or {}, path
end
local function save_raw(guidToLabel, preferredPath)
  local paths = mod_file_candidates(FILE_NAME)
  local target = preferredPath
  if target == nil then target = paths[1] end
  local file = io.open(target, "w")
  if file == nil then
    util.Log("base_labels", "failed to write base_labels.ini to " .. tostring(target), "ERROR")
    return false
  end
  file:write("; AutoHaul - Base Logistics - base labels\n")
  local guids = {}
  for guid in pairs(guidToLabel) do guids[#guids + 1] = guid end
  table.sort(guids)
  for _, guid in ipairs(guids) do
    file:write(guid .. "=" .. guidToLabel[guid] .. "\n")
  end
  file:close()
  return true
end
local guidToLabel, loadedPath = load_raw()
local nextIndex = 1
for _ in pairs(guidToLabel) do nextIndex = nextIndex + 1 end
local deletedGuids = {}
function M.label_for(guid)
  if guid == nil then return "Base ?" end
  local existing = guidToLabel[guid]
  if existing ~= nil then return existing end
  local label = "Base " .. tostring(nextIndex)
  nextIndex = nextIndex + 1
  guidToLabel[guid] = label
  local ok, savedPath = save_raw(guidToLabel, loadedPath)
  if ok and loadedPath == nil then
    loadedPath = mod_file_candidates(FILE_NAME)[1]
  end
  return label
end
function M.mark_scan_result(foundGuids)
  for guid in pairs(guidToLabel) do
    if foundGuids[guid] then
      deletedGuids[guid] = nil
    else
      deletedGuids[guid] = true
    end
  end
end
function M.is_deleted(guid)
  return deletedGuids[guid] == true
end
function M.purge_deleted(keepGuids)
  local toRemove = {}
  for guid in pairs(deletedGuids) do
    if keepGuids == nil or not keepGuids[guid] then
      toRemove[#toRemove + 1] = guid
    end
  end
  for _, guid in ipairs(toRemove) do
    guidToLabel[guid] = nil
    deletedGuids[guid] = nil
  end
  if #toRemove > 0 then
    save_raw(guidToLabel, loadedPath)
  end
  return #toRemove
end
function M.rename_many(changes)
  local applied = 0
  for _, change in ipairs(changes or {}) do
    local guid = change.guid
    if guid ~= nil and guidToLabel[guid] ~= nil then
      local trimmed = trim(change.label or "")
      if trimmed ~= "" then
        guidToLabel[guid] = trimmed
        applied = applied + 1
      end
    end
  end
  if applied > 0 then
    save_raw(guidToLabel, loadedPath)
  end
  return applied
end
function M.all()
  local list = {}
  for guid, label in pairs(guidToLabel) do
    list[#list + 1] = { guid = guid, label = label }
  end
  table.sort(list, function(a, b) return a.label < b.label end)
  return list
end
return M
