#ifndef UE4SS_SDK_WBP_IngameMenu_Task_Simple_HPP
#define UE4SS_SDK_WBP_IngameMenu_Task_Simple_HPP

class UWBP_IngameMenu_Task_Simple_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UCanvasPanel* Canvas_RemainPalNum;                                          // 0x0280 (size: 0x8)
    class UCanvasPanel* Canvas_TaskDetail;                                            // 0x0288 (size: 0x8)
    class UCanvasPanel* CanvasPanel_Order;                                            // 0x0290 (size: 0x8)
    class UCanvasPanel* CanvasPanel_WorkerInfo;                                       // 0x0298 (size: 0x8)
    class UHorizontalBox* HorizontalBox_Alarm;                                        // 0x02A0 (size: 0x8)
    class UHorizontalBox* HorizontalBox_WorkMode;                                     // 0x02A8 (size: 0x8)
    class UImage* Image_21;                                                           // 0x02B0 (size: 0x8)
    class UImage* Image_22;                                                           // 0x02B8 (size: 0x8)
    class UImage* Image_23;                                                           // 0x02C0 (size: 0x8)
    class UImage* Image_24;                                                           // 0x02C8 (size: 0x8)
    class UImage* Image_25;                                                           // 0x02D0 (size: 0x8)
    class UImage* Image_454;                                                          // 0x02D8 (size: 0x8)
    class UImage* Image_Icon_AlarmMode;                                               // 0x02E0 (size: 0x8)
    class UImage* Image_Icon_Bed;                                                     // 0x02E8 (size: 0x8)
    class UImage* Image_Icon_Pal;                                                     // 0x02F0 (size: 0x8)
    class UImage* Image_Icon_WorkMode;                                                // 0x02F8 (size: 0x8)
    class UOverlay* Overlay_Alarm;                                                    // 0x0300 (size: 0x8)
    class UOverlay* Overlay_SimpleInfoToggle_01;                                      // 0x0308 (size: 0x8)
    class UOverlay* Overlay_WorkMode;                                                 // 0x0310 (size: 0x8)
    class UBP_PalTextBlock_C* Text_AlarmMode;                                         // 0x0318 (size: 0x8)
    class UBP_PalTextBlock_C* Text_BaseCampName;                                      // 0x0320 (size: 0x8)
    class UBP_PalTextBlock_C* Text_BedInsufficient;                                   // 0x0328 (size: 0x8)
    class UBP_PalTextBlock_C* Text_BedNum;                                            // 0x0330 (size: 0x8)
    class UBP_PalTextBlock_C* Text_PalNum;                                            // 0x0338 (size: 0x8)
    class UBP_PalTextBlock_C* Text_RemainDIsplayPalNum;                               // 0x0340 (size: 0x8)
    class UBP_PalTextBlock_C* Text_TaskDetail_Base;                                   // 0x0348 (size: 0x8)
    class UBP_PalTextBlock_C* Text_TaskDetail_Base_1;                                 // 0x0350 (size: 0x8)
    class UBP_PalTextBlock_C* Text_TaskDetail_Base_2;                                 // 0x0358 (size: 0x8)
    class UBP_PalTextBlock_C* Text_TaskDetail_Base_3;                                 // 0x0360 (size: 0x8)
    class UBP_PalTextBlock_C* Text_WorkHardType;                                      // 0x0368 (size: 0x8)
    class UVerticalBox* VerticalBox_All;                                              // 0x0370 (size: 0x8)
    class UVerticalBox* VerticalBox_SimpleInfoToggle_01;                              // 0x0378 (size: 0x8)
    class UVerticalBox* VerticalBox_TaskDetail;                                       // 0x0380 (size: 0x8)
    class UWBP_IngameMenu_Task_SimpleList_C* WBP_IngameMenu_Task_SimpleList;          // 0x0388 (size: 0x8)
    class UWBP_IngameMenu_Task_SimpleList_C* WBP_IngameMenu_Task_SimpleList_1;        // 0x0390 (size: 0x8)
    class UWBP_IngameMenu_Task_SimpleList_C* WBP_IngameMenu_Task_SimpleList_2;        // 0x0398 (size: 0x8)
    class UWBP_IngameMenu_Task_SimpleList_C* WBP_IngameMenu_Task_SimpleList_3;        // 0x03A0 (size: 0x8)
    class UWBP_IngameMenu_Task_SimpleList_C* WBP_IngameMenu_Task_SimpleList_4;        // 0x03A8 (size: 0x8)
    class UWBP_IngameMenu_TaskMaterial_C* WBP_IngameMenu_TaskMaterial;                // 0x03B0 (size: 0x8)
    class UWrapBox* WrapBox_ItemInfo;                                                 // 0x03B8 (size: 0x8)
    TArray<UWBP_IngameMenu_Task_SimpleList_C*> palDetailWidgetArray;                  // 0x03C0 (size: 0x10)
    FSlateFontInfo TaskDetailBaseFont;                                                // 0x03D0 (size: 0x60)
    class UMaterial* completedTaskFontMaterial;                                       // 0x0430 (size: 0x8)
    FDataTableRowHandle buildTaskMsgID;                                               // 0x0438 (size: 0x10)
    FDataTableRowHandle workerTaskMsgID;                                              // 0x0448 (size: 0x10)
    TMap<EPalBaseCampWorkerDirectionBattleType, FDataTableRowHandle> BattleTypeMsgMap; // 0x0458 (size: 0x50)
    TMap<EPalBaseCampWorkerDirectionBattleType, TSoftObjectPtr<class UTexture2D>> BattleTypeIconMap; // 0x04A8 (size: 0x50)
    TMap<EPalBaseCampPassiveEffectWorkHardType, FDataTableRowHandle> WorkHardTypeMsgMap; // 0x04F8 (size: 0x50)
    TMap<EPalBaseCampPassiveEffectWorkHardType, TSoftObjectPtr<class UTexture2D>> WorkHardTypeIconMap; // 0x0548 (size: 0x50)
    bool CollapseLastPal;                                                             // 0x0598 (size: 0x1)

    void SetActiveSimpleInfoMode(bool bActiveSimpleInfo);
    void OnUISettingaChanged(const FPalOptionUISettings& PrevSettings, const FPalOptionUISettings& NewSettings);
    void SetEnableWorkHardInfo(bool IsEnable);
    void SetWorkHardType(EPalBaseCampPassiveEffectWorkHardType WorkHardType);
    void SetEnableWorkerBattleTypeInfo(bool IsEnable);
    void SetWorkerBattleType(EPalBaseCampWorkerDirectionBattleType BattleType);
    void RemoveAllItemDetail();
    void AddItemInfo(bool isHideWhenZero, FName ItemId, int64 itemNum, int64 gaugeMaxNumBorder);
    void SetVisibilityTaskDetail(ESlateVisibility NewVisibility);
    void Set Pal Slots(TArray<UPalIndividualCharacterSlot*>& Slots, int32 maxPalNum, int32 Palbed);
    void SetRemainTimer(double remainTime);
    void RemoveTaskDetailText();
    void AddTaskDetailText(FText Text, int32 nowNum, int32 requireNum, int32 TaskIndex);
    void Set Task List(FPalBaseCampTaskCheckedData taskCheckedData, FPalBaseCampTaskDataSet TaskData);
    void SetRemainDIsplayPalNum(int32 Num);
    void Set Camp Pal and Bed Num(int32 nowPalNum, int32 maxPalNum, int32 BedNum);
    void Set Camp Name(FText BaseCampName);
    void OnInitialized();
    void ExecuteUbergraph_WBP_IngameMenu_Task_Simple(int32 EntryPoint);
}; // Size: 0x599

#endif
