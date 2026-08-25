#ifndef UE4SS_SDK_ModActor_DUPL_4_HPP
#define UE4SS_SDK_ModActor_DUPL_4_HPP

class AModActor_C : public AActor
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0290 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0298 (size: 0x8)
    FTimerHandle GetMapTimerHandle;                                                   // 0x02A0 (size: 0x8)
    class UWBP_Map_Base_C* WBP_Map_Base;                                              // 0x02A8 (size: 0x8)
    FString Strings;                                                                  // 0x02B0 (size: 0x10)
    bool FastTravelToNotDiscoveredPoints;                                             // 0x02C0 (size: 0x1)
    TArray<FGuid> PointsGuids;                                                        // 0x02C8 (size: 0x10)
    FString strings2;                                                                 // 0x02D8 (size: 0x10)
    FString ModAuthor;                                                                // 0x02E8 (size: 0x10)

    void ReceiveBeginPlay();
    void GetMap2();
    void DoUnlockFlag();
    void MakePointsGUIDs();
    void ExecuteUbergraph_ModActor(int32 EntryPoint);
}; // Size: 0x2F8

#endif
