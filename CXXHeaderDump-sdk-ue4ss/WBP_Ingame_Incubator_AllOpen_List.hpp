#ifndef UE4SS_SDK_WBP_Ingame_Incubator_AllOpen_List_HPP
#define UE4SS_SDK_WBP_Ingame_Incubator_AllOpen_List_HPP

class UWBP_Ingame_Incubator_AllOpen_List_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWidgetAnimation* Anm_NormalToFocus;                                        // 0x0280 (size: 0x8)
    class UBP_PalTextBlock_C* BP_PalTextBlock_Name;                                   // 0x0288 (size: 0x8)
    class UImage* Image_Mutant;                                                       // 0x0290 (size: 0x8)
    class UImage* Image_PalIcon;                                                      // 0x0298 (size: 0x8)
    class UImage* Image_passive_0;                                                    // 0x02A0 (size: 0x8)
    class UImage* Image_passive_1;                                                    // 0x02A8 (size: 0x8)
    class UImage* Image_passive_2;                                                    // 0x02B0 (size: 0x8)
    class UImage* Image_passive_3;                                                    // 0x02B8 (size: 0x8)
    class UImage* Image_Strong;                                                       // 0x02C0 (size: 0x8)
    class UWBP_PalInvisibleButton_C* WBP_PalInvisibleButton;                          // 0x02C8 (size: 0x8)
    TArray<class UImage*> Passives;                                                   // 0x02D0 (size: 0x10)
    int32 Index;                                                                      // 0x02E0 (size: 0x4)
    FWBP_Ingame_Incubator_AllOpen_List_COnHatchedInfoHovered OnHatchedInfoHovered;    // 0x02E8 (size: 0x10)
    void OnHatchedInfoHovered(int32 Index);
    FWBP_Ingame_Incubator_AllOpen_List_COnHatchedInfoUnhovered OnHatchedInfoUnhovered; // 0x02F8 (size: 0x10)
    void OnHatchedInfoUnhovered();

    void BndEvt__WBP_Ingame_Incubator_AllOpen_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_Ingame_Incubator_AllOpen_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void Setup(class UPalIndividualCharacterParameter* individualParam);
    void OnInitialized();
    void ExecuteUbergraph_WBP_Ingame_Incubator_AllOpen_List(int32 EntryPoint);
    void OnHatchedInfoUnhovered__DelegateSignature();
    void OnHatchedInfoHovered__DelegateSignature(int32 Index);
}; // Size: 0x308

#endif
