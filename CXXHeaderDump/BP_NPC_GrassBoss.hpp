#ifndef UE4SS_SDK_BP_NPC_GrassBoss_HPP
#define UE4SS_SDK_BP_NPC_GrassBoss_HPP

class ABP_NPC_GrassBoss_C : public ABP_NPC_StandardHumanDataSet_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0C80 (size: 0x8)
    class UBP_PalCryComponent_C* BP_PalCryComponent;                                  // 0x0C88 (size: 0x8)

    void ReceiveBeginPlay();
    void OnChangeBattleModeDelegate_イベント(bool bIsBattleMode);
    void ExecuteUbergraph_BP_NPC_GrassBoss(int32 EntryPoint);
}; // Size: 0xC90

#endif
