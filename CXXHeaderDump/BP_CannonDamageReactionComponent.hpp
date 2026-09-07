#ifndef UE4SS_SDK_BP_CannonDamageReactionComponent_HPP
#define UE4SS_SDK_BP_CannonDamageReactionComponent_HPP

class UBP_CannonDamageReactionComponent_C : public UPalCannonDamageReactionComponent
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x00F0 (size: 0x8)

    void PrintOnRepHP_BP();
    void PrintCreateHPHUD_BP();
    void ExecuteUbergraph_BP_CannonDamageReactionComponent(int32 EntryPoint);
}; // Size: 0xF8

#endif
