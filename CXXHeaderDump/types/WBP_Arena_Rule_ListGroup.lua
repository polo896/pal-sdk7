---@meta

---@class UWBP_Arena_Rule_ListGroup_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_Arena_RuleListContent_Boss UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_Duplicate UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_Element UWBP_Arena_RuleListContent_1_C
---@field WBP_Arena_RuleListContent_Human UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_Legend UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_LevelSync UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_PalDamage UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_PalRestrict UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_PlayerDamage UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_Ride UWBP_Arena_RuleListContent_0_C
---@field WBP_Arena_RuleListContent_Time UWBP_Arena_RuleListContent_0_C
---@field SomethingChanged boolean
---@field CurrentRule FPalArenaRule
---@field OnRuleUpdated FWBP_Arena_Rule_ListGroup_COnRuleUpdated
---@field OnRestrictPalClicked FWBP_Arena_Rule_ListGroup_COnRestrictPalClicked
---@field SettingContents TArray<UWBP_Arena_RuleListContent_0_C>
---@field LastHoveredConten UCommonButtonBase
---@field ToggleLevelSyncInfo FWBP_Arena_Rule_ListGroup_CToggleLevelSyncInfo
local UWBP_Arena_Rule_ListGroup_C = {}

---@param Value double
function UWBP_Arena_Rule_ListGroup_C:OnTimeLimitDamageChanged(Value) end
---@param IsOn boolean
function UWBP_Arena_Rule_ListGroup_C:OnHumanRestrictChanged(IsOn) end
---@param Elements TArray<EPalElementType>
function UWBP_Arena_Rule_ListGroup_C:OnElementRestrictChanged(Elements) end
function UWBP_Arena_Rule_ListGroup_C:OnPalRestrictClicked() end
---@param IsOn boolean
function UWBP_Arena_Rule_ListGroup_C:OnDuplicateRestrictChanged(IsOn) end
---@param IsOn boolean
function UWBP_Arena_Rule_ListGroup_C:OnRideRestrictChanged(IsOn) end
---@param IsOn boolean
function UWBP_Arena_Rule_ListGroup_C:OnLegendRestrictChanged(IsOn) end
---@param IsOn boolean
function UWBP_Arena_Rule_ListGroup_C:OnBossRestrictChanged(IsOn) end
---@param Value double
function UWBP_Arena_Rule_ListGroup_C:OnPalDamageChanged(Value) end
---@param Value double
function UWBP_Arena_Rule_ListGroup_C:OnPlayerDamageChanged(Value) end
---@param IsOn boolean
function UWBP_Arena_Rule_ListGroup_C:OnLevelSyncChanged(IsOn) end
---@param Widget UWidget
function UWBP_Arena_Rule_ListGroup_C:GetDesiredFocusTarget(Widget) end
---@param ArenaRule FPalArenaRule
---@param RuleEditable boolean
function UWBP_Arena_Rule_ListGroup_C:Setup(ArenaRule, RuleEditable) end
function UWBP_Arena_Rule_ListGroup_C:OnInitialized() end
---@param Button UWidget
function UWBP_Arena_Rule_ListGroup_C:OnContentHovered(Button) end
function UWBP_Arena_Rule_ListGroup_C:OnContentUnhovered() end
---@param EntryPoint int32
function UWBP_Arena_Rule_ListGroup_C:ExecuteUbergraph_WBP_Arena_Rule_ListGroup(EntryPoint) end
---@param Show boolean
function UWBP_Arena_Rule_ListGroup_C:ToggleLevelSyncInfo__DelegateSignature(Show) end
function UWBP_Arena_Rule_ListGroup_C:OnRestrictPalClicked__DelegateSignature() end
---@param NewRule FPalArenaRule
function UWBP_Arena_Rule_ListGroup_C:OnRuleUpdated__DelegateSignature(NewRule) end


