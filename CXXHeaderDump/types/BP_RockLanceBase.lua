---@meta

---@class ABP_RockLanceBase_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_SkillSign04 UNiagaraComponent
---@field MainEffect UNiagaraComponent
---@field OmenEffect UNiagaraComponent
---@field Capsule UCapsuleComponent
---@field ThunderEffect UNiagaraSystem
---@field ShootInterval double
---@field CollisitionEnableTime double
---@field ['Decal Material'] UMaterialInterface
---@field DecalLocationOffset FVector
local ABP_RockLanceBase_C = {}

ABP_RockLanceBase_C['カスタムイベント_0'] = function(self, ) end
function ABP_RockLanceBase_C:ShootThunder() end
function ABP_RockLanceBase_C:ChangeCollisionProfile() end
---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
---@param FoliageIndex TArray<int32>
---@param HitLocation FVector
---@param HitCount int32
function ABP_RockLanceBase_C:OnHitDelegate_01(MyHitComponent, OtherHitActor, OtherHitComponent, FoliageIndex, HitLocation, HitCount) end
function ABP_RockLanceBase_C:ReceiveBeginPlay() end
---@param PSystem UNiagaraComponent
function ABP_RockLanceBase_C:BndEvt__BP_ThunderStrikeBase_NS_Thunder01_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
ABP_RockLanceBase_C['カスタムイベント_1'] = function(self, ) end
ABP_RockLanceBase_C['カスタムイベント_2'] = function(self, ) end
---@param EntryPoint int32
function ABP_RockLanceBase_C:ExecuteUbergraph_BP_RockLanceBase(EntryPoint) end


