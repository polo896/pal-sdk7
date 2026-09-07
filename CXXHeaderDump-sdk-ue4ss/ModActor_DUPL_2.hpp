#ifndef UE4SS_SDK_ModActor_DUPL_2_HPP
#define UE4SS_SDK_ModActor_DUPL_2_HPP

class AModActor_C : public AActor
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0290 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0298 (size: 0x8)
    bool Can Press Hotkey;                                                            // 0x02A0 (size: 0x1)
    FVector EggHatcherIndicatorPrevLoc;                                               // 0x02A8 (size: 0x18)
    class UPalInteractiveObjectBoxComponent* EggHatcher;                              // 0x02C0 (size: 0x8)
    bool ShouldEnableInteract;                                                        // 0x02C8 (size: 0x1)
    TArray<class APalBuildObject*> EggHatchers;                                       // 0x02D0 (size: 0x10)
    TArray<class UPalInteractiveObjectBoxComponent*> InteractiveBoxArray;             // 0x02E0 (size: 0x10)
    class UObject* Last Interacted Object;                                            // 0x02F0 (size: 0x8)
    FVector LastInteractedObjectIndicatorPosition;                                    // 0x02F8 (size: 0x18)
    bool WidgetOnScreen;                                                              // 0x0310 (size: 0x1)
    class UPalPlayerManager* Player Manager;                                          // 0x0318 (size: 0x8)
    TMap<class FGuid, class APalPlayerState*> Players;                                // 0x0320 (size: 0x50)
    bool DedicatedServer;                                                             // 0x0370 (size: 0x1)
    class UPalMapObjectManager* Object Manager;                                       // 0x0378 (size: 0x8)
    class APalGameStateInGame* Game State;                                            // 0x0380 (size: 0x8)
    bool UseAutoHatch;                                                                // 0x0388 (size: 0x1)
    TMap<class FGuid, class bool> PlayerSettings;                                     // 0x0390 (size: 0x50)
    TArray<class UPalMapObjectModel*> EggIncubators;                                  // 0x03E0 (size: 0x10)
    TMap<class UPalMapObjectModel*, class FGuid> PlayerEggIncubators;                 // 0x03F0 (size: 0x50)
    TMap<class UPalMapObjectModel*, class FGuid> PlayerBreedFarms;                    // 0x0440 (size: 0x50)
    bool UsedMultiHatch;                                                              // 0x0490 (size: 0x1)
    TArray<uint8> ByteArray;                                                          // 0x0498 (size: 0x10)
    TMap<class FGuid, class APalPlayerState*> EggToPlayerMap;                         // 0x04A8 (size: 0x50)
    FTimerHandle CheckBreedFarmTimer;                                                 // 0x04F8 (size: 0x8)
    FTimerHandle CheckIncubatorTimer;                                                 // 0x0500 (size: 0x8)
    bool KeepSprint;                                                                  // 0x0508 (size: 0x1)
    TMap<class UPalWorkProgress*, class FGuid> WorkProgress_To_PlayerUId__Map;        // 0x0510 (size: 0x50)
    TMap<class UPalWorkBase*, class FGuid> WorkBase_To_PlayerUId_Map;                 // 0x0560 (size: 0x50)
    TMap<class UPalWorkProgress*, class UPalMapObjectConcreteModelBase*> WorkProgress_To_Incubator_Map; // 0x05B0 (size: 0x50)

    void PickUpAllEggs();
    void GetPalFromPaldexID();
    void GetEggOwnerUIdMulti(class UPalMapObjectMultiHatchingEggModel* PalMapObjectMultiHatchingEggModel, int32 Index, FGuid& OwnerUId);
    void GetEggOwnerUIdSingle(class UPalMapObjectHatchingEggModel* PalMapObjectHatchingEggModel, FGuid& OwnerUId);
    void GivePlayerID(int32 ID, int32& PlayerId);
    void AutoPickUpEgg(class UPalMapObjectModel* Target Egg, FGuid PlayerUId_In, FGuid& PlayerUId, class UPalMapObjectModel*& TargetBreedFarm, class UPalMapObjectModel*& Egg);
    void EggCleanUp(class UPalMapObjectModel* Target Breed Farm);
    void FindBreedFarmBelongTo(FGuid InstanceId);
    void SaveToJson();
    void Lua_ModInitialized(class AModActor_C*& Mod Actor);
    FString PushedStackableUI(class APalHUDInGame*& AsPal HUDIn Game, class UPalUserWidgetStackableUI*& StackableWidget);
    void GetLoggedInPlayerUId(FGuid ModelPlayerUId, FGuid& PlayerUId);
    void FinishInit(class APalCharacter* InCharacter);
    void LoadPlayerSettings(FString UId, bool Enabled);
    void OnRecievedChatMessageDelegate_Event(const FPalChatMessage& Message);
    void BP_OnWidgetDeactivated_Event();
    void OnPushedStackableUI_Event(const FGuid& pushedWidgetID);
    void OnCreateMapObject(class UPalMapObjectModel* MapObjectModel, const FVector& Vector);
    void PostBeginPlay();
    void PreBeginPlay();
    void PrintToModLoader(FString Message);
    void ReceiveTick(float DeltaSeconds);
    void OnUpdateHatchedCharacterDelegate_Event(class UPalMapObjectHatchingEggModel* Model);
    void ChatReceived(EPalChatCategory Category, FString Sender, FString Sender Player UId, FString Message);
    void OnReflectWorkAmountDelegate_Event(class UPalWorkProgress* WorkProgress);
    void GetIncubatorsOnLaunch();
    void GetBytes(uint8 Byte);
    void GetPlayerStateFromLua(FString PlayerUId, class APalPlayerState* PlayerState);
    void GetBreedFarms();
    void OnChangeSprintDelegate_Event(class UPalCharacterMovementComponent* Component, bool IsInSprint);
    void GetGameStateFromLua(class APalGameStateInGame* Game State);
    void GetObjectManagerFromLua(class UPalMapObjectManager* Object Manager);
    void OnAncientHatcheryReflectWorkAmount(class UPalWorkProgress* WorkProgress);
    void OnUpdatePalEggArray();
    void AutoHatch(FGuid PlayerUId);
    void GetPlayerManagerFromLua(class UPalPlayerManager* Player Manager);
    void ExecuteUbergraph_ModActor(int32 EntryPoint);
}; // Size: 0x600

#endif
