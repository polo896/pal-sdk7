#ifndef UE4SS_SDK_WBP_SettingsRow_Slider_HPP
#define UE4SS_SDK_WBP_SettingsRow_Slider_HPP

class UWBP_SettingsRow_Slider_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UTextBlock* Label;                                                          // 0x0280 (size: 0x8)
    class USlider* Slider;                                                            // 0x0288 (size: 0x8)
    class UTextBlock* TextBlock;                                                      // 0x0290 (size: 0x8)
    class UTextBlock* Value;                                                          // 0x0298 (size: 0x8)
    FString SettingKey;                                                               // 0x02A0 (size: 0x10)

    void BndEvt__WBP_SettingsRow_Slider_Slider_K2Node_ComponentBoundEvent_0_OnFloatValueChangedEvent__DelegateSignature(float Value);
    void BndEvt__WBP_SettingsRow_Slider_Slider_K2Node_ComponentBoundEvent_1_OnMouseCaptureEndEvent__DelegateSignature();
    void ExecuteUbergraph_WBP_SettingsRow_Slider(int32 EntryPoint);
}; // Size: 0x2B0

#endif
