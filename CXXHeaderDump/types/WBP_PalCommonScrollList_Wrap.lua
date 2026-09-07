---@meta

---@class UWBP_PalCommonScrollList_Wrap_C : UPalCommonScrollListBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_Root UCanvasPanel
---@field ScrollBox_Wrap UScrollBox
---@field WBP_InventoryArrow_Bottom UWBP_InventoryArrow_C
---@field WBP_InventoryArrow_Top UWBP_InventoryArrow_C
---@field WrapBox UWrapBox
---@field lastScrollOffset double
---@field IsDisplayArrow boolean
---@field GamePadFocusChangeScrollType EScrollWhenFocusChanges
local UWBP_PalCommonScrollList_Wrap_C = {}

---@param bEnableMouseWheel boolean
function UWBP_PalCommonScrollList_Wrap_C:SetEnableMouseWheelScroll(bEnableMouseWheel) end
---@param ScrollBox UScrollBox
function UWBP_PalCommonScrollList_Wrap_C:GetScrollBox(ScrollBox) end
---@param Widget UUserWidget
function UWBP_PalCommonScrollList_Wrap_C:AddWidget(Widget) end
---@param Index int32
function UWBP_PalCommonScrollList_Wrap_C:GetAllChildrenNum(Index) end
---@param Widget UWidget
---@param Index int32
function UWBP_PalCommonScrollList_Wrap_C:GetIndexFromWidget(Widget, Index) end
---@param Offset double
function UWBP_PalCommonScrollList_Wrap_C:AddScrollOffset(Offset) end
---@param bNewInputType ECommonInputType
function UWBP_PalCommonScrollList_Wrap_C:OnInputMethodChanged(bNewInputType) end
function UWBP_PalCommonScrollList_Wrap_C:ClearAllChildren() end
---@param CurrentOffset double
function UWBP_PalCommonScrollList_Wrap_C:UpdateArrowVisibilityAndAnimation(CurrentOffset) end
function UWBP_PalCommonScrollList_Wrap_C:Construct() end
function UWBP_PalCommonScrollList_Wrap_C:Destruct() end
---@param CurrentOffset float
function UWBP_PalCommonScrollList_Wrap_C:BndEvt__WBP_PalCommonScrollList_Wrap_ScrollBox_Wrap_K2Node_ComponentBoundEvent_0_OnUserScrolledEvent__DelegateSignature(CurrentOffset) end
---@param EntryPoint int32
function UWBP_PalCommonScrollList_Wrap_C:ExecuteUbergraph_WBP_PalCommonScrollList_Wrap(EntryPoint) end


