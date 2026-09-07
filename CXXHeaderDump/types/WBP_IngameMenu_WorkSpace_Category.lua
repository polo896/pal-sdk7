---@meta

---@class UWBP_IngameMenu_WorkSpace_Category_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field Image_CategoryIcon UImage
---@field Text_Title UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field bCurrentActive boolean
---@field BindCategory E_PalUIWorkSpaceDisplayCategory::Type
---@field MsgIDMap TMap<E_PalUIWorkSpaceDisplayCategory::Type, FDataTableRowHandle>
---@field OnClicked FWBP_IngameMenu_WorkSpace_Category_COnClicked
local UWBP_IngameMenu_WorkSpace_Category_C = {}

---@param OutCategory E_PalUIWorkSpaceDisplayCategory::Type
function UWBP_IngameMenu_WorkSpace_Category_C:GetBindCategory(OutCategory) end
---@param ItemTypesA TArray<EPalItemTypeA>
---@param ExcludeItemTypesB TArray<EPalItemTypeA>
function UWBP_IngameMenu_WorkSpace_Category_C:GetTargetItemTypes(ItemTypesA, ExcludeItemTypesB) end
function UWBP_IngameMenu_WorkSpace_Category_C:Setup() end
---@param bIsActive boolean
function UWBP_IngameMenu_WorkSpace_Category_C:AnmEvent_Active(bIsActive) end
function UWBP_IngameMenu_WorkSpace_Category_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_WorkSpace_Category_C:BndEvt__WBP_IngameMenu_WorkSpace_Category_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_IngameMenu_WorkSpace_Category_C:Destruct() end
---@param EntryPoint int32
function UWBP_IngameMenu_WorkSpace_Category_C:ExecuteUbergraph_WBP_IngameMenu_WorkSpace_Category(EntryPoint) end
---@param Widget UWBP_IngameMenu_WorkSpace_Category_C
function UWBP_IngameMenu_WorkSpace_Category_C:OnClicked__DelegateSignature(Widget) end


