---@meta

---@class ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Box UBoxComponent
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field ChargeTime float
---@field EnablePull boolean
---@field OverlappedActors TArray<APalCharacter>
---@field PullRadius double
---@field PullVelocity double
---@field AttractAlpha double
local ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C = {}

---@param Character APalCharacter
---@param InRange boolean
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:CalcZInRange(Character, InRange) end
---@param DeltaSeconds float
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:ReceiveTick(DeltaSeconds) end
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:UserConstructionScript() end
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:ReceiveBeginPlay() end
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:Activate() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:FadeOutEffect(DeltaSecond) end
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:SetFade() end
---@param PSystem UNiagaraComponent
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:BndEvt__BP_SkillEffect_ThunderStorm_Storm_Niagara_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:BndEvt__BP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param Life double
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:SetLife(Life) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C:ExecuteUbergraph_BP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm(EntryPoint) end


