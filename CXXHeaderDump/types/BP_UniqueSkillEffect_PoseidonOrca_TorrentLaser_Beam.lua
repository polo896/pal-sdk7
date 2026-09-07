---@meta

---@class ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Capsule UCapsuleComponent
local ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C = {}

function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C:ReceiveBeginPlay() end
---@param Length double
---@param Size double
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C:SetBeamSizeAndLife(Length, Size) end
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C:EndBeam() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C:FadeOutEffect(DeltaSecond) end
---@param Length double
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C:SetBeamLength(Length) end
---@param PowerRate double
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C:SetPowerRate(PowerRate) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C:ExecuteUbergraph_BP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam(EntryPoint) end


