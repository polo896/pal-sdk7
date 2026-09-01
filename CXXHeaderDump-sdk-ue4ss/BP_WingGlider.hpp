#ifndef UE4SS_SDK_BP_WingGlider_HPP
#define UE4SS_SDK_BP_WingGlider_HPP

class ABP_WingGlider_C : public ABP_Glider_Item_Base_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x04C0 (size: 0x8)

    void OnNotifyEnd_BF4C4F184A64D6E26C7312AB7EA510EA(FName NotifyName);
    void OnNotifyBegin_BF4C4F184A64D6E26C7312AB7EA510EA(FName NotifyName);
    void OnInterrupted_BF4C4F184A64D6E26C7312AB7EA510EA(FName NotifyName);
    void OnBlendOut_BF4C4F184A64D6E26C7312AB7EA510EA(FName NotifyName);
    void OnCompleted_BF4C4F184A64D6E26C7312AB7EA510EA(FName NotifyName);
    void OnNotifyEnd_801568FB493F6CAB9A9531919F9B39AD(FName NotifyName);
    void OnNotifyBegin_801568FB493F6CAB9A9531919F9B39AD(FName NotifyName);
    void OnInterrupted_801568FB493F6CAB9A9531919F9B39AD(FName NotifyName);
    void OnBlendOut_801568FB493F6CAB9A9531919F9B39AD(FName NotifyName);
    void OnCompleted_801568FB493F6CAB9A9531919F9B39AD(FName NotifyName);
    void OnEquipJetpack();
    void ReceiveBeginPlay();
    void CustomEvent(class UPalCharacterMovementComponent* Component, TEnumAsByte<EMovementMode> prevMode, TEnumAsByte<EMovementMode> newMode, EPalCharacterMovementCustomMode PrevCustomMode, EPalCharacterMovementCustomMode NewCustomMode);
    void ReceiveTick(float DeltaSeconds);
    void ExecuteUbergraph_BP_WingGlider(int32 EntryPoint);
}; // Size: 0x4C8

#endif
