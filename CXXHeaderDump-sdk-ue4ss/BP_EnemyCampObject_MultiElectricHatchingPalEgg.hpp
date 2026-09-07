#ifndef UE4SS_SDK_BP_EnemyCampObject_MultiElectricHatchingPalEgg_HPP
#define UE4SS_SDK_BP_EnemyCampObject_MultiElectricHatchingPalEgg_HPP

class ABP_EnemyCampObject_MultiElectricHatchingPalEgg_C : public APalBuildObject
{
    class UPalEnemyCampObjectSpawnMapObjectComponent* EnemyCampObjectSpawnMapObject;  // 0x0770 (size: 0x8)
    class UStaticMeshComponent* SM_EggHatchingMachineFuture;                          // 0x0778 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x0780 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x0788 (size: 0x8)
    class UNiagaraComponent* PalGetEffect;                                            // 0x0790 (size: 0x8)

}; // Size: 0x798

#endif
