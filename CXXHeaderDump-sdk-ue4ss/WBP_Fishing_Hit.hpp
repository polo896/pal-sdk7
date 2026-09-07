#ifndef UE4SS_SDK_WBP_Fishing_Hit_HPP
#define UE4SS_SDK_WBP_Fishing_Hit_HPP

class UWBP_Fishing_Hit_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWidgetAnimation* Anm_Guide_Loop;                                           // 0x0280 (size: 0x8)
    class UWidgetAnimation* Anm_Hit;                                                  // 0x0288 (size: 0x8)
    class UImage* Image_115;                                                          // 0x0290 (size: 0x8)
    class UImage* Image_Bloom;                                                        // 0x0298 (size: 0x8)
    class UImage* Image_Mark;                                                         // 0x02A0 (size: 0x8)
    class UImage* Image_Mark_1;                                                       // 0x02A8 (size: 0x8)
    class UImage* Image_Ripple_0;                                                     // 0x02B0 (size: 0x8)
    class UImage* Image_Ripple_1;                                                     // 0x02B8 (size: 0x8)
    class UImage* Image_Ripple_2;                                                     // 0x02C0 (size: 0x8)
    class UWBP_PlayerInputKeyGuideIcon_C* WBP_PlayerInputKeyGuideIcon;                // 0x02C8 (size: 0x8)

    void Finished_2E34FB9345682690EC9932908042E186();
    void AnmEvent_Hit();
    void AnmEvent_Hide();
    void OnInitialized();
    void ExecuteUbergraph_WBP_Fishing_Hit(int32 EntryPoint);
}; // Size: 0x2D0

#endif
