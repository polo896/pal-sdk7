local M = {}
M.MOD_ROOT_CANDIDATES = {
  "ue4ss/Mods/AutoHaulBaseLogistics",
  "Mods/AutoHaulBaseLogistics",
  "Pal/Binaries/Win64/ue4ss/Mods/AutoHaulBaseLogistics",
  "AutoHaulBaseLogistics",
  ".",
}
function M.mod_file_candidates(filename)
  local paths = {}
  for _, root in ipairs(M.MOD_ROOT_CANDIDATES) do
    paths[#paths + 1] = root .. "/" .. filename
  end
  return paths
end
function M.trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end
function M.Log(scope, message, level)
  local tag = level and (level .. " - ") or ""
  print("[AutoHaulBaseLogistics] " .. scope .. ": " .. tag .. message .. "\n")
end
function M.find_existing_path(paths)
  for _, path in ipairs(paths) do
    local file = io.open(path, "r")
    if file ~= nil then
      file:close()
      return path
    end
  end
  return nil
end
function M.load_first_existing(paths, loader)
  for _, path in ipairs(paths) do
    local result = loader(path)
    if result ~= nil then return result, path end
  end
  return nil, nil
end
return M
