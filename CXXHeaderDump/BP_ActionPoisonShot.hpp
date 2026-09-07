#ifndef UE4SS_SDK_BP_ActionPoisonShot_HPP
#define UE4SS_SDK_BP_ActionPoisonShot_HPP

class UBP_ActionPoisonShot_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)
    TSubclassOf<class AActor> PredictedTargetClass_0;                                 // 0x02F0 (size: 0x8)
    float PredictPowerRate_0;                                                         // 0x02F8 (size: 0x4)
    class AActor* PredictedTarget_0;                                                  // 0x0300 (size: 0x8)

    void SetPredictedTarget_0();
    void OnSpawnEffect(class APalSkillEffectBase* Effect);
    void TickAction(float DeltaTime);
    void OnEndAction();
    void OnBeginAction();
    void ExecuteUbergraph_BP_ActionPoisonShot(int32 EntryPoint);
}; // Size: 0x308

#endif
