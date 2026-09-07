#ifndef UE4SS_SDK_WBP_MultiProductRecipeSelect_HPP
#define UE4SS_SDK_WBP_MultiProductRecipeSelect_HPP

class UWBP_MultiProductRecipeSelect_C : public UPalUserWidgetOverlayUI
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0480 (size: 0x8)
    class UWBP_PalWork_RecipeSelect_C* WBP_PalWork_RecipeSelect;                      // 0x0488 (size: 0x8)
    class UPalUIMapObjectMultiProductModel* Model;                                    // 0x0490 (size: 0x8)

    void OnUnhoverSlot(class UWBP_PalConvertItemMenu_RecipeSlotButton_C* SelfWidget);
    void OnHoverSlot(class UWBP_PalConvertItemMenu_RecipeSlotButton_C* SelfWidget);
    void OnClickSlot(class UWBP_PalConvertItemMenu_RecipeSlotButton_C* SelfWidget);
    class UWidget* BP_GetDesiredFocusTarget();
    void SetupRecipeList();
    void OnSetup();
    void OnClose();
    void ExecuteUbergraph_WBP_MultiProductRecipeSelect(int32 EntryPoint);
}; // Size: 0x498

#endif
