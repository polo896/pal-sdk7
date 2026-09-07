---@meta

---@class UWBP_EquipSkin_ItemSlot_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_UnselectedToSelected UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field WBP_EquipSkin_SkinIcon UWBP_EquipSkin_SkinIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnSlotClicked FWBP_EquipSkin_ItemSlot_COnSlotClicked
---@field slotType EPalSkinType
---@field OnSlotHovered FWBP_EquipSkin_ItemSlot_COnSlotHovered
---@field OnSlotUnhovered FWBP_EquipSkin_ItemSlot_COnSlotUnhovered
---@field SkinName FName
---@field IsEquip boolean
local UWBP_EquipSkin_ItemSlot_C = {}

---@param MakeInfo FPalPlayerDataCharacterMakeInfo
---@param SkinName FName
---@param IsEuip boolean
function UWBP_EquipSkin_ItemSlot_C:GetDressingSlotInfo(MakeInfo, SkinName, IsEuip) end
---@param MakeInfo FPalPlayerDataCharacterMakeInfo
function UWBP_EquipSkin_ItemSlot_C:Setup(MakeInfo) end
---@param Button UCommonButtonBase
function UWBP_EquipSkin_ItemSlot_C:BndEvt__WBP_EquipSkin_ItemSlot_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_EquipSkin_ItemSlot_C:BndEvt__WBP_EquipSkin_ItemSlot_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_EquipSkin_ItemSlot_C:BndEvt__WBP_EquipSkin_ItemSlot_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_EquipSkin_ItemSlot_C:ExecuteUbergraph_WBP_EquipSkin_ItemSlot(EntryPoint) end
function UWBP_EquipSkin_ItemSlot_C:OnSlotUnhovered__DelegateSignature() end
---@param Button UWBP_EquipSkin_ItemSlot_C
function UWBP_EquipSkin_ItemSlot_C:OnSlotHovered__DelegateSignature(Button) end
---@param Button UWBP_EquipSkin_ItemSlot_C
function UWBP_EquipSkin_ItemSlot_C:OnSlotClicked__DelegateSignature(Button) end


