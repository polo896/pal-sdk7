#ifndef UE4SS_SDK_BP_NPC_Male_Ninja01_BOSS_HPP
#define UE4SS_SDK_BP_NPC_Male_Ninja01_BOSS_HPP

class ABP_NPC_Male_Ninja01_BOSS_C : public ABP_NPC_Male_Ninja01_C
{
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule1;                        // 0x0C80 (size: 0x8)
    class UNiagaraComponent* NS_BossAura;                                             // 0x0C88 (size: 0x8)
    class UNiagaraComponent* NS_BossAura_Body;                                        // 0x0C90 (size: 0x8)

    void GetVisual_ExceptMainMesh_SyncAnyway(TArray<class USceneComponent*>& OutComponent);
}; // Size: 0xC98

#endif
