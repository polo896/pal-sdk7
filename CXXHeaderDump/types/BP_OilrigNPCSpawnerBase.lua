---@meta

---@class ABP_OilrigNPCSpawnerBase_C : APalOilrigNPCSpawnerBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Debug_Mesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field DefaultAction TSubclassOf<UBP_AIAction_NPC_RelaxBase_C>
---@field HumanName FPalDataTableRowName_PalHumanData
---@field Level int32
---@field SpawnedNPCHandle UPalIndividualCharacterHandle
---@field OtomoName FPalDataTableRowName_PalMonsterData
---@field RecheckTimerHandle FTimerHandle
---@field SpawnedOtomo APalCharacter
---@field StartCombatByOilrigAlert boolean
local ABP_OilrigNPCSpawnerBase_C = {}

---@param Handles TArray<UPalIndividualCharacterHandle>
function ABP_OilrigNPCSpawnerBase_C:GetAllSpawnedNPCHandle(Handles) end
---@param HolderController AController
---@param OtomoPal APalCharacter
ABP_OilrigNPCSpawnerBase_C['On Spawn Otomo'] = function(self, HolderController, OtomoPal) end
---@param Exist boolean
function ABP_OilrigNPCSpawnerBase_C:ExistSpawnableCollision(Exist) end
function ABP_OilrigNPCSpawnerBase_C:RequestSpawn() end
---@param Distance double
---@param IsNear boolean
function ABP_OilrigNPCSpawnerBase_C:IsNearAnyPlayer(Distance, IsNear) end
function ABP_OilrigNPCSpawnerBase_C:SpawnOneNPC() end
---@param ID FPalInstanceID
ABP_OilrigNPCSpawnerBase_C['Despawn Delegate'] = function(self, ID) end
---@param Handle UPalIndividualCharacterHandle
function ABP_OilrigNPCSpawnerBase_C:Despawn(Handle) end
---@param Handle UPalIndividualCharacterHandle
function ABP_OilrigNPCSpawnerBase_C:InitializeSpawnedCharacter(Handle) end
---@param ID FPalInstanceID
ABP_OilrigNPCSpawnerBase_C['Spawn Delegate'] = function(self, ID) end
---@param CharacterID FName
---@param Level int32
---@param Location FVector
---@param Rotation FRotator
---@param Handle UPalIndividualCharacterHandle
function ABP_OilrigNPCSpawnerBase_C:Spawn(CharacterID, Level, Location, Rotation, Handle) end
---@param EndPlayReason EEndPlayReason::Type
function ABP_OilrigNPCSpawnerBase_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_OilrigNPCSpawnerBase_C:ExecuteUbergraph_BP_OilrigNPCSpawnerBase(EntryPoint) end


