---@meta

---@class ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Attacker UBoxComponent
---@field Niagara UNiagaraComponent
---@field TimeUntilFade double
---@field ['Time Until Fade Timer'] double
local ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C = {}

---@param action UPalActionBase
function ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C:OnOtherActionBegin(action) end
function ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C:ReceiveBeginPlay() end
---@param DeltaSecond double
function ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C:FadeOut() end
---@param DeltaSeconds float
function ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function ABP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield_C:ExecuteUbergraph_BP_SkillEffect_WhiteShieldDragon_ShieldTackle_Shield(EntryPoint) end


