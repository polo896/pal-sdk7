---@meta

---@class ABP_BlizzardLanceBase_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BlockingCapsule UCapsuleComponent
---@field NS_SkillSign04 UNiagaraComponent
---@field MainEffect UNiagaraComponent
---@field OmenEffect UNiagaraComponent
---@field AttackCapsule UCapsuleComponent
---@field ThunderEffect UNiagaraSystem
---@field ShootInterval double
---@field CollisitionEnableTime double
---@field ['Decal Material'] UMaterialInterface
---@field DecalLocationOffset FVector
---@field CameraShakeClass TSubclassOf<UCameraShakeBase>
local ABP_BlizzardLanceBase_C = {}

function ABP_BlizzardLanceBase_C:ShootThunder() end
function ABP_BlizzardLanceBase_C:ChangeCollisionProfile() end
---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
---@param FoliageIndex TArray<int32>
---@param HitLocation FVector
---@param HitCount int32
function ABP_BlizzardLanceBase_C:OnHitDelegate_01(MyHitComponent, OtherHitActor, OtherHitComponent, FoliageIndex, HitLocation, HitCount) end
function ABP_BlizzardLanceBase_C:ReceiveBeginPlay() end
ABP_BlizzardLanceBase_C['カスタムイベント_0'] = function(self, ) end
---@param PSystem UNiagaraComponent
function ABP_BlizzardLanceBase_C:BndEvt__BP_ThunderStrikeBase_NS_Thunder01_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
ABP_BlizzardLanceBase_C['カスタムイベント_1'] = function(self, ) end
ABP_BlizzardLanceBase_C['カスタムイベント_2'] = function(self, ) end
---@param EntryPoint int32
function ABP_BlizzardLanceBase_C:ExecuteUbergraph_BP_BlizzardLanceBase(EntryPoint) end


