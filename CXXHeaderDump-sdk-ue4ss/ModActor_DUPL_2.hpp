#ifndef UE4SS_SDK_ModActor_DUPL_2_HPP
#define UE4SS_SDK_ModActor_DUPL_2_HPP

class AModActor_C : public AActor
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0290 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0298 (size: 0x8)
    TArray<UObject*> LoadedAssetsTemp;                                                // 0x02A0 (size: 0x10)
    TArray<ABP_Fetcher_C*> FetcherList;                                               // 0x02B0 (size: 0x10)
    int32 LastClickedDropdownIndex;                                                   // 0x02C0 (size: 0x4)
    FString LastClickedDropdownValue;                                                 // 0x02C8 (size: 0x10)
    class UScrollBox* PendingScrollBox;                                               // 0x02D8 (size: 0x8)
    FString PendingOptions;                                                           // 0x02E0 (size: 0x10)
    int32 CurrentPopulateIndex;                                                       // 0x02F0 (size: 0x4)

    void GetAllLoadedAssets(TArray<UObject*>& OutAssets);
    void BP_PopulateDropdownList_F(class UScrollBox* TargetScrollBox, TArray<FString>& OptionsList);
    void GetAndRemoveLoadedAssets(const class UObject*& Requester, TArray<UObject*>& OutAssets);
    void PrintToModLoader(FString Message);
    void RequestBatchAsyncLoad(const TArray<FString>& AssetPaths, class UObject* Requester);
    void ReceiveBeginPlay();
    void OnCompleted_Event(class UObject* Requester, const TArray<UObject*>& LoadedAssets);
    void BP_PopulateDropdownList(class UScrollBox* TargetScrollBox, TArray<FString>& OptionsList);
    void OnClicked_Event();
    void ReEnableClicks();
    void ExecuteUbergraph_ModActor(int32 EntryPoint);
}; // Size: 0x2F4

#endif
