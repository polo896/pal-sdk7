---@meta

---@class UWBP_Trading_Item_Buy_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanel_Buy UCanvasPanel
---@field CanvasPanel_ItemNum UCanvasPanel
---@field HorizontalBoxSellListHead_ UHorizontalBox
---@field Image_365 UImage
---@field Image_Icon_1 UImage
---@field Image_Icon_Shadow UImage
---@field Image_ItemNum_Base UImage
---@field ItemThumbnail UCanvasPanel
---@field PalRetainerBox_150 UPalRetainerBox
---@field Text_ItemName UBP_PalTextBlock_C
---@field Text_ItemNum UBP_PalTextBlock_C
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_IngameCommonSelectNum UWBP_IngameCommonSelectNum_C
---@field WBP_IngameMenu_WorkSpace_Item UWBP_IngameMenu_WorkSpace_Item_C
---@field WBP_ItemInfo_ForItemBooth UWBP_ItemInfo_ForItemBooth_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_NoData UWBP_NoData_C
---@field WBP_PalInGameMenuItemIcon UWBP_PalInGameMenuItemIcon_C
---@field WBP_Trading_Item_List UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_1 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_2 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_3 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_4 UWBP_Trading_Item_List_C
---@field TradeList TArray<UWBP_Trading_Item_List_C>
---@field [' ItemBoothModel'] UPalMapObjectItemBoothModel
---@field CurrentSelectIndex int32
---@field TakeOutBindedActions TArray<FPalUIActionBindData>
---@field CurrentGroupAmount int32
---@field Tradeable boolean
---@field ['HasEmptySlot '] boolean
local UWBP_Trading_Item_Buy_C = {}

---@param TradeIndex int32
function UWBP_Trading_Item_Buy_C:OnTradeUnhovered(TradeIndex) end
---@param TradeIndex int32
function UWBP_Trading_Item_Buy_C:OnTradeHovered(TradeIndex) end
---@param PlayerState APalPlayerState
function UWBP_Trading_Item_Buy_C:OnTradeComplete(PlayerState) end
UWBP_Trading_Item_Buy_C['Update Select Count'] = function(self, ) end
---@param Count int32
function UWBP_Trading_Item_Buy_C:CalcMaxTradeGroup(Count) end
function UWBP_Trading_Item_Buy_C:SetMax() end
function UWBP_Trading_Item_Buy_C:OnCancelAction() end
function UWBP_Trading_Item_Buy_C:CheckTradeable() end
---@param Visible boolean
UWBP_Trading_Item_Buy_C['Switch Trading Panel'] = function(self, Visible) end
---@param ItemContainer UPalItemContainer
UWBP_Trading_Item_Buy_C['On Store Content Updated'] = function(self, ItemContainer) end
UWBP_Trading_Item_Buy_C['Update Sell List'] = function(self, ) end
---@return UWidget
function UWBP_Trading_Item_Buy_C:BP_GetDesiredFocusTarget() end
function UWBP_Trading_Item_Buy_C:Setup() end
---@param Index int32
function UWBP_Trading_Item_Buy_C:OnTradeSelected(Index) end
function UWBP_Trading_Item_Buy_C:OnSetup() end
function UWBP_Trading_Item_Buy_C:OnInitialized() end
function UWBP_Trading_Item_Buy_C:BndEvt__WBP_Trading_Item_Buy_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_Trading_Item_Buy_C:BndEvt__WBP_Trading_Item_Buy_WBP_CommonButton_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
function UWBP_Trading_Item_Buy_C:Destruct() end
---@param Num int64
function UWBP_Trading_Item_Buy_C:BndEvt__WBP_Trading_Item_Buy_WBP_IngameCommonSelectNum_K2Node_ComponentBoundEvent_5_OnUpdateNum__DelegateSignature(Num) end
---@param EntryPoint int32
function UWBP_Trading_Item_Buy_C:ExecuteUbergraph_WBP_Trading_Item_Buy(EntryPoint) end


