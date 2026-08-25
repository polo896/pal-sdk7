#ifndef UE4SS_SDK_ModActor_DUPL_1_HPP
#define UE4SS_SDK_ModActor_DUPL_1_HPP

class AModActor_C : public AActor
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0290 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0298 (size: 0x8)
    FString ModAuthor;                                                                // 0x02A0 (size: 0x10)
    FString ModDescription;                                                           // 0x02B0 (size: 0x10)
    FString ModVersion;                                                               // 0x02C0 (size: 0x10)

    void PostBeginPlay();
    void ExecuteUbergraph_ModActor(int32 EntryPoint);
}; // Size: 0x2D0

#endif
