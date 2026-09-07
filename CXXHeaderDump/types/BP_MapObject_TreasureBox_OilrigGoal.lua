---@meta

---@class ABP_MapObject_TreasureBox_OilrigGoal_C : ABP_MapObject_TreasureBox_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field IsOpened boolean
local ABP_MapObject_TreasureBox_OilrigGoal_C = {}

---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_TreasureBox_OilrigGoal_C:SetupVisual(ConcreteModel) end
function ABP_MapObject_TreasureBox_OilrigGoal_C:ReceiveBeginPlay() end
function ABP_MapObject_TreasureBox_OilrigGoal_C:TriggerOpen() end
---@param EntryPoint int32
function ABP_MapObject_TreasureBox_OilrigGoal_C:ExecuteUbergraph_BP_MapObject_TreasureBox_OilrigGoal(EntryPoint) end


