#ifndef UE4SS_SDK_WBP_Fishing_Required_HPP
#define UE4SS_SDK_WBP_Fishing_Required_HPP

class UWBP_Fishing_Required_C : public UPalUserWidgetWorldHUD
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0450 (size: 0x8)
    class UWidgetAnimation* Anm_In;                                                   // 0x0458 (size: 0x8)
    class UImage* Image;                                                              // 0x0460 (size: 0x8)
    class UImage* Image_597;                                                          // 0x0468 (size: 0x8)
    class UImage* Image_680;                                                          // 0x0470 (size: 0x8)
    class UImage* Image_Dot;                                                          // 0x0478 (size: 0x8)

    void Construct();
    void ExecuteUbergraph_WBP_Fishing_Required(int32 EntryPoint);
}; // Size: 0x480

#endif
