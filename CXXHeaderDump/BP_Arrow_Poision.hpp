#ifndef UE4SS_SDK_BP_Arrow_Poision_HPP
#define UE4SS_SDK_BP_Arrow_Poision_HPP

class ABP_Arrow_Poision_C : public ABP_Arrow_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0478 (size: 0x8)

    void GetEffectValue(int32& Value);
    void GetEffectType(EPalAdditionalEffectType& Effect);
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_Arrow_Poision(int32 EntryPoint);
}; // Size: 0x480

#endif
