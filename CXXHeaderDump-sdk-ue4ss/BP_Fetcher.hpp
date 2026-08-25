#ifndef UE4SS_SDK_BP_Fetcher_HPP
#define UE4SS_SDK_BP_Fetcher_HPP

class ABP_Fetcher_C : public AActor
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0290 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0298 (size: 0x8)
    TArray<class UObject*> LoadedAssetsTemp;                                          // 0x02A0 (size: 0x10)
    int32 ArrrayLength;                                                               // 0x02B0 (size: 0x4)
    TArray<FString> Asset Paths;                                                      // 0x02B8 (size: 0x10)
    class UObject* Requester;                                                         // 0x02C8 (size: 0x8)
    class AModActor_C* ModActor;                                                      // 0x02D0 (size: 0x8)

    void OnLoaded_6D1C744F48EB40A914E8D780B534F94A(class UObject* Loaded);
    void ReceiveBeginPlay();
    void PrintToModLoader(FString Messag);
    void ExecuteUbergraph_BP_Fetcher(int32 EntryPoint);
}; // Size: 0x2D8

#endif
