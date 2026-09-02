---@meta

---@class UWBP_AssignBoard_WorkList_Common_C : UWBP_AssignBoard_WorkListBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Unselect UWidgetAnimation
---@field Anm_Selected UWidgetAnimation
---@field Anm_NormalToDisable UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field HorizontalBox_AssignedPal UHorizontalBox
---@field HorizontalBox_Suitability UHorizontalBox
---@field HorizontalBox_WorkNum UHorizontalBox
---@field Image_BuildingIcon UImage
---@field Image_RecipeIcon UImage
---@field Image_WorkStatus_Base UImage
---@field Overlay_Recipe UOverlay
---@field Overlay_WorkStatus UOverlay
---@field SizeBox_WorkIcon_0 USizeBox
---@field SizeBox_WorkIcon_1 USizeBox
---@field SizeBox_WorkIcon_2 USizeBox
---@field Text_AssignTargetName UBP_PalTextBlock_C
---@field WBP_IconPalWork_0 UWBP_IconPalWork_C
---@field WBP_IconPalWork_1 UWBP_IconPalWork_C
---@field WBP_IconPalWork_2 UWBP_IconPalWork_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field IsSelectingAnm boolean
---@field IsEnableAnm boolean
---@field WorkIconArray TArray<UWBP_IconPalWork_C>
---@field WorkIconSizeBoxArray TArray<USizeBox>
---@field UpdateAssignedCharacterDetailTimerHandle FTimerHandle
---@field AssignableMaxNum int32
local UWBP_AssignBoard_WorkList_Common_C = {}

function UWBP_AssignBoard_WorkList_Common_C:OnTimer_UpdateAssignedCharacterDetail() end
---@param TargetWidget UWidget
function UWBP_AssignBoard_WorkList_Common_C:GetFocusTarget(TargetWidget) end
function UWBP_AssignBoard_WorkList_Common_C:Unbind() end
function UWBP_AssignBoard_WorkList_Common_C:ResetAssignedChaarcterSlotDetail() end
---@param Work UPalWorkBase
function UWBP_AssignBoard_WorkList_Common_C:OnUpdateAssignedCharacter(Work) end
function UWBP_AssignBoard_WorkList_Common_C:SetupAssignedCharacterSlot() end
function UWBP_AssignBoard_WorkList_Common_C:SetupWorkSuitability() end
function UWBP_AssignBoard_WorkList_Common_C:SetupTitle() end
function UWBP_AssignBoard_WorkList_Common_C:SetupWorkNum() end
---@param Work UPalWorkBase
function UWBP_AssignBoard_WorkList_Common_C:OnUpdateWorkState(Work) end
function UWBP_AssignBoard_WorkList_Common_C:SetupWorkStatus() end
function UWBP_AssignBoard_WorkList_Common_C:Setup() end
function UWBP_AssignBoard_WorkList_Common_C:SetupRecipeDetail() end
function UWBP_AssignBoard_WorkList_Common_C:SetupAssignTargetName() end
function UWBP_AssignBoard_WorkList_Common_C:AnmEvent_Hover() end
function UWBP_AssignBoard_WorkList_Common_C:AnmEvent_Unhover() end
function UWBP_AssignBoard_WorkList_Common_C:AnmEvent_Select() end
function UWBP_AssignBoard_WorkList_Common_C:AnmEvent_Unselect() end
function UWBP_AssignBoard_WorkList_Common_C:AnmEvent_Enable() end
function UWBP_AssignBoard_WorkList_Common_C:AnmEvent_DIsable() end
function UWBP_AssignBoard_WorkList_Common_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_AssignBoard_WorkList_Common_C:BndEvt__WBP_AssignBoard_WorkList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_AssignBoard_WorkList_Common_C:BndEvt__WBP_AssignBoard_WorkList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_AssignBoard_WorkList_Common_C:BndEvt__WBP_AssignBoard_WorkList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_AssignBoard_WorkList_Common_C:OnInitialized() end
function UWBP_AssignBoard_WorkList_Common_C:Destruct() end
---@param EntryPoint int32
function UWBP_AssignBoard_WorkList_Common_C:ExecuteUbergraph_WBP_AssignBoard_WorkList_Common(EntryPoint) end


