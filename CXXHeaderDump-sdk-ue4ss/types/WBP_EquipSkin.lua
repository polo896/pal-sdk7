---@meta

---@class UWBP_EquipSkin_C : UPalUICharacterDressing
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanel_Dressing UCanvasPanel
---@field WBP_CharaCre_BG UWBP_CharaCre_BG_C
---@field WBP_CharaCre_MenuButton_Cancel_InGame UWBP_CharaCre_MenuButton_C
---@field WBP_CharaCre_MenuButton_Finish_InGame UWBP_CharaCre_MenuButton_C
---@field WBP_EquipSkin_ItemButton UWBP_EquipSkin_ItemButton_C
---@field WBP_EquipSkin_Slot_Body UWBP_EquipSkin_ItemSlot_C
---@field WBP_EquipSkin_Slot_Glider UWBP_EquipSkin_ItemSlot_C
---@field WBP_EquipSkin_Slot_Head UWBP_EquipSkin_ItemSlot_C
---@field WBP_MainMenu_PalSkillInfo UWBP_MainMenu_PalSkillInfo_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_1 UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_2 UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_3 UWBP_PalKeyGuideIcon_C
---@field WBP_PalPlayerInframeRender UWBP_PalPlayerInframeRender_C
---@field WrapBox_Equip UWrapBox
---@field CachedAnalogValueX double
---@field CachedAnalogValueY double
---@field RotationSpeed_Pad double
---@field RotationSpeed_MouseDrag double
---@field IsRTriggerDown boolean
---@field IsLTriggerDown boolean
---@field CameraUpDownSpeed_ForPad double
---@field ZoomSpeed_Pad double
---@field ZoomRate_WheelTrigger double
---@field CameraRelativeLocation FVector
---@field IsMLBDown boolean
---@field MouseZoomInInputAction FPalDataTableRowName_UIInputAction
---@field MouseZoomOutInputAction FPalDataTableRowName_UIInputAction
---@field MakeInfo FPalPlayerDataCharacterMakeInfo
---@field CharacterMakeData UBP_PalPlayerDataCharacterMake_C
---@field DressingSlots TArray<UWBP_EquipSkin_ItemSlot_C>
---@field LastSelectSkinType EPalSkinType
---@field LastSelectSkinSlot UWBP_EquipSkin_ItemButton_C
---@field CurrentPreviewType EPalSkinType
---@field ['Static Id'] FName
---@field NowDisplayGlider boolean
local UWBP_EquipSkin_C = {}

---@param IsEquip boolean
---@param SkinName1 FName
---@param SkinName2 FName
---@param IsEqual boolean
function UWBP_EquipSkin_C:CheckSkinEqual(IsEquip, SkinName1, SkinName2, IsEqual) end
---@param IsEquip boolean
---@param SkinName FName
---@param ShouldDisplay boolean
---@param Title FText
---@param Desc FText
function UWBP_EquipSkin_C:GetSkinInfo(IsEquip, SkinName, ShouldDisplay, Title, Desc) end
function UWBP_EquipSkin_C:HideSkinInfo() end
---@param RelativeWidget UWidget
---@param AnchorPosition FVector2D
---@param SkinName FName
---@param IsEquip boolean
function UWBP_EquipSkin_C:ShowSkinInfo(RelativeWidget, AnchorPosition, SkinName, IsEquip) end
function UWBP_EquipSkin_C:OnSkinSlotUnhovered() end
---@param Button UWBP_EquipSkin_ItemButton_C
function UWBP_EquipSkin_C:OnSkinSlotHovered(Button) end
---@param Button UWBP_EquipSkin_ItemButton_C
function UWBP_EquipSkin_C:OnSkinSlotClicked(Button) end
---@param SkinType EPalSkinType
---@param EquipIds TArray<FName>
function UWBP_EquipSkin_C:GetUseableSkins(SkinType, EquipIds) end
function UWBP_EquipSkin_C:OnDressingSlotUnhovered() end
---@param Button UWBP_EquipSkin_ItemSlot_C
function UWBP_EquipSkin_C:OnDressingSlotHovered(Button) end
---@param Button UWBP_EquipSkin_ItemSlot_C
function UWBP_EquipSkin_C:OnDressingSlotClicked(Button) end
---@return UWidget
function UWBP_EquipSkin_C:BP_GetDesiredFocusTarget() end
UWBP_EquipSkin_C['Request Display'] = function(self, ) end
function UWBP_EquipSkin_C:OnTriggerZoomOut_Mouse() end
UWBP_EquipSkin_C['On Trigger Zoom in Mouse'] = function(self, ) end
---@param IsZoomIn boolean
function UWBP_EquipSkin_C:UpdateCameraLocationByWheel(IsZoomIn) end
function UWBP_EquipSkin_C:OnCancelAction() end
---@param MyGeometry FGeometry
---@param MouseEvent FPointerEvent
---@return FEventReply
function UWBP_EquipSkin_C:OnMouseMove(MyGeometry, MouseEvent) end
---@param MyGeometry FGeometry
---@param MouseEvent FPointerEvent
---@return FEventReply
function UWBP_EquipSkin_C:OnMouseButtonDown(MyGeometry, MouseEvent) end
---@param MyGeometry FGeometry
---@param MouseEvent FPointerEvent
---@return FEventReply
function UWBP_EquipSkin_C:OnMouseButtonUp(MyGeometry, MouseEvent) end
---@param MyGeometry FGeometry
---@param InKeyEvent FKeyEvent
---@return FEventReply
function UWBP_EquipSkin_C:OnKeyUp(MyGeometry, InKeyEvent) end
---@param MyGeometry FGeometry
---@param InKeyEvent FKeyEvent
---@return FEventReply
function UWBP_EquipSkin_C:OnKeyDown(MyGeometry, InKeyEvent) end
---@param MyGeometry FGeometry
---@param InAnalogInputEvent FAnalogInputEvent
---@return FEventReply
function UWBP_EquipSkin_C:OnAnalogValueChanged(MyGeometry, InAnalogInputEvent) end
---@param Offset double
function UWBP_EquipSkin_C:GetAddCameraOffsetUpDown_ForPad(Offset) end
---@param DeltaTime double
UWBP_EquipSkin_C['Update Camera Location'] = function(self, DeltaTime) end
---@param DeltaTime double
function UWBP_EquipSkin_C:UpdateCharacterRotation(DeltaTime) end
function UWBP_EquipSkin_C:Setup() end
---@param Loaded UClass
function UWBP_EquipSkin_C:OnLoaded_4251E5CF44968BCFF3126FBB8CFC7169(Loaded) end
function UWBP_EquipSkin_C:OnSetup() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_EquipSkin_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_EquipSkin_C:Destruct() end
---@param InFocusEvent FFocusEvent
function UWBP_EquipSkin_C:OnFocusLost(InFocusEvent) end
---@param MouseEvent FPointerEvent
function UWBP_EquipSkin_C:OnMouseLeave(MouseEvent) end
---@param Button UWBP_CharaCre_MenuButton_C
function UWBP_EquipSkin_C:BndEvt__WBP_EquipSkin_WBP_CharaCre_MenuButton_Cancel_InGame_1_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature(Button) end
---@param Button UWBP_CharaCre_MenuButton_C
function UWBP_EquipSkin_C:BndEvt__WBP_EquipSkin_WBP_CharaCre_MenuButton_Finish_InGame_1_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature(Button) end
function UWBP_EquipSkin_C:OnInitialized() end
function UWBP_EquipSkin_C:Construct() end
---@param Type EPalSkinType
---@param PreviewSkin FName
function UWBP_EquipSkin_C:SetPreview(Type, PreviewSkin) end
---@param EntryPoint int32
function UWBP_EquipSkin_C:ExecuteUbergraph_WBP_EquipSkin(EntryPoint) end


