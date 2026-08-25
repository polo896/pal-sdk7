local layout = require("ui_common_layout")
local primitives = require("ui_common_primitives")
local util = require("util")
local M = {}
local WINDOW_CLASS_PATHS = {
  "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_PalCommonWindow.WBP_PalCommonWindow_C",
  "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_PalCommonWindow.WBP_PalCommonWindow",
}
local function get_common_window_class()
  for _, assetPath in ipairs(WINDOW_CLASS_PATHS) do
    local cls = primitives.get_cached_class_or_asset(assetPath)
    if cls then return cls end
  end
  return nil
end
local function find_named_slot(window)
  local okTree, winTree = pcall(function() return window.WidgetTree end)
  if not okTree or not winTree or not winTree:IsValid() then return nil end
  local okRoot, root = pcall(function() return winTree.RootWidget end)
  if not okRoot or not root or not root:IsValid() then return nil end
  local okCount, count = pcall(function() return root:GetChildrenCount() end)
  if not okCount or not count then return nil end
  for i = 0, count - 1 do
    local okChild, child = pcall(function() return root:GetChildAt(i) end)
    if okChild and child and child:IsValid() then
      local okName, fullName = pcall(function() return child:GetFullName() end)
      if okName and fullName:match("^NamedSlot%s") then
        return child
      end
    end
  end
  return nil
end
local function hide_window_chrome(window)
  local slot = find_named_slot(window)
  if not slot then return end
  local okSlotName, slotName = pcall(function() return slot:GetFullName() end)
  if not okSlotName then return end
  local okTree, winTree = pcall(function() return window.WidgetTree end)
  if not okTree or not winTree or not winTree:IsValid() then return end
  local okRoot, root = pcall(function() return winTree.RootWidget end)
  if not okRoot or not root or not root:IsValid() then return end
  local okCount, count = pcall(function() return root:GetChildrenCount() end)
  if not okCount or not count then return end
  for i = 0, count - 1 do
    local okChild, child = pcall(function() return root:GetChildAt(i) end)
    if okChild and child and child:IsValid() then
      local okChildName, childName = pcall(function() return child:GetFullName() end)
      if okChildName and childName ~= slotName then
        pcall(function() child:SetVisibility(layout.ESlateVisibility.Collapsed) end)
      end
    end
  end
end
function M.BuildCommonWindowHost(panel, tree, w, h)
  local windowClass = get_common_window_class()
  if not windowClass then return nil end
  local canvasClass = StaticFindObject("/Script/UMG.CanvasPanel")
  if not canvasClass or not canvasClass:IsValid() then return nil end
  local sizeBoxClass = StaticFindObject("/Script/UMG.SizeBox")
  if not sizeBoxClass or not sizeBoxClass:IsValid() then return nil end
  local library = primitives.get_widget_blueprint_library()
  if not library then return nil end
  local modalContainer = M.FindLayerContainer("Modal")
  if not modalContainer then return nil end
  local shell, realWindow, innerCanvas
  local ok, err = pcall(function()
    local owningPlayer = panel:GetOwningPlayer()
    shell = modalContainer:BP_AddWidget(windowClass)
    if not shell or not shell:IsValid() then error("Modal container BP_AddWidget for shell WBP_PalCommonWindow failed") end
    hide_window_chrome(shell)
    local shellSlot = find_named_slot(shell)
    if not shellSlot or not shellSlot:IsValid() then error("shell WBP_PalCommonWindow has no content NamedSlot") end
    local okFullscreenBlur, fullscreenBlurErr = pcall(function()
      local okRoot, root = pcall(function() return shell.WidgetTree.RootWidget end)
      if not okRoot or not root or not root:IsValid() then error("could not resolve shell root widget") end
      local blur = primitives.ConstructBackgroundBlur(tree, primitives.FULLSCREEN_BLUR_DEFAULTS)
      if blur then layout.PlaceFillParent(root, blur, -1) end
    end)
    if not okFullscreenBlur then util.Log("ui_common_window_host", "BuildCommonWindowHost: full-screen blur placement failed - " .. tostring(fullscreenBlurErr), "WARN") end
    realWindow = library:Create(panel, windowClass, owningPlayer)
    if not realWindow or not realWindow:IsValid() then error("WidgetBlueprintLibrary.Create for real WBP_PalCommonWindow failed") end
    local realSlot = find_named_slot(realWindow)
    if not realSlot or not realSlot:IsValid() then error("real WBP_PalCommonWindow has no content NamedSlot") end
    innerCanvas = StaticConstructObject(canvasClass, tree)
    if not innerCanvas or not innerCanvas:IsValid() then error("StaticConstructObject for inner CanvasPanel failed") end
    local innerSizeBox = StaticConstructObject(sizeBoxClass, tree)
    if not innerSizeBox or not innerSizeBox:IsValid() then error("StaticConstructObject for inner SizeBox failed") end
    innerSizeBox:SetWidthOverride(w)
    innerSizeBox:SetHeightOverride(h)
    innerSizeBox:SetContent(innerCanvas)
    realSlot:SetContent(innerSizeBox)
    local hostCanvas = StaticConstructObject(canvasClass, tree)
    if not hostCanvas or not hostCanvas:IsValid() then error("StaticConstructObject for host CanvasPanel failed") end
    shellSlot:SetContent(hostCanvas)
    layout.PlaceCentered(hostCanvas, realWindow, w, h)
  end)
  if not ok then
    util.Log("ui_common_window_host", "WBP_PalCommonWindow host build failed: " .. tostring(err), "ERROR")
    return nil
  end
  local okBlur, blurErr = pcall(function()
    local blur = primitives.ConstructBackgroundBlur(tree)
    if blur then
      layout.PlaceAt(innerCanvas, blur, 0, 0, w, h)
    end
  end)
  if not okBlur then util.Log("ui_common_window_host", "BuildCommonWindowHost: nested blur placement failed - " .. tostring(blurErr), "WARN") end
  return { window = shell, contentPanel = innerCanvas }
end
function M.CloseWindowShell(shell)
  if not shell or not shell:IsValid() then return end
  local container = M.FindLayerContainer("Modal")
  if not container then
    util.Log("ui_common_window_host", "CloseWindowShell: Modal container not found, cannot RemoveWidget", "ERROR")
    return
  end
  local ok, err = pcall(function() container:RemoveWidget(shell) end)
  if not ok then util.Log("ui_common_window_host", "CloseWindowShell: RemoveWidget failed - " .. tostring(err), "ERROR") end
end
function M.CloseShell(state)
  if state.shell then
    M.CloseWindowShell(state.shell)
    state.shell = nil
  end
  state.built = false
end
local PERSISTENT_LAYOUT_CLASS = "WBP_PalOverallUILayout_C"
local PERSISTENT_HOST_PANEL_NAME = "CanvasPanel_Root"
M.PERSISTENT_HOST_PANEL_NAME = PERSISTENT_HOST_PANEL_NAME
function M.FindPersistentLayout()
  local ok, instances = pcall(FindAllOf, PERSISTENT_LAYOUT_CLASS)
  if not ok or instances == nil or #instances == 0 then return nil end
  return instances[1]
end
function M.FindNamedCanvasPanel(outerFullName, childName)
  local ok, panels = pcall(FindAllOf, "CanvasPanel")
  if not ok or panels == nil then return nil end
  local suffix = "." .. childName
  for i = 1, #panels do
    local p = panels[i]
    if p ~= nil and p:IsValid() then
      local okName, pName = pcall(function() return p:GetFullName() end)
      if okName and pName:sub(-#suffix) == suffix then
        local okOuter, po = pcall(function() return p:GetOuter() end)
        if okOuter and po ~= nil and po:IsValid() then
          local okOuterName, poName = pcall(function() return po:GetFullName() end)
          if okOuterName and poName == outerFullName then return p end
        end
      end
    end
  end
  return nil
end
function M.FindLayerContainer(layerName)
  local layout_ = M.FindPersistentLayout()
  if not layout_ or not layout_:IsValid() then return nil end
  local ok, container = pcall(function() return layout_[layerName] end)
  if not ok or not container or not container:IsValid() then return nil end
  return container
end
return M
