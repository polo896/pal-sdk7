---@meta

---@class UWBP_PalWork_RelicRecycler_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_PalWorkRecycler UWBP_PalWorkRecycler_C
---@field RecyclerUIModel UPalUIMapObjectRecyclerStatusIndicatorModel
---@field DisplayCheckTimer FTimerHandle
---@field isDisplayedDetail boolean
---@field LocationCheckTimerHandle FTimerHandle
---@field bValidTarget boolean
local UWBP_PalWork_RelicRecycler_C = {}

function UWBP_PalWork_RelicRecycler_C:CloseDetail() end
function UWBP_PalWork_RelicRecycler_C:DisplayDetail() end
---@param Module UPalMapObjectSwitchModule
function UWBP_PalWork_RelicRecycler_C:OnUpdateSwitch(Module) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function UWBP_PalWork_RelicRecycler_C:OnReadySwitchModule(Model, Module) end
---@param Module UPalMapObjectItemContainerModule
---@param bInitial boolean
function UWBP_PalWork_RelicRecycler_C:OnUpdateItemContainerContent_Internal(Module, bInitial) end
---@param Module UPalMapObjectItemContainerModule
function UWBP_PalWork_RelicRecycler_C:OnUpdateItemContainerContent(Module) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function UWBP_PalWork_RelicRecycler_C:OnReadyItemContainerModule(Model, Module) end
---@param Work UPalWorkBase
function UWBP_PalWork_RelicRecycler_C:OnUpdatedWorkerPal(Work) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function UWBP_PalWork_RelicRecycler_C:OnReadyEnergyModule(Model, Module) end
---@param WorkProgress UPalWorkProgress
function UWBP_PalWork_RelicRecycler_C:OnReflectWorkProgress(WorkProgress) end
---@param Module UPalMapObjectWorkeeModule
---@param Work UPalWorkBase
function UWBP_PalWork_RelicRecycler_C:OnReadyWork(Module, Work) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function UWBP_PalWork_RelicRecycler_C:OnReadyWorkeeModule(Model, Module) end
---@param UIModel UPalUIMapObjectRecyclerStatusIndicatorModel
function UWBP_PalWork_RelicRecycler_C:OnUpdateBoost(UIModel) end
---@param UIModel UPalUIMapObjectRecyclerStatusIndicatorModel
function UWBP_PalWork_RelicRecycler_C:OnUpdateRecycleTarget(UIModel) end
function UWBP_PalWork_RelicRecycler_C:RefreshBoostDisplay() end
function UWBP_PalWork_RelicRecycler_C:SetupUI() end
function UWBP_PalWork_RelicRecycler_C:OnSetup() end
function UWBP_PalWork_RelicRecycler_C:Construct() end
function UWBP_PalWork_RelicRecycler_C:CheckLocationEvent() end
function UWBP_PalWork_RelicRecycler_C:Destruct() end
---@param EntryPoint int32
function UWBP_PalWork_RelicRecycler_C:ExecuteUbergraph_WBP_PalWork_RelicRecycler(EntryPoint) end


