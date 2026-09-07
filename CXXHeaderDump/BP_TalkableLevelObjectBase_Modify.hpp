#ifndef UE4SS_SDK_BP_TalkableLevelObjectBase_Modify_HPP
#define UE4SS_SDK_BP_TalkableLevelObjectBase_Modify_HPP

class ABP_TalkableLevelObjectBase_Modify_C : public APalLevelObject_Talkable
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02D0 (size: 0x8)
    class UPalLimitVolumeBoxComponent* PalLimitVolumeBox;                             // 0x02D8 (size: 0x8)
    class UPalInteractableSphereComponentNative* BP_InteractableSphere;               // 0x02E0 (size: 0x8)
    class UPalSkeletalMeshComponent* CharacterMesh;                                   // 0x02E8 (size: 0x8)
    class UPalLookAtComponent* PalLookAt;                                             // 0x02F0 (size: 0x8)
    class UBP_PalNPCTalkFlowComponent_C* BP_PalNPCTalkFlowComponent;                  // 0x02F8 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0300 (size: 0x8)
    class UAnimMontage* IdleAnimation;                                                // 0x0308 (size: 0x8)
    class UPalQuestManager* QuestManager;                                             // 0x0310 (size: 0x8)
    bool DefaultVisibility;                                                           // 0x0318 (size: 0x1)
    bool IsTurnWhenTalkStart;                                                         // 0x0319 (size: 0x1)
    TArray<FF_Pal_TalkableLevelObjectVisibilityCondition> VisibilityCondition;        // 0x0320 (size: 0x10)
    FBP_TalkableLevelObjectBase_Modify_COnHiddenAndDisableCollision OnHiddenAndDisableCollision; // 0x0330 (size: 0x10)
    void OnHiddenAndDisableCollision();
    bool IsEnableTickTurn;                                                            // 0x0340 (size: 0x1)
    bool IsEnableLookAtBeforeTalk;                                                    // 0x0341 (size: 0x1)

    void UpdateVisibility(bool OnBeginPlay, bool& Visibility);
    void SetHiddenAndDisableCollision(bool InputPin);
    bool IsBlockInProgress(TSubclassOf<class UPalQuestBlock> QuestBlock, const FName& QuestId, class UPalQuestManager* QuestManager);
    bool CanTalk();
    void OnNotifyEnd_4EDD31BC41D3E5422416BCBED6D49E3A(FName NotifyName);
    void OnNotifyBegin_4EDD31BC41D3E5422416BCBED6D49E3A(FName NotifyName);
    void OnInterrupted_4EDD31BC41D3E5422416BCBED6D49E3A(FName NotifyName);
    void OnBlendOut_4EDD31BC41D3E5422416BCBED6D49E3A(FName NotifyName);
    void OnCompleted_4EDD31BC41D3E5422416BCBED6D49E3A(FName NotifyName);
    void BndEvt__BP_TalkableLevelObjectBase_BP_PalNPCTalkFlowComponent_K2Node_ComponentBoundEvent_0_OnPreStartFlowDelegate__DelegateSignature(class UPalNPCTalkFlowComponent* SelfComponent);
    void BndEvt__BP_TalkableLevelObjectBase_BP_PalNPCTalkFlowComponent_K2Node_ComponentBoundEvent_1_OnEndTalkFlowDelegate__DelegateSignature(class UPalNPCTalkFlowComponent* SelfComponent);
    void OnCompleteSyncPlayer_BP(class APalPlayerState* PlayerState);
    void ReceiveBeginPlay();
    void OnCreatedLocalPlayerState(class UPalQuestManager* QuestManager);
    void WaitCompletedLocalPlayerState();
    void OnSetHiddenAndDisableCollision();
    void OnCreatedQuestManager(class UPalQuestManager* QuestManager);
    void OnQuestStateChanged(const FName& QuestId);
    void WaitUntilPlayerLeaves(bool Visibility);
    void カスタムイベント();
    void ReceiveTick(float DeltaSeconds);
    void ExecuteUbergraph_BP_TalkableLevelObjectBase_Modify(int32 EntryPoint);
    void OnHiddenAndDisableCollision__DelegateSignature();
}; // Size: 0x342

#endif
