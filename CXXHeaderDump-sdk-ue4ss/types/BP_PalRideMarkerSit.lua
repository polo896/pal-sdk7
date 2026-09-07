---@meta

---@class UBP_PalRideMarkerSit_C : UPalRideMarkerComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field MaterialTimer double
---@field MaterialTime double
---@field MaterialCurve UCurveFloat
---@field DynamicMaterials TArray<UMaterialInstanceDynamic>
---@field isMaterialComplete boolean
local UBP_PalRideMarkerSit_C = {}

function UBP_PalRideMarkerSit_C:ResetMaterial() end
---@param Progress double
function UBP_PalRideMarkerSit_C:SetMaterialProgress(Progress) end
function UBP_PalRideMarkerSit_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function UBP_PalRideMarkerSit_C:ReceiveTick(DeltaSeconds) end
---@param IsEnable boolean
UBP_PalRideMarkerSit_C['OnChangeRiding_イベント_0'] = function(self, IsEnable) end
---@param EntryPoint int32
function UBP_PalRideMarkerSit_C:ExecuteUbergraph_BP_PalRideMarkerSit(EntryPoint) end


