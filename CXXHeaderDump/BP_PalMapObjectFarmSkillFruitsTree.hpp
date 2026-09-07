#ifndef UE4SS_SDK_BP_PalMapObjectFarmSkillFruitsTree_HPP
#define UE4SS_SDK_BP_PalMapObjectFarmSkillFruitsTree_HPP

class ABP_PalMapObjectFarmSkillFruitsTree_C : public APalMapObjectFarmSkillFruitsTree
{
    class UPalFarmSkillFruitsProductInteractiveSphereComponent* InteractiveSphere2;   // 0x02C8 (size: 0x8)
    class UBP_PalFarmSkillFruitsVisualComponent_C* BP_PalFarmSkillFruitsVisualComponent; // 0x02D0 (size: 0x8)
    class UBP_PalFarmSkillFruitsVisualComponent_C* BP_PalFarmSkillFruitsVisualComponent1; // 0x02D8 (size: 0x8)
    class UBP_PalFarmSkillFruitsVisualComponent_C* BP_PalFarmSkillFruitsVisualComponent2; // 0x02E0 (size: 0x8)
    class UNiagaraComponent* NS_Skilltree1;                                           // 0x02E8 (size: 0x8)
    class UPalFarmSkillFruitsProductInteractiveSphereComponent* InteractiveSphere1;   // 0x02F0 (size: 0x8)
    class UStaticMeshComponent* SM_SkillFruitsTree_unglown;                           // 0x02F8 (size: 0x8)
    class UPalFarmSkillFruitsProductInteractiveSphereComponent* InteractiveSphere3;   // 0x0300 (size: 0x8)
    class UStaticMeshComponent* SM_SkillFruitsTree;                                   // 0x0308 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0310 (size: 0x8)

    TArray<class UPalFarmSkillFruitsVisualComponent*> GetVisualComponents();
    TArray<class UPalFarmSkillFruitsProductInteractiveSphereComponent*> GetInteractiveSphereComponents();
}; // Size: 0x318

#endif
