---@meta

---@class UWBP_RaidBossMenuSelectItem_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_Altar_SelectItem UWBP_Altar_SelectItem_C
---@field LastSelectedSlot UWBP_Altar_SelectItem_Button_C
---@field WarningUltraRaidItemId TArray<FPalDataTableRowName_ItemData>
---@field WarningUltraRaidMsgId FDataTableRowHandle
local UWBP_RaidBossMenuSelectItem_C = {}

---@return UWidget
function UWBP_RaidBossMenuSelectItem_C:BP_GetDesiredFocusTarget() end
---@param bResult boolean
function UWBP_RaidBossMenuSelectItem_C:OnClosedDialog_WarningUltraRaid(bResult) end
---@param SelfSlot UWBP_Altar_SelectItem_Button_C
function UWBP_RaidBossMenuSelectItem_C:OnClickSlot_Internal(SelfSlot) end
function UWBP_RaidBossMenuSelectItem_C:OpenUltraRaidWarningDialog() end
---@param SelfSlot UWBP_Altar_SelectItem_Button_C
function UWBP_RaidBossMenuSelectItem_C:OnUnhoveredSlot(SelfSlot) end
---@param SelfSlot UWBP_Altar_SelectItem_Button_C
function UWBP_RaidBossMenuSelectItem_C:OnHoveredSlot(SelfSlot) end
---@param SelfSlot UWBP_Altar_SelectItem_Button_C
function UWBP_RaidBossMenuSelectItem_C:OnClickSlot(SelfSlot) end
---@param UIModel UPalUIMapObjectRaidBossSummonSelectionModel
function UWBP_RaidBossMenuSelectItem_C:OnUpdateSelectedInfo(UIModel) end
function UWBP_RaidBossMenuSelectItem_C:ConstructTargetList() end
function UWBP_RaidBossMenuSelectItem_C:BindUIEvents() end
---@param UIModel UPalUIMapObjectRaidBossSummonSelectionModel
function UWBP_RaidBossMenuSelectItem_C:GetUIModel(UIModel) end
function UWBP_RaidBossMenuSelectItem_C:Setup() end
function UWBP_RaidBossMenuSelectItem_C:OnSetup() end
function UWBP_RaidBossMenuSelectItem_C:BndEvt__WBP_RaidBossMenuSelectItem_WBP_Altar_SelectItem_K2Node_ComponentBoundEvent_1_OnClickedCloseButton__DelegateSignature() end
function UWBP_RaidBossMenuSelectItem_C:Destruct() end
---@param EntryPoint int32
function UWBP_RaidBossMenuSelectItem_C:ExecuteUbergraph_WBP_RaidBossMenuSelectItem(EntryPoint) end


