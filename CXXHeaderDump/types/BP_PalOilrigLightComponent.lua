---@meta

---@class UBP_PalOilrigLightComponent_C : UPalOilrigLightComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultColor FLinearColor
---@field RedColor FLinearColor
local UBP_PalOilrigLightComponent_C = {}

---@param Combat boolean
---@param LightComp ULightComponent
function UBP_PalOilrigLightComponent_C:ChangeLight(Combat, LightComp) end
---@param IsCombat boolean
function UBP_PalOilrigLightComponent_C:ChangeLightColor(IsCombat) end
function UBP_PalOilrigLightComponent_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function UBP_PalOilrigLightComponent_C:ExecuteUbergraph_BP_PalOilrigLightComponent(EntryPoint) end


