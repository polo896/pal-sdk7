#ifndef UE4SS_SDK_BP_BuildObject_Wood_Foundation_HPP
#define UE4SS_SDK_BP_BuildObject_Wood_Foundation_HPP

class ABP_BuildObject_Wood_Foundation_C : public APalBuildObjectBasicBase
{
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07A0 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07A8 (size: 0x8)
    class UStaticMeshComponent* SM_Floor_Wood;                                        // 0x07B0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07B8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07C0 (size: 0x8)

    void GetStaticMeshComponents(TArray<class UStaticMeshComponent*>& OutComponents);
    void GetStaticMeshInfos(TArray<FPalStaticMeshImposterStaticMeshInfo>& OutStaticMeshInfo);
}; // Size: 0x7C8

#endif
