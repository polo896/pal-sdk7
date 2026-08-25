local M = {}
local SUBMODULES = {
  require("ui_common_colors"),
  require("ui_common_layout"),
  require("ui_common_hooks"),
  require("ui_common_primitives"),
  require("ui_common_chrome"),
  require("ui_common_window_host"),
  require("ui_common_buttons"),
  require("ui_common_item_grid"),
  require("ui_common_text_input"),
  require("ui_common_select_num"),
}
for _, sub in ipairs(SUBMODULES) do
  for key, value in pairs(sub) do
    M[key] = value
  end
end
return M
