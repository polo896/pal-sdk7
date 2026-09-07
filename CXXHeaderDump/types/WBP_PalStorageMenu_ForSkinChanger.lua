---@meta

---@class UWBP_PalStorageMenu_ForSkinChanger_C : UWBP_PalStorageMenu_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field OnClickedAnySlot FWBP_PalStorageMenu_ForSkinChanger_COnClickedAnySlot
---@field TargetCharacterID FName
---@field OnClickedCloseButton FWBP_PalStorageMenu_ForSkinChanger_COnClickedCloseButton
---@field bRemoveSkinMode boolean
local UWBP_PalStorageMenu_ForSkinChanger_C = {}

---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_PalStorageMenu_ForSkinChanger_C:OnCampSlotEmpty(Slot) end
UWBP_PalStorageMenu_ForSkinChanger_C['Register Pal Operate Input'] = function(self, ) end
function UWBP_PalStorageMenu_ForSkinChanger_C:OnClickedCloseButtonInternal() end
---@param Parameter UPalHUDDispatchParameter_PalBox
function UWBP_PalStorageMenu_ForSkinChanger_C:SetupByParameter(Parameter) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_PalStorageMenu_ForSkinChanger_C:OnBoxSlotCreated(Slot) end
---@param Slot UPalIndividualCharacterSlot
---@param bSkinApplied boolean
UWBP_PalStorageMenu_ForSkinChanger_C['Is Skin Applied'] = function(self, Slot, bSkinApplied) end
UWBP_PalStorageMenu_ForSkinChanger_C['To Remove Skin Mode'] = function(self, ) end
UWBP_PalStorageMenu_ForSkinChanger_C['Update Button Enable'] = function(self, ) end
---@param Slot UPalIndividualCharacterSlot
---@param bIsMatch boolean
function UWBP_PalStorageMenu_ForSkinChanger_C:IsMatchCharacterID(Slot, bIsMatch) end
---@param CharacterID FName
UWBP_PalStorageMenu_ForSkinChanger_C['Set Target Character ID'] = function(self, CharacterID) end
---@param Slot UPalIndividualCharacterSlot
---@param PressType EPalItemSlotPressType
function UWBP_PalStorageMenu_ForSkinChanger_C:SelectSlot(Slot, PressType) end
function UWBP_PalStorageMenu_ForSkinChanger_C:Construct() end
function UWBP_PalStorageMenu_ForSkinChanger_C:OnSetup() end
---@param EntryPoint int32
function UWBP_PalStorageMenu_ForSkinChanger_C:ExecuteUbergraph_WBP_PalStorageMenu_ForSkinChanger(EntryPoint) end
function UWBP_PalStorageMenu_ForSkinChanger_C:OnClickedCloseButton__DelegateSignature() end
---@param Slot UPalIndividualCharacterSlot
function UWBP_PalStorageMenu_ForSkinChanger_C:OnClickedAnySlot__DelegateSignature(Slot) end


