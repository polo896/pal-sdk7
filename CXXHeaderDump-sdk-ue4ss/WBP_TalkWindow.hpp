#ifndef UE4SS_SDK_WBP_TalkWindow_HPP
#define UE4SS_SDK_WBP_TalkWindow_HPP

class UWBP_TalkWindow_C : public UPalTalkWindowWidgetBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x04A0 (size: 0x8)
    class UOverlay* Overlay_0;                                                        // 0x04A8 (size: 0x8)
    class UBP_PalRichTextBlock_C* RichText_Dummy;                                     // 0x04B0 (size: 0x8)
    class UWBP_Talk_C* WBP_Talk;                                                      // 0x04B8 (size: 0x8)
    int32 DisplayTextIndex;                                                           // 0x04C0 (size: 0x4)
    FText DisplayText;                                                                // 0x04C8 (size: 0x18)
    bool IsDisplayingText;                                                            // 0x04E0 (size: 0x1)
    TArray<FName> DisplayTextIdList;                                                  // 0x04E8 (size: 0x10)
    double TextDisplayTimer;                                                          // 0x04F8 (size: 0x8)
    bool IsRegisteredText;                                                            // 0x0500 (size: 0x1)
    FPalDataTableRowName_UIInputAction ProgressTextInputAction_01;                    // 0x0504 (size: 0x8)
    FPalDataTableRowName_UIInputAction ProgressTextInputAction_02;                    // 0x050C (size: 0x8)
    FPalUIActionBindData ProgressTextInputActionHandle_01;                            // 0x0514 (size: 0x4)
    FPalUIActionBindData ProgressTextInputActionHandle_02;                            // 0x0518 (size: 0x4)
    bool IsChoiceMode;                                                                // 0x051C (size: 0x1)
    TArray<FName> DIsplayChoiceMsgIDList;                                             // 0x0520 (size: 0x10)
    TArray<FText> SplittedTextArray;                                                  // 0x0530 (size: 0x10)
    int32 CurrentDIsplaySplittedTextIndex;                                            // 0x0540 (size: 0x4)
    FPalDataTableRowName_UIInputAction ProgressTextInputAction_Skip;                  // 0x0544 (size: 0x8)
    FPalUIActionBindData ProgressTextInputActionHandle_SkipPress;                     // 0x054C (size: 0x4)
    FPalUIActionBindData ProgressTextInputActionHandle_SkipRelease;                   // 0x0550 (size: 0x4)
    bool IsSkipEnable;                                                                // 0x0554 (size: 0x1)

    void SkipDisable();
    void SkipEnable();
    void SplitText(FText InOriginalText, TArray<FText>& SplittedTextArray);
    void SetTextList(const TArray<FName>& InMsgIDList);
    void OnProgressTextInput();
    void UnregisterInputAction_DisplayingText();
    void RegisterInputAction_DisplayingText();
    void ProgressText();
    class UWidget* BP_GetDesiredFocusTarget();
    void SkipText();
    void CalculateDisplayingText();
    void SetupNextSplittedText();
    void SetupNextText();
    void OnChoiced(int32 Index);
    void ShowChoice(const TArray<FName>& ChoiceMsgIDList);
    void Tick(FGeometry MyGeometry, float InDeltaTime);
    void BndEvt__WBP_TalkWindow_WBP_Talk_K2Node_ComponentBoundEvent_0_OnChoiced__DelegateSignature(int32 ChoicedIndex);
    void BndEvt__WBP_TalkWindow_WBP_Talk_K2Node_ComponentBoundEvent_2_OnRequestSkipText__DelegateSignature();
    void SetHide(bool bHide);
    void ExecuteUbergraph_WBP_TalkWindow(int32 EntryPoint);
}; // Size: 0x555

#endif
