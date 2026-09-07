---@meta

---@class UWBP_Ingame_Incubator_Multiple_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_DetailToSimple UWidgetAnimation
---@field BP_PalRichTextBlock_NoSet UBP_PalRichTextBlock_C
---@field LineCenter UImage
---@field OverlayStatus UOverlay
---@field Text_Status UBP_PalTextBlock_C
---@field WBP_Ingame_Incubator_MultipleSlot UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_1 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_2 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_3 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_4 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_5 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_6 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_7 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_8 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_9 UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_Simple UWBP_Ingame_Incubator_MultipleSlot_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field Model UPalMapObjectMultiHatchingEggModel
---@field isDisplayedDetail boolean
---@field DisplayCheckTimer FTimerHandle
---@field Slots TArray<UWBP_Ingame_Incubator_MultipleSlot_C>
---@field LastSimpleSlotIndex int32
---@field SimpleSlotUpdateTimer FTimerHandle
---@field NoEgg boolean
---@field HasPower boolean
local UWBP_Ingame_Incubator_Multiple_C = {}

function UWBP_Ingame_Incubator_Multiple_C:OnEggArrayUpdated() end
function UWBP_Ingame_Incubator_Multiple_C:UpdateSimpleSlot() end
---@param Module UPalMapObjectEnergyModule
UWBP_Ingame_Incubator_Multiple_C['Update Power Suffcient'] = function(self, Module) end
---@param ItemContainer UPalItemContainer
UWBP_Ingame_Incubator_Multiple_C['Update Slots'] = function(self, ItemContainer) end
function UWBP_Ingame_Incubator_Multiple_C:Setup() end
function UWBP_Ingame_Incubator_Multiple_C:OnSetup() end
function UWBP_Ingame_Incubator_Multiple_C:Destruct() end
function UWBP_Ingame_Incubator_Multiple_C:Construct() end
function UWBP_Ingame_Incubator_Multiple_C:DisplayCheck() end
function UWBP_Ingame_Incubator_Multiple_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_Ingame_Incubator_Multiple_C:ExecuteUbergraph_WBP_Ingame_Incubator_Multiple(EntryPoint) end


