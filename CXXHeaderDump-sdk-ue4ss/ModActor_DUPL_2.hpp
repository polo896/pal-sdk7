#ifndef UE4SS_SDK_ModActor_DUPL_2_HPP
#define UE4SS_SDK_ModActor_DUPL_2_HPP

class AModActor_C : public AActor
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0290 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0298 (size: 0x8)
    TMap<class AActor*, class UPaperSpriteComponent*> ActorMap;                       // 0x02A0 (size: 0x50)
    FTimerHandle ReadyForHUDTimer;                                                    // 0x02F0 (size: 0x8)
    bool Position Mode;                                                               // 0x02F8 (size: 0x1)
    bool Hidden;                                                                      // 0x02F9 (size: 0x1)
    FString ModAuthor;                                                                // 0x0300 (size: 0x10)
    FString ModName;                                                                  // 0x0310 (size: 0x10)
    FString ModDescription;                                                           // 0x0320 (size: 0x10)
    FString ModVersion;                                                               // 0x0330 (size: 0x10)
    FString ModLocation;                                                              // 0x0340 (size: 0x10)
    bool UpKeyDown;                                                                   // 0x0350 (size: 0x1)
    bool DownKeyDown;                                                                 // 0x0351 (size: 0x1)
    bool LeftKeyDown;                                                                 // 0x0352 (size: 0x1)
    bool RightKeyDown;                                                                // 0x0353 (size: 0x1)
    bool ShiftKeyDown;                                                                // 0x0354 (size: 0x1)
    bool CtrlKeyDown;                                                                 // 0x0355 (size: 0x1)
    bool AltKeyDown;                                                                  // 0x0356 (size: 0x1)
    bool NumPlusDown;                                                                 // 0x0357 (size: 0x1)
    bool NumMinusDown;                                                                // 0x0358 (size: 0x1)
    class USceneCaptureComponent2D* SzeneCaptureComponent;                            // 0x0360 (size: 0x8)
    TMap<class FName, class FString> AssetLoading;                                    // 0x0368 (size: 0x50)
    FText PlayerPosition;                                                             // 0x03B8 (size: 0x18)
    bool InBase;                                                                      // 0x03D0 (size: 0x1)
    bool ManuallyHidden;                                                              // 0x03D1 (size: 0x1)
    bool TitleScreenButtonShown;                                                      // 0x03D2 (size: 0x1)
    FVector landScapeRealPositionMin;                                                 // 0x03D8 (size: 0x18)
    FVector landScapeRealPositionMax;                                                 // 0x03F0 (size: 0x18)
    float DisplayScale;                                                               // 0x0408 (size: 0x4)
    float DisplayOffsetX;                                                             // 0x040C (size: 0x4)
    float DisplayOffsetY;                                                             // 0x0410 (size: 0x4)
    FJsonObjectWrapper LiveConfig;                                                    // 0x0418 (size: 0x20)
    FString DefaultConfigJson;                                                        // 0x0438 (size: 0x10)
    FJsonObjectWrapper MergeWorkingConfig;                                            // 0x0448 (size: 0x20)
    bool ZoomInDown;                                                                  // 0x0468 (size: 0x1)
    bool ZoomOutDown;                                                                 // 0x0469 (size: 0x1)
    TMap<class AActor*, class UPaperSpriteComponent*> OtomoActorMap;                  // 0x0470 (size: 0x50)
    TMap<class AActor*, class UPaperSpriteComponent*> PlayerActorMap;                 // 0x04C0 (size: 0x50)
    TMap<class AActor*, class UPaperSpriteComponent*> NPCActorMap;                    // 0x0510 (size: 0x50)
    class APalPlayerCharacter* LocalPlayerCharacter;                                  // 0x0560 (size: 0x8)
    FInputActionKeyMapping ZoomInKeymapCached;                                        // 0x0568 (size: 0x28)
    FInputActionKeyMapping ZoomOutKeymapCached;                                       // 0x0590 (size: 0x28)
    FInputActionKeyMapping MapUpKeymapCached;                                         // 0x05B8 (size: 0x28)
    FInputActionKeyMapping MapDownKeymapCached;                                       // 0x05E0 (size: 0x28)
    FInputActionKeyMapping MapLeftKeymapCached;                                       // 0x0608 (size: 0x28)
    FInputActionKeyMapping MapRightKeymapCached;                                      // 0x0630 (size: 0x28)
    FInputActionKeyMapping MapBiggerKeymapCached;                                     // 0x0658 (size: 0x28)
    FInputActionKeyMapping MapSmallerKeymapCached;                                    // 0x0680 (size: 0x28)
    FString ActiveStringTableId;                                                      // 0x06A8 (size: 0x10)
    class UObject* ActiveStringTable;                                                 // 0x06B8 (size: 0x8)

    void CreateMinimapIconWithTexture(class AActor* TargetActor, class UTexture2D* IconTexture, FString ScaleSettingKey, float HeightOffset, class UPaperSpriteComponent*& Sprite, class UBP_MinimapIconActor_C*& IconComponent);
    void CreateMinimapIcon(class AActor* TargetActor, FSoftObjectPath IconPath, FString ScaleSettingKey, float HeightOffset, class UPaperSpriteComponent*& Sprite, class UBP_MinimapIconActor_C*& IconComponent);
    void ContinuousZoomTick();
    void MergeConfigWithDefaults();
    void PersistConfig();
    void GetPlayerMapCoordinates(FVector2D& Coordinates);
    void RenderMap();
    void BaseEnteredDetection();
    void ToggleSuperZoom();
    void UpdateMapPosition();
    void MoveMapKeyDetection();
    void ToggleMapPressDetection();
    void Map Move Mode Press Detection();
    void CheckCtrlDown();
    void CheckAltDown();
    void CheckShiftDown();
    bool IsHotkeyMappingReleased(const FInputActionKeyMapping& InputActionKeyMapping);
    bool IsHotkeyMappingPressed(const FInputActionKeyMapping& InputActionKeyMapping);
    void InitConfig();
    void GetFilepath(FFilePath& File Path);
    void LoadConfigFromFile(FJsonObjectWrapper& ConfigAsJson);
    void DebugPrint(const FString Message);
    void CreateHUD(class APlayerController* self2);
    void IsPlayerInGame(bool& IsPlayerInGame);
    void CheckReadyForHUD();
    void ScanAndMarkType(TSubclassOf<class AActor> actorClass, class UTexture2D* Texture);
    void ScanAndMarkDungeon(class UTexture2D* Texture);
    void ScanAndMarkNPC();
    void ScanAndMarkPlayer();
    void ScanAndMarkOtomoPal();
    void ScanAndMarkWIldPal();
    void ScanAndMarkRelic();
    void ScanAndMarkNote();
    void ScanTypes();
    void Create Capture Screen Component 2D(class APlayerController* PC);
    void PrintToModLoader(const FString Message);
    void PostBeginPlay();
    void ReadyForHUD();
    void SetupBindingsForModConfig();
    void SetupModConfigBindings(FString Unique Mod Config Name, FString On Saved Callback Name, FString On Updated Callback Name);
    void OnSavedModConfig();
    void OnUpdatedModConfig();
    void ReceiveTick(float DeltaSeconds);
    void CheckTitleScreen();
    void ExecuteUbergraph_ModActor(int32 EntryPoint);
}; // Size: 0x6C0

#endif
