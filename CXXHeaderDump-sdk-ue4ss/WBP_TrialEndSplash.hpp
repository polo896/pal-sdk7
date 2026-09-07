#ifndef UE4SS_SDK_WBP_TrialEndSplash_HPP
#define UE4SS_SDK_WBP_TrialEndSplash_HPP

class UWBP_TrialEndSplash_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWidgetAnimation* Out;                                                      // 0x0280 (size: 0x8)
    class UWidgetAnimation* In;                                                       // 0x0288 (size: 0x8)
    class UImage* Image_Black;                                                        // 0x0290 (size: 0x8)
    class UWBP_Trial_TYFP_C* WBP_Trial_TYFP;                                          // 0x0298 (size: 0x8)

    void Finished_21855C7B4EA397CD2F6CDD896BC6E582();
    void Construct();
    void EndGame_Timer();
    void ExecuteUbergraph_WBP_TrialEndSplash(int32 EntryPoint);
}; // Size: 0x2A0

#endif
