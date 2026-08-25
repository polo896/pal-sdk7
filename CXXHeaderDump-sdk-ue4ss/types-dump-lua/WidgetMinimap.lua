---@meta

---@class UWidgetMinimap_C : UPalUserWidgetWorldHUD
---@field UberGraphFrame FPointerToUberGraphFrame
---@field coords UTextBlock
---@field Image_0 UImage
---@field MinimapOverlay UOverlay
---@field OverlayText URichTextBlock
---@field ModActorDelegate AModActor_C
---@field MinimapDynamicMaterial UMaterialInstanceDynamic
---@field bOverlayTextLocalized boolean
local UWidgetMinimap_C = {}

---@param Text FText
function UWidgetMinimap_C:GetCoordinateText(Text) end
function UWidgetMinimap_C:UpdateSizeAndPosition() end
function UWidgetMinimap_C:GetMapPositionMode() end
function UWidgetMinimap_C:GetMapVisibility() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWidgetMinimap_C:Tick(MyGeometry, InDeltaTime) end
function UWidgetMinimap_C:OnSetup() end
---@param EntryPoint int32
function UWidgetMinimap_C:ExecuteUbergraph_WidgetMinimap(EntryPoint) end


