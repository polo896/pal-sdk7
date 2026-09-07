#ifndef UE4SS_SDK_BP_AIAction_Teleport_HPP
#define UE4SS_SDK_BP_AIAction_Teleport_HPP

class UBP_AIAction_Teleport_C : public UPalAIActionBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0138 (size: 0x8)
    double TeleProbability;                                                           // 0x0140 (size: 0x8)
    double TeleportTargetDistance;                                                    // 0x0148 (size: 0x8)

    void TeleportFailedAction();
    void ActionBindProcess(class UPalActionBase* action);
    void AfterTeleportAction();
    void IsTeleportCondition(bool& Success);
    void ActTeleport(FVector CurrentLocation, FVector TargetLocation);
    void GetActionClass(bool& Success, TSubclassOf<class UPalActionBase>& Value);
    void ActionStart(class APawn* ControlledPawn);
    void OnChildActionFinished(class UPawnAction* action, TEnumAsByte<EPawnActionResult::Type> WithResult);
    void OnActionEnd();
    void ExecuteUbergraph_BP_AIAction_Teleport(int32 EntryPoint);
}; // Size: 0x150

#endif
