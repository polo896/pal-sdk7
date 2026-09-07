#ifndef UE4SS_SDK_BP_UniqueSkillModule_Tackle_IceHorse_New_HPP
#define UE4SS_SDK_BP_UniqueSkillModule_Tackle_IceHorse_New_HPP

class UBP_UniqueSkillModule_Tackle_IceHorse_New_C : public UPalSkillModule_HorseTackle
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    double QuickStartTime;                                                            // 0x0358 (size: 0x8)

    void OnBeginModule();
    void ExecuteUbergraph_BP_UniqueSkillModule_Tackle_IceHorse_New(int32 EntryPoint);
}; // Size: 0x360

#endif
