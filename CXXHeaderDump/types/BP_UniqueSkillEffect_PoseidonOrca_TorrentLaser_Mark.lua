---@meta

---@class ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field ['Is Water'] boolean
local ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C = {}

function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C:ReceiveBeginPlay() end
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C:Burst() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C:FadeOutEffect(DeltaSecond) end
---@param IsWater boolean
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C:SetWaterEffect(IsWater) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C:ExecuteUbergraph_BP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark(EntryPoint) end


