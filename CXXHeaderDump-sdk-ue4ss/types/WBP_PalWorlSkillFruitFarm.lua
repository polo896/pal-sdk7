---@meta

---@class UWBP_PalWorlSkillFruitFarm_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Progress_Pre_Loop UWidgetAnimation
---@field Anm_DetailToSimple UWidgetAnimation
---@field Canvas_Progress_Aft UCanvasPanel
---@field Canvas_Progress_Pre UCanvasPanel
---@field Canvas_Progress_Simple UCanvasPanel
---@field CircleGauge_Progress UImage
---@field Image UImage
---@field ProgressArrow0 UImage
---@field ProgressArrow0_1 UImage
---@field ProgressArrow0_2 UImage
---@field Text_ItemName UBP_PalTextBlock_C
---@field Text_Progress_Aft UBP_PalTextBlock_C
---@field Text_Progress_Pre UBP_PalTextBlock_C
---@field Text_Progress_Simple UBP_PalTextBlock_C
---@field WBP_PalCommonItemIcon UWBP_PalCommonItemIcon_C
---@field WBP_PalCraftInfo_Pal UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_1 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_2 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_3 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_4 UWBP_PalCraftInfo_Pal_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field PalInfos TArray<UWBP_PalCraftInfo_Pal_C>
---@field DisplayCheckTimer FTimerHandle
---@field isDisplayedDetail boolean
---@field HideNextState boolean
---@field MyModel UPalMapObjectFarmSkillFruitsModel
---@field StateMsgIdMap TMap<EPalFarmSkillFruitsState, FDataTableRowHandle>
local UWBP_PalWorlSkillFruitFarm_C = {}

---@param NewValue float
function UWBP_PalWorlSkillFruitFarm_C:CREATEDELEGATE_PROXYFUNCTION_0(NewValue) end
---@param StaticItemId FName
function UWBP_PalWorlSkillFruitFarm_C:SetGrowingItemId(StaticItemId) end
---@param NextState EPalFarmSkillFruitsState
function UWBP_PalWorlSkillFruitFarm_C:OnUpdateState(NextState) end
---@param Work UPalWorkBase
UWBP_PalWorlSkillFruitFarm_C['On Updated Worker Pal'] = function(self, Work) end
---@param Progress double
function UWBP_PalWorlSkillFruitFarm_C:OnUpdateProgress(Progress) end
function UWBP_PalWorlSkillFruitFarm_C:OnSetup() end
function UWBP_PalWorlSkillFruitFarm_C:DisplayCheck() end
function UWBP_PalWorlSkillFruitFarm_C:Destruct() end
function UWBP_PalWorlSkillFruitFarm_C:Construct() end
---@param EntryPoint int32
function UWBP_PalWorlSkillFruitFarm_C:ExecuteUbergraph_WBP_PalWorlSkillFruitFarm(EntryPoint) end


