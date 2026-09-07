#ifndef UE4SS_SDK_WBP_IngameMenu_FishPond_PalList_HPP
#define UE4SS_SDK_WBP_IngameMenu_FishPond_PalList_HPP

class UWBP_IngameMenu_FishPond_PalList_C : public UUserWidget
{
    class UImage* Image_Base;                                                         // 0x0278 (size: 0x8)
    class UImage* Image_Base_1;                                                       // 0x0280 (size: 0x8)
    class UImage* Image_Unknown;                                                      // 0x0288 (size: 0x8)
    class UWBP_PalCommonCharacterIcon_C* WBP_PalCommonCharacterIcon;                  // 0x0290 (size: 0x8)

    void SetDisplay(bool bDisplay);
    void SetCharacter(FName CharacterID);
}; // Size: 0x298

#endif
