---@meta

---@class UWBP_PalSpectatorHUD_C : UPalUserWidgetStackableUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Text_PlayerName UBP_PalTextBlock_C
---@field Text_UserId UBP_PalTextBlock_C
---@field WBP_Ingame_Chat_Wrapper UWBP_Ingame_Chat_Wrapper_C
---@field ActionNameEscape FPalDataTableRowName_UIInputAction
---@field ActionNameOpenMenu FPalDataTableRowName_UIInputAction
---@field ActionNameSpectatePrevPlayer FPalDataTableRowName_UIInputAction
---@field ActionNameSpectateNextPlayer FPalDataTableRowName_UIInputAction
---@field ActionNameSpectateFreely FPalDataTableRowName_UIInputAction
---@field ActionNameIncreaseSpecateMoveSpeed FPalDataTableRowName_UIInputAction
---@field ActionNameDecreaseSpecateMoveSpeed FPalDataTableRowName_UIInputAction
---@field ActionNameSetHUDVisible FPalDataTableRowName_UIInputAction
---@field ActionNameMoveUp FPalDataTableRowName_UIInputAction
---@field ActionNameMoveDown FPalDataTableRowName_UIInputAction
---@field bIsHUDVisible boolean
---@field DelayedSetupTimerHandle FTimerHandle
---@field ActionNameOpenChat FPalDataTableRowName_UIInputAction
---@field BindDataActionNameMoveDown FPalUIActionBindData
---@field BindDataActionNameMoveUp FPalUIActionBindData
---@field BindDataActionNameEscape FPalUIActionBindData
---@field BindDataActionNameSetHUDVisible FPalUIActionBindData
---@field BindDataActionNameIncreaseSpecateMoveSpeed FPalUIActionBindData
---@field BindDataActionNameDecreaseSpecateMoveSpeed FPalUIActionBindData
---@field BindDataActionNameOpenChat FPalUIActionBindData
---@field BindDataActionNameSpectatePrevPlayer FPalUIActionBindData
---@field BindDataActionNameSpectateNextPlayer FPalUIActionBindData
---@field BindDataActionNameSpectateFreely FPalUIActionBindData
---@field BindDataActionNameOpenMenu FPalUIActionBindData
---@field UpdateViewPortWidgetsVisibilityTimerHandle FTimerHandle
local UWBP_PalSpectatorHUD_C = {}

---@param PlayerName FString
---@param NickName FString
---@param PlayerUId FString
---@param UserId FString
function UWBP_PalSpectatorHUD_C:OnSpectateNextPlayer(PlayerName, NickName, PlayerUId, UserId) end
---@param Visibility ESlateVisibility
function UWBP_PalSpectatorHUD_C:SetViewportWidgetsVisiblity(Visibility) end
function UWBP_PalSpectatorHUD_C:RequestOpenChat() end
---@param bIsHide boolean
---@param LayerTagName FGameplayTag
function UWBP_PalSpectatorHUD_C:SetUILayerVisibility(bIsHide, LayerTagName) end
function UWBP_PalSpectatorHUD_C:DoNothing() end
function UWBP_PalSpectatorHUD_C:SetHUDVisible() end
function UWBP_PalSpectatorHUD_C:OpenMenu() end
function UWBP_PalSpectatorHUD_C:DecreaseSpectateMoveSpeed() end
function UWBP_PalSpectatorHUD_C:IncreaseSpectateMoveSpeed() end
function UWBP_PalSpectatorHUD_C:SpectateFreely() end
function UWBP_PalSpectatorHUD_C:SpectatePrevPlayer() end
function UWBP_PalSpectatorHUD_C:SpectateNextPlayer() end
function UWBP_PalSpectatorHUD_C:EndSpectate() end
function UWBP_PalSpectatorHUD_C:UnRegisterInputActions() end
function UWBP_PalSpectatorHUD_C:RegisterInputActions() end
function UWBP_PalSpectatorHUD_C:OnSetup() end
function UWBP_PalSpectatorHUD_C:OnClosed() end
function UWBP_PalSpectatorHUD_C:DelayedSetup() end
function UWBP_PalSpectatorHUD_C:UpdateViewPortWidgetsVisibility() end
---@param EntryPoint int32
function UWBP_PalSpectatorHUD_C:ExecuteUbergraph_WBP_PalSpectatorHUD(EntryPoint) end


