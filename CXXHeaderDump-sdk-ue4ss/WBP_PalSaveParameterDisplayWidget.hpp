#ifndef UE4SS_SDK_WBP_PalSaveParameterDisplayWidget_HPP
#define UE4SS_SDK_WBP_PalSaveParameterDisplayWidget_HPP

class UWBP_PalSaveParameterDisplayWidget_C : public UPalUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0450 (size: 0x8)
    FPalIndividualCharacterSaveParameter CachedSaveParameter;                         // 0x0458 (size: 0x370)

    void SetAwakening(bool IsAwaked);
    void SetFriendShip(int32 FriendshipRank, int32 FriendshipPoint);
    void CalcBuffedWorkSuitabilityRank(TMap<EPalWorkSuitability, int32>& RankMap);
    void SetImportedFlag(bool bImported);
    void OnSessionMemberChangeEvent(FString UserId, const EPalSessionMemberChange ChangeType);
    void Bind Event();
    void UpdateForPsn();
    void UnbindEvent();
    void SetSoulRank(int32 SoulRank);
    void SetFavorite(int32 FavoriteIndex);
    void SetElement(EPalElementType type1, EPalElementType type2);
    void SetFoodAmount(int32 FoddAmount);
    void SetGender(EPalGenderType GenderType);
    void SetWorkSuitability(TMap<EPalWorkSuitability, int32> SuitabilityMap);
    void SetupAfterDisplayed();
    void GetSaveParameter(FPalIndividualCharacterSaveParameter& Parameter);
    void SetBaseParameter(int32 MeleeAttack, int32 ShotAttack, int32 Defense, int32 Support, int32 Speed);
    void SetHunger(double nowHunger, double maxHunger);
    void SetPassiveSkill(TArray<FName>& PassiveSkillNameArray);
    void Calc HP();
    void SetHP(int32 nowHP, int32 MaxHP);
    void SetWaza(TArray<EPalWazaID>& wazaArray);
    void CalcExp(int32 Level, int64 Exp, bool IsPlayer);
    void SetLevelAndExp(int32 Level, int64 NowExp, int64 NextEXP, double nowExpRate);
    void SetNickName(FString NickName);
    void SetRank(int32 Rank);
    void Hide();
    void DisplaySaveParameter(FPalIndividualCharacterSaveParameter DisplayParameter);
    void Construct();
    void Destruct();
    void ExecuteUbergraph_WBP_PalSaveParameterDisplayWidget(int32 EntryPoint);
}; // Size: 0x7C8

#endif
