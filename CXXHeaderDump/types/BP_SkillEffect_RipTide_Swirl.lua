---@meta

---@class ABP_SkillEffect_RipTide_Swirl_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Box UBoxComponent
---@field Niagara UNiagaraComponent
---@field WirlDuration double
---@field CurrentHitableActorMap TMap<UPrimitiveComponent, AActor>
---@field InitialExpansion double
---@field HitActors TArray<AActor>
---@field MaxHitHeight float
---@field HeightBelow double
---@field CurrentExpansion double
---@field RingThickness double
---@field ShrinkSpeed double
local ABP_SkillEffect_RipTide_Swirl_C = {}

function ABP_SkillEffect_RipTide_Swirl_C:UserConstructionScript() end
function ABP_SkillEffect_RipTide_Swirl_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_RipTide_Swirl_C:ReceiveTick(DeltaSeconds) end
function ABP_SkillEffect_RipTide_Swirl_C:StartFadeRing() end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_RipTide_Swirl_C:BndEvt__BP_SkillEffect_Unique_NightmareFlame_Ring_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
function ABP_SkillEffect_RipTide_Swirl_C:BndEvt__BP_SkillEffect_RipTide_Swirl_Box_K2Node_ComponentBoundEvent_2_ComponentEndOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex) end
---@param EntryPoint int32
function ABP_SkillEffect_RipTide_Swirl_C:ExecuteUbergraph_BP_SkillEffect_RipTide_Swirl(EntryPoint) end


