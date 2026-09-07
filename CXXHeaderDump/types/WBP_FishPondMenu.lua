---@meta

---@class UWBP_FishPondMenu_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_IngameMenu_FishPond UWBP_IngameMenu_FishPond_C
---@field UpdateRecipeTimer FTimerHandle
---@field Phase EUIFishPondMenuPhase::Type
---@field InputActionName_Max FName
---@field InputActionName_Start FName
---@field InputActionName_Cancel FName
---@field LastSelectedSlot UWBP_IngameMenu_FishPond_ListButton_C
local UWBP_FishPondMenu_C = {}

---@return UWidget
function UWBP_FishPondMenu_C:BP_GetDesiredFocusTarget() end
---@param UIModel UPalUIMapObjectFishPondModel
UWBP_FishPondMenu_C['On Update Product Num'] = function(self, UIModel) end
---@param UIModel UPalUIMapObjectFishPondModel
function UWBP_FishPondMenu_C:OnUpdateSelectedLotteryName(UIModel) end
UWBP_FishPondMenu_C['Update Product Num Display'] = function(self, ) end
function UWBP_FishPondMenu_C:UpdateRequiredMaterials() end
function UWBP_FishPondMenu_C:UpdateCaptureCharacterInfo() end
---@param AddNum int32
function UWBP_FishPondMenu_C:AddProductNum(AddNum) end
---@param Num int32
function UWBP_FishPondMenu_C:SetProductNum(Num) end
---@param NewParam int32
function UWBP_FishPondMenu_C:GetProductNum(NewParam) end
---@param SelfSlot UWBP_IngameMenu_FishPond_ListButton_C
function UWBP_FishPondMenu_C:OnUnhoveredTargetSlot(SelfSlot) end
---@param SelfSlot UWBP_IngameMenu_FishPond_ListButton_C
function UWBP_FishPondMenu_C:OnHoveredTargetSlot(SelfSlot) end
---@param SelfSlot UWBP_IngameMenu_FishPond_ListButton_C
function UWBP_FishPondMenu_C:OnClickedTargetSlot(SelfSlot) end
function UWBP_FishPondMenu_C:ChangePhaseTotargetDetail() end
function UWBP_FishPondMenu_C:ChangePhaseToTargetList() end
---@param NextPhase EUIFishPondMenuPhase::Type
function UWBP_FishPondMenu_C:ChangePhase(NextPhase) end
function UWBP_FishPondMenu_C:OnCancelInput() end
function UWBP_FishPondMenu_C:StartProduce() end
function UWBP_FishPondMenu_C:SetProductMax() end
UWBP_FishPondMenu_C['Construct Detail'] = function(self, ) end
function UWBP_FishPondMenu_C:ConstructTargetList() end
function UWBP_FishPondMenu_C:BindUIEvents() end
---@param UIModel UPalUIMapObjectFishPondModel
function UWBP_FishPondMenu_C:GetUIModel(UIModel) end
---@param InputType ECommonInputType
function UWBP_FishPondMenu_C:InputMethodChanged(InputType) end
function UWBP_FishPondMenu_C:Setup() end
function UWBP_FishPondMenu_C:BndEvt__WBP_FishPondMenu_WBP_IngameMenu_FishPond_K2Node_ComponentBoundEvent_4_OnClickedStartProduct__DelegateSignature() end
---@param Num int32
function UWBP_FishPondMenu_C:BndEvt__WBP_FishPondMenu_WBP_IngameMenu_FishPond_K2Node_ComponentBoundEvent_6_OnSetNum__DelegateSignature(Num) end
function UWBP_FishPondMenu_C:OnSetup() end
function UWBP_FishPondMenu_C:Destruct() end
function UWBP_FishPondMenu_C:Construct() end
function UWBP_FishPondMenu_C:BndEvt__WBP_FishPondMenu_WBP_IngameMenu_FishPond_K2Node_ComponentBoundEvent_0_OnClickedCloseButton__DelegateSignature() end
---@param EntryPoint int32
function UWBP_FishPondMenu_C:ExecuteUbergraph_WBP_FishPondMenu(EntryPoint) end


