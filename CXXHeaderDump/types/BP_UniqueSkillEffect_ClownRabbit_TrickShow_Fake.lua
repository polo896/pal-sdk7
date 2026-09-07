---@meta

---@class ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalFacial UPalFacialComponent
---@field PalSkeletalMesh UPalSkeletalMeshComponent
---@field ['Target Character'] AActor
---@field ['Warp Effect'] UNiagaraSystem
---@field FadeIn boolean
---@field ['Opacity Intensity'] float
local ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C = {}

function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C:ReceiveTick(DeltaSeconds) end
---@param NewLeaderBoneComponent USkinnedMeshComponent
---@param TargetCharacter AActor
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C:SetTargetAndAnim(NewLeaderBoneComponent, TargetCharacter) end
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C:SetFade() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C:FadeOutEffect(DeltaSecond) end
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C:ActFakeAttack() end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C:ExecuteUbergraph_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake(EntryPoint) end


