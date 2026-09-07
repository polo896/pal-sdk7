#ifndef UE4SS_SDK_WBP_PalDialog_HPP
#define UE4SS_SDK_WBP_PalDialog_HPP

class UWBP_PalDialog_C : public UPalUIDialogBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0480 (size: 0x8)
    class UWBP_CommonPopupWindow_C* WBP_CommonPopupWindow;                            // 0x0488 (size: 0x8)
    class UPalDialogParameterDialog* Parameter;                                       // 0x0490 (size: 0x8)
    FDataTableRowHandle RowName_Yes;                                                  // 0x0498 (size: 0x10)
    FDataTableRowHandle RowName_No;                                                   // 0x04A8 (size: 0x10)
    FDataTableRowHandle YesMSGID;                                                     // 0x04B8 (size: 0x10)
    FDataTableRowHandle NoMSGID;                                                      // 0x04C8 (size: 0x10)
    FDataTableRowHandle DecideMSGID;                                                  // 0x04D8 (size: 0x10)
    FDataTableRowHandle CancelMSGID;                                                  // 0x04E8 (size: 0x10)
    FDataTableRowHandle OkMSGID;                                                      // 0x04F8 (size: 0x10)
    FPalDataTableRowName_UIInputAction ShortcutConfirmInputAction;                    // 0x0508 (size: 0x8)

    void OnShortcutConfirm();
    class UWidget* BP_GetDesiredFocusTarget();
    void OnCancelAction();
    void SetupUI(EPalDialogType DialogType, FText Message);
    void OnSetup();
    void BndEvt__WBP_PalDialog_WBP_CommonPopupWindow_K2Node_ComponentBoundEvent_2_OnClickedLeftButton__DelegateSignature();
    void BndEvt__WBP_PalDialog_WBP_CommonPopupWindow_K2Node_ComponentBoundEvent_3_OnClickedRightButton__DelegateSignature();
    void Construct();
    void ExecuteUbergraph_WBP_PalDialog(int32 EntryPoint);
}; // Size: 0x510

#endif
