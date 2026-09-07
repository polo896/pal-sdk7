#ifndef UE4SS_SDK_WBP_PalCommonScrollList_Wrap_HPP
#define UE4SS_SDK_WBP_PalCommonScrollList_Wrap_HPP

class UWBP_PalCommonScrollList_Wrap_C : public UPalCommonScrollListBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0450 (size: 0x8)
    class UCanvasPanel* Canvas_Root;                                                  // 0x0458 (size: 0x8)
    class UScrollBox* ScrollBox_Wrap;                                                 // 0x0460 (size: 0x8)
    class UWBP_InventoryArrow_C* WBP_InventoryArrow_Bottom;                           // 0x0468 (size: 0x8)
    class UWBP_InventoryArrow_C* WBP_InventoryArrow_Top;                              // 0x0470 (size: 0x8)
    class UWrapBox* WrapBox;                                                          // 0x0478 (size: 0x8)
    double lastScrollOffset;                                                          // 0x0480 (size: 0x8)
    bool IsDisplayArrow;                                                              // 0x0488 (size: 0x1)
    EScrollWhenFocusChanges GamePadFocusChangeScrollType;                             // 0x0489 (size: 0x1)

    void SetEnableMouseWheelScroll(bool bEnableMouseWheel);
    void GetScrollBox(class UScrollBox*& ScrollBox);
    void AddWidget(class UUserWidget* Widget);
    void GetAllChildrenNum(int32& Index);
    void GetIndexFromWidget(class UWidget* Widget, int32& Index);
    void AddScrollOffset(double Offset);
    void OnInputMethodChanged(ECommonInputType bNewInputType);
    void ClearAllChildren();
    void UpdateArrowVisibilityAndAnimation(double CurrentOffset);
    void Construct();
    void Destruct();
    void BndEvt__WBP_PalCommonScrollList_Wrap_ScrollBox_Wrap_K2Node_ComponentBoundEvent_0_OnUserScrolledEvent__DelegateSignature(float CurrentOffset);
    void ExecuteUbergraph_WBP_PalCommonScrollList_Wrap(int32 EntryPoint);
}; // Size: 0x48A

#endif
