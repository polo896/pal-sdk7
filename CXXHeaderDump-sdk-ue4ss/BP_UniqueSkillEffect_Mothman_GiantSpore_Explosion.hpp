#ifndef UE4SS_SDK_BP_UniqueSkillEffect_Mothman_GiantSpore_Explosion_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_Mothman_GiantSpore_Explosion_HPP

class ABP_UniqueSkillEffect_Mothman_GiantSpore_Explosion_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0438 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0440 (size: 0x8)

    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_UniqueSkillEffect_Mothman_GiantSpore_Explosion(int32 EntryPoint);
}; // Size: 0x448

#endif
