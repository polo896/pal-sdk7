#ifndef UE4SS_SDK_BP_EnemyCampObject_DimensionPalStorage_HPP
#define UE4SS_SDK_BP_EnemyCampObject_DimensionPalStorage_HPP

class ABP_EnemyCampObject_DimensionPalStorage_C : public APalBuildObject
{
    class UPalEnemyCampObjectSpawnMapObjectComponent* EnemyCampObjectSpawnMapObject;  // 0x0770 (size: 0x8)
    class UNiagaraComponent* NS_PalFourDimensionalBox;                                // 0x0778 (size: 0x8)
    class UStaticMeshComponent* SM_mirrortable;                                       // 0x0780 (size: 0x8)
    class USceneComponent* Meshes;                                                    // 0x0788 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x0790 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0798 (size: 0x8)

}; // Size: 0x7A0

#endif
