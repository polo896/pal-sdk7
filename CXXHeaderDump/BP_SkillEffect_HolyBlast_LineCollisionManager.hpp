#ifndef UE4SS_SDK_BP_SkillEffect_HolyBlast_LineCollisionManager_HPP
#define UE4SS_SDK_BP_SkillEffect_HolyBlast_LineCollisionManager_HPP

class ABP_SkillEffect_HolyBlast_LineCollisionManager_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)

    void ReceiveBeginPlay();
    void ActExplode();
    void DeactivateCollision();
    void BindCollision(class UPrimitiveComponent* Component);
    void ExecuteUbergraph_BP_SkillEffect_HolyBlast_LineCollisionManager(int32 EntryPoint);
}; // Size: 0x438

#endif
