---@meta

---@class AModActor_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultSceneRoot USceneComponent
---@field ['Can Press Hotkey'] boolean
---@field EggHatcherIndicatorPrevLoc FVector
---@field EggHatcher UPalInteractiveObjectBoxComponent
---@field ShouldEnableInteract boolean
---@field EggHatchers TArray<APalBuildObject>
---@field InteractiveBoxArray TArray<UPalInteractiveObjectBoxComponent>
---@field ['Last Interacted Object'] UObject
---@field LastInteractedObjectIndicatorPosition FVector
---@field WidgetOnScreen boolean
---@field ['Player Manager'] UPalPlayerManager
---@field Players TMap<FGuid, APalPlayerState>
---@field DedicatedServer boolean
---@field ['Object Manager'] UPalMapObjectManager
---@field ['Game State'] APalGameStateInGame
---@field UseAutoHatch boolean
---@field PlayerSettings TMap<FGuid, boolean>
---@field EggIncubators TArray<UPalMapObjectModel>
---@field PlayerEggIncubators TMap<UPalMapObjectModel, FGuid>
---@field PlayerBreedFarms TMap<UPalMapObjectModel, FGuid>
---@field UsedMultiHatch boolean
---@field ByteArray TArray<uint8>
---@field EggToPlayerMap TMap<FGuid, APalPlayerState>
---@field CheckBreedFarmTimer FTimerHandle
---@field CheckIncubatorTimer FTimerHandle
---@field KeepSprint boolean
---@field WorkProgress_To_PlayerUId__Map TMap<UPalWorkProgress, FGuid>
---@field WorkBase_To_PlayerUId_Map TMap<UPalWorkBase, FGuid>
---@field WorkProgress_To_Incubator_Map TMap<UPalWorkProgress, UPalMapObjectConcreteModelBase>
local AModActor_C = {}

function AModActor_C:PickUpAllEggs() end
function AModActor_C:GetPalFromPaldexID() end
---@param PalMapObjectMultiHatchingEggModel UPalMapObjectMultiHatchingEggModel
---@param Index int32
---@param OwnerUId FGuid
function AModActor_C:GetEggOwnerUIdMulti(PalMapObjectMultiHatchingEggModel, Index, OwnerUId) end
---@param PalMapObjectHatchingEggModel UPalMapObjectHatchingEggModel
---@param OwnerUId FGuid
function AModActor_C:GetEggOwnerUIdSingle(PalMapObjectHatchingEggModel, OwnerUId) end
---@param ID int32
---@param PlayerId int32
function AModActor_C:GivePlayerID(ID, PlayerId) end
---@param Target_Egg UPalMapObjectModel
---@param PlayerUId_In FGuid
---@param PlayerUId FGuid
---@param TargetBreedFarm UPalMapObjectModel
---@param Egg UPalMapObjectModel
function AModActor_C:AutoPickUpEgg(Target_Egg, PlayerUId_In, PlayerUId, TargetBreedFarm, Egg) end
---@param Target_Breed_Farm UPalMapObjectModel
function AModActor_C:EggCleanUp(Target_Breed_Farm) end
---@param InstanceId FGuid
function AModActor_C:FindBreedFarmBelongTo(InstanceId) end
function AModActor_C:SaveToJson() end
---@param Mod_Actor AModActor_C
function AModActor_C:Lua_ModInitialized(Mod_Actor) end
---@param AsPal_HUDIn_Game APalHUDInGame
---@param StackableWidget UPalUserWidgetStackableUI
---@return FString
function AModActor_C:PushedStackableUI(AsPal_HUDIn_Game, StackableWidget) end
---@param ModelPlayerUId FGuid
---@param PlayerUId FGuid
function AModActor_C:GetLoggedInPlayerUId(ModelPlayerUId, PlayerUId) end
---@param InCharacter APalCharacter
function AModActor_C:FinishInit(InCharacter) end
---@param UId FString
---@param Enabled boolean
function AModActor_C:LoadPlayerSettings(UId, Enabled) end
---@param Message FPalChatMessage
function AModActor_C:OnRecievedChatMessageDelegate_Event(Message) end
function AModActor_C:BP_OnWidgetDeactivated_Event() end
---@param pushedWidgetID FGuid
function AModActor_C:OnPushedStackableUI_Event(pushedWidgetID) end
---@param MapObjectModel UPalMapObjectModel
---@param Vector FVector
function AModActor_C:OnCreateMapObject(MapObjectModel, Vector) end
function AModActor_C:PostBeginPlay() end
function AModActor_C:PreBeginPlay() end
---@param Message FString
function AModActor_C:PrintToModLoader(Message) end
---@param DeltaSeconds float
function AModActor_C:ReceiveTick(DeltaSeconds) end
---@param Model UPalMapObjectHatchingEggModel
function AModActor_C:OnUpdateHatchedCharacterDelegate_Event(Model) end
---@param Category EPalChatCategory
---@param Sender FString
---@param Sender_Player_UId FString
---@param Message FString
function AModActor_C:ChatReceived(Category, Sender, Sender_Player_UId, Message) end
---@param WorkProgress UPalWorkProgress
function AModActor_C:OnReflectWorkAmountDelegate_Event(WorkProgress) end
function AModActor_C:GetIncubatorsOnLaunch() end
---@param Byte uint8
function AModActor_C:GetBytes(Byte) end
---@param PlayerUId FString
---@param PlayerState APalPlayerState
function AModActor_C:GetPlayerStateFromLua(PlayerUId, PlayerState) end
function AModActor_C:GetBreedFarms() end
---@param Component UPalCharacterMovementComponent
---@param IsInSprint boolean
function AModActor_C:OnChangeSprintDelegate_Event(Component, IsInSprint) end
---@param Game_State APalGameStateInGame
function AModActor_C:GetGameStateFromLua(Game_State) end
---@param Object_Manager UPalMapObjectManager
function AModActor_C:GetObjectManagerFromLua(Object_Manager) end
---@param WorkProgress UPalWorkProgress
function AModActor_C:OnAncientHatcheryReflectWorkAmount(WorkProgress) end
function AModActor_C:OnUpdatePalEggArray() end
---@param PlayerUId FGuid
function AModActor_C:AutoHatch(PlayerUId) end
---@param Player_Manager UPalPlayerManager
function AModActor_C:GetPlayerManagerFromLua(Player_Manager) end
---@param EntryPoint int32
function AModActor_C:ExecuteUbergraph_ModActor(EntryPoint) end


