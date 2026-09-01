#ifndef UE4SS_SDK_WBP_EquipSkin_ItemSlot_HPP
#define UE4SS_SDK_WBP_EquipSkin_ItemSlot_HPP

class UWBP_EquipSkin_ItemSlot_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UWidgetAnimation* Anm_UnselectedToSelected;                                 // 0x0280 (size: 0x8)
    class UWidgetAnimation* Anm_NormalToFocus;                                        // 0x0288 (size: 0x8)
    class UWBP_EquipSkin_SkinIcon_C* WBP_EquipSkin_SkinIcon;                          // 0x0290 (size: 0x8)
    class UWBP_PalInvisibleButton_C* WBP_PalInvisibleButton;                          // 0x0298 (size: 0x8)
    FWBP_EquipSkin_ItemSlot_COnSlotClicked OnSlotClicked;                             // 0x02A0 (size: 0x10)
    void OnSlotClicked(class UWBP_EquipSkin_ItemSlot_C* Button);
    EPalSkinType slotType;                                                            // 0x02B0 (size: 0x1)
    FWBP_EquipSkin_ItemSlot_COnSlotHovered OnSlotHovered;                             // 0x02B8 (size: 0x10)
    void OnSlotHovered(class UWBP_EquipSkin_ItemSlot_C* Button);
    FWBP_EquipSkin_ItemSlot_COnSlotUnhovered OnSlotUnhovered;                         // 0x02C8 (size: 0x10)
    void OnSlotUnhovered();
    FName SkinName;                                                                   // 0x02D8 (size: 0x8)
    bool IsEquip;                                                                     // 0x02E0 (size: 0x1)

    void GetDressingSlotInfo(FPalPlayerDataCharacterMakeInfo MakeInfo, FName& SkinName, bool& IsEuip);
    void Setup(FPalPlayerDataCharacterMakeInfo MakeInfo);
    void BndEvt__WBP_EquipSkin_ItemSlot_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_EquipSkin_ItemSlot_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_EquipSkin_ItemSlot_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void ExecuteUbergraph_WBP_EquipSkin_ItemSlot(int32 EntryPoint);
    void OnSlotUnhovered__DelegateSignature();
    void OnSlotHovered__DelegateSignature(class UWBP_EquipSkin_ItemSlot_C* Button);
    void OnSlotClicked__DelegateSignature(class UWBP_EquipSkin_ItemSlot_C* Button);
}; // Size: 0x2E1

#endif
