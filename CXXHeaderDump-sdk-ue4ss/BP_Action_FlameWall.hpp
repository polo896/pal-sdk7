#ifndef UE4SS_SDK_BP_Action_FlameWall_HPP
#define UE4SS_SDK_BP_Action_FlameWall_HPP

class UBP_Action_FlameWall_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)

    void GetGroundOrWaterPlaneTrace(const FVector Start, const FVector End, FVector& Location, bool& Hitted, bool& IsWater);
    void OnSpawnEffect(class APalSkillEffectBase* Effect);
    void GetPredictedTargetLocation(FVector& Location);
    void OnBeginAction();
    void TickAction(float DeltaTime);
    void ExecuteUbergraph_BP_Action_FlameWall(int32 EntryPoint);
}; // Size: 0x2F0

#endif
