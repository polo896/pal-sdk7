#ifndef UE4SS_SDK_WBP_Paldex_HPP
#define UE4SS_SDK_WBP_Paldex_HPP

class UWBP_Paldex_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWidgetAnimation* Anm_NoData_Encounted;                                     // 0x0280 (size: 0x8)
    class UWidgetAnimation* Anm_NoData_NotEncounted;                                  // 0x0288 (size: 0x8)
    class UWidgetAnimation* Anm_MapToPalinfo;                                         // 0x0290 (size: 0x8)
    class UWidgetAnimation* Anm_PalinfoToMap;                                         // 0x0298 (size: 0x8)
    class UWidgetAnimation* Anm_Map;                                                  // 0x02A0 (size: 0x8)
    class UWidgetAnimation* Anm_PalInfo;                                              // 0x02A8 (size: 0x8)
    class UCanvasPanel* Canvas_LongDesc;                                              // 0x02B0 (size: 0x8)
    class UCanvasPanel* CanvasPanel_NoItemDisplay;                                    // 0x02B8 (size: 0x8)
    class UCanvasPanel* CanvasPanel_NoListItemHide_01;                                // 0x02C0 (size: 0x8)
    class UCanvasPanel* CanvasPanel_NoListItemHide_02;                                // 0x02C8 (size: 0x8)
    class UCircularThrobber* CircularThrobber_49;                                     // 0x02D0 (size: 0x8)
    class UImage* FrameFlare;                                                         // 0x02D8 (size: 0x8)
    class UCanvasPanel* HorizontalBox_SearchName;                                     // 0x02E0 (size: 0x8)
    class UImage* Image_92;                                                           // 0x02E8 (size: 0x8)
    class UImage* Image_106;                                                          // 0x02F0 (size: 0x8)
    class UImage* Image_PalReflection;                                                // 0x02F8 (size: 0x8)
    class UPalEditableTextBox* PalEditableTextBox_Search;                             // 0x0300 (size: 0x8)
    class UBP_PalRichTextBlock_C* RichText_LongDesc;                                  // 0x0308 (size: 0x8)
    class UBP_PalTextBlock_C* Text_EncountPalNumValue;                                // 0x0310 (size: 0x8)
    class UBP_PalTextBlock_C* Text_RegisterPalNumValue;                               // 0x0318 (size: 0x8)
    class UWBP_CommonButton_Activation_Icon_C* WBP_CommonButton_Activation_Icon;      // 0x0320 (size: 0x8)
    class UWBP_MainMenu_PalSkillInfo_C* WBP_MainMenu_PalSkillInfo;                    // 0x0328 (size: 0x8)
    class UWBP_NoData_C* WBP_NoData;                                                  // 0x0330 (size: 0x8)
    class UWBP_NoData_C* WBP_NoData_74;                                               // 0x0338 (size: 0x8)
    class UWBP_Paldex_Map_C* WBP_Paldex_Map;                                          // 0x0340 (size: 0x8)
    class UWBP_Paldex_PalInfo_00_C* WBP_Paldex_PalInfo_00;                            // 0x0348 (size: 0x8)
    class UWBP_Paldex_tabset_C* WBP_Paldex_tabset;                                    // 0x0350 (size: 0x8)
    class UWBP_PaldexScrollList_C* WBP_PaldexScrollList;                              // 0x0358 (size: 0x8)
    class UWBP_PalMonsterInframeRender_C* WBP_PalInframeRender;                       // 0x0360 (size: 0x8)
    class UWBP_PalInvisibleButton_C* WBP_PalInvisibleButton_SerchName;                // 0x0368 (size: 0x8)
    FName nowRenderCharacterID;                                                       // 0x0370 (size: 0x8)
    FWBP_Paldex_COnHoveredAnyPalPanel OnHoveredAnyPalPanel;                           // 0x0378 (size: 0x10)
    void OnHoveredAnyPalPanel(FName CharacterID);
    FDataTableRowHandle NoDataNoticeMsgID;                                            // 0x0388 (size: 0x10)
    FDataTableRowHandle NoDistributionNoticeMsgID;                                    // 0x0398 (size: 0x10)
    FWBP_Paldex_COnClickedModelTab OnClickedModelTab;                                 // 0x03A8 (size: 0x10)
    void OnClickedModelTab();
    FWBP_Paldex_COnClickedDistributionTab OnClickedDistributionTab;                   // 0x03B8 (size: 0x10)
    void OnClickedDistributionTab();
    FDataTableRowHandle NoDistributionThisTimeNoticeMsgID;                            // 0x03C8 (size: 0x10)
    class UWBP_Paldex_List_C* lastHoveredPanel;                                       // 0x03D8 (size: 0x8)
    bool IsFirstSetup;                                                                // 0x03E0 (size: 0x1)
    bool isDIsplayDisrtibution;                                                       // 0x03E1 (size: 0x1)
    FWBP_Paldex_COnClickedAnyPalPanel OnClickedAnyPalPanel;                           // 0x03E8 (size: 0x10)
    void OnClickedAnyPalPanel(FName CharacterID);
    class UWBP_Paldex_List_C* LastClickedPalPanel;                                    // 0x03F8 (size: 0x8)
    FPalUIPaldex_DisplayInfo ChacedDisplayInfo;                                       // 0x0400 (size: 0x38)
    TEnumAsByte<E_PaldexDistributionTimeType::Type> CachedTimeType;                   // 0x0438 (size: 0x1)
    FWBP_Paldex_COnClickedFilteringButton OnClickedFilteringButton;                   // 0x0440 (size: 0x10)
    void OnClickedFilteringButton();
    FWBP_Paldex_COnCommittedSearchWord OnCommittedSearchWord;                         // 0x0450 (size: 0x10)
    void OnCommittedSearchWord(FText SearchWord);

    void IsHideCharacterInList(FName CharacterID, bool& bHide);
    void GetFilteringButtonFocusTarget(class UWidget*& Target);
    void ResetFiltering();
    void Filtering(TArray<FPalUIPaldex_DisplayInfo>& displayInfoArray, bool bDisplayActiveFiltering);
    void ChangeMap(FName MapName);
    void DisplayDistribution();
    void DisplayPalStat();
    void ChangeNextMap();
    void ScrollByCharacterID(FName CharacterID);
    void ClickByCharacterID(FName CharacterID);
    void ScrollByPanelIndex(int32 ScrollByPanelIndex);
    void OnCompleteCapturePalActor();
    void ClickByIndex(int32 Index);
    void GetFocusTargetByCharacterID(FName CharacterID, class UWidget*& Target);
    void SetEncountedPalNum(int32 Num);
    void SetRegisteredPalNum(int32 Num);
    void ResetMapOffset();
    void SetZoomDisrtibutionMap(double Rate);
    void IsZoomMax(bool& IsMax);
    void AddZoomDistributionMap(double AddZoomRate);
    void Add Captured Actor Rotation(FRotator Rotator);
    void AddDistributionMapOffset(FVector2D Offset);
    void PageSkip_Up(EUINavigation Navigation);
    void PageSkip_Down(EUINavigation Navigation);
    void DisplayNoDataWidget(FDataTableRowHandle msgIdHandle);
    void HideNoDataWidget();
    void ChangeToModelDisplayModel();
    void ChangeToDistributionDIsplayMode();
    void Set Display Info(FPalUIPaldex_DisplayInfo DisplayInfo, TEnumAsByte<E_PaldexDistributionTimeType::Type> timeType);
    void CapturePalActor(FName CharacterID);
    void GetFocusTargetByIndex(int32 Index, class UWidget*& Target);
    void FocusByCharacterID(FName CharacterID);
    void FocusByIndex(int32 Index);
    void SetupCaptureCameraActor();
    void SetupPalPanelList(TArray<FPalUIPaldex_DisplayInfo>& displayInfoArray);
    void AnmEvent_ToModel();
    void AnmEvent_ToDistribution();
    void AnmEvent_FirstOpen();
    void AnmEvent_ChnageTimeType(TEnumAsByte<E_PaldexDistributionTimeType::Type> timeType);
    void Construct();
    void BndEvt__WBP_Paldex_WBP_PaldexScrollList_K2Node_ComponentBoundEvent_0_OnHoveredAnyPanel__DelegateSignature(FName CharacterID, class UWBP_Paldex_List_C* SelfWidget);
    void Destruct();
    void OnInitialized();
    void BndEvt__WBP_Paldex_WBP_Paldex_tabset_K2Node_ComponentBoundEvent_1_OnSelectedModelTab__DelegateSignature();
    void BndEvt__WBP_Paldex_WBP_Paldex_tabset_K2Node_ComponentBoundEvent_2_OnSelectedDistributionTab__DelegateSignature();
    void BndEvt__WBP_Paldex_WBP_PaldexScrollList_K2Node_ComponentBoundEvent_3_OnClickedAnyPanel__DelegateSignature(FName CharacterID, class UWBP_Paldex_List_C* Widget);
    void BndEvt__WBP_Paldex_WBP_Paldex_PalInfo_00_K2Node_ComponentBoundEvent_4_OnHoveredSuitabilityPanel__DelegateSignature(class UWBP_MainMenu_Pal_WorkIconText_C* Widget);
    void BndEvt__WBP_Paldex_WBP_Paldex_PalInfo_00_K2Node_ComponentBoundEvent_6_OnUnhoveredSuitabilityPanel__DelegateSignature();
    void BndEvt__WBP_Paldex_WBP_CommonButton_Activation_Icon_K2Node_ComponentBoundEvent_7_OnClicked__DelegateSignature();
    void BndEvt__WBP_Paldex_PalEditableTextBox_Search_K2Node_ComponentBoundEvent_5_OnEditableTextBoxCommittedEvent__DelegateSignature(const FText& Text, TEnumAsByte<ETextCommit::Type> CommitMethod);
    void BndEvt__WBP_Paldex_WBP_PalInvisibleButton_SerchName_K2Node_ComponentBoundEvent_8_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void ExecuteUbergraph_WBP_Paldex(int32 EntryPoint);
    void OnCommittedSearchWord__DelegateSignature(FText SearchWord);
    void OnClickedFilteringButton__DelegateSignature();
    void OnClickedAnyPalPanel__DelegateSignature(FName CharacterID);
    void OnClickedDistributionTab__DelegateSignature();
    void OnClickedModelTab__DelegateSignature();
    void OnHoveredAnyPalPanel__DelegateSignature(FName CharacterID);
}; // Size: 0x460

#endif
