#ifndef UE4SS_SDK_WBP_IngameMenu_Incubator_Multiple_HPP
#define UE4SS_SDK_WBP_IngameMenu_Incubator_Multiple_HPP

class UWBP_IngameMenu_Incubator_Multiple_C : public UPalUserWidgetOverlayUI
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0478 (size: 0x8)
    class UCanvasPanel* Canvas_Buff;                                                  // 0x0480 (size: 0x8)
    class UCanvasPanel* Canvas_PowerShortage;                                         // 0x0488 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Buff_Value;                                        // 0x0490 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Head;                                              // 0x0498 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Status;                                            // 0x04A0 (size: 0x8)
    class UWBP_Common_Inventory_C* WBP_Common_Inventory;                              // 0x04A8 (size: 0x8)
    class UWBP_CommonButton_C* WBP_CommonButton_OpenAll;                              // 0x04B0 (size: 0x8)
    class UWBP_CommonButton_1_C* WBP_CommonButton_SetAll;                             // 0x04B8 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot; // 0x04C0 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_1; // 0x04C8 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_2; // 0x04D0 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_3; // 0x04D8 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_4; // 0x04E0 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_5; // 0x04E8 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_6; // 0x04F0 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_7; // 0x04F8 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_8; // 0x0500 (size: 0x8)
    class UWBP_IngameMenu_Incubator_MultipleSlot_C* WBP_Ingame_Incubator_MultipleSlot_9; // 0x0508 (size: 0x8)
    class UWBP_Menu_btn_C* WBP_Menu_btn;                                              // 0x0510 (size: 0x8)
    class UBP_PalInventoryModel_C* InventoryModel;                                    // 0x0518 (size: 0x8)
    class UPalMapObjectMultiHatchingEggModel* Hatching Egg Model;                     // 0x0520 (size: 0x8)
    TArray<UWBP_IngameMenu_Incubator_MultipleSlot_C*> HatchSlots;                     // 0x0528 (size: 0x10)
    bool BlockGetAll;                                                                 // 0x0538 (size: 0x1)
    bool EnableWaitWorkSync;                                                          // 0x0539 (size: 0x1)

    void OnEggArrayUpdated();
    void OnWorkSynced(class UPalMapObjectWorkeeModule* WorkeeModule, class UPalWorkBase* WorkProgress);
    class UWidget* DoCustomNavigation_ToSlot8(EUINavigation Navigation);
    class UWidget* DoCustomNavigation_ToSetAll(EUINavigation Navigation);
    void OnMultiHatchComplete(TArray<FPalInstanceID>& HatchedIDs);
    class UWidget* BP_GetDesiredFocusTarget();
    void FocusRight();
    void FocusLeft();
    void OnLeftClickEggSlot(class UPalItemSlot* TargetSlot);
    void OnRightClickEggSlot(class UPalItemSlot* TargetSlot);
    void UpdateSlots(class UPalItemContainer* ItemContainer);
    void Check Get All Enable(class UPalMapObjectHatchingEggModelBase* Model);
    void RatioToPersentOffsetText(double Ratio, FText& Persent);
    void Update Power Suffcient(class UPalMapObjectEnergyModule* Module);
    void SetupHatch();
    void OnSetup();
    void BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature();
    void OnInitialized();
    void BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_CommonButton_SetAll_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature();
    void BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_CommonButton_OpenAll_K2Node_ComponentBoundEvent_2_OnClicked__DelegateSignature();
    void Destruct();
    void BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_Common_Inventory_K2Node_ComponentBoundEvent_3_OnClickedInventorySortButton__DelegateSignature();
    void OnHatchFailed();
    void Empty(bool bResult);
    void ExecuteUbergraph_WBP_IngameMenu_Incubator_Multiple(int32 EntryPoint);
}; // Size: 0x53A

#endif
