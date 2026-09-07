---@meta

---@class UWBP_IngameMenu_FishPond_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanelIcon UCanvasPanel
---@field CanvasPanelMaterialText UCanvasPanel
---@field CanvasPanelSelect UCanvasPanel
---@field DurableFrameB UImage
---@field Line_U UCanvasPanel
---@field MenuTitleText UBP_PalTextBlock_C
---@field PalScrollBox_63 UPalScrollBox
---@field WBP_IngameCommonSelectNum UWBP_IngameCommonSelectNum_C
---@field WBP_IngameMenu_StartButton UWBP_IngameMenu_WorkSpace_StartButton_C
---@field WBP_InventoryEquipment_ItemInfo_Tecnology UWBP_InventoryEquipment_ItemInfo_Tecnology_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonScrollList_ListButton UWBP_PalCommonScrollList_C
---@field WrapBox_PalList UWrapBox
---@field OnClickedCloseButton FWBP_IngameMenu_FishPond_COnClickedCloseButton
---@field OnClickedStartProduct FWBP_IngameMenu_FishPond_COnClickedStartProduct
---@field OnSetNum FWBP_IngameMenu_FishPond_COnSetNum
local UWBP_IngameMenu_FishPond_C = {}

---@param Widget UWidget
function UWBP_IngameMenu_FishPond_C:GetListTopFocusTarget(Widget) end
function UWBP_IngameMenu_FishPond_C:BndEvt__WBP_IngameMenu_FishPond_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_IngameMenu_FishPond_C:BndEvt__WBP_IngameMenu_FishPond_WBP_IngameMenu_StartButton_K2Node_ComponentBoundEvent_5_OnClicked__DelegateSignature() end
---@param Num int64
function UWBP_IngameMenu_FishPond_C:BndEvt__WBP_IngameMenu_FishPond_WBP_IngameCommonSelectNum_K2Node_ComponentBoundEvent_7_OnUpdateNum__DelegateSignature(Num) end
function UWBP_IngameMenu_FishPond_C:Construct() end
function UWBP_IngameMenu_FishPond_C:Destruct() end
---@param EntryPoint int32
function UWBP_IngameMenu_FishPond_C:ExecuteUbergraph_WBP_IngameMenu_FishPond(EntryPoint) end
---@param Num int32
function UWBP_IngameMenu_FishPond_C:OnSetNum__DelegateSignature(Num) end
function UWBP_IngameMenu_FishPond_C:OnClickedStartProduct__DelegateSignature() end
function UWBP_IngameMenu_FishPond_C:OnClickedCloseButton__DelegateSignature() end


