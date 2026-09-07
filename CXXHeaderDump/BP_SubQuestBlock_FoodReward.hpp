#ifndef UE4SS_SDK_BP_SubQuestBlock_FoodReward_HPP
#define UE4SS_SDK_BP_SubQuestBlock_FoodReward_HPP

class UBP_SubQuestBlock_FoodReward_C : public UPalQuestBlock
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0120 (size: 0x8)
    FTimerHandle NewVar;                                                              // 0x0128 (size: 0x8)
    int32 OldItemCount;                                                               // 0x0130 (size: 0x4)
    FName OldRequestid;                                                               // 0x0134 (size: 0x8)
    EPalItemRequireCategory RequestCategry;                                           // 0x013C (size: 0x1)

    void GetRecordData(class UPalPlayerRecordData*& RecordData);
    void GetInventoryData(class UPalPlayerInventoryData*& InventoryData);
    void GetProgressText(FText& OutText);
    void GetDescriptionText(FText& OutText);
    void GetCurrentObjecttiveData(FPalCircumRequestData& RewardData);
    void IsCompleted(bool& bCompleted);
    void カスタムイベント();
    void OnSetup_ServerInternal_ForBP();
    void OnComplete_ServerInternal_ForBP();
    void ExecuteUbergraph_BP_SubQuestBlock_FoodReward(int32 EntryPoint);
}; // Size: 0x13D

#endif
