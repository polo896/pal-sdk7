#ifndef UE4SS_SDK_BP_AIAction_RoundStep_HPP
#define UE4SS_SDK_BP_AIAction_RoundStep_HPP

class UBP_AIAction_RoundStep_C : public UPalAIActionBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0138 (size: 0x8)
    double SideWalkProbability;                                                       // 0x0140 (size: 0x8)
    class APalCharacter* SelfActor;                                                   // 0x0148 (size: 0x8)
    class UPalActionBase* PlayAction;                                                 // 0x0150 (size: 0x8)
    bool HasRoundStepped;                                                             // 0x0158 (size: 0x1)
    int32 MaxStepCount;                                                               // 0x015C (size: 0x4)
    bool IsRightStep;                                                                 // 0x0160 (size: 0x1)
    TArray<bool> RoundStepHistoryCache;                                               // 0x0168 (size: 0x10)

    void IsStepCountMax(bool& IsMax);
    void IsFirstCheckRight(bool& IsRight);
    void GetSelfPalBlackBoard(class UBP_PalAIBlackboard_Common_C*& PalBlackBoard);
    void GetStepLocation(bool IsRight, FVector& StepLocation);
    void GetPlayAction(bool IsRight, TSubclassOf<class UPalActionBase>& actionClass);
    void GetPlayMontage(bool IsRight, class UAnimMontage*& Montage);
    void FindStepLocation(FVector& Location, bool& CanStep, bool& IsRight);
    void ActionStart(class APawn* ControlledPawn);
    void OnChildActionFinished(class UPawnAction* action, TEnumAsByte<EPawnActionResult::Type> WithResult);
    void ActionAbort(class APawn* ControlledPawn);
    void ActionFinished(class APawn* ControlledPawn, TEnumAsByte<EPawnActionResult::Type> WithResult);
    void ActionPause(class APawn* ControlledPawn);
    void ActionTick(class APawn* ControlledPawn, float DeltaSeconds);
    void ExecuteUbergraph_BP_AIAction_RoundStep(int32 EntryPoint);
}; // Size: 0x178

#endif
