#ifndef UE4SS_SDK_WBP_CustomTimer_HPP
#define UE4SS_SDK_WBP_CustomTimer_HPP

class UWBP_CustomTimer_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UImage* Image_1;                                                            // 0x0280 (size: 0x8)
    class UTextBlock* TimeText;                                                       // 0x0288 (size: 0x8)
    TArray<UTexture2D*> IconList;                                                     // 0x0290 (size: 0x10)

    void UpdateTimer(FString Text);
    void SetIconByID(int32 IconIndex);
    void ExecuteUbergraph_WBP_CustomTimer(int32 EntryPoint);
}; // Size: 0x2A0

#endif
