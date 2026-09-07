#ifndef UE4SS_SDK_WBP_Fishing_Recommended_HPP
#define UE4SS_SDK_WBP_Fishing_Recommended_HPP

class UWBP_Fishing_Recommended_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWidgetAnimation* Anm_Out;                                                  // 0x0280 (size: 0x8)
    class UWidgetAnimation* Anm_In;                                                   // 0x0288 (size: 0x8)
    class UImage* Image;                                                              // 0x0290 (size: 0x8)
    class UImage* Image_32;                                                           // 0x0298 (size: 0x8)
    class UImage* Image_Line_L;                                                       // 0x02A0 (size: 0x8)
    class UImage* Image_Line_L_1;                                                     // 0x02A8 (size: 0x8)
    class UImage* Image_Line_R;                                                       // 0x02B0 (size: 0x8)
    class UImage* Image_Line_R_1;                                                     // 0x02B8 (size: 0x8)
    class USizeBox* SizeBox_Check_1;                                                  // 0x02C0 (size: 0x8)
    class USizeBox* SizeBox_Check_2;                                                  // 0x02C8 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Bait;                                              // 0x02D0 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Rod;                                               // 0x02D8 (size: 0x8)
    bool IsShow;                                                                      // 0x02E0 (size: 0x1)

    void Hide();
    void GetBaitText(FText ItemName, bool IsAbove, FText& Text);
    void GetRodText(FText ItemName, bool IsAbove, FText& Text);
    void Setup(FPalFishingRecommendInfo RecommendInfo);
    void AnmEvent_In();
    void AnmEvent_Out();
    void ExecuteUbergraph_WBP_Fishing_Recommended(int32 EntryPoint);
}; // Size: 0x2E1

#endif
