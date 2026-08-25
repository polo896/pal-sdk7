---@meta

---@class AModActor_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultSceneRoot USceneComponent
---@field GetMapTimerHandle FTimerHandle
---@field WBP_Map_Base UWBP_Map_Base_C
---@field Strings FString
---@field FastTravelToNotDiscoveredPoints boolean
---@field PointsGuids TArray<FGuid>
---@field strings2 FString
---@field ModAuthor FString
local AModActor_C = {}

function AModActor_C:ReceiveBeginPlay() end
function AModActor_C:GetMap2() end
function AModActor_C:DoUnlockFlag() end
function AModActor_C:MakePointsGUIDs() end
---@param EntryPoint int32
function AModActor_C:ExecuteUbergraph_ModActor(EntryPoint) end


