---@meta

---@class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Niagara UNiagaraComponent
---@field MagmaLife double
local ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C = {}

function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C:ReceiveBeginPlay() end
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C:LifeEnd() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C:FadeOutEffect(DeltaSecond) end
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C:DoFadeEffect() end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C:ExecuteUbergraph_BP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma(EntryPoint) end


