#ifndef UE4SS_SDK_WBP_SettingsRow_Keybind_HPP
#define UE4SS_SDK_WBP_SettingsRow_Keybind_HPP

class UWBP_SettingsRow_Keybind_C : public UUserWidget
{
    class UInputKeySelector* KeyInput;                                                // 0x0278 (size: 0x8)
    class UTextBlock* Label;                                                          // 0x0280 (size: 0x8)
    class UTextBlock* TextBlock;                                                      // 0x0288 (size: 0x8)
    FString SettingKey;                                                               // 0x0290 (size: 0x10)

}; // Size: 0x2A0

#endif
