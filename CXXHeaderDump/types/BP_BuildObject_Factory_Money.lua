---@meta

---@class ABP_BuildObject_Factory_Money_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WorkSound_Flowing UPalWorkEffectSoundComponent
---@field Box4 UBoxComponent
---@field box3 UBoxComponent
---@field box2 UBoxComponent
---@field box1 UBoxComponent
---@field Box UBoxComponent
---@field PalMapObjectSkeletalMesh UPalMapObjectSkeletalMeshComponent
---@field FactoryConveyorComponent UBP_BuildObjectFactoryConveyorComponent_C
---@field WorkFacing1 UPalWorkFacingComponent
---@field WorkFacing2 UPalWorkFacingComponent
---@field WorkFacing UPalWorkFacingComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field ItemConverterParameter UPalMapObjectItemConverterParameterComponent
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_Factory_Money_C = {}

function ABP_BuildObject_Factory_Money_C:OnAvailable_BlueprintImpl() end
---@param Model UPalMapObjectConcreteModelBase
function ABP_BuildObject_Factory_Money_C:OnSetConcreteModel(Model) end
function ABP_BuildObject_Factory_Money_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_BuildObject_Factory_Money_C:ExecuteUbergraph_BP_BuildObject_Factory_Money(EntryPoint) end


