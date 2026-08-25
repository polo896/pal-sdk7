#ifndef UE4SS_SDK_BP_Arrow_Fire_HPP
#define UE4SS_SDK_BP_Arrow_Fire_HPP

class ABP_Arrow_Fire_C : public ABP_Arrow_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0478 (size: 0x8)

    void GetEffectValue(int32& Value);
    void GetEffectType(EPalAdditionalEffectType& Effect);
    void GetBulletElementType(EPalElementType& NewParam);
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_Arrow_Fire(int32 EntryPoint);
}; // Size: 0x480

#endif
