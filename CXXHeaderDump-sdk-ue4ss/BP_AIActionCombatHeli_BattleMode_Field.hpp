#ifndef UE4SS_SDK_BP_AIActionCombatHeli_BattleMode_Field_HPP
#define UE4SS_SDK_BP_AIActionCombatHeli_BattleMode_Field_HPP

class UBP_AIActionCombatHeli_BattleMode_Field_C : public UBP_AIActionCombatHeli_BattleMode_C
{
    double BGMDistance;                                                               // 0x0218 (size: 0x8)

    void IsWantedPoliceTargetPlayer(class AActor* PlayerCharacter, bool& IsTarget);
    void Is Valid BGMTarget(class AActor* TargetActor, bool& Valid);
    void IsValid Target(class AActor* TargetActor, bool& Validd);
    void FindTarget(class AActor*& TargetActor);
}; // Size: 0x220

#endif
