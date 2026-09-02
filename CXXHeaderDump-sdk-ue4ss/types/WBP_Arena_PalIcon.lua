---@meta

---@class UWBP_Arena_PalIcon_C : UWBP_IndividualParameterBindWidget_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_Level UBP_PalTextBlock_C
---@field Image_PalIcon UImage
---@field Overlay_Ban UOverlay
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnPalIconHovered FWBP_Arena_PalIcon_COnPalIconHovered
---@field OnPalIconUnhovered FWBP_Arena_PalIcon_COnPalIconUnhovered
local UWBP_Arena_PalIcon_C = {}

---@param IsBaned boolean
function UWBP_Arena_PalIcon_C:SetBan(IsBaned) end
---@param NewLevel int32
function UWBP_Arena_PalIcon_C:OnLevelUpdate(NewLevel) end
---@param targetHandle UPalIndividualCharacterHandle
function UWBP_Arena_PalIcon_C:BindFromHandle(targetHandle) end
function UWBP_Arena_PalIcon_C:OnInitialized() end
---@param Button UCommonButtonBase
function UWBP_Arena_PalIcon_C:BndEvt__WBP_Arena_PalIcon_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_PalIcon_C:BndEvt__WBP_Arena_PalIcon_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Arena_PalIcon_C:ExecuteUbergraph_WBP_Arena_PalIcon(EntryPoint) end
function UWBP_Arena_PalIcon_C:OnPalIconUnhovered__DelegateSignature() end
---@param Icon UWBP_Arena_PalIcon_C
function UWBP_Arena_PalIcon_C:OnPalIconHovered__DelegateSignature(Icon) end


