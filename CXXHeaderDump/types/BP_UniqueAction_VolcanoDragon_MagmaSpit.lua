---@meta

---@class UBP_UniqueAction_VolcanoDragon_MagmaSpit_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NowAdjusting boolean
---@field ActDirect boolean
---@field SpitInterval float
---@field SpitTimer FTimerHandle
---@field RandomBulletRange double
---@field DirectAdjustAlpha float
---@field ScaterOffset TArray<FVector2D>
---@field SpitCount int32
---@field EnableRotate boolean
---@field MagmaManager ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_MagmaManager_C
local UBP_UniqueAction_VolcanoDragon_MagmaSpit_C = {}

---@param Niagara UNiagaraSystem
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:GetMuzzleEffect(Niagara) end
---@param ManagerClass TSubclassOf<ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_MagmaManager_C>
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:GetManagerClass(ManagerClass) end
---@param BulletClass TSubclassOf<ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C>
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:GetBulletClass(BulletClass) end
---@param MagmaActor ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnMagmaSpawned(MagmaActor) end
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:SpitMagma() end
---@param NotifyName FName
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnNotifyEnd_B9F2F461484E222101E73E8D8B6B42B6(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnNotifyBegin_B9F2F461484E222101E73E8D8B6B42B6(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnInterrupted_B9F2F461484E222101E73E8D8B6B42B6(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnBlendOut_B9F2F461484E222101E73E8D8B6B42B6(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnCompleted_B9F2F461484E222101E73E8D8B6B42B6(NotifyName) end
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnBeginAction() end
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:OnEndAction() end
---@param DeltaTime float
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_UniqueAction_VolcanoDragon_MagmaSpit_C:ExecuteUbergraph_BP_UniqueAction_VolcanoDragon_MagmaSpit(EntryPoint) end


