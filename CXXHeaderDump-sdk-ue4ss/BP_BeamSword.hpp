#ifndef UE4SS_SDK_BP_BeamSword_HPP
#define UE4SS_SDK_BP_BeamSword_HPP

class ABP_BeamSword_C : public ABP_MeleeWeaponBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0698 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x06A0 (size: 0x8)
    TSubclassOf<class APalBullet> Bullet Class;                                       // 0x06A8 (size: 0x8)

    bool IsUseLeftHandAttach();
    void GetTarget(FVector& Location);
    void OnAnimNotifyBegin(FName NotifyName);
    void ExecuteUbergraph_BP_BeamSword(int32 EntryPoint);
}; // Size: 0x6B0

#endif
