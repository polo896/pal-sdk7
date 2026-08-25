local util = require("util")
local M = {}
local mod_file_candidates = util.mod_file_candidates
local trim = util.trim
local function parse_ini(path)
  local file = io.open(path, "r")
  if file == nil then return nil end
  local values, section = {}, "general"
  for raw_line in file:lines() do
    local line = trim((raw_line:gsub("[;#].*$", "")))
    local new_section = line:match("^%[([^%]]+)%]$")
    if new_section ~= nil then
      section = string.lower(trim(new_section))
      values[section] = values[section] or {}
    else
      local key, value = line:match("^([^=]+)=(.*)$")
      if key ~= nil then
        values[section] = values[section] or {}
        values[section][trim(key)] = trim(value)
      end
    end
  end
  file:close()
  return values
end
local DEFAULT_TEMPLATE = [[
; AutoHaul - Base Logistics - settings
]]
function M.ensure_default_file()
  local paths = mod_file_candidates("settings.ini")
  local existingPath = util.find_existing_path(paths)
  if existingPath ~= nil then return false, existingPath end
  for _, path in ipairs(paths) do
    local file = io.open(path, "w")
    if file ~= nil then
      file:write(DEFAULT_TEMPLATE)
      file:close()
      return true, path
    end
  end
  util.Log("config", "could not write settings.ini template - tried: " .. table.concat(paths, ", "), "ERROR")
  return false, nil
end
function M.load()
  local paths = mod_file_candidates("settings.ini")
  local ini, loaded_path = util.load_first_existing(paths, parse_ini)
  local result = { enabled = true, routes = {}, loaded_path = loaded_path }
  if ini == nil then
    return result
  end
  local general = ini.general or {}
  if general.Enabled ~= nil then
    result.enabled = string.lower(general.Enabled) ~= "false"
  end
  local function nil_if_empty(s)
    if s == nil or s == "" then return nil end
    return s
  end
  for section_name, section in pairs(ini) do
    if section_name:match("^route%d+$") then
      if section.Item and section.Item ~= "" then
        result.routes[#result.routes + 1] = {
          item = section.Item,
          from = nil_if_empty(section.FromBaseGuid),
          to = nil_if_empty(section.ToBaseGuid),
          keep_min = tonumber(section.KeepMin) or 0,
          keep_max = tonumber(section.KeepMax), 
        }
      end
    end
  end
  table.sort(result.routes, function(a, b) return (a.item or "") < (b.item or "") end)
  return result
end
function M.save(cfg)
  local target = cfg.loaded_path
  if target == nil then
    local paths = mod_file_candidates("settings.ini")
    target = util.find_existing_path(paths) or paths[1]
  end
  local file = io.open(target, "w")
  if file == nil then
    util.Log("config", "failed to write settings.ini to " .. tostring(target), "ERROR")
    return false, target
  end
  file:write("; AutoHaul - Base Logistics - settings (last written by the in-game route editor)\n")
  file:write("[General]\n")
  file:write("Enabled=" .. tostring(cfg.enabled ~= false) .. "\n\n")
  for i, route in ipairs(cfg.routes or {}) do
    file:write("[Route" .. i .. "]\n")
    file:write("Item=" .. tostring(route.item or "") .. "\n")
    file:write("FromBaseGuid=" .. tostring(route.from or "") .. "\n")
    file:write("ToBaseGuid=" .. tostring(route.to or "") .. "\n")
    file:write("KeepMin=" .. tostring(route.keep_min or 0) .. "\n")
    if route.keep_max ~= nil then file:write("KeepMax=" .. tostring(route.keep_max) .. "\n") end
    file:write("\n")
  end
  file:close()
  return true, target
end
return M
