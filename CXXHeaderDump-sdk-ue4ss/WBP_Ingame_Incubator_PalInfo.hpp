#ifndef UE4SS_SDK_WBP_Ingame_Incubator_PalInfo_HPP
#define UE4SS_SDK_WBP_Ingame_Incubator_PalInfo_HPP

class UWBP_Ingame_Incubator_PalInfo_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive;          // 0x0280 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive_1;        // 0x0288 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive_2;        // 0x0290 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive_3;        // 0x0298 (size: 0x8)
    class UWBP_PalKeyGuideIcon_C* WBP_PalKeyGuideIcon;                                // 0x02A0 (size: 0x8)
    TArray<UWBP_MainMenu_Pal_Skill_Passive_C*> PassiveSkillPanelArray;                // 0x02A8 (size: 0x10)

    void Setup(TArray<FName>& passiveList);
    void OnInitialized();
    void ExecuteUbergraph_WBP_Ingame_Incubator_PalInfo(int32 EntryPoint);
}; // Size: 0x2B8

#endif
