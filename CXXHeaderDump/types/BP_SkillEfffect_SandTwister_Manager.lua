---@meta

---@class ABP_SkillEfffect_SandTwister_Manager_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CenterLocation FVector
---@field CircleTornadoCount int32
---@field CircleRadius double
---@field CircleLocations TArray<FVector>
---@field AttackDelay float
---@field AttackTimer FTimerHandle
---@field CircleTornados TArray<ABP_SkillEfffect_SandTwister_Tornado2_C>
---@field AttackAct boolean
---@field RotateSpeed double
---@field RotateTimer double
---@field InitialPhase TArray<double>
local ABP_SkillEfffect_SandTwister_Manager_C = {}

function ABP_SkillEfffect_SandTwister_Manager_C:SpawnTornado() end
function ABP_SkillEfffect_SandTwister_Manager_C:SpawnOmen() end
function ABP_SkillEfffect_SandTwister_Manager_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEfffect_SandTwister_Manager_C:ReceiveTick(DeltaSeconds) end
function ABP_SkillEfffect_SandTwister_Manager_C:CancelAttack() end
---@param EntryPoint int32
function ABP_SkillEfffect_SandTwister_Manager_C:ExecuteUbergraph_BP_SkillEfffect_SandTwister_Manager(EntryPoint) end


