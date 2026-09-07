---@meta

---@class UWBP_Expedition_PalList_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field Icon_NonOwnership UImage
---@field Icon_Target UImage
---@field Image_Focus_CloseBtn UImage
---@field Image_Focus_Flare UImage
---@field Image_Focus_Frame UImage
---@field Text_PalLevel_Value UBP_PalTextBlock_C
---@field Text_PalName UBP_PalTextBlock_C
---@field Text_PowerNum UBP_PalTextBlock_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClicked FWBP_Expedition_PalList_COnClicked
---@field MyInfo FPalUIMapObjectCharacterTeamMissionIndividual
---@field OnHovered FWBP_Expedition_PalList_COnHovered
local UWBP_Expedition_PalList_C = {}

---@param AssignInfo FPalUIMapObjectCharacterTeamMissionIndividual
function UWBP_Expedition_PalList_C:GetAssignInfo(AssignInfo) end
---@param AssignInfo FPalUIMapObjectCharacterTeamMissionIndividual
function UWBP_Expedition_PalList_C:Setup(AssignInfo) end
---@param Button UCommonButtonBase
function UWBP_Expedition_PalList_C:BndEvt__WBP_Expedition_PalList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Expedition_PalList_C:BndEvt__WBP_Expedition_PalList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Expedition_PalList_C:ExecuteUbergraph_WBP_Expedition_PalList(EntryPoint) end
---@param Widget UWBP_Expedition_PalList_C
function UWBP_Expedition_PalList_C:OnHovered__DelegateSignature(Widget) end
---@param Widget UWBP_Expedition_PalList_C
function UWBP_Expedition_PalList_C:OnClicked__DelegateSignature(Widget) end


