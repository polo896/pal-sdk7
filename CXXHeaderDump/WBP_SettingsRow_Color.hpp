#ifndef UE4SS_SDK_WBP_SettingsRow_Color_HPP
#define UE4SS_SDK_WBP_SettingsRow_Color_HPP

class UWBP_SettingsRow_Color_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class USlider* Hue_Slider;                                                        // 0x0280 (size: 0x8)
    class UTextBlock* Label;                                                          // 0x0288 (size: 0x8)
    class UBorder* Preview;                                                           // 0x0290 (size: 0x8)
    class USlider* Saturation_Slider;                                                 // 0x0298 (size: 0x8)
    class UTextBlock* TextBlock;                                                      // 0x02A0 (size: 0x8)
    class USlider* Value_Slider;                                                      // 0x02A8 (size: 0x8)
    FString SettingKey;                                                               // 0x02B0 (size: 0x10)
    class UMaterialInstanceDynamic* SatGradientMID;                                   // 0x02C0 (size: 0x8)
    class UMaterialInstanceDynamic* ValGradientMID;                                   // 0x02C8 (size: 0x8)

    void BndEvt__WBP_SettingsRow_Color_Hue_Slider_K2Node_ComponentBoundEvent_0_OnFloatValueChangedEvent__DelegateSignature(float Value);
    void BndEvt__WBP_SettingsRow_Color_Saturation_Slider_K2Node_ComponentBoundEvent_1_OnFloatValueChangedEvent__DelegateSignature(float Value);
    void BndEvt__WBP_SettingsRow_Color_Value_Slider_K2Node_ComponentBoundEvent_2_OnFloatValueChangedEvent__DelegateSignature(float Value);
    void InitGradientMIDs();
    void RefreshGradientTint();
    void ExecuteUbergraph_WBP_SettingsRow_Color(int32 EntryPoint);
}; // Size: 0x2D0

#endif
