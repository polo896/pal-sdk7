#ifndef UE4SS_SDK_WBP_Ingame_Incubator_AllOpen_HPP
#define UE4SS_SDK_WBP_Ingame_Incubator_AllOpen_HPP

class UWBP_Ingame_Incubator_AllOpen_C : public UPalUIObtainCharactersPerformance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0478 (size: 0x8)
    class UWidgetAnimation* Anm_Close;                                                // 0x0480 (size: 0x8)
    class UWidgetAnimation* Anm_Open;                                                 // 0x0488 (size: 0x8)
    class UBP_PalTextBlock_C* Text_RewardInfo;                                        // 0x0490 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Title;                                             // 0x0498 (size: 0x8)
    class UWBP_CommonButton_C* WBP_CommonButton_Close;                                // 0x04A0 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List;    // 0x04A8 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_1;  // 0x04B0 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_2;  // 0x04B8 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_3;  // 0x04C0 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_4;  // 0x04C8 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_5;  // 0x04D0 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_6;  // 0x04D8 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_7;  // 0x04E0 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_8;  // 0x04E8 (size: 0x8)
    class UWBP_Ingame_Incubator_AllOpen_List_C* WBP_Ingame_Incubator_AllOpen_List_9;  // 0x04F0 (size: 0x8)
    class UWBP_Ingame_Incubator_PalInfo_C* WBP_Ingame_Incubator_PalInfo;              // 0x04F8 (size: 0x8)
    TArray<FPalInstanceID> Hatched IDs;                                               // 0x0500 (size: 0x10)
    TArray<UWBP_Ingame_Incubator_AllOpen_List_C*> HatchedList;                        // 0x0510 (size: 0x10)
    FPalUIActionBindData ViewDetailAction;                                            // 0x0520 (size: 0x4)
    class UPalIndividualCharacterHandle* LastHoveredHandle;                           // 0x0528 (size: 0x8)
    bool Closing;                                                                     // 0x0530 (size: 0x1)
    FName PalStorageReplicateKey;                                                     // 0x0534 (size: 0x8)

    void OnSyncIndividualParameter(class UPalIndividualCharacterHandle* Handle, class UPalIndividualCharacterParameter* Parameter);
    class UWidget* BP_GetDesiredFocusTarget();
    void ViewHatchedDetail();
    void OnHatchedInfoUnhovered();
    void OnHatchedInfoHovered(int32 Index);
    void Setup();
    void Finished_87D9091741F1283AF653F79A16402783();
    void AnmEvent_Open();
    void AnmEvent_Close();
    void OnSetup();
    void OnInitialized();
    void BndEvt__WBP_Ingame_Incubator_AllOpen_WBP_CommonButton_Close_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature();
    void OnClose();
    void ExecuteUbergraph_WBP_Ingame_Incubator_AllOpen(int32 EntryPoint);
}; // Size: 0x53C

#endif
