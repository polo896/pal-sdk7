#ifndef UE4SS_SDK_WBP_FishPondMenu_HPP
#define UE4SS_SDK_WBP_FishPondMenu_HPP

class UWBP_FishPondMenu_C : public UPalUserWidgetOverlayUI
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0478 (size: 0x8)
    class UWBP_IngameMenu_FishPond_C* WBP_IngameMenu_FishPond;                        // 0x0480 (size: 0x8)
    FTimerHandle UpdateRecipeTimer;                                                   // 0x0488 (size: 0x8)
    TEnumAsByte<EUIFishPondMenuPhase::Type> Phase;                                    // 0x0490 (size: 0x1)
    FName InputActionName_Max;                                                        // 0x0494 (size: 0x8)
    FName InputActionName_Start;                                                      // 0x049C (size: 0x8)
    FName InputActionName_Cancel;                                                     // 0x04A4 (size: 0x8)
    class UWBP_IngameMenu_FishPond_ListButton_C* LastSelectedSlot;                    // 0x04B0 (size: 0x8)

    class UWidget* BP_GetDesiredFocusTarget();
    void On Update Product Num(class UPalUIMapObjectFishPondModel* UIModel);
    void OnUpdateSelectedLotteryName(class UPalUIMapObjectFishPondModel* UIModel);
    void Update Product Num Display();
    void UpdateRequiredMaterials();
    void UpdateCaptureCharacterInfo();
    void AddProductNum(int32 AddNum);
    void SetProductNum(int32 Num);
    void GetProductNum(int32& NewParam);
    void OnUnhoveredTargetSlot(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    void OnHoveredTargetSlot(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    void OnClickedTargetSlot(class UWBP_IngameMenu_FishPond_ListButton_C* SelfSlot);
    void ChangePhaseTotargetDetail();
    void ChangePhaseToTargetList();
    void ChangePhase(TEnumAsByte<EUIFishPondMenuPhase::Type> NextPhase);
    void OnCancelInput();
    void StartProduce();
    void SetProductMax();
    void Construct Detail();
    void ConstructTargetList();
    void BindUIEvents();
    void GetUIModel(class UPalUIMapObjectFishPondModel*& UIModel);
    void InputMethodChanged(ECommonInputType InputType);
    void Setup();
    void BndEvt__WBP_FishPondMenu_WBP_IngameMenu_FishPond_K2Node_ComponentBoundEvent_4_OnClickedStartProduct__DelegateSignature();
    void BndEvt__WBP_FishPondMenu_WBP_IngameMenu_FishPond_K2Node_ComponentBoundEvent_6_OnSetNum__DelegateSignature(int32 Num);
    void OnSetup();
    void Destruct();
    void Construct();
    void BndEvt__WBP_FishPondMenu_WBP_IngameMenu_FishPond_K2Node_ComponentBoundEvent_0_OnClickedCloseButton__DelegateSignature();
    void ExecuteUbergraph_WBP_FishPondMenu(int32 EntryPoint);
}; // Size: 0x4B8

#endif
