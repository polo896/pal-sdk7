---@meta

---@class UWBP_IngameMenu_PalCompare_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_61 UImage
---@field Image_Arrow_0 UImage
---@field Image_Arrow_1 UImage
---@field Image_Dark UImage
---@field Image_Pattern UImage
---@field WBP_CommonButton_Cancel UWBP_CommonButton_1_C
---@field WBP_CommonButton_OK UWBP_CommonButton_2_C
---@field WBP_PalCommonInfo_SaveParameter_Original UWBP_PalCommonInfo_SaveParameter_C
---@field WBP_PalCommonInfo_SaveParameter_Overwrite UWBP_PalCommonInfo_SaveParameter_C
---@field OnClickedConfirm FWBP_IngameMenu_PalCompare_COnClickedConfirm
---@field OnClickedCancel FWBP_IngameMenu_PalCompare_COnClickedCancel
local UWBP_IngameMenu_PalCompare_C = {}

---@param OverwriteParameter FPalIndividualCharacterSaveParameter
---@param OriginalParameter FPalIndividualCharacterSaveParameter
function UWBP_IngameMenu_PalCompare_C:SetCompareParameter(OverwriteParameter, OriginalParameter) end
---@param Widget UWidget
function UWBP_IngameMenu_PalCompare_C:GetCancelButtonFocusTarget(Widget) end
function UWBP_IngameMenu_PalCompare_C:BndEvt__WBP_IngameMenu_PalCompare_WBP_CommonButton_OK_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature() end
function UWBP_IngameMenu_PalCompare_C:BndEvt__WBP_IngameMenu_PalCompare_WBP_CommonButton_Cancel_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_IngameMenu_PalCompare_C:ExecuteUbergraph_WBP_IngameMenu_PalCompare(EntryPoint) end
function UWBP_IngameMenu_PalCompare_C:OnClickedCancel__DelegateSignature() end
function UWBP_IngameMenu_PalCompare_C:OnClickedConfirm__DelegateSignature() end


