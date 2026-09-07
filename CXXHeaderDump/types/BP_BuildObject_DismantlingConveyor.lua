---@meta

---@class ABP_BuildObject_DismantlingConveyor_C : APalBuildObjectConvertCharacterToItem
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ItemOutputWidget UWidgetComponent
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field PalWorkEffectSound UPalWorkEffectSoundComponent
---@field StaticMesh4 UStaticMeshComponent
---@field ConveyorSpline USplineComponent
---@field DropItemLocation UArrowComponent
---@field StaticMesh3 UStaticMeshComponent
---@field StaticMesh2 UStaticMeshComponent
---@field StaticMesh1 UStaticMeshComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
---@field VisualSkeletalMeshMap TMap<FGuid, UPalCharacterVisualSkeletalMeshComponent>
---@field ConveyerDynamicMaterialInstance UMaterialInstanceDynamic
---@field CharacterMontageType EPalGeneralMontageType
local ABP_BuildObject_DismantlingConveyor_C = {}

---@param bVisible boolean
function ABP_BuildObject_DismantlingConveyor_C:SetVisibleItemOutputWidget(bVisible) end
function ABP_BuildObject_DismantlingConveyor_C:UpdateConveyerVisual() end
---@param DeltaSeconds float
function ABP_BuildObject_DismantlingConveyor_C:UpdateVisualByTick(DeltaSeconds) end
---@param VisualProcessInfo FPalBuildObjectConvertCharacterToItemVisualProcessInfo
---@param VisualSkeletalMesh UPalCharacterVisualSkeletalMeshComponent
---@param DeltaTime double
function ABP_BuildObject_DismantlingConveyor_C:UpdateCurrentVisualProcessForItem(VisualProcessInfo, VisualSkeletalMesh, DeltaTime) end
---@param DeltaTime double
function ABP_BuildObject_DismantlingConveyor_C:UpdateCurrentVisualProcess(DeltaTime) end
---@param VisualProcessInfo FPalBuildObjectConvertCharacterToItemVisualProcessInfo
---@param SheduledRemovePool TArray<UPalCharacterVisualSkeletalMeshComponent>
ABP_BuildObject_DismantlingConveyor_C['Add New Visual Skeletal Mesh if Not Exists'] = function(self, VisualProcessInfo, SheduledRemovePool) end
---@param SheduledRemovePool TArray<UPalCharacterVisualSkeletalMeshComponent>
---@return UPalCharacterVisualSkeletalMeshComponent
function ABP_BuildObject_DismantlingConveyor_C:GetOrCreateNewVisual(SheduledRemovePool) end
---@return TArray<FGuid>
function ABP_BuildObject_DismantlingConveyor_C:GetInstanceIdsNotExistsVisualProcess() end
---@param InstanceId FGuid
---@param Return_Value boolean
function ABP_BuildObject_DismantlingConveyor_C:IsExistsVisualProcess(InstanceId, Return_Value) end
function ABP_BuildObject_DismantlingConveyor_C:BP_UpdateConvertProcessVisual() end
---@param DeltaSeconds float
function ABP_BuildObject_DismantlingConveyor_C:ReceiveTick(DeltaSeconds) end
function ABP_BuildObject_DismantlingConveyor_C:ReceiveBeginPlay() end
function ABP_BuildObject_DismantlingConveyor_C:OnStartSimulation() end
---@param EntryPoint int32
function ABP_BuildObject_DismantlingConveyor_C:ExecuteUbergraph_BP_BuildObject_DismantlingConveyor(EntryPoint) end


