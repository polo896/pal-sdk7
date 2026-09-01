---@meta

---@class UWBP_IngameMenu_WorkSpace_Slider_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field HorizontalBox_0 UHorizontalBox
---@field ProgressBar_305 UProgressBar
---@field Slider USlider
---@field Text_Num_Max UBP_PalTextBlock_C
---@field Text_Num_Min UBP_PalTextBlock_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field OnValueChanged FWBP_IngameMenu_WorkSpace_Slider_COnValueChanged
---@field Current int64
local UWBP_IngameMenu_WorkSpace_Slider_C = {}

---@param Selection ECommonInputType
UWBP_IngameMenu_WorkSpace_Slider_C['On Input Method Changed'] = function(self, Selection) end
---@return float
function UWBP_IngameMenu_WorkSpace_Slider_C:GetPercent() end
---@param Min int64
---@param Max int64
function UWBP_IngameMenu_WorkSpace_Slider_C:SetupRange(Min, Max) end
---@param Current int64
function UWBP_IngameMenu_WorkSpace_Slider_C:SetCurrentValue(Current) end
---@param Value float
function UWBP_IngameMenu_WorkSpace_Slider_C:BndEvt__WBP_IngameMenu_WorkSpace_Slider_Slider_K2Node_ComponentBoundEvent_1_OnFloatValueChangedEvent__DelegateSignature(Value) end
function UWBP_IngameMenu_WorkSpace_Slider_C:Construct() end
---@param EntryPoint int32
function UWBP_IngameMenu_WorkSpace_Slider_C:ExecuteUbergraph_WBP_IngameMenu_WorkSpace_Slider(EntryPoint) end
---@param NewCount int64
function UWBP_IngameMenu_WorkSpace_Slider_C:OnValueChanged__DelegateSignature(NewCount) end


