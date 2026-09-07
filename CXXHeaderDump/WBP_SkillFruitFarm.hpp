#ifndef UE4SS_SDK_WBP_SkillFruitFarm_HPP
#define UE4SS_SDK_WBP_SkillFruitFarm_HPP

class UWBP_SkillFruitFarm_C : public UPalUISkillFruitFarm
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0480 (size: 0x8)
    class UWidgetAnimation* Default_In;                                               // 0x0488 (size: 0x8)
    class UCheckBox* CheckBox_Transport;                                              // 0x0490 (size: 0x8)
    class UHorizontalBox* HorizontalBox_ProductSlot;                                  // 0x0498 (size: 0x8)
    class UHorizontalBox* HorizontalBox_TransportCheckBox;                            // 0x04A0 (size: 0x8)
    class UOverlay* Overlay_WaitRep;                                                  // 0x04A8 (size: 0x8)
    class UBP_PalTextBlock_C* Text_FilterContent;                                     // 0x04B0 (size: 0x8)
    class UBP_PalTextBlock_C* Text_TargetContainerName;                               // 0x04B8 (size: 0x8)
    class UWBP_Common_Inventory_C* WBP_Common_Inventory;                              // 0x04C0 (size: 0x8)
    class UWBP_Menu_btn_C* WBP_Menu_btn;                                              // 0x04C8 (size: 0x8)
    class UWBP_PalCommonWindow_C* WBP_PalCommonWindow;                                // 0x04D0 (size: 0x8)
    class UWBP_PalInGameMenuItemSlotButton_C* WBP_PalInGameMenuItemSlotButton_FruitSlot; // 0x04D8 (size: 0x8)
    class UWBP_PalInvisibleButton_C* WBP_PalInvisibleButton_QuickMove;                // 0x04E0 (size: 0x8)
    class UWBP_PalInvisibleButton_C* WBP_PalInvisibleButton_TransportCheck;           // 0x04E8 (size: 0x8)
    class UBP_PalInventoryModel_C* InventoryModel;                                    // 0x04F0 (size: 0x8)
    FPalDataTableRowName_UIInputAction LeftFocusInput;                                // 0x04F8 (size: 0x8)
    FPalDataTableRowName_UIInputAction RightFocusInput;                               // 0x0500 (size: 0x8)

    class UWidget* CustomNavi_ToFruitSlot(EUINavigation Navigation);
    class UWidget* CustomNavi_ToCloseButton(EUINavigation Navigation);
    class UWidget* CustomNavi_ToGetAllButton(EUINavigation Navigation);
    void OnRightClickedProductSlot(class UWBP_PalItemSlotButtonBase_C* ButtonBase, EPalItemSlotPressType PressType);
    void OnClickedProductSlot(class UWBP_PalItemSlotButtonBase_C* Widget, EPalItemSlotPressType PressType);
    void RequestStopReplication();
    void RequestStartReplication();
    class UWidget* BP_GetDesiredFocusTarget();
    void Setup();
    void OnSetup();
    void Construct();
    void ChangeFocus_Inv_Pad();
    void ChangeFocus_Chest_Pad();
    void OnClose();
    void OnReadyItemContainer(TScriptInterface<class IPalMapObjectItemContainerAccessInterface> AccessInterface);
    void Destruct();
    void BndEvt__WBP_SkillFruitFarm_WBP_Common_Inventory_K2Node_ComponentBoundEvent_0_OnClickedInventorySortButton__DelegateSignature();
    void BndEvt__WBP_SkillFruitFarm_WBP_Common_Inventory_K2Node_ComponentBoundEvent_1_OnRightClickSlot__DelegateSignature(class UWBP_PalItemSlotButtonBase_C* Slot, EPalItemSlotPressType PressType);
    void BndEvt__WBP_SkillFruitFarm_WBP_PalInvisibleButton_QuickMove_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_SkillFruitFarm_WBP_Menu_btn_K2Node_ComponentBoundEvent_4_OnButtonClicked__DelegateSignature();
    void BndEvt__WBP_SkillFruitFarm_WBP_PalInGameMenuItemSlotButton_FruitSlot_K2Node_ComponentBoundEvent_6_OnClickedButton__DelegateSignature(class UWBP_PalItemSlotButtonBase_C* Widget, EPalItemSlotPressType PressType);
    void BndEvt__WBP_SkillFruitFarm_WBP_PalInGameMenuItemSlotButton_FruitSlot_K2Node_ComponentBoundEvent_7_OnRightClickedButton__DelegateSignature(class UWBP_PalItemSlotButtonBase_C* ButtonBase, EPalItemSlotPressType PressType);
    void BndEvt__WBP_SkillFruitFarm_WBP_PalInvisibleButton_TransportCheck_K2Node_ComponentBoundEvent_8_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void ExecuteUbergraph_WBP_SkillFruitFarm(int32 EntryPoint);
}; // Size: 0x508

#endif
