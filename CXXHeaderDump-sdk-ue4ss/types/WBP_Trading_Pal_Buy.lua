---@meta

---@class UWBP_Trading_Pal_Buy_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanel_BuyPanel UCanvasPanel
---@field Image_365 UImage
---@field PalRetainerBox_150 UPalRetainerBox
---@field Text_LevelValue UBP_PalTextBlock_C
---@field Text_PalName UBP_PalTextBlock_C
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
---@field WBP_IngameMenu_WorkSpace_Item UWBP_IngameMenu_WorkSpace_Item_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_NoData UWBP_NoData_C
---@field WBP_PalCommonCharacterIcon UWBP_PalCommonCharacterIcon_C
---@field WBP_Trading_Item_List UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_1 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_2 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_3 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_4 UWBP_Trading_Item_List_C
---@field TradeList TArray<UWBP_Trading_Item_List_C>
---@field PalBoothModel UPalMapObjectPalBoothModel
---@field CurrentSelectIndex int32
---@field Tradeable boolean
---@field LastHoveredTradePalHandle UPalIndividualCharacterHandle
---@field IsPined boolean
---@field ViewDetailInputHandle FPalUIActionBindData
---@field PinedPalHandle UPalIndividualCharacterHandle
---@field ['HasEmptySlot '] boolean
local UWBP_Trading_Pal_Buy_C = {}

function UWBP_Trading_Pal_Buy_C:UpdateSellList() end
---@param PlayerState APalPlayerState
function UWBP_Trading_Pal_Buy_C:OnTradeComplete(PlayerState) end
---@param Slot UPalIndividualCharacterSlot
---@param LastHandle UPalIndividualCharacterHandle
function UWBP_Trading_Pal_Buy_C:OnStoreSlotUpdate(Slot, LastHandle) end
---@param CharacterContainer UPalIndividualCharacterContainer
UWBP_Trading_Pal_Buy_C['On Character Container Update'] = function(self, CharacterContainer) end
function UWBP_Trading_Pal_Buy_C:OnViewDetailInput() end
---@param IsEnable boolean
UWBP_Trading_Pal_Buy_C['Set Detail Enable'] = function(self, IsEnable) end
function UWBP_Trading_Pal_Buy_C:OnCancelAction() end
function UWBP_Trading_Pal_Buy_C:CheckTradeable() end
---@return UWidget
function UWBP_Trading_Pal_Buy_C:BP_GetDesiredFocusTarget() end
function UWBP_Trading_Pal_Buy_C:Setup() end
---@param Visible boolean
UWBP_Trading_Pal_Buy_C['Switch Trading Panel'] = function(self, Visible) end
---@param TradeIndex int32
function UWBP_Trading_Pal_Buy_C:OnTradeUnhovered(TradeIndex) end
---@param TradeIndex int32
function UWBP_Trading_Pal_Buy_C:OnTradeHovered(TradeIndex) end
---@param Index int32
function UWBP_Trading_Pal_Buy_C:OnTradeSelected(Index) end
function UWBP_Trading_Pal_Buy_C:OnInitialized() end
function UWBP_Trading_Pal_Buy_C:OnSetup() end
function UWBP_Trading_Pal_Buy_C:BndEvt__WBP_Trading_Pal_Buy_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_Trading_Pal_Buy_C:BndEvt__WBP_Trading_Pal_Buy_WBP_CommonButton_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
function UWBP_Trading_Pal_Buy_C:Destruct() end
---@param EntryPoint int32
function UWBP_Trading_Pal_Buy_C:ExecuteUbergraph_WBP_Trading_Pal_Buy(EntryPoint) end


