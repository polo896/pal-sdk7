---@meta

---@class ABP_SkillEffect_Commet_Ring_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Box UBoxComponent
---@field Niagara UNiagaraComponent
---@field Duration double
---@field HitActors TArray<AActor>
---@field RingThickness double
---@field ExpandSpeed double
---@field CurrentExpansion double
---@field MaxHitHeight float
---@field HeightBelow double
---@field CurrentHitableActorMap TMap<AActor, UPrimitiveComponent>
local ABP_SkillEffect_Commet_Ring_C = {}

function ABP_SkillEffect_Commet_Ring_C:UserConstructionScript() end
function ABP_SkillEffect_Commet_Ring_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_Commet_Ring_C:ReceiveTick(DeltaSeconds) end
function ABP_SkillEffect_Commet_Ring_C:StartFadeRing() end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_Commet_Ring_C:BndEvt__BP_SkillEffect_Unique_NightmareFlame_Ring_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param EntryPoint int32
function ABP_SkillEffect_Commet_Ring_C:ExecuteUbergraph_BP_SkillEffect_Commet_Ring(EntryPoint) end


