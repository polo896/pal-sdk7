---@meta

---@class ABP_OilrigNPCSpawner_Mono_C : ABP_OilrigNPCSpawnerBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_OilrigNPCSpawner_Mono_C = {}

---@param SelfCharacter APalCharacter
---@param Attacker APalCharacter
ABP_OilrigNPCSpawner_Mono_C['On Captured'] = function(self, SelfCharacter, Attacker) end
---@param DeadInfo FPalDeadInfo
ABP_OilrigNPCSpawner_Mono_C['On Dead'] = function(self, DeadInfo) end
---@param Handle UPalIndividualCharacterHandle
function ABP_OilrigNPCSpawner_Mono_C:InitializeSpawnedCharacter(Handle) end
function ABP_OilrigNPCSpawner_Mono_C:ReceiveBeginPlay() end
function ABP_OilrigNPCSpawner_Mono_C:OnResetOilrig_BP() end
---@param DeltaTime float
function ABP_OilrigNPCSpawner_Mono_C:BlueprintTick_Spawning(DeltaTime) end
---@param DeltaTime float
function ABP_OilrigNPCSpawner_Mono_C:BlueprintTick_Despawning(DeltaTime) end
---@param EntryPoint int32
function ABP_OilrigNPCSpawner_Mono_C:ExecuteUbergraph_BP_OilrigNPCSpawner_Mono(EntryPoint) end


