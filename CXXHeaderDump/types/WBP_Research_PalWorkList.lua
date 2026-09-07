---@meta

---@class UWBP_Research_PalWorkList_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Unselect UWidgetAnimation
---@field Anm_Selected UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field Canvas_Progress UCanvasPanel
---@field SizeBox_Progress USizeBox
---@field Text_LevelNum_1 UBP_PalTextBlock_C
---@field Text_LevelNum_2 UBP_PalTextBlock_C
---@field Text_PalWorkName UBP_PalTextBlock_C
---@field WBP_IconPalWork UWBP_IconPalWork_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnResearchEntryClicked FWBP_Research_PalWorkList_COnResearchEntryClicked
---@field ['Work Type'] EPalWorkSuitability
---@field OnResearchEntryHovered FWBP_Research_PalWorkList_COnResearchEntryHovered
---@field OnResearchEntryUnhovered FWBP_Research_PalWorkList_COnResearchEntryUnhovered
local UWBP_Research_PalWorkList_C = {}

function UWBP_Research_PalWorkList_C:AnmEvent_Focus() end
function UWBP_Research_PalWorkList_C:AnmEvent_Normal() end
function UWBP_Research_PalWorkList_C:AnmEvent_Selected() end
function UWBP_Research_PalWorkList_C:AnmEvent_Unselected() end
---@param Button UCommonButtonBase
function UWBP_Research_PalWorkList_C:BndEvt__WBP_Research_PalWorkList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Research_PalWorkList_C:BndEvt__WBP_Research_PalWorkList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param WorkType EPalWorkSuitability
---@param Level int32
---@param Total int32
---@param Progressing boolean
function UWBP_Research_PalWorkList_C:Setup(WorkType, Level, Total, Progressing) end
---@param Button UCommonButtonBase
function UWBP_Research_PalWorkList_C:BndEvt__WBP_Research_PalWorkList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Research_PalWorkList_C:Construct() end
---@param EntryPoint int32
function UWBP_Research_PalWorkList_C:ExecuteUbergraph_WBP_Research_PalWorkList(EntryPoint) end
---@param WorkType EPalWorkSuitability
function UWBP_Research_PalWorkList_C:OnResearchEntryUnhovered__DelegateSignature(WorkType) end
---@param WorkType EPalWorkSuitability
function UWBP_Research_PalWorkList_C:OnResearchEntryHovered__DelegateSignature(WorkType) end
---@param WorkType EPalWorkSuitability
function UWBP_Research_PalWorkList_C:OnResearchEntryClicked__DelegateSignature(WorkType) end


