#ifndef UE4SS_SDK_WBP_MinimapSettingsButton_HPP
#define UE4SS_SDK_WBP_MinimapSettingsButton_HPP

class UWBP_MinimapSettingsButton_C : public UPalActivatableWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x03D0 (size: 0x8)
    class UButton* OpenSettingsButton;                                                // 0x03D8 (size: 0x8)
    class UTextBlock* TextBlock;                                                      // 0x03E0 (size: 0x8)
    class UWBT_MinimapSettings_C* ActiveSettingsWidget;                               // 0x03E8 (size: 0x8)

    void Construct();
    void BndEvt__WBP_MinimapSettingsButton_OpenSettingsButton_K2Node_ComponentBoundEvent_1_OnButtonPressedEvent__DelegateSignature();
    void ExecuteUbergraph_WBP_MinimapSettingsButton(int32 EntryPoint);
}; // Size: 0x3F0

#endif
