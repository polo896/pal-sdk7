---@meta

---@class ABP_BuildObject_AncientCookingStove_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalMapObjectItemConverterSound UPalMapObjectItemConverterSoundComponent
---@field BP_WorkVisualFX UBP_WorkVisualFX_C
---@field PalBuildObjectHUDLocator1 UPalBuildObjectHUDLocatorComponent
---@field PalBuildObjectHUDLocator UPalBuildObjectHUDLocatorComponent
---@field WorkFacing_Handcraft UPalWorkFacingComponent
---@field NS_CookingSmoke UNiagaraComponent
---@field PalWorkFacing_EmitFire UPalWorkFacingComponent
---@field StaticMesh UStaticMeshComponent
---@field ParticleSystem UParticleSystemComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field ItemConverterParameter UPalMapObjectItemConverterParameterComponent
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_AncientCookingStove_C = {}

---@param bOn boolean
function ABP_BuildObject_AncientCookingStove_C:SetActive_Internal(bOn) end
function ABP_BuildObject_AncientCookingStove_C:ReceiveBeginPlay() end
function ABP_BuildObject_AncientCookingStove_C:OnAvailable_BlueprintImpl() end
---@param EntryPoint int32
function ABP_BuildObject_AncientCookingStove_C:ExecuteUbergraph_BP_BuildObject_AncientCookingStove(EntryPoint) end


