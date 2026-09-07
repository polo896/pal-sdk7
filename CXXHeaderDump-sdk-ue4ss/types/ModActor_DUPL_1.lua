---@meta

---@class AModActor_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultSceneRoot USceneComponent
---@field LoadedAssetsTemp TArray<UObject>
---@field FetcherList TArray<ABP_Fetcher_C>
---@field LastClickedDropdownIndex int32
---@field LastClickedDropdownValue FString
---@field PendingScrollBox UScrollBox
---@field PendingOptions FString
---@field CurrentPopulateIndex int32
local AModActor_C = {}

---@param OutAssets TArray<UObject>
function AModActor_C:GetAllLoadedAssets(OutAssets) end
---@param TargetScrollBox UScrollBox
---@param OptionsList TArray<FString>
function AModActor_C:BP_PopulateDropdownList_F(TargetScrollBox, OptionsList) end
---@param Requester UObject
---@param OutAssets TArray<UObject>
function AModActor_C:GetAndRemoveLoadedAssets(Requester, OutAssets) end
---@param Message FString
function AModActor_C:PrintToModLoader(Message) end
---@param AssetPaths TArray<FString>
---@param Requester UObject
function AModActor_C:RequestBatchAsyncLoad(AssetPaths, Requester) end
function AModActor_C:ReceiveBeginPlay() end
---@param Requester UObject
---@param LoadedAssets TArray<UObject>
function AModActor_C:OnCompleted_Event(Requester, LoadedAssets) end
---@param TargetScrollBox UScrollBox
---@param OptionsList TArray<FString>
function AModActor_C:BP_PopulateDropdownList(TargetScrollBox, OptionsList) end
function AModActor_C:OnClicked_Event() end
function AModActor_C:ReEnableClicks() end
---@param EntryPoint int32
function AModActor_C:ExecuteUbergraph_ModActor(EntryPoint) end


