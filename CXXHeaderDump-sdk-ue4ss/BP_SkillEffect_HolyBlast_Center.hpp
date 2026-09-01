#ifndef UE4SS_SDK_BP_SkillEffect_HolyBlast_Center_HPP
#define UE4SS_SDK_BP_SkillEffect_HolyBlast_Center_HPP

class ABP_SkillEffect_HolyBlast_Center_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* ImpactCollision;                                         // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    double BlastDelay;                                                                // 0x0448 (size: 0x8)
    FTimerHandle BlastTimer;                                                          // 0x0450 (size: 0x8)
    float LineSpawnDelay;                                                             // 0x0458 (size: 0x4)
    FTimerHandle  LineTimer;                                                          // 0x0460 (size: 0x8)
    bool CanCancel;                                                                   // 0x0468 (size: 0x1)
    int32 LineCount;                                                                  // 0x046C (size: 0x4)
    TArray<ABP_SkillEffect_HolyBlast_Line_C*> CreatedLines;                           // 0x0470 (size: 0x10)
    double LineOffset;                                                                // 0x0480 (size: 0x8)
    class ABP_SkillEffect_HolyBlast_LineCollisionManager_C* Manager;                  // 0x0488 (size: 0x8)

    void DestroyAll();
    void DeactivateHitCollision();
    void CreateLine();
    void bLast();
    void ReceiveBeginPlay();
    void CancelSkill();
    void ExecuteUbergraph_BP_SkillEffect_HolyBlast_Center(int32 EntryPoint);
}; // Size: 0x490

#endif
