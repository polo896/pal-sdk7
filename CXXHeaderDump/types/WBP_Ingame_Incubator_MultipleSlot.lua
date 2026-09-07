---@meta

---@class UWBP_Ingame_Incubator_MultipleSlot_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalRichTextBlock_RemainTime UBP_PalRichTextBlock_C
---@field BP_PalTextBlock_Complete UBP_PalTextBlock_C
---@field CircleGauge_Complete UImage
---@field CircleGauge_Progress UImage
---@field WBP_PalCommonItemIcon UWBP_PalCommonItemIcon_C
---@field ['Work Progress'] UPalWorkProgress
---@field TargetSlot UPalItemSlot
local UWBP_Ingame_Incubator_MultipleSlot_C = {}

---@param WorkProgress UPalWorkProgress
UWBP_Ingame_Incubator_MultipleSlot_C['On Update Work Amount'] = function(self, WorkProgress) end
---@param Slot UPalItemSlot
function UWBP_Ingame_Incubator_MultipleSlot_C:SetSlot(Slot) end
---@param Work_Progress UPalWorkProgress
function UWBP_Ingame_Incubator_MultipleSlot_C:UpdateSlotProgress(Work_Progress) end
function UWBP_Ingame_Incubator_MultipleSlot_C:Unbind() end
---@param EntryPoint int32
function UWBP_Ingame_Incubator_MultipleSlot_C:ExecuteUbergraph_WBP_Ingame_Incubator_MultipleSlot(EntryPoint) end


