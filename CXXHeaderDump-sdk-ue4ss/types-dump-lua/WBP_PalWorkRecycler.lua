---@meta

---@class UWBP_PalWorkRecycler_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Work_Stop UWidgetAnimation
---@field Anm_Work_Proceed UWidgetAnimation
---@field Anm_Boost_Off UWidgetAnimation
---@field Anm_Boost_On UWidgetAnimation
---@field Anm_Storage_Full UWidgetAnimation
---@field Anm_Storage_NotFull UWidgetAnimation
---@field Anm_None UWidgetAnimation
---@field Anm_DetailToSimple UWidgetAnimation
---@field Canvas_Storage UCanvasPanel
---@field CircularGauge_Progress UWBP_CommonCircularGauge_C
---@field Image_442 UImage
---@field Image_Icon_Stop UImage
---@field Overlay_PowerOFF UOverlay
---@field Text_ItemName UBP_PalTextBlock_C
---@field Text_WorkBoostNum UBP_PalTextBlock_C
---@field WBP_PalCommonItemIcon UWBP_PalCommonItemIcon_C
---@field WBP_PalCraftInfo_Pal UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_1 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_2 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_3 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_4 UWBP_PalCraftInfo_Pal_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field workerPalWidgetArray TArray<UWBP_PalCraftInfo_Pal_C>
---@field InfinityNumMsgId FDataTableRowHandle
---@field RequireGenusMSGID FDataTableRowHandle
---@field RequireTypeMSGID FDataTableRowHandle
---@field bLastFullOutput boolean
local UWBP_PalWorkRecycler_C = {}

---@param bFull boolean
---@param bForce boolean
function UWBP_PalWorkRecycler_C:SetFullOutputState(bFull, bForce) end
---@param bIsOn boolean
function UWBP_PalWorkRecycler_C:SetPowerState(bIsOn) end
---@param bActive boolean
function UWBP_PalWorkRecycler_C:SetActiveBoost(bActive) end
---@param SpeedMultiplier float
function UWBP_PalWorkRecycler_C:SetBoostSpeed(SpeedMultiplier) end
---@param Work UPalWorkBase
---@param DisplayData TArray<FPalUIMapObjectStatusIndicatorWorkSuitabilityDisplayData>
function UWBP_PalWorkRecycler_C:UpdateRequireInfo(Work, DisplayData) end
---@param TargetCharacter UPalCharacterParameterComponent
---@param WorkId FGuid
---@return boolean
function UWBP_PalWorkRecycler_C:IsCharacterAssignedFixedToTargetWork(TargetCharacter, WorkId) end
---@param ItemId FName
function UWBP_PalWorkRecycler_C:SetProductItemID(ItemId) end
---@param Rate double
function UWBP_PalWorkRecycler_C:SetWorkProgressRate(Rate) end
---@param Slots TArray<UPalIndividualCharacterSlot>
---@param WorkId FGuid
function UWBP_PalWorkRecycler_C:SetWorkerPalSlots(Slots, WorkId) end
function UWBP_PalWorkRecycler_C:AnmEvent_ToDetail() end
function UWBP_PalWorkRecycler_C:AnmEvent_ToSimpleDetail() end
function UWBP_PalWorkRecycler_C:AnmEvent_NoRecipe() end
function UWBP_PalWorkRecycler_C:AnmEvent_ForceSimple() end
function UWBP_PalWorkRecycler_C:AnmEvent_Full() end
function UWBP_PalWorkRecycler_C:AnmEvent_NotFull() end
function UWBP_PalWorkRecycler_C:AnmEvent_BoostOn() end
function UWBP_PalWorkRecycler_C:AnmEvent_BoostOff() end
function UWBP_PalWorkRecycler_C:OnInitialized() end
function UWBP_PalWorkRecycler_C:Construct() end
---@param EntryPoint int32
function UWBP_PalWorkRecycler_C:ExecuteUbergraph_WBP_PalWorkRecycler(EntryPoint) end


