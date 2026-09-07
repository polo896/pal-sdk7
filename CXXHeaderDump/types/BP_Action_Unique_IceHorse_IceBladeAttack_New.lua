---@meta

---@class UBP_Action_Unique_IceHorse_IceBladeAttack_New_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TackleModule UPalSkillModule_HorseTackle
---@field SkillEffect_Loop ABP_SkillEffectBase_C
---@field EffectEndTimerHandle FTimerHandle
---@field SocketOffsetMap TArray<FName>
local UBP_Action_Unique_IceHorse_IceBladeAttack_New_C = {}

---@param OutActor AActor
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:SearchEnemyCharacter(OutActor) end
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:ActSpecialAttack() end
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:TickAction(DeltaTime) end
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:OnCompletedEndMontage() end
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:OnEndAction() end
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:OnEndAttack() end
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:OnEndSkillEffect() end
---@param LoopEffect APalSkillEffectBase
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:OnSpawnedLoopEffect(LoopEffect) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:OnMontageNotify(Montage, NotifyName) end
---@param EntryPoint int32
function UBP_Action_Unique_IceHorse_IceBladeAttack_New_C:ExecuteUbergraph_BP_Action_Unique_IceHorse_IceBladeAttack_New(EntryPoint) end


