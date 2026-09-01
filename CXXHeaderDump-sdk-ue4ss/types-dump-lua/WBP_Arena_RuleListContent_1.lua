---@meta

---@class UWBP_Arena_RuleListContent_1_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field Image_ChangeMark UImage
---@field WBP_Arena_RuleButton_Element UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_1 UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_2 UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_3 UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_4 UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_5 UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_6 UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_7 UWBP_Arena_RuleButton_Element_C
---@field WBP_Arena_RuleButton_Element_8 UWBP_Arena_RuleButton_Element_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field ElementButtons TArray<UWBP_Arena_RuleButton_Element_C>
---@field CurrentRestriction TArray<EPalElementType>
---@field OnElementRestrictionUpdate FWBP_Arena_RuleListContent_1_COnElementRestrictionUpdate
---@field ['Is Changeable'] boolean
---@field OnContentHovered FWBP_Arena_RuleListContent_1_COnContentHovered
---@field OnContentUnhovered FWBP_Arena_RuleListContent_1_COnContentUnhovered
local UWBP_Arena_RuleListContent_1_C = {}

---@param Navigation EUINavigation
---@return UWidget
function UWBP_Arena_RuleListContent_1_C:CustomNavigation_ToContent(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Arena_RuleListContent_1_C:CustomNavigation_ToElementButton(Navigation) end
---@param IsChangeable boolean
function UWBP_Arena_RuleListContent_1_C:SetChangeable(IsChangeable) end
function UWBP_Arena_RuleListContent_1_C:SetChangedFlag() end
---@param ElementType EPalElementType
UWBP_Arena_RuleListContent_1_C['Toggle Element Restrict'] = function(self, ElementType) end
---@param ElementRestrict TArray<EPalElementType>
---@param RestrictChangedEvent FSetupRestrictChangedEvent
function UWBP_Arena_RuleListContent_1_C:Setup(ElementRestrict, RestrictChangedEvent) end
function UWBP_Arena_RuleListContent_1_C:AnmEvent_Focus() end
function UWBP_Arena_RuleListContent_1_C:AnmEvent_Normal() end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleListContent_1_C:BndEvt__WBP_Arena_RuleListContent_1_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleListContent_1_C:BndEvt__WBP_Arena_RuleListContent_1_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Arena_RuleListContent_1_C:OnInitialized() end
function UWBP_Arena_RuleListContent_1_C:Construct() end
---@param EntryPoint int32
function UWBP_Arena_RuleListContent_1_C:ExecuteUbergraph_WBP_Arena_RuleListContent_1(EntryPoint) end
function UWBP_Arena_RuleListContent_1_C:OnContentUnhovered__DelegateSignature() end
---@param Button UWidget
function UWBP_Arena_RuleListContent_1_C:OnContentHovered__DelegateSignature(Button) end
---@param RestrictElements TArray<EPalElementType>
function UWBP_Arena_RuleListContent_1_C:OnElementRestrictionUpdate__DelegateSignature(RestrictElements) end


