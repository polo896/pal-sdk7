#ifndef UE4SS_SDK_BP_Action_Unique_MoonQueen_IceMoonBlade_HPP
#define UE4SS_SDK_BP_Action_Unique_MoonQueen_IceMoonBlade_HPP

class UBP_Action_Unique_MoonQueen_IceMoonBlade_C : public UBP_Action_Unique_MoonQueen_MoonBlade_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0300 (size: 0x8)

    void GetMontageArray(TArray<FReserveMontage>& Motages);
    void SpawnMoonBlade(class ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C*& Instance);
    void OnBeginAction();
    void OnEndAction();
    void SpecialBlade(class UAnimMontage* Montage);
    void ExecuteUbergraph_BP_Action_Unique_MoonQueen_IceMoonBlade(int32 EntryPoint);
}; // Size: 0x308

#endif
