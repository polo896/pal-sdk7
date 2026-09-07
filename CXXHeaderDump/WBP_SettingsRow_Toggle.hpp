#ifndef UE4SS_SDK_WBP_SettingsRow_Toggle_HPP
#define UE4SS_SDK_WBP_SettingsRow_Toggle_HPP

class UWBP_SettingsRow_Toggle_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UButton* btnOne;                                                            // 0x0280 (size: 0x8)
    class UTextBlock* btnOneText;                                                     // 0x0288 (size: 0x8)
    class UButton* btnTwo;                                                            // 0x0290 (size: 0x8)
    class UTextBlock* btnTwoText;                                                     // 0x0298 (size: 0x8)
    class UTextBlock* Label;                                                          // 0x02A0 (size: 0x8)
    class UTextBlock* TextBlock;                                                      // 0x02A8 (size: 0x8)
    bool bIsOn;                                                                       // 0x02B0 (size: 0x1)
    FString SettingKey;                                                               // 0x02B8 (size: 0x10)

    void SetIsOn(bool NewValue);
    void Construct();
    void BndEvt__WBP_SettingsRow_Toggle_btnOne_K2Node_ComponentBoundEvent_2_OnButtonPressedEvent__DelegateSignature();
    void BndEvt__WBP_SettingsRow_Toggle_btnTwo_K2Node_ComponentBoundEvent_3_OnButtonPressedEvent__DelegateSignature();
    void ExecuteUbergraph_WBP_SettingsRow_Toggle(int32 EntryPoint);
}; // Size: 0x2C8

#endif
