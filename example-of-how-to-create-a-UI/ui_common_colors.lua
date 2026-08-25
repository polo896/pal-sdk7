local M = {}
function M.HexColor(hex)
  hex = hex:gsub("^#", "")
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255
  return r, g, b
end
local function srgb_channel_to_linear(c)
  if c <= 0.04045 then return c / 12.92 end
  return ((c + 0.055) / 1.055) ^ 2.4
end
function M.SrgbToLinear(r, g, b)
  return srgb_channel_to_linear(r), srgb_channel_to_linear(g), srgb_channel_to_linear(b)
end
return M
