---@meta

---@class UWBP_CommonTutorialPopup_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_CommonButton_NO UWBP_CommonButton_C
---@field WBP_CommonButton_YES UWBP_CommonButton_C
---@field WBP_Option_NoteContent UWBP_Option_NoteContent_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
---@field OnClickedYes FWBP_CommonTutorialPopup_COnClickedYes
local UWBP_CommonTutorialPopup_C = {}

---@param TargetWidget UWidget
function UWBP_CommonTutorialPopup_C:GetFocusTarget_YesButton(TargetWidget) end
---@param InText FText
function UWBP_CommonTutorialPopup_C:SetText(InText) end
---@param SoftTexture TSoftObjectPtr<UTexture2D>
function UWBP_CommonTutorialPopup_C:SetTexture(SoftTexture) end
function UWBP_CommonTutorialPopup_C:BndEvt__WBP_CommonTutorialPopup_WBP_CommonButton_Yes_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_CommonTutorialPopup_C:ExecuteUbergraph_WBP_CommonTutorialPopup(EntryPoint) end
function UWBP_CommonTutorialPopup_C:OnClickedYes__DelegateSignature() end


