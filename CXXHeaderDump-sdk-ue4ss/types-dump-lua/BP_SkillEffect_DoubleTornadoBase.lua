---@meta

---@class ABP_SkillEffect_DoubleTornadoBase_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SideOffset double
---@field RightTornado APalSkillEffectBase
---@field LeftTornado APalSkillEffectBase
---@field TornadoClass TSubclassOf<AActor>
---@field LeftTargetLocation2D FVector2D
---@field LeftNormalizedDirection2D FVector2D
---@field DotThreshold double
---@field RotationDegree double
---@field MoveSpeed double
---@field RightTargetLocation2D FVector2D
---@field RightNormalizedDirection2D FVector2D
---@field RightTornadoDelay float
---@field LeftTornadoDelay float
---@field StandbyTime double
---@field LeftReady boolean
---@field RightReady boolean
local ABP_SkillEffect_DoubleTornadoBase_C = {}

---@param SkillEffect APalSkillEffectBase
function ABP_SkillEffect_DoubleTornadoBase_C:OnTornadoReady(SkillEffect) end
---@param IsLeft boolean
---@param SkillEffect APalSkillEffectBase
function ABP_SkillEffect_DoubleTornadoBase_C:ShootTornado(IsLeft, SkillEffect) end
---@param Tornado APalSkillEffectBase
---@param DeltaTime double
---@param TargetLocation2D FVector2D
---@param NormalizedDirection2D FVector2D
---@param NewDirection FVector2D
---@param NewTargetLocation2D FVector2D
function ABP_SkillEffect_DoubleTornadoBase_C:MoveToTargetLocation(Tornado, DeltaTime, TargetLocation2D, NormalizedDirection2D, NewDirection, NewTargetLocation2D) end
---@param TargetLocation FVector
function ABP_SkillEffect_DoubleTornadoBase_C:ShootBullet(TargetLocation) end
function ABP_SkillEffect_DoubleTornadoBase_C:CancelShoot() end
---@param DeltaSeconds float
function ABP_SkillEffect_DoubleTornadoBase_C:ReceiveTick(DeltaSeconds) end
function ABP_SkillEffect_DoubleTornadoBase_C:OnInitialize() end
function ABP_SkillEffect_DoubleTornadoBase_C:SpawnLeftTornado() end
function ABP_SkillEffect_DoubleTornadoBase_C:SpawnRightTornado() end
---@param EntryPoint int32
function ABP_SkillEffect_DoubleTornadoBase_C:ExecuteUbergraph_BP_SkillEffect_DoubleTornadoBase(EntryPoint) end


