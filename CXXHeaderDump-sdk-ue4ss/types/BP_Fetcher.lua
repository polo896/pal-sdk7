---@meta

---@class ABP_Fetcher_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultSceneRoot USceneComponent
---@field LoadedAssetsTemp TArray<UObject>
---@field ArrrayLength int32
---@field ['Asset Paths'] TArray<FString>
---@field Requester UObject
---@field ModActor AModActor_C
local ABP_Fetcher_C = {}

---@param Loaded UObject
function ABP_Fetcher_C:OnLoaded_6D1C744F48EB40A914E8D780B534F94A(Loaded) end
function ABP_Fetcher_C:ReceiveBeginPlay() end
---@param Messag FString
function ABP_Fetcher_C:PrintToModLoader(Messag) end
---@param EntryPoint int32
function ABP_Fetcher_C:ExecuteUbergraph_BP_Fetcher(EntryPoint) end


