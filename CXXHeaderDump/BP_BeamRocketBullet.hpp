#ifndef UE4SS_SDK_BP_BeamRocketBullet_HPP
#define UE4SS_SDK_BP_BeamRocketBullet_HPP

class ABP_BeamRocketBullet_C : public ABP_RocketBullet_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0448 (size: 0x8)
    class UNiagaraComponent* NS_Yakushima_VortexBeater_Trail;                         // 0x0450 (size: 0x8)

    void GetExplosionClass(TSubclassOf<class ABP_ExplosionAttackBase_C>& ExplosionClass);
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void ExecuteUbergraph_BP_BeamRocketBullet(int32 EntryPoint);
}; // Size: 0x458

#endif
