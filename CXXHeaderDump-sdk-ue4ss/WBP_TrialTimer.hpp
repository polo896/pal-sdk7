#ifndef UE4SS_SDK_WBP_TrialTimer_HPP
#define UE4SS_SDK_WBP_TrialTimer_HPP

class UWBP_TrialTimer_C : public UPalUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0450 (size: 0x8)
    class UBP_PalTextBlock_C* BP_PalTextBlock_C_68;                                   // 0x0458 (size: 0x8)

    void Tick(FGeometry MyGeometry, float InDeltaTime);
    void ExecuteUbergraph_WBP_TrialTimer(int32 EntryPoint);
}; // Size: 0x460

#endif
