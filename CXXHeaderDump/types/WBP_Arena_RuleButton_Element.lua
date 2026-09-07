---@meta

---@class UWBP_Arena_RuleButton_Element_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_OnToOff UWidgetAnimation
---@field WBP_PalElementIcon UWBP_PalElementIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnElementButtonClicked FWBP_Arena_RuleButton_Element_COnElementButtonClicked
---@field ['Element Type'] EPalElementType
local UWBP_Arena_RuleButton_Element_C = {}

function UWBP_Arena_RuleButton_Element_C:AnmEvent_Enable() end
function UWBP_Arena_RuleButton_Element_C:AnmEvent_Restrict() end
---@param ElementType EPalElementType
function UWBP_Arena_RuleButton_Element_C:SetupElement(ElementType) end
---@param IsRestrict boolean
function UWBP_Arena_RuleButton_Element_C:SetRestrict(IsRestrict) end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleButton_Element_C:BndEvt__WBP_Arena_RuleButton_Element_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Arena_RuleButton_Element_C:ExecuteUbergraph_WBP_Arena_RuleButton_Element(EntryPoint) end
---@param ElementType EPalElementType
function UWBP_Arena_RuleButton_Element_C:OnElementButtonClicked__DelegateSignature(ElementType) end


