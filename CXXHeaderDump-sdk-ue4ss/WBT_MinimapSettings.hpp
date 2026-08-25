#ifndef UE4SS_SDK_WBT_MinimapSettings_HPP
#define UE4SS_SDK_WBT_MinimapSettings_HPP

class UWBT_MinimapSettings_C : public UPalActivatableWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x03D0 (size: 0x8)
    class UButton* btnCancel;                                                         // 0x03D8 (size: 0x8)
    class UButton* btnReset;                                                          // 0x03E0 (size: 0x8)
    class UButton* btnSave;                                                           // 0x03E8 (size: 0x8)
    class UTextBlock* MinimapSettingsHeader;                                          // 0x03F0 (size: 0x8)
    class UScrollBox* ScrollBox;                                                      // 0x03F8 (size: 0x8)
    class UTextBlock* TextBlock_1;                                                    // 0x0400 (size: 0x8)
    class UTextBlock* TextBlock_127;                                                  // 0x0408 (size: 0x8)
    class UTextBlock* TextBlock_313;                                                  // 0x0410 (size: 0x8)
    class UVerticalBox* VerticalBox;                                                  // 0x0418 (size: 0x8)
    class UObject* MyModActor;                                                        // 0x0420 (size: 0x8)
    class AModActor_C* ModActorRef;                                                   // 0x0428 (size: 0x8)

    void ResetSettingsRows();
    void SaveSettingsRows();
    void BuildSettingsRows();
    void BuildKeyMapping(class UWBP_SettingsRow_Keybind_C* Row, FName ActionName, FInputActionKeyMapping& Output);
    void CreateHeaderRow(FText Label, class UWBP_SettingsRow_Header_C*& Output);
    void Create Keybind Row(FText Label, FText Description, const FInputChord& InSelectedKey, class UWBP_SettingsRow_Keybind_C*& Output);
    void CreateSliderRow(FText Reference, FText Description, float MinValue, float MaxValue, float Value, float Step Size, class UWBP_SettingsRow_Slider_C*& Output);
    void CreateToggleRow(FText Label, FText Description, bool bIsOn, class UWBP_SettingsRow_Toggle_C*& Output);
    void PrintToModLoader(FString Message);
    void Construct();
    void BndEvt__WBP_MinimapSettings_btnCancel_K2Node_ComponentBoundEvent_1_OnButtonPressedEvent__DelegateSignature();
    void BndEvt__WBP_MinimapSettings_btnSave_K2Node_ComponentBoundEvent_2_OnButtonPressedEvent__DelegateSignature();
    void BndEvt__WBT_MinimapSettings_btnReset_K2Node_ComponentBoundEvent_0_OnButtonPressedEvent__DelegateSignature();
    void ExecuteUbergraph_WBT_MinimapSettings(int32 EntryPoint);
}; // Size: 0x430

#endif
