#ifndef UE4SS_SDK_ModActor_HPP
#define UE4SS_SDK_ModActor_HPP

class AModActor_C : public AActor
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0290 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0298 (size: 0x8)

    void ReceiveBeginPlay();
    void ExecuteUbergraph_ModActor(int32 EntryPoint);
}; // Size: 0x2A0

#endif
