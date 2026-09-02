---@meta

---@class UWBP_PalArenaSpectatorHUD_C : UPalUserWidgetStackableUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_PlayerName UBP_PalTextBlock_C
---@field CanvasPanel_PlayerName UCanvasPanel
---@field Image_1 UImage
---@field Image_Base UImage
---@field WBP_Ingame_Chat_Wrapper UWBP_Ingame_Chat_Wrapper_C
---@field WBP_PalKeyGuideIconAndText_Exit UWBP_PalKeyGuideIconAndText_C
---@field WBP_PalKeyGuideIconAndText_Free UWBP_PalKeyGuideIconAndText_C
---@field WBP_PalKeyGuideIconAndText_Player UWBP_PalKeyGuideIconAndText_C
---@field WBP_PalKeyGuideIconAndText_TopDown UWBP_PalKeyGuideIconAndText_C
---@field ActionNameEscape FPalDataTableRowName_UIInputAction
---@field ActionNameSpectateNextPlayer FPalDataTableRowName_UIInputAction
---@field ActionNameSpectateFreely FPalDataTableRowName_UIInputAction
---@field DelayedSetupTimerHandle FTimerHandle
---@field ActionNameOpenChat FPalDataTableRowName_UIInputAction
---@field BindDataActionNameEscape FPalUIActionBindData
---@field BindDataActionNameOpenChat FPalUIActionBindData
---@field BinDataActionNameSpectateNextPlayer FPalUIActionBindData
---@field BindDataActionNameSpectateFreely FPalUIActionBindData
---@field ActionNameSpectateTopDown FPalDataTableRowName_UIInputAction
---@field BindDataActionNameTopDown FPalUIActionBindData
local UWBP_PalArenaSpectatorHUD_C = {}

---@param PlayerName FString
---@param IndexType EPalArenaPlayerIndex
UWBP_PalArenaSpectatorHUD_C['On Spectate Next Player'] = function(self, PlayerName, IndexType) end
---@param bIsHide boolean
---@param LayerTagName FGameplayTag
function UWBP_PalArenaSpectatorHUD_C:SetUILayerVisibility(bIsHide, LayerTagName) end
function UWBP_PalArenaSpectatorHUD_C:UnRegisterInputActions() end
function UWBP_PalArenaSpectatorHUD_C:RegisterInputActions() end
function UWBP_PalArenaSpectatorHUD_C:RequestOpenChat() end
UWBP_PalArenaSpectatorHUD_C['Spectate TopDown'] = function(self, ) end
function UWBP_PalArenaSpectatorHUD_C:SpectateFreely() end
function UWBP_PalArenaSpectatorHUD_C:SpectateNextPlayer() end
function UWBP_PalArenaSpectatorHUD_C:EndSpectate() end
function UWBP_PalArenaSpectatorHUD_C:OnSetup() end
function UWBP_PalArenaSpectatorHUD_C:OnClosed() end
---@param EntryPoint int32
function UWBP_PalArenaSpectatorHUD_C:ExecuteUbergraph_WBP_PalArenaSpectatorHUD(EntryPoint) end


