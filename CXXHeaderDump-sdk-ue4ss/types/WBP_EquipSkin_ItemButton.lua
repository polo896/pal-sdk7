---@meta

---@class UWBP_EquipSkin_ItemButton_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Overlay_Focus UOverlay
---@field Select UCanvasPanel
---@field WBP_EquipSkin_SkinIcon UWBP_EquipSkin_SkinIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field ['Skin Id'] FName
---@field ['Is Equip'] boolean
---@field OnSkinSlotClicked FWBP_EquipSkin_ItemButton_COnSkinSlotClicked
---@field OnSkinSlotHovered FWBP_EquipSkin_ItemButton_COnSkinSlotHovered
---@field OnSkinSlotUnhovered FWBP_EquipSkin_ItemButton_COnSkinSlotUnhovered
local UWBP_EquipSkin_ItemButton_C = {}

---@param IsSelected boolean
function UWBP_EquipSkin_ItemButton_C:SetSelect(IsSelected) end
---@param SkinId FName
---@param IsEquip boolean
function UWBP_EquipSkin_ItemButton_C:Setup(SkinId, IsEquip) end
function UWBP_EquipSkin_ItemButton_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_EquipSkin_ItemButton_C:BndEvt__WBP_EquipSkin_ItemButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_EquipSkin_ItemButton_C:BndEvt__WBP_EquipSkin_ItemButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_EquipSkin_ItemButton_C:BndEvt__WBP_EquipSkin_ItemButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_EquipSkin_ItemButton_C:ExecuteUbergraph_WBP_EquipSkin_ItemButton(EntryPoint) end
function UWBP_EquipSkin_ItemButton_C:OnSkinSlotUnhovered__DelegateSignature() end
---@param Button UWBP_EquipSkin_ItemButton_C
function UWBP_EquipSkin_ItemButton_C:OnSkinSlotHovered__DelegateSignature(Button) end
---@param Button UWBP_EquipSkin_ItemButton_C
function UWBP_EquipSkin_ItemButton_C:OnSkinSlotClicked__DelegateSignature(Button) end


