---@meta

---@class UWBP_PalWorkProduct_Dual_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_None UWidgetAnimation
---@field Anm_DetailToSimple UWidgetAnimation
---@field Test_Color_R UWidgetAnimation
---@field Test_Color_L UWidgetAnimation
---@field Test_Over UWidgetAnimation
---@field CircleGauge_Base_L UImage
---@field CircleGauge_Base_R UImage
---@field CircleGauge_Over_L UImage
---@field CircleGauge_Over_R UImage
---@field Image_3 UImage
---@field Image_65 UImage
---@field Image_IconBloom_L UImage
---@field Image_IconBloom_R UImage
---@field Image_Plus UImage
---@field Image_Plus_1 UImage
---@field Text_ItemName UBP_PalTextBlock_C
---@field Text_MaxItemNum UBP_PalTextBlock_C
---@field Text_NowItemNum UBP_PalTextBlock_C
---@field Text_WorkNum_L UBP_PalTextBlock_C
---@field Text_WorkNum_R UBP_PalTextBlock_C
---@field WBP_CommonCircularGauge_L UWBP_CommonCircularGauge_C
---@field WBP_CommonCircularGauge_R UWBP_CommonCircularGauge_C
---@field WBP_IconPalWork_L UWBP_IconPalWork_C
---@field WBP_IconPalWork_R UWBP_IconPalWork_C
---@field WBP_PalCommonItemIcon_1 UWBP_PalCommonItemIcon_C
---@field WBP_PalCraftInfo_Pal_L UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_R UWBP_PalCraftInfo_Pal_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field WidgetSetL FFPalUIWorkProductDualWidgetSet
---@field WidgetSetR FFPalUIWorkProductDualWidgetSet
---@field InfinityNumMsgId FDataTableRowHandle
---@field RequireGenusMSGID FDataTableRowHandle
---@field RequireTypeMSGID FDataTableRowHandle
---@field BaseColorWorkSuitability TMap<EPalWorkSuitability, FLinearColor>
local UWBP_PalWorkProduct_Dual_C = {}

---@param Target EPalWorkSuitability
---@return FLinearColor
function UWBP_PalWorkProduct_Dual_C:GetWorkSuitabilityColor(Target) end
---@param Index int32
---@return FFPalUIWorkProductDualWidgetSet
function UWBP_PalWorkProduct_Dual_C:GetWidgetSetByIndex(Index) end
---@param Work UPalWorkProgressMultiType
---@param WidgetIndex int32
function UWBP_PalWorkProduct_Dual_C:RefreshWorkPalSlot(Work, WidgetIndex) end
---@return TArray<UWBP_PalCraftInfo_Pal_C>
function UWBP_PalWorkProduct_Dual_C:GetWorkerPalWidgetArray() end
---@param WorkSuitability EPalWorkSuitability
function UWBP_PalWorkProduct_Dual_C:SetWorkSuitability(WorkSuitability) end
---@param Work UPalWorkBase
---@param DisplayData TArray<FPalUIMapObjectStatusIndicatorWorkSuitabilityDisplayData>
function UWBP_PalWorkProduct_Dual_C:UpdateRequireInfo(Work, DisplayData) end
---@param TargetCharacter UPalCharacterParameterComponent
---@param WorkId FGuid
---@return boolean
function UWBP_PalWorkProduct_Dual_C:IsCharacterAssignedFixedToTargetWork(TargetCharacter, WorkId) end
UWBP_PalWorkProduct_Dual_C['Set Invalid Recipe Detail'] = function(self, ) end
---@param ItemId FName
function UWBP_PalWorkProduct_Dual_C:SetProductItemID(ItemId) end
---@param WorkProgress UPalWorkProgressMultiType
---@param WidgetIndex int32
function UWBP_PalWorkProduct_Dual_C:ReflectWorkProgressRateForTargetSlot(WorkProgress, WidgetIndex) end
---@param WorkProgress UPalWorkProgressMultiType
function UWBP_PalWorkProduct_Dual_C:ReflectWorkProgressRate(WorkProgress) end
---@param ItemId FName
function UWBP_PalWorkProduct_Dual_C:SetIcon(ItemId) end
function UWBP_PalWorkProduct_Dual_C:SetInfinityProductMode() end
---@param nowProductNum int32
---@param maxProductNum int32
function UWBP_PalWorkProduct_Dual_C:SetProductNum(nowProductNum, maxProductNum) end
---@param Work UPalWorkProgressMultiType
function UWBP_PalWorkProduct_Dual_C:RefreshWorkPalSlots(Work) end
---@param bLeft boolean
---@param Work UPalWorkProgress
function UWBP_PalWorkProduct_Dual_C:GetTargetWorkSuitabilityByWork(bLeft, Work) end
---@param Work UPalWorkProgressMultiType
---@param WorkSuitability EPalWorkSuitability
---@param WidgetImage_Progress UImage
function UWBP_PalWorkProduct_Dual_C:OnUpdateProgress_ForTarget(Work, WorkSuitability, WidgetImage_Progress) end
function UWBP_PalWorkProduct_Dual_C:CreateWidgetSets() end
---@param Work UPalWorkProgressMultiType
---@param Index int32
function UWBP_PalWorkProduct_Dual_C:SetupUI_ForWorkSlot(Work, Index) end
---@param WorkProgressMulti UPalWorkProgressMultiType
function UWBP_PalWorkProduct_Dual_C:SetupUI(WorkProgressMulti) end
function UWBP_PalWorkProduct_Dual_C:AnmEvent_ToDetail() end
function UWBP_PalWorkProduct_Dual_C:AnmEvent_ToSimpleDetail() end
function UWBP_PalWorkProduct_Dual_C:AnmEvent_NoRecipe() end
function UWBP_PalWorkProduct_Dual_C:AnmEvent_ForceSimple() end
function UWBP_PalWorkProduct_Dual_C:OnInitialized() end
function UWBP_PalWorkProduct_Dual_C:Construct() end
---@param EntryPoint int32
function UWBP_PalWorkProduct_Dual_C:ExecuteUbergraph_WBP_PalWorkProduct_Dual(EntryPoint) end


