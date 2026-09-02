---@meta

---@class UWBP_Trading_Item_List_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToSoldout UWidgetAnimation
---@field Canvas_Empty UCanvasPanel
---@field Canvas_Select UCanvasPanel
---@field CanvasPanel_TradeInfo UCanvasPanel
---@field Frame_Focus_Flare UImage
---@field Text_Stock UBP_PalTextBlock_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonCharacterSlotButton UWBP_PalCommonCharacterSlotButton_C
---@field WBP_PalInGameMenuItemSlotButton_Cost UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInGameMenuItemSlotButton_Product UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnEmptySlotClicked FWBP_Trading_Item_List_COnEmptySlotClicked
---@field Index int32
---@field OnClickedRemoveButton FWBP_Trading_Item_List_COnClickedRemoveButton
---@field IsEmpty boolean
---@field OnTradeSelect FWBP_Trading_Item_List_COnTradeSelect
---@field OnTradeInfoHovered FWBP_Trading_Item_List_COnTradeInfoHovered
---@field OnTradeInfoUnhovered FWBP_Trading_Item_List_COnTradeInfoUnhovered
---@field NowSoldOut boolean
local UWBP_Trading_Item_List_C = {}

---@param StockCount int32
function UWBP_Trading_Item_List_C:UpdateStock(StockCount) end
function UWBP_Trading_Item_List_C:SetEmpty() end
---@param TradeInfo FPalPalBoothTradeInfo
---@param RemoveButtonVisible boolean
---@param CharacterID FName
UWBP_Trading_Item_List_C['Setup Pal Trade Info'] = function(self, TradeInfo, RemoveButtonVisible, CharacterID) end
---@param TradeInfo FPalItemBoothTradeInfo
---@param RemoveButtonVisible boolean
UWBP_Trading_Item_List_C['Setup Item Trade Info'] = function(self, TradeInfo, RemoveButtonVisible) end
function UWBP_Trading_Item_List_C:AnmEvent_SoldOut() end
function UWBP_Trading_Item_List_C:AnmEvent_Normal() end
function UWBP_Trading_Item_List_C:BndEvt__WBP_Trading_Item_List_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_List_C:BndEvt__WBP_Trading_Item_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_List_C:BndEvt__WBP_Trading_Item_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_List_C:BndEvt__WBP_Trading_Item_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Trading_Item_List_C:Construct() end
---@param Selected boolean
function UWBP_Trading_Item_List_C:ToggleSelect(Selected) end
---@param EntryPoint int32
function UWBP_Trading_Item_List_C:ExecuteUbergraph_WBP_Trading_Item_List(EntryPoint) end
---@param Index int32
function UWBP_Trading_Item_List_C:OnTradeInfoUnhovered__DelegateSignature(Index) end
---@param Index int32
function UWBP_Trading_Item_List_C:OnTradeInfoHovered__DelegateSignature(Index) end
---@param Index int32
function UWBP_Trading_Item_List_C:OnTradeSelect__DelegateSignature(Index) end
---@param TradeIndex int32
function UWBP_Trading_Item_List_C:OnClickedRemoveButton__DelegateSignature(TradeIndex) end
function UWBP_Trading_Item_List_C:OnEmptySlotClicked__DelegateSignature() end


