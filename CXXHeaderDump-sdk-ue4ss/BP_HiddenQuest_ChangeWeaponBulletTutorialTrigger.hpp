#ifndef UE4SS_SDK_BP_HiddenQuest_ChangeWeaponBulletTutorialTrigger_HPP
#define UE4SS_SDK_BP_HiddenQuest_ChangeWeaponBulletTutorialTrigger_HPP

class UBP_HiddenQuest_ChangeWeaponBulletTutorialTrigger_C : public UBP_PalQuestDataBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0238 (size: 0x8)

    void TakeAdditionalReward();
    void ExecuteUbergraph_BP_HiddenQuest_ChangeWeaponBulletTutorialTrigger(int32 EntryPoint);
}; // Size: 0x240

#endif
