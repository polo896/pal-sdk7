#ifndef UE4SS_SDK_WBP_IngameMenu_Incubator_MultipleSlot_HPP
#define UE4SS_SDK_WBP_IngameMenu_Incubator_MultipleSlot_HPP

class UWBP_IngameMenu_Incubator_MultipleSlot_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UBP_PalTextBlock_C* BP_PalTextBlock_EggName;                                // 0x0280 (size: 0x8)
    class UBP_PalTextBlock_C* BP_PalTextBlock_Empty;                                  // 0x0288 (size: 0x8)
    class UCanvasPanel* Canvas_EggSeted;                                              // 0x0290 (size: 0x8)
    class UOverlay* Overlay_Complete;                                                 // 0x0298 (size: 0x8)
    class UProgressBar* ProgressBar;                                                  // 0x02A0 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Timer;                                             // 0x02A8 (size: 0x8)
    class UWBP_PalInGameMenuItemSlotButton_C* WBP_PalInGameMenuItemSlotButton;        // 0x02B0 (size: 0x8)
    class UPalWorkProgress* Work Progress;                                            // 0x02B8 (size: 0x8)
    FWBP_IngameMenu_Incubator_MultipleSlot_COnRightClickEggSlot OnRightClickEggSlot;  // 0x02C0 (size: 0x10)
    void OnRightClickEggSlot(class UPalItemSlot* TargetSlot);
    class UPalItemSlot* TargetSlot;                                                   // 0x02D0 (size: 0x8)
    FWBP_IngameMenu_Incubator_MultipleSlot_COnLeftClickEggSlot OnLeftClickEggSlot;    // 0x02D8 (size: 0x10)
    void OnLeftClickEggSlot(class UPalItemSlot* TargetSlot);

    void OnSlotContentUpdate(class UPalItemSlot* Slot);
    void On Update Work Amount(class UPalWorkProgress* WorkProgress);
    void SetEmpty();
    void SetupEgg(class UPalWorkProgress* WorkProgress);
    void Unbind();
    void BndEvt__WBP_IngameMenu_Incubator_MultipleSlot_WBP_PalInGameMenuItemSlotButton_K2Node_ComponentBoundEvent_0_OnRightClickedButton__DelegateSignature(class UWBP_PalItemSlotButtonBase_C* ButtonBase, EPalItemSlotPressType PressType);
    void Construct();
    void BndEvt__WBP_IngameMenu_Incubator_MultipleSlot_WBP_PalInGameMenuItemSlotButton_K2Node_ComponentBoundEvent_1_OnClickedButton__DelegateSignature(class UWBP_PalItemSlotButtonBase_C* Widget, EPalItemSlotPressType PressType);
    void SetSlot(class UPalItemSlot* TargetSlot);
    void ExecuteUbergraph_WBP_IngameMenu_Incubator_MultipleSlot(int32 EntryPoint);
    void OnLeftClickEggSlot__DelegateSignature(class UPalItemSlot* TargetSlot);
    void OnRightClickEggSlot__DelegateSignature(class UPalItemSlot* TargetSlot);
}; // Size: 0x2E8

#endif
