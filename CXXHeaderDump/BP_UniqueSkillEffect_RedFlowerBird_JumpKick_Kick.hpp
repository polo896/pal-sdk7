#ifndef UE4SS_SDK_BP_UniqueSkillEffect_RedFlowerBird_JumpKick_Kick_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_RedFlowerBird_JumpKick_Kick_HPP

class ABP_UniqueSkillEffect_RedFlowerBird_JumpKick_Kick_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)

    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_UniqueSkillEffect_RedFlowerBird_JumpKick_Kick(int32 EntryPoint);
}; // Size: 0x448

#endif
