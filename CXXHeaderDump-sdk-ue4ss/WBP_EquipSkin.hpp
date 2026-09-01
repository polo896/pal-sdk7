#ifndef UE4SS_SDK_WBP_EquipSkin_HPP
#define UE4SS_SDK_WBP_EquipSkin_HPP

class UWBP_EquipSkin_C : public UPalUICharacterDressing
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0480 (size: 0x8)
    class UCanvasPanel* CanvasPanel_Dressing;                                         // 0x0488 (size: 0x8)
    class UWBP_CharaCre_BG_C* WBP_CharaCre_BG;                                        // 0x0490 (size: 0x8)
    class UWBP_CharaCre_MenuButton_C* WBP_CharaCre_MenuButton_Cancel_InGame;          // 0x0498 (size: 0x8)
    class UWBP_CharaCre_MenuButton_C* WBP_CharaCre_MenuButton_Finish_InGame;          // 0x04A0 (size: 0x8)
    class UWBP_EquipSkin_ItemButton_C* WBP_EquipSkin_ItemButton;                      // 0x04A8 (size: 0x8)
    class UWBP_EquipSkin_ItemSlot_C* WBP_EquipSkin_Slot_Body;                         // 0x04B0 (size: 0x8)
    class UWBP_EquipSkin_ItemSlot_C* WBP_EquipSkin_Slot_Glider;                       // 0x04B8 (size: 0x8)
    class UWBP_EquipSkin_ItemSlot_C* WBP_EquipSkin_Slot_Head;                         // 0x04C0 (size: 0x8)
    class UWBP_MainMenu_PalSkillInfo_C* WBP_MainMenu_PalSkillInfo;                    // 0x04C8 (size: 0x8)
    class UWBP_PalKeyGuideIcon_C* WBP_PalKeyGuideIcon;                                // 0x04D0 (size: 0x8)
    class UWBP_PalKeyGuideIcon_C* WBP_PalKeyGuideIcon_1;                              // 0x04D8 (size: 0x8)
    class UWBP_PalKeyGuideIcon_C* WBP_PalKeyGuideIcon_2;                              // 0x04E0 (size: 0x8)
    class UWBP_PalKeyGuideIcon_C* WBP_PalKeyGuideIcon_3;                              // 0x04E8 (size: 0x8)
    class UWBP_PalPlayerInframeRender_C* WBP_PalPlayerInframeRender;                  // 0x04F0 (size: 0x8)
    class UWrapBox* WrapBox_Equip;                                                    // 0x04F8 (size: 0x8)
    double CachedAnalogValueX;                                                        // 0x0500 (size: 0x8)
    double CachedAnalogValueY;                                                        // 0x0508 (size: 0x8)
    double RotationSpeed_Pad;                                                         // 0x0510 (size: 0x8)
    double RotationSpeed_MouseDrag;                                                   // 0x0518 (size: 0x8)
    bool IsRTriggerDown;                                                              // 0x0520 (size: 0x1)
    bool IsLTriggerDown;                                                              // 0x0521 (size: 0x1)
    double CameraUpDownSpeed_ForPad;                                                  // 0x0528 (size: 0x8)
    double ZoomSpeed_Pad;                                                             // 0x0530 (size: 0x8)
    double ZoomRate_WheelTrigger;                                                     // 0x0538 (size: 0x8)
    FVector CameraRelativeLocation;                                                   // 0x0540 (size: 0x18)
    bool IsMLBDown;                                                                   // 0x0558 (size: 0x1)
    FPalDataTableRowName_UIInputAction MouseZoomInInputAction;                        // 0x055C (size: 0x8)
    FPalDataTableRowName_UIInputAction MouseZoomOutInputAction;                       // 0x0564 (size: 0x8)
    FPalPlayerDataCharacterMakeInfo MakeInfo;                                         // 0x0570 (size: 0x208)
    class UBP_PalPlayerDataCharacterMake_C* CharacterMakeData;                        // 0x0778 (size: 0x8)
    TArray<UWBP_EquipSkin_ItemSlot_C*> DressingSlots;                                 // 0x0780 (size: 0x10)
    EPalSkinType LastSelectSkinType;                                                  // 0x0790 (size: 0x1)
    class UWBP_EquipSkin_ItemButton_C* LastSelectSkinSlot;                            // 0x0798 (size: 0x8)
    EPalSkinType CurrentPreviewType;                                                  // 0x07A0 (size: 0x1)
    FName Static Id;                                                                  // 0x07A4 (size: 0x8)
    bool NowDisplayGlider;                                                            // 0x07AC (size: 0x1)

    void CheckSkinEqual(bool IsEquip, FName SkinName1, FName SkinName2, bool& IsEqual);
    void GetSkinInfo(bool IsEquip, FName SkinName, bool& ShouldDisplay, FText& Title, FText& Desc);
    void HideSkinInfo();
    void ShowSkinInfo(class UWidget* RelativeWidget, FVector2D AnchorPosition, FName SkinName, bool IsEquip);
    void OnSkinSlotUnhovered();
    void OnSkinSlotHovered(class UWBP_EquipSkin_ItemButton_C* Button);
    void OnSkinSlotClicked(class UWBP_EquipSkin_ItemButton_C* Button);
    void GetUseableSkins(EPalSkinType SkinType, TArray<FName>& EquipIds);
    void OnDressingSlotUnhovered();
    void OnDressingSlotHovered(class UWBP_EquipSkin_ItemSlot_C* Button);
    void OnDressingSlotClicked(class UWBP_EquipSkin_ItemSlot_C* Button);
    class UWidget* BP_GetDesiredFocusTarget();
    void Request Display();
    void OnTriggerZoomOut_Mouse();
    void On Trigger Zoom in Mouse();
    void UpdateCameraLocationByWheel(bool IsZoomIn);
    void OnCancelAction();
    FEventReply OnMouseMove(FGeometry MyGeometry, const FPointerEvent& MouseEvent);
    FEventReply OnMouseButtonDown(FGeometry MyGeometry, const FPointerEvent& MouseEvent);
    FEventReply OnMouseButtonUp(FGeometry MyGeometry, const FPointerEvent& MouseEvent);
    FEventReply OnKeyUp(FGeometry MyGeometry, FKeyEvent InKeyEvent);
    FEventReply OnKeyDown(FGeometry MyGeometry, FKeyEvent InKeyEvent);
    FEventReply OnAnalogValueChanged(FGeometry MyGeometry, FAnalogInputEvent InAnalogInputEvent);
    void GetAddCameraOffsetUpDown_ForPad(double& Offset);
    void Update Camera Location(double DeltaTime);
    void UpdateCharacterRotation(double DeltaTime);
    void Setup();
    void OnLoaded_4251E5CF44968BCFF3126FBB8CFC7169(UClass* Loaded);
    void OnSetup();
    void Tick(FGeometry MyGeometry, float InDeltaTime);
    void Destruct();
    void OnFocusLost(FFocusEvent InFocusEvent);
    void OnMouseLeave(const FPointerEvent& MouseEvent);
    void BndEvt__WBP_EquipSkin_WBP_CharaCre_MenuButton_Cancel_InGame_1_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature(class UWBP_CharaCre_MenuButton_C* Button);
    void BndEvt__WBP_EquipSkin_WBP_CharaCre_MenuButton_Finish_InGame_1_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature(class UWBP_CharaCre_MenuButton_C* Button);
    void OnInitialized();
    void Construct();
    void SetPreview(EPalSkinType Type, FName PreviewSkin);
    void ExecuteUbergraph_WBP_EquipSkin(int32 EntryPoint);
}; // Size: 0x7AD

#endif
