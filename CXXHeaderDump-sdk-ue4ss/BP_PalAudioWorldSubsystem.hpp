#ifndef UE4SS_SDK_BP_PalAudioWorldSubsystem_HPP
#define UE4SS_SDK_BP_PalAudioWorldSubsystem_HPP

class UBP_PalAudioWorldSubsystem_C : public UPalAudioWorldSubsystem
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x00D8 (size: 0x8)
    bool IsDead;                                                                      // 0x00E0 (size: 0x1)
    class AActor* DeubugModel;                                                        // 0x00E8 (size: 0x8)
    class AActor* LastOneEnemy;                                                       // 0x00F0 (size: 0x8)
    TArray<FGuid> ExecRaid;                                                           // 0x00F8 (size: 0x10)
    TArray<FGuid> ArrivedRaid;                                                        // 0x0108 (size: 0x10)
    bool IsLocalPlayerInsideBaseCamp;                                                 // 0x0118 (size: 0x1)
    TArray<class APalSpotAreaBase*> SpotList;                                         // 0x0120 (size: 0x10)
    TArray<class APalAmbientSoundAreaBase*> AmbientSoundList;                         // 0x0130 (size: 0x10)
    TArray<class APalAmbientSoundAreaBase*> AmbientSoundListPrev;                     // 0x0140 (size: 0x10)
    TArray<int32> AmbinetSoundPlayingIdList;                                          // 0x0150 (size: 0x10)
    FPalAmbientSoundAreaData CurrentAmbientData;                                      // 0x0160 (size: 0x28)
    TMap<class EPalBattleBGMType, class EPalAudioState> BattleBGMMap2;                // 0x0188 (size: 0x50)
    bool IsDisableBattleBGM;                                                          // 0x01D8 (size: 0x1)
    EPalBattleBGMType BattleBGMRankCache;                                             // 0x01D9 (size: 0x1)
    bool IsRaidStateApplied;                                                          // 0x01DA (size: 0x1)

    bool IsRaidBGMSuppressed();
    void ResetBossBGMState(EPalBattleBGMType Selection);
    void OnArenaSequenceChanged(class UPalArenaSequencer* Sequencer, EPalArenaSequenceType PrevType, EPalArenaSequenceType AfterType);
    void SetDsiableBattleBGM(bool bIsDisable);
    void On Change Battle BGM(EPalBattleBGMType Rank);
    void OnArenaSequenceEnd();
    void OnArenaSequenceStart(class UPalArenaSequencer* ArenaSequencer);
    void FindMaxPriorityAmbientSoundArea(class APalAmbientSoundAreaBase*& AmbinetSoundArea);
    bool IsPlayingArea(class APalAmbientSoundAreaBase* AmbientSoundArea);
    void OnPlayerEnterAmbientArea(class APalPlayerCharacter* Player, class APalAmbientSoundAreaBase* AmbientSoundArea);
    void OnPlayerExitAmbientArea(class APalPlayerCharacter* Player, class APalAmbientSoundAreaBase* AmbientSoundArea);
    void PlayAmbientSounds(EPalOneDayTimeType OneDayTimeType);
    void OnChangeOneDayTimeType(EPalOneDayTimeType OneDayTimeType);
    void OnNightEnd();
    void OnNightStart();
    void UpdateAmbient();
    void OnBattleRankDown(EPalPlayerBattleFinishType Finish);
    void OnPlayerExitSpotArea(class APalPlayerCharacter* Player, class APalSpotAreaBase* SpotArea);
    void OnPlayerEnterSpotArea(class APalPlayerCharacter* Player, class APalSpotAreaBase* SpotArea);
    void UpdateSpot();
    void OnPlayerExitBaseCamp(class APalPlayerCharacter* Player, class UPalBaseCampModel* BaseCampModel);
    void OnPlayerEnterBaseCamp(class APalPlayerCharacter* Player, class UPalBaseCampModel* BaseCampModel);
    void Update Raid();
    void OnArrivedRaid(const FPalIncidentBroadcastParameter& Param);
    void OnEndRaid(const FPalIncidentBroadcastParameter& Parameter);
    void On Start Raid(const FPalIncidentBroadcastParameter& Parameter);
    void CreateDebugModel(class AActor*& NewParam);
    void OnBattleModeChanged(bool IsBattleMode);
    void UpdateDebugDisplay();
    void UpdateWorldLocation();
    void UpdateWorldTime();
    void UpdateStatePlayerAlive();
    void SetDefaultState();
    void Tick_BP(float DeltaTime);
    void OnEndOfEvent();
    void DeathPlayer();
    void RespawnPlayer(class APalPlayerCharacter* Player);
    void OnSpawnedLocalPlayerCharacter(class APawn* Pawn, class AController* Controller);
    void カスタムイベント();
    void カスタムイベント_0(bool bIsSkipped);
    void カスタムイベント_1(class APalPlayerState* PlayerState);
    void カスタムイベント_2();
    void ExecuteUbergraph_BP_PalAudioWorldSubsystem(int32 EntryPoint);
}; // Size: 0x1DB

#endif
