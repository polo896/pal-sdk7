#ifndef UE4SS_SDK_BP_AIAction_CityLifePalBase_HPP
#define UE4SS_SDK_BP_AIAction_CityLifePalBase_HPP

class UBP_AIAction_CityLifePalBase_C : public UBP_AIAction_CanCombatBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0178 (size: 0x8)
    class APalCharacter* SelfActor;                                                   // 0x0180 (size: 0x8)
    FTimerHandle UnequipTimer;                                                        // 0x0188 (size: 0x8)
    FVector DefaultLocation;                                                          // 0x0190 (size: 0x18)
    FVector DefaultForward;                                                           // 0x01A8 (size: 0x18)
    bool IsReturnDefaultLocationAI;                                                   // 0x01C0 (size: 0x1)
    bool IsDefaultLocationMotionPlayMode;                                             // 0x01C1 (size: 0x1)
    class UPalActionBase* DefaultLocationAction;                                      // 0x01C8 (size: 0x8)
    double tempDeltaTime;                                                             // 0x01D0 (size: 0x8)
    FRotator DefaultRotate;                                                           // 0x01D8 (size: 0x18)
    bool IsDefaultLocationForceSet;                                                   // 0x01F0 (size: 0x1)
    bool IsSkipSight;                                                                 // 0x01F1 (size: 0x1)
    FTimerHandle SightSkipTimer;                                                      // 0x01F8 (size: 0x8)
    class AActor* CurrentTarget;                                                      // 0x0200 (size: 0x8)
    EPalAIResponseType CurrentResponse;                                               // 0x0208 (size: 0x1)
    TSubclassOf<class UPalActionBase> actionClass;                                    // 0x0210 (size: 0x8)

    void SetDefaultActionClass(TSubclassOf<class UPalActionBase> action);
    void PlayDefaultAction();
    void CancelDefaultAction();
    void SelfIsLeader(bool& IsLeader);
    void SoundEvent(FVector EmitLocation);
    void ActionPause(class APawn* ControlledPawn);
    void ActionAbort(class APawn* ControlledPawn);
    void ActionTickAnyThread(class APawn* ControlledPawn, float DeltaSeconds);
    void ActionFinished(class APawn* ControlledPawn, TEnumAsByte<EPawnActionResult::Type> WithResult);
    void ActionStart(class APawn* ControlledPawn);
    void ActionResume(class APawn* ControlledPawn);
    void ActionPostTick(class APawn* ControlledPawn, float DeltaSeconds);
    void ActionTick(class APawn* ControlledPawn, float DeltaSeconds);
    void ExecuteUbergraph_BP_AIAction_CityLifePalBase(int32 EntryPoint);
}; // Size: 0x218

#endif
