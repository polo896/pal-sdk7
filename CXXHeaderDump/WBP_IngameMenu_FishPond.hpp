#ifndef UE4SS_SDK_WBP_IngameMenu_FishPond_HPP
#define UE4SS_SDK_WBP_IngameMenu_FishPond_HPP

class UWBP_IngameMenu_FishPond_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UCanvasPanel* CanvasPanelIcon;                                              // 0x0280 (size: 0x8)
    class UCanvasPanel* CanvasPanelMaterialText;                                      // 0x0288 (size: 0x8)
    class UCanvasPanel* CanvasPanelSelect;                                            // 0x0290 (size: 0x8)
    class UImage* DurableFrameB;                                                      // 0x0298 (size: 0x8)
    class UCanvasPanel* Line_U;                                                       // 0x02A0 (size: 0x8)
    class UBP_PalTextBlock_C* MenuTitleText;                                          // 0x02A8 (size: 0x8)
    class UPalScrollBox* PalScrollBox_63;                                             // 0x02B0 (size: 0x8)
    class UWBP_IngameCommonSelectNum_C* WBP_IngameCommonSelectNum;                    // 0x02B8 (size: 0x8)
    class UWBP_IngameMenu_WorkSpace_StartButton_C* WBP_IngameMenu_StartButton;        // 0x02C0 (size: 0x8)
    class UWBP_InventoryEquipment_ItemInfo_Tecnology_C* WBP_InventoryEquipment_ItemInfo_Tecnology; // 0x02C8 (size: 0x8)
    class UWBP_Menu_btn_C* WBP_Menu_btn;                                              // 0x02D0 (size: 0x8)
    class UWBP_PalCommonScrollList_C* WBP_PalCommonScrollList_ListButton;             // 0x02D8 (size: 0x8)
    class UWrapBox* WrapBox_PalList;                                                  // 0x02E0 (size: 0x8)
    FWBP_IngameMenu_FishPond_COnClickedCloseButton OnClickedCloseButton;              // 0x02E8 (size: 0x10)
    void OnClickedCloseButton();
    FWBP_IngameMenu_FishPond_COnClickedStartProduct OnClickedStartProduct;            // 0x02F8 (size: 0x10)
    void OnClickedStartProduct();
    FWBP_IngameMenu_FishPond_COnSetNum OnSetNum;                                      // 0x0308 (size: 0x10)
    void OnSetNum(int32 Num);

    void GetListTopFocusTarget(class UWidget*& Widget);
    void BndEvt__WBP_IngameMenu_FishPond_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature();
    void BndEvt__WBP_IngameMenu_FishPond_WBP_IngameMenu_StartButton_K2Node_ComponentBoundEvent_5_OnClicked__DelegateSignature();
    void BndEvt__WBP_IngameMenu_FishPond_WBP_IngameCommonSelectNum_K2Node_ComponentBoundEvent_7_OnUpdateNum__DelegateSignature(int64 Num);
    void Construct();
    void Destruct();
    void ExecuteUbergraph_WBP_IngameMenu_FishPond(int32 EntryPoint);
    void OnSetNum__DelegateSignature(int32 Num);
    void OnClickedStartProduct__DelegateSignature();
    void OnClickedCloseButton__DelegateSignature();
}; // Size: 0x318

#endif
