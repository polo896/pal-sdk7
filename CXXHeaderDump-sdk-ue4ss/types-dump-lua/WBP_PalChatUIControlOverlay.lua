---@meta

---@class UWBP_PalChatUIControlOverlay_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ControllChatUI UWBP_Ingame_Chat_C
---@field ChageCategoryChatActionName FPalDataTableRowName_UIInputAction
---@field CancelActionHandle_Default FPalDataTableRowName_UIInputAction
---@field CancelActionHandle_Escape FPalDataTableRowName_UIInputAction
---@field SendChatActionhandle FPalDataTableRowName_UIInputAction
---@field ResetFocusActionName FPalDataTableRowName_UIInputAction
local UWBP_PalChatUIControlOverlay_C = {}

function UWBP_PalChatUIControlOverlay_C:SendChat() end
UWBP_PalChatUIControlOverlay_C['On Cancel Force Close'] = function(self, ) end
function UWBP_PalChatUIControlOverlay_C:OnCancel_ForPad() end
function UWBP_PalChatUIControlOverlay_C:OnCompletedChatInput() end
function UWBP_PalChatUIControlOverlay_C:ChangeChatCategory() end
---@return UWidget
function UWBP_PalChatUIControlOverlay_C:BP_GetDesiredFocusTarget() end
function UWBP_PalChatUIControlOverlay_C:Destruct() end
function UWBP_PalChatUIControlOverlay_C:OnSetup() end
function UWBP_PalChatUIControlOverlay_C:OnClose() end
function UWBP_PalChatUIControlOverlay_C:OnResetFocus() end
---@param EntryPoint int32
function UWBP_PalChatUIControlOverlay_C:ExecuteUbergraph_WBP_PalChatUIControlOverlay(EntryPoint) end


