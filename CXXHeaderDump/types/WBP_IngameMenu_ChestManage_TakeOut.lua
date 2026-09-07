---@meta

---@class UWBP_IngameMenu_ChestManage_TakeOut_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_ItemName UBP_PalTextBlock_C
---@field WBP_CommonButton_Confirm UWBP_CommonButton_2_C
---@field WBP_IngameCommonSelectNum UWBP_IngameCommonSelectNum_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field CurrentProductAmount int64
---@field CurrentItemInfo FPalItemAndNum
---@field OnTakeOutClosed FWBP_IngameMenu_ChestManage_TakeOut_COnTakeOutClosed
---@field OnTakeOutConfirmed FWBP_IngameMenu_ChestManage_TakeOut_COnTakeOutConfirmed
---@field MaxCount int64
local UWBP_IngameMenu_ChestManage_TakeOut_C = {}

---@param ItemAndNum FPalItemAndNum
---@param MaxNum int64
function UWBP_IngameMenu_ChestManage_TakeOut_C:Setup(ItemAndNum, MaxNum) end
function UWBP_IngameMenu_ChestManage_TakeOut_C:BndEvt__WBP_IngameMenu_ChestManage_TakeOut_WBP_Menu_btn_K2Node_ComponentBoundEvent_5_OnButtonClicked__DelegateSignature() end
function UWBP_IngameMenu_ChestManage_TakeOut_C:BndEvt__WBP_IngameMenu_ChestManage_TakeOut_WBP_CommonButton_Confirm_K2Node_ComponentBoundEvent_8_OnClicked__DelegateSignature() end
---@param Num int64
function UWBP_IngameMenu_ChestManage_TakeOut_C:BndEvt__WBP_IngameMenu_ChestManage_TakeOut_WBP_IngameCommonSelectNum_K2Node_ComponentBoundEvent_0_OnUpdateNum__DelegateSignature(Num) end
---@param EntryPoint int32
function UWBP_IngameMenu_ChestManage_TakeOut_C:ExecuteUbergraph_WBP_IngameMenu_ChestManage_TakeOut(EntryPoint) end
---@param TakeOutId FPalItemId
---@param TakeOutCount int64
function UWBP_IngameMenu_ChestManage_TakeOut_C:OnTakeOutConfirmed__DelegateSignature(TakeOutId, TakeOutCount) end
function UWBP_IngameMenu_ChestManage_TakeOut_C:OnTakeOutClosed__DelegateSignature() end


