---@meta

---@class ABP_YakushimaBlade003_C : ABP_MeleeWeaponBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BladeMaxNum int32
---@field SpawnedBlade TArray<ABP_YakushimaBlade003_Blade_C>
---@field BladeClass TSubclassOf<APalBullet>
---@field SummonMax int32
local ABP_YakushimaBlade003_C = {}

function ABP_YakushimaBlade003_C:PlayShootAnim() end
---@param Array_Index int32
function ABP_YakushimaBlade003_C:CurrentBlades(Array_Index) end
---@return FTransform
function ABP_YakushimaBlade003_C:GetBladeSpawnTransform() end
---@return boolean
function ABP_YakushimaBlade003_C:IsNeedCheckSummonWeapon() end
---@param NotifyName FName
function ABP_YakushimaBlade003_C:OnAnimNotifyBegin(NotifyName) end
---@param bForce boolean
function ABP_YakushimaBlade003_C:SpawnBlade(bForce) end
---@param DestroyedActor AActor
function ABP_YakushimaBlade003_C:OnDestroyBlade(DestroyedActor) end
function ABP_YakushimaBlade003_C:ReceiveDestroyed() end
function ABP_YakushimaBlade003_C:OnStartAim() end
---@param SummonCount int32
function ABP_YakushimaBlade003_C:OnSummonWeapon(SummonCount) end
function ABP_YakushimaBlade003_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_YakushimaBlade003_C:ReceiveTick(DeltaSeconds) end
function ABP_YakushimaBlade003_C:ReleaseWeapon() end
---@param EntryPoint int32
function ABP_YakushimaBlade003_C:ExecuteUbergraph_BP_YakushimaBlade003(EntryPoint) end


