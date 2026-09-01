---@meta

---@class UWBP_RelicMenu_ForDisplay_C : UPalUIRelicMenu
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_Buildup_Player_1 UWBP_Buildup_Player_1_C
---@field StatusOperation UPalCharacterStatusOperation
---@field bRequesting boolean
---@field bReplicated_Relic boolean
---@field bReplicated_Status boolean
---@field bLastOperationSuccessed boolean
---@field LastRequestedRelicType TArray<EPalRelicType>
---@field WaitingSynsRelicType TArray<EPalRelicType>
---@field PreRankupStatusMap TMap<FName, int32>
local UWBP_RelicMenu_ForDisplay_C = {}

function UWBP_RelicMenu_ForDisplay_C:Reset() end
function UWBP_RelicMenu_ForDisplay_C:TryRequestRankup() end
---@return UWidget
function UWBP_RelicMenu_ForDisplay_C:BP_GetDesiredFocusTarget() end
UWBP_RelicMenu_ForDisplay_C['On Got Status'] = function(self, ) end
---@param Type EPalRelicType
---@param NewNum int32
function UWBP_RelicMenu_ForDisplay_C:OnUpdatedRelicNum(Type, NewNum) end
---@param OutRelicType TArray<EPalRelicType>
function UWBP_RelicMenu_ForDisplay_C:GetLastRequestedRelicType(OutRelicType) end
function UWBP_RelicMenu_ForDisplay_C:CheckCompleteSynchronize() end
---@param Result EPalCharacterStatusOperationResult
function UWBP_RelicMenu_ForDisplay_C:OnReceiveResult(Result) end
function UWBP_RelicMenu_ForDisplay_C:TeardownEventBind() end
function UWBP_RelicMenu_ForDisplay_C:SetupEventBind() end
function UWBP_RelicMenu_ForDisplay_C:SetupCollectedRelics() end
function UWBP_RelicMenu_ForDisplay_C:OnSetup() end
function UWBP_RelicMenu_ForDisplay_C:Destruct() end
function UWBP_RelicMenu_ForDisplay_C:BndEvt__WBP_RelicMenu_ForDisplay_WBP_Buildup_Player_1_K2Node_ComponentBoundEvent_0_OnClickedConfirm__DelegateSignature() end
function UWBP_RelicMenu_ForDisplay_C:BndEvt__WBP_RelicMenu_ForDisplay_WBP_Buildup_Player_1_K2Node_ComponentBoundEvent_1_OnClickedCloseButton__DelegateSignature() end
function UWBP_RelicMenu_ForDisplay_C:Construct() end
---@param EntryPoint int32
function UWBP_RelicMenu_ForDisplay_C:ExecuteUbergraph_WBP_RelicMenu_ForDisplay(EntryPoint) end


