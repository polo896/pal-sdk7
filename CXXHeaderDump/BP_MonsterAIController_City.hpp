#ifndef UE4SS_SDK_BP_MonsterAIController_City_HPP
#define UE4SS_SDK_BP_MonsterAIController_City_HPP

class ABP_MonsterAIController_City_C : public ABP_MonsterAIControllerBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0590 (size: 0x8)
    class UPalAISensorComponent* PalAISensor;                                         // 0x0598 (size: 0x8)

    void GetMyBB(class UBP_PalAIBlackboard_Common_C*& PalBrackboard);
    void GetLeaderBB(class UBP_PalAIBlackboard_Common_C*& LeaderPalBrackboard);
    void SetDefaultAction(TSubclassOf<class UPalActionBase> action);
    void SetupBySpawner();
    void ExecuteUbergraph_BP_MonsterAIController_City(int32 EntryPoint);
}; // Size: 0x5A0

#endif
