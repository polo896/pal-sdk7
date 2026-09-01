---@meta

---@class ABP_OilRigCannonBase_C : APalOilRigCannonBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_InteractableSphere UPalInteractableSphereComponentNative
---@field DefaultSceneRoot USceneComponent
---@field ActionType EPalActionType
---@field IsCallDestroyed_Local boolean
local ABP_OilRigCannonBase_C = {}

---@return EPalInteractiveObjectIndicatorType
function ABP_OilRigCannonBase_C:GetIndicatorType() end
---@param Other AActor
---@param IndicatorType EPalInteractiveObjectIndicatorType
ABP_OilRigCannonBase_C['Stop Animation'] = function(self, Other, IndicatorType) end
---@param Other AActor
---@param IndicatorType EPalInteractiveObjectIndicatorType
ABP_OilRigCannonBase_C['Start Animation'] = function(self, Other, IndicatorType) end
---@param Other AActor
---@param IndicatorType EPalInteractiveObjectIndicatorType
ABP_OilRigCannonBase_C['Interact Completed'] = function(self, Other, IndicatorType) end
function ABP_OilRigCannonBase_C:ReceiveBeginPlay() end
function ABP_OilRigCannonBase_C:OnDestroyedWeapon_ForBP() end
function ABP_OilRigCannonBase_C:ChangeDefaultVisual_BP() end
---@param DeltaSeconds float
function ABP_OilRigCannonBase_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function ABP_OilRigCannonBase_C:ExecuteUbergraph_BP_OilRigCannonBase(EntryPoint) end


