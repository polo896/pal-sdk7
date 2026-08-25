local util = require("util")
local M = {}
M.ESlateVisibility = {
  Visible = 0,
  Collapsed = 1,
  Hidden = 2,
  HitTestInvisible = 3,
}
local function MakeCanvasSlot(panel, widget)
  local slot = panel:AddChildToCanvas(widget)
  if not slot or not slot:IsValid() then error("AddChildToCanvas failed") end
  slot:SetAutoSize(false)
  return slot
end
function M.PlaceAt(panel, widget, x, y, w, h, zOrder)
  local slot = MakeCanvasSlot(panel, widget)
  local pos = slot:GetPosition()
  pos.X = x
  pos.Y = y
  slot:SetPosition(pos)
  local size = slot:GetSize()
  size.X = w
  size.Y = h
  slot:SetSize(size)
  if zOrder then slot:SetZOrder(zOrder) end
  return slot, widget
end
function M.PlaceCentered(panel, widget, w, h, zOrder)
  local slot = MakeCanvasSlot(panel, widget)
  local anchors = slot:GetAnchors()
  anchors.Minimum.X, anchors.Minimum.Y = 0.5, 0.5
  anchors.Maximum.X, anchors.Maximum.Y = 0.5, 0.5
  slot:SetAnchors(anchors)
  local alignment = slot:GetAlignment()
  alignment.X, alignment.Y = 0.5, 0.5
  slot:SetAlignment(alignment)
  local pos = slot:GetPosition()
  pos.X, pos.Y = 0, 0
  slot:SetPosition(pos)
  local size = slot:GetSize()
  size.X = w
  size.Y = h
  slot:SetSize(size)
  if zOrder then slot:SetZOrder(zOrder) end
  return slot, widget
end
function M.PlaceBottomCenter(panel, widget, w, h, marginBottom, zOrder)
  local slot = MakeCanvasSlot(panel, widget)
  local anchors = slot:GetAnchors()
  anchors.Minimum.X, anchors.Minimum.Y = 0.5, 1.0
  anchors.Maximum.X, anchors.Maximum.Y = 0.5, 1.0
  slot:SetAnchors(anchors)
  local alignment = slot:GetAlignment()
  alignment.X, alignment.Y = 0.5, 1.0
  slot:SetAlignment(alignment)
  local pos = slot:GetPosition()
  pos.X, pos.Y = 0, -marginBottom
  slot:SetPosition(pos)
  local size = slot:GetSize()
  size.X = w
  size.Y = h
  slot:SetSize(size)
  if zOrder then slot:SetZOrder(zOrder) end
  return slot, widget
end
function M.PlaceFillParent(panel, widget, zOrder)
  local slot = MakeCanvasSlot(panel, widget)
  local anchors = slot:GetAnchors()
  anchors.Minimum.X, anchors.Minimum.Y = 0, 0
  anchors.Maximum.X, anchors.Maximum.Y = 1, 1
  slot:SetAnchors(anchors)
  local offsets = slot:GetOffsets()
  offsets.Left, offsets.Top, offsets.Right, offsets.Bottom = 0, 0, 0, 0
  slot:SetOffsets(offsets)
  if zOrder then slot:SetZOrder(zOrder) end
  return slot, widget
end
local REFERENCE_UI_SCALE = 1440 / 1080 
local WIDGET_LAYOUT_LIBRARY_PATH = "/Script/UMG.Default__WidgetLayoutLibrary"
function M.GetUIScale(worldContextObject)
  local scale = 1.0
  local ok, err = pcall(function()
    local library = StaticFindObject(WIDGET_LAYOUT_LIBRARY_PATH)
    if not library or not library:IsValid() then error("WidgetLayoutLibrary not found") end
    local v = library:GetViewportScale(worldContextObject)
    if v ~= nil and v > 0 then scale = v end
  end)
  if not ok then util.Log("ui_common_layout", "GetUIScale: falling back to 1.0 - " .. tostring(err), "WARN") end
  return scale
end
function M.ScreenPxToSlate(worldContextObject, screenPx)
  return screenPx / REFERENCE_UI_SCALE
end
function M.PlaceOrLog(widget, name, panel, x, y, w, h)
  if widget then
    M.PlaceAt(panel, widget, x, y, w, h)
  else
    util.Log("ui_common_layout", name .. " failed to build - will not be available this session", "ERROR")
  end
  return widget
end
function M.AddScrollBoxRow(scrollBox, tree, content, w, h, spacingH, logPrefix, rowLabel)
  local sizeBoxClass = StaticFindObject("/Script/UMG.SizeBox")
  local sizeBox = StaticConstructObject(sizeBoxClass, tree)
  sizeBox:SetWidthOverride(w)
  sizeBox:SetHeightOverride(h)
  sizeBox:SetContent(content)
  local okAdd = pcall(function() scrollBox:AddChild(sizeBox) end)
  if not okAdd then util.Log("ui_common_layout", logPrefix .. "ScrollBox:AddChild failed for " .. rowLabel, "ERROR") end
  local spacerBox = StaticConstructObject(sizeBoxClass, tree)
  spacerBox:SetWidthOverride(w)
  spacerBox:SetHeightOverride(spacingH)
  local okSpacerAdd = pcall(function() scrollBox:AddChild(spacerBox) end)
  if not okSpacerAdd then util.Log("ui_common_layout", logPrefix .. "ScrollBox:AddChild failed for spacer after " .. rowLabel, "ERROR") end
  return sizeBox, spacerBox
end
return M
