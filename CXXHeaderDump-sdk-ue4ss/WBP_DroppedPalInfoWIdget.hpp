#ifndef UE4SS_SDK_WBP_DroppedPalInfoWIdget_HPP
#define UE4SS_SDK_WBP_DroppedPalInfoWIdget_HPP

class UWBP_DroppedPalInfoWIdget_C : public UWBP_PalSaveParameterDisplayWidget_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x07C8 (size: 0x8)
    class UCircularThrobber* CircularThrobber_92;                                     // 0x07D0 (size: 0x8)
    class UImage* EXP_Gauge;                                                          // 0x07D8 (size: 0x8)
    class UProgressBar* Hp;                                                           // 0x07E0 (size: 0x8)
    class UProgressBar* Hunger;                                                       // 0x07E8 (size: 0x8)
    class UImage* Image_HP_Line;                                                      // 0x07F0 (size: 0x8)
    class UImage* Image_Hunger_Line;                                                  // 0x07F8 (size: 0x8)
    class UImage* Image_Icon_GlobalInport;                                            // 0x0800 (size: 0x8)
    class UImage* Image_Icon_Locked;                                                  // 0x0808 (size: 0x8)
    class UOverlay* Overlay_Awakening;                                                // 0x0810 (size: 0x8)
    class UCanvasPanel* PalStatus;                                                    // 0x0818 (size: 0x8)
    class UBP_PalTextBlock_C* Text_DefenseValue;                                      // 0x0820 (size: 0x8)
    class UBP_PalTextBlock_C* Text_HP_Slash;                                          // 0x0828 (size: 0x8)
    class UBP_PalTextBlock_C* Text_Hunger_Slash;                                      // 0x0830 (size: 0x8)
    class UBP_PalTextBlock_C* Text_LevelValue;                                        // 0x0838 (size: 0x8)
    class UBP_PalTextBlock_C* Text_MaxHP;                                             // 0x0840 (size: 0x8)
    class UBP_PalTextBlock_C* Text_MaxHunger;                                         // 0x0848 (size: 0x8)
    class UBP_PalTextBlock_C* Text_MelleAttackValue;                                  // 0x0850 (size: 0x8)
    class UBP_PalTextBlock_C* Text_NowHP;                                             // 0x0858 (size: 0x8)
    class UBP_PalTextBlock_C* Text_NowHunger;                                         // 0x0860 (size: 0x8)
    class UBP_PalTextBlock_C* Text_PalName;                                           // 0x0868 (size: 0x8)
    class UBP_PalTextBlock_C* Text_RangeAttackValue;                                  // 0x0870 (size: 0x8)
    class UBP_PalTextBlock_C* Text_SpeedValue;                                        // 0x0878 (size: 0x8)
    class UBP_PalTextBlock_C* Text_SupportValue;                                      // 0x0880 (size: 0x8)
    class UWBP_DroppedTimer_C* WBP_DroppedTimer;                                      // 0x0888 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Active_C* WBP_MainMenu_Pal_Skill_Active_00;         // 0x0890 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Active_C* WBP_MainMenu_Pal_Skill_Active_01;         // 0x0898 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Active_C* WBP_MainMenu_Pal_Skill_Active_02;         // 0x08A0 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive;          // 0x08A8 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive_1;        // 0x08B0 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive_2;        // 0x08B8 (size: 0x8)
    class UWBP_MainMenu_Pal_Skill_Passive_C* WBP_MainMenu_Pal_Skill_Passive_3;        // 0x08C0 (size: 0x8)
    class UWBP_PalCommonCharacterIcon_C* WBP_PalCommonCharacterIcon;                  // 0x08C8 (size: 0x8)
    class UWBP_PalGenderIcon_C* WBP_PalGenderIcon;                                    // 0x08D0 (size: 0x8)
    class UMaterialInstanceDynamic* expGaugeMaterial;                                 // 0x08D8 (size: 0x8)
    TArray<class UWBP_MainMenu_Pal_Skill_Active_C*> WazaWidgetArray;                  // 0x08E0 (size: 0x10)
    TArray<class UWBP_MainMenu_Pal_Skill_Passive_C*> PassiveSkillWidgetArray;         // 0x08F0 (size: 0x10)
    class UPalMapObjectDeathDroppedCharacterModel* Death Drop Model;                  // 0x0900 (size: 0x8)
    FTimerHandle DropTimerHandle;                                                     // 0x0908 (size: 0x8)
    class UPalWordFilterWaiter* FilteringWaiter;                                      // 0x0910 (size: 0x8)

    void OnCompleteTextFiltering(class UPalWordFilterWaiter* Waiter, FString FilteredString);
    void SetAwakening(bool IsAwaked);
    void SetImportedFlag(bool bImported);
    void DropTimer();
    void SetDeathDropTimer(class UPalMapObjectDeathDroppedCharacterModel* DeathDropModel);
    void SetFavorite(int32 FavoriteIndex);
    void SetGender(EPalGenderType GenderType);
    void SetNickName(FString NickName);
    void SetPassiveSkill(TArray<FName>& PassiveSkillNameArray);
    void SetWaza(TArray<EPalWazaID>& wazaArray);
    void SetBaseParameter(int32 MeleeAttack, int32 ShotAttack, int32 Defense, int32 Support, int32 Speed);
    void SetLevelAndExp(int32 Level, int64 NowExp, int64 NextEXP, double nowExpRate);
    void SetupAfterDisplayed();
    void SetHunger(double nowHunger, double maxHunger);
    void SetHP(int32 nowHP, int32 MaxHP);
    void Construct();
    void OnInitialized();
    void Destruct();
    void カスタムイベント();
    void ExecuteUbergraph_WBP_DroppedPalInfoWIdget(int32 EntryPoint);
}; // Size: 0x918

#endif
