#ifndef UE4SS_SDK_WBP_IngameMenu_FishPond_ListButton_HPP
#define UE4SS_SDK_WBP_IngameMenu_FishPond_ListButton_HPP

class UWBP_IngameMenu_FishPond_ListButton_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWidgetAnimation* Anm_Selected;                                             // 0x0280 (size: 0x8)
    class UWidgetAnimation* Anm_NormalToFocus;                                        // 0x0288 (size: 0x8)
    class UImage* Image_3;                                                            // 0x0290 (size: 0x8)
    class UImage* Image_Base;                                                         // 0x0298 (size: 0x8)
    class UImage* Image_Base_Focus;                                                   // 0x02A0 (size: 0x8)
    class UImage* Image_Base_Selected;                                                // 0x02A8 (size: 0x8)
    class UImage* Image_Frame;                                                        // 0x02B0 (size: 0x8)
    class UImage* Image_Frame_1;                                                      // 0x02B8 (size: 0x8)
    class UImage* Image_Time_1;                                                       // 0x02C0 (size: 0x8)
    class UImage* Image_Time_2;                                                       // 0x02C8 (size: 0x8)
    class UImage* Image_Time_3;                                                       // 0x02D0 (size: 0x8)
    class UImage* Image_Time_4;                                                       // 0x02D8 (size: 0x8)
    class UImage* Image_Time_5;                                                       // 0x02E0 (size: 0x8)
    class UBP_PalTextBlock_C* Text_FishingPlan;                                       // 0x02E8 (size: 0x8)
    class UWBP_PalInvisibleButton_C* WBP_PalInvisibleButton;                          // 0x02F0 (size: 0x8)
    FWBP_IngameMenu_FishPond_ListButton_COnClickSlot OnClickSlot;                     // 0x02F8 (size: 0x10)
    void OnClickSlot(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    FWBP_IngameMenu_FishPond_ListButton_COnHoveredSlot OnHoveredSlot;                 // 0x0308 (size: 0x10)
    void OnHoveredSlot(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    FWBP_IngameMenu_FishPond_ListButton_COnUnhoveredSlot OnUnhoveredSlot;             // 0x0318 (size: 0x10)
    void OnUnhoveredSlot(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    bool Selected;                                                                    // 0x0328 (size: 0x1)
    FName TargetLotteryName;                                                          // 0x032C (size: 0x8)
    TArray<double> VisibleWorkAmountValues;                                           // 0x0338 (size: 0x10)

    void SetVisibilityMoreThanValue(class UWidget* TargetImage, double Value, double Threshold);
    void UpdateRequiredTimeDisplay(double RequiredWorkAmount);
    void SetUnselect();
    void Setup(FPalUIMapObjectFishPondTargetInfo& InTargetInfo);
    void BndEvt__WBP_IngameMenu_FishPond_ListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_IngameMenu_FishPond_ListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_IngameMenu_FishPond_ListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void ExecuteUbergraph_WBP_IngameMenu_FishPond_ListButton(int32 EntryPoint);
    void OnUnhoveredSlot__DelegateSignature(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    void OnHoveredSlot__DelegateSignature(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    void OnClickSlot__DelegateSignature(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
}; // Size: 0x348

#endif
