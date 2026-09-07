---@meta

---@class UWBP_TItle_C : UPalUITitleBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_Title_MenuBG UWBP_Title_MenuBG_C
---@field WBP_TitleMenu UWBP_TitleMenu_C
---@field ['Requested Privilege'] ECommonUserPrivilege
---@field CurrentLoadingScreen ULoadingProcessTask
---@field CurrentWidget UWBP_LoadingScreen_Transition_C
---@field RestartWithoutModsMsgId FDataTableRowHandle
---@field CrossPlayNetworkErrorMsgID FDataTableRowHandle
---@field TermsWindowParameter UPalHUDDispatchParameterBase
---@field TermsOfUseAgreementNumber int32
---@field SoftLastClickedButton TSoftObjectPtr<UWBP_Title_MenuButton_C>
---@field pushedWidgetID FGuid
---@field WaitCloudDownloadingWidgetId FGuid
---@field DiscordInvitePassword UWBP_Title_WorldSelect_OverlayWindow_InputCode_C
---@field IPAddressForDiscordInvitation FString
---@field PortForDiscordInvitation int32
---@field ModCautionWithExternalModsMsgId FDataTableRowHandle
local UWBP_TItle_C = {}

---@param bResult boolean
function UWBP_TItle_C:OnClosedDiskErrorDialog(bResult) end
function UWBP_TItle_C:OpenDiskSpaceErrorDialog() end
---@param bResult boolean
function UWBP_TItle_C:OnClosedLongPathErrorDialog(bResult) end
function UWBP_TItle_C:OpenLongPathErrorDialog() end
---@param bResult boolean
function UWBP_TItle_C:OnClosedModCautionWithExternalMods(bResult) end
function UWBP_TItle_C:OnCloudDownloadFinished() end
function UWBP_TItle_C:ProcessCloudDownload() end
---@param InMessage FString
---@param OutMessage FText
function UWBP_TItle_C:ConvertNetworkErrorMessage(InMessage, OutMessage) end
function UWBP_TItle_C:SetupForSteamDeck() end
---@param bResult boolean
function UWBP_TItle_C:WBP_TItle_AutoGenFunc(bResult) end
---@param bResult boolean
function UWBP_TItle_C:OnClosedQuitGameDialog(bResult) end
function UWBP_TItle_C:OpenQuitGameDialog() end
---@param ButtonWidget UWBP_Title_MenuButton_C
function UWBP_TItle_C:OnClickedMenu_Internal(ButtonWidget) end
---@return UWidget
function UWBP_TItle_C:BP_GetDesiredFocusTarget() end
---@param UserInfo UPocketpairUserInfo
---@param bSuccess boolean
---@param ErrorStr FString
function UWBP_TItle_C:Completed_0EC96F8E452B5A23D69FAFB13A8CD5AD(UserInfo, bSuccess, ErrorStr) end
---@param bIsReset boolean
---@param bCanPlay boolean
---@param MultiplayRestrictReason EPalMultiplayRestrictReason
function UWBP_TItle_C:OnCompleted_708D28F54D3FD418A6BB83B87E52AA52(bIsReset, bCanPlay, MultiplayRestrictReason) end
function UWBP_TItle_C:OnSetup() end
---@param ButtonWidget UWBP_Title_MenuButton_C
function UWBP_TItle_C:BndEvt__WBP_TItle_WBP_TitleMenu_K2Node_ComponentBoundEvent_6_OnClickedMenu__DelegateSignature(ButtonWidget) end
function UWBP_TItle_C:SwitchUser() end
---@param Param UPalHUDDispatchParameterBase
function UWBP_TItle_C:OnCloseTermsWindow(Param) end
function UWBP_TItle_C:Construct() end
---@param EuraCurrentVersion int32
function UWBP_TItle_C:OnCompleteGetEuraVersions(EuraCurrentVersion) end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_TItle_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_TItle_C:CheckModError() end
---@param IpAddress FString
---@param Port int32
function UWBP_TItle_C:InputPasswordForDiscordInvitation(IpAddress, Port) end
---@param Param UPalHUDDispatchParameterBase
UWBP_TItle_C['カスタムイベント'] = function(self, Param) end
---@param IpAddress FString
---@param Port int32
function UWBP_TItle_C:InputPasswordForXboxInvitation(IpAddress, Port) end
---@param Param UPalHUDDispatchParameterBase
UWBP_TItle_C['カスタムイベント_0'] = function(self, Param) end
function UWBP_TItle_C:StartLaunchErrorFlow() end
---@param EntryPoint int32
function UWBP_TItle_C:ExecuteUbergraph_WBP_TItle(EntryPoint) end


