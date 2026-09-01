---@meta

---@class UWBP_RelicRecyclerMenu_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_RecyclerMenu UWBP_RecyclerMenu_C
---@field UIModel UPalUIMapObjectRecyclerModel
local UWBP_RelicRecyclerMenu_C = {}

UWBP_RelicRecyclerMenu_C['Cleanup UIModel'] = function(self, ) end
function UWBP_RelicRecyclerMenu_C:CleanupRelicChestEventBind() end
---@return UWidget
function UWBP_RelicRecyclerMenu_C:BP_GetDesiredFocusTarget() end
---@param UIModel UPalUIMapObjectRecyclerModel
function UWBP_RelicRecyclerMenu_C:OnUpdateBoost(UIModel) end
---@param UIModel UPalUIMapObjectRecyclerModel
function UWBP_RelicRecyclerMenu_C:OnUpdateOutputContainerCaution(UIModel) end
---@param Module UPalMapObjectWorkeeModule
---@param Work UPalWorkBase
function UWBP_RelicRecyclerMenu_C:OnReadyWorkProgress(Module, Work) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function UWBP_RelicRecyclerMenu_C:OnReadyWorkeeModule(Model, Module) end
---@param UIModel UPalUIMapObjectRecyclerModel
function UWBP_RelicRecyclerMenu_C:OnUpdatCurrentRecycleItem(UIModel) end
---@param UIModel UPalUIMapObjectRecyclerModel
---@param bInitial boolean
function UWBP_RelicRecyclerMenu_C:OnUpdateSwitch_Internal(UIModel, bInitial) end
---@param UIModel UPalUIMapObjectRecyclerModel
function UWBP_RelicRecyclerMenu_C:OnUpdateSwitch(UIModel) end
function UWBP_RelicRecyclerMenu_C:SetupRelicChestEventBind() end
function UWBP_RelicRecyclerMenu_C:SetupRelicChestDisplay() end
function UWBP_RelicRecyclerMenu_C:BndEvt__WBP_RelicRecyclerMenu_WBP_RecyclerMenu_K2Node_ComponentBoundEvent_0_OnClickClosedButton__DelegateSignature() end
function UWBP_RelicRecyclerMenu_C:OnSetup() end
function UWBP_RelicRecyclerMenu_C:BndEvt__WBP_RelicRecyclerMenu_WBP_RecyclerMenu_K2Node_ComponentBoundEvent_2_OnClickedTargetContainerSortButton__DelegateSignature() end
function UWBP_RelicRecyclerMenu_C:BndEvt__WBP_RelicRecyclerMenu_WBP_RecyclerMenu_K2Node_ComponentBoundEvent_3_OnHoveredTargetContainerSlot__DelegateSignature() end
---@param EntryPoint int32
function UWBP_RelicRecyclerMenu_C:ExecuteUbergraph_WBP_RelicRecyclerMenu(EntryPoint) end


