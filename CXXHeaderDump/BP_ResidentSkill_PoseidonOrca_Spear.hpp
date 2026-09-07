#ifndef UE4SS_SDK_BP_ResidentSkill_PoseidonOrca_Spear_HPP
#define UE4SS_SDK_BP_ResidentSkill_PoseidonOrca_Spear_HPP

class UBP_ResidentSkill_PoseidonOrca_Spear_C : public UPalResidentSkillPoseidonOrca_SpearBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0050 (size: 0x8)
    int32 BulletMax;                                                                  // 0x0058 (size: 0x4)
    double ShootInteraval;                                                            // 0x0060 (size: 0x8)
    bool IsShootCool_Server;                                                          // 0x0068 (size: 0x1)
    bool IsActiveOtomo;                                                               // 0x0069 (size: 0x1)
    int32 CurrentBulletNum_Local;                                                     // 0x006C (size: 0x4)
    TArray<FVector> BulletLocationOffset;                                             // 0x0070 (size: 0x10)
    TArray<class ABP_SkillEffectPoseidonOrca_SpearBullet_C*> BulletEffectList;        // 0x0080 (size: 0x10)
    double OpenIntervalTime;                                                          // 0x0090 (size: 0x8)
    bool IsOpenInterval;                                                              // 0x0098 (size: 0x1)
    FTimerHandle OpenIntervalTimer;                                                   // 0x00A0 (size: 0x8)
    FTimerHandle BulletChargeTimer;                                                   // 0x00A8 (size: 0x8)
    FTimerHandle BulletCloseTimer;                                                    // 0x00B0 (size: 0x8)
    double BulletCloseTime;                                                           // 0x00B8 (size: 0x8)
    class UNiagaraSystem* BulletSpawnEffect;                                          // 0x00C0 (size: 0x8)
    class UNiagaraSystem* BulletShootEffect;                                          // 0x00C8 (size: 0x8)
    FName flagName;                                                                   // 0x00D0 (size: 0x8)

    void IsNeedBulletOpen(bool& IsNeedOpen);
    void SetEnableSendReticleTarget(bool IsEnable);
    void UpdateShootByMeleeAttack();
    void OnNotify(const FName& NotifyName, const FPalResidentSkillNotifyParameter& NotifyParameter);
    bool IsBattleMode();
    void UpdateOpenMode();
    bool IsMeleeAttacking();
    void CanShootSpear(bool& CanShoot);
    void FindTarget(class APalCharacter*& Target);
    void On Shoot Bullet(class APalCharacter* Target);
    void CreateBullet(int32 BulletIndex);
    void AttachToOwner(class APalSkillEffectBase* Effect, FVector Offset);
    void ChargeBullets();
    void カスタムイベント_0();
    void カスタムイベント_1();
    void OnActivatedAsOtomo();
    void OnInactivatedAsOtomo();
    void ShootBullet(class APalCharacter* Target);
    void OnTick(float DeltaTime);
    void OpenBullets();
    void CloseBullets();
    void OnShooterShootBulletDelegate();
    void カスタムイベント();
    void OnInitialize();
    void OnBulletCloseTimer();
    void OnShooterPullTrigger();
    void ExecuteUbergraph_BP_ResidentSkill_PoseidonOrca_Spear(int32 EntryPoint);
}; // Size: 0xD8

#endif
