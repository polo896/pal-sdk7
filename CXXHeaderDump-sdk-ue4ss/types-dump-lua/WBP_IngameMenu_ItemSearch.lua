---@meta

---@class UWBP_IngameMenu_ItemSearch_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_IngameMenu_ItemSearchList UWBP_IngameMenu_ItemSearchList_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field LegalItemInfos TArray<FPalItemAndNum>
---@field LegalItemIds TArray<FName>
local UWBP_IngameMenu_ItemSearch_C = {}

function UWBP_IngameMenu_ItemSearch_C:CreateItemMap() end
function UWBP_IngameMenu_ItemSearch_C:OnCancelAction() end
function UWBP_IngameMenu_ItemSearch_C:Setup() end
---@return UWidget
function UWBP_IngameMenu_ItemSearch_C:BP_GetDesiredFocusTarget() end
function UWBP_IngameMenu_ItemSearch_C:OnSetup() end
function UWBP_IngameMenu_ItemSearch_C:BndEvt__WBP_IngameMenu_ItemSearch_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_IngameMenu_ItemSearch_C:OnInitialized() end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_IngameMenu_ItemSearch_C:BndEvt__WBP_IngameMenu_ItemSearch_WBP_IngameMenu_ItemSearchList_K2Node_ComponentBoundEvent_1_OnRightClickSlot__DelegateSignature(Slot, PressType) end
---@param EntryPoint int32
function UWBP_IngameMenu_ItemSearch_C:ExecuteUbergraph_WBP_IngameMenu_ItemSearch(EntryPoint) end


