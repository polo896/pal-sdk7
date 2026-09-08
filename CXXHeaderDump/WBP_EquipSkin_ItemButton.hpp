#ifndef UE4SS_SDK_WBP_EquipSkin_ItemButton_HPP
#define UE4SS_SDK_WBP_EquipSkin_ItemButton_HPP

class UWBP_EquipSkin_ItemButton_C : public UUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0278 (size: 0x8)
    class UOverlay* Overlay_Focus;                                                    // 0x0280 (size: 0x8)
    class UCanvasPanel* Select;                                                       // 0x0288 (size: 0x8)
    class UWBP_EquipSkin_SkinIcon_C* WBP_EquipSkin_SkinIcon;                          // 0x0290 (size: 0x8)
    class UWBP_PalInvisibleButton_C* WBP_PalInvisibleButton;                          // 0x0298 (size: 0x8)
    FName Skin Id;                                                                    // 0x02A0 (size: 0x8)
    bool Is Equip;                                                                    // 0x02A8 (size: 0x1)
    FWBP_EquipSkin_ItemButton_COnSkinSlotClicked OnSkinSlotClicked;                   // 0x02B0 (size: 0x10)
    void OnSkinSlotClicked(class UWBP_EquipSkin_ItemButton_C* Button);
    FWBP_EquipSkin_ItemButton_COnSkinSlotHovered OnSkinSlotHovered;                   // 0x02C0 (size: 0x10)
    void OnSkinSlotHovered(class UWBP_EquipSkin_ItemButton_C* Button);
    FWBP_EquipSkin_ItemButton_COnSkinSlotUnhovered OnSkinSlotUnhovered;               // 0x02D0 (size: 0x10)
    void OnSkinSlotUnhovered();

    void SetSelect(bool IsSelected);
    void Setup(FName SkinId, bool IsEquip);
    void Construct();
    void BndEvt__WBP_EquipSkin_ItemButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_EquipSkin_ItemButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void BndEvt__WBP_EquipSkin_ItemButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(class UCommonButtonBase* Button);
    void ExecuteUbergraph_WBP_EquipSkin_ItemButton(int32 EntryPoint);
    void OnSkinSlotUnhovered__DelegateSignature();
    void OnSkinSlotHovered__DelegateSignature(class UWBP_EquipSkin_ItemButton_C* Button);
    void OnSkinSlotClicked__DelegateSignature(class UWBP_EquipSkin_ItemButton_C* Button);
}; // Size: 0x2E0

#endif
