---@meta

---@class ABP_ThunderStrikeBase_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Main UNiagaraComponent
---@field Omen UNiagaraComponent
---@field Capsule UCapsuleComponent
---@field ShootInterval double
---@field CollisitionEnableTime double
---@field ['Decal Material'] UMaterialInterface
---@field DecalLocationOffset FVector
---@field ThunderScale double
---@field CameraShakeClass TSubclassOf<UCameraShakeBase>
---@field ThunderStrikeDelay float
local ABP_ThunderStrikeBase_C = {}

function ABP_ThunderStrikeBase_C:SetThuderSize() end
function ABP_ThunderStrikeBase_C:ActivateOmen() end
function ABP_ThunderStrikeBase_C:ShootThunder() end
function ABP_ThunderStrikeBase_C:DisableCollision() end
---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
---@param FoliageIndex TArray<int32>
---@param HitLocation FVector
---@param HitCount int32
function ABP_ThunderStrikeBase_C:OnHitDelegate_01(MyHitComponent, OtherHitActor, OtherHitComponent, FoliageIndex, HitLocation, HitCount) end
---@param PSystem UNiagaraComponent
function ABP_ThunderStrikeBase_C:BndEvt__BP_ThunderStrikeBase_NS_Thunder01_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
function ABP_ThunderStrikeBase_C:ReceiveBeginPlay() end
function ABP_ThunderStrikeBase_C:ActivateThunder() end
---@param EntryPoint int32
function ABP_ThunderStrikeBase_C:ExecuteUbergraph_BP_ThunderStrikeBase(EntryPoint) end


