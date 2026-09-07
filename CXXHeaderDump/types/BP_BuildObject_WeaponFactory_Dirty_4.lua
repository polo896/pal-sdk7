---@meta

---@class ABP_BuildObject_WeaponFactory_Dirty_4_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalMapObjectItemConverterSound UPalMapObjectItemConverterSoundComponent
---@field WorkSound_Spark UPalWorkEffectSoundComponent
---@field WorkSound_Flowing UPalWorkEffectSoundComponent
---@field WorkSound_Manufacturing UPalWorkEffectSoundComponent
---@field Box5 UBoxComponent
---@field Box4 UBoxComponent
---@field box3 UBoxComponent
---@field box2 UBoxComponent
---@field box1 UBoxComponent
---@field Box UBoxComponent
---@field PalMapObjectSkeletalMesh UPalMapObjectSkeletalMeshComponent
---@field WorkFacing3 UPalWorkFacingComponent
---@field CheckOverlapCollision UBoxComponent
---@field BuildWorkableBounds UBoxComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field FactoryConveyorComponent UBP_BuildObjectFactoryConveyorComponent_C
---@field WorkFacing1 UPalWorkFacingComponent
---@field WorkFacing2 UPalWorkFacingComponent
---@field WorkFacing UPalWorkFacingComponent
---@field ItemConverterParameter UPalMapObjectItemConverterParameterComponent
---@field Root USceneComponent
local ABP_BuildObject_WeaponFactory_Dirty_4_C = {}

function ABP_BuildObject_WeaponFactory_Dirty_4_C:OnAvailable_BlueprintImpl() end
---@param Model UPalMapObjectConcreteModelBase
function ABP_BuildObject_WeaponFactory_Dirty_4_C:OnSetConcreteModel(Model) end
function ABP_BuildObject_WeaponFactory_Dirty_4_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_BuildObject_WeaponFactory_Dirty_4_C:ExecuteUbergraph_BP_BuildObject_WeaponFactory_Dirty_4(EntryPoint) end


