#ifndef UE4SS_SDK_BP_PalFarmSkillFruitsVisualComponent_HPP
#define UE4SS_SDK_BP_PalFarmSkillFruitsVisualComponent_HPP

class UBP_PalFarmSkillFruitsVisualComponent_C : public UPalFarmSkillFruitsVisualComponent
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0300 (size: 0x8)

    void UpdateVisual();
    void OnLoaded_552C6AD8444A0E328D54FCB87C79863B(UClass* Loaded);
    void LoadVisualActor(TSoftClassPtr<AActor> BlueprintClassSoft);
    void ExecuteUbergraph_BP_PalFarmSkillFruitsVisualComponent(int32 EntryPoint);
}; // Size: 0x308

#endif
