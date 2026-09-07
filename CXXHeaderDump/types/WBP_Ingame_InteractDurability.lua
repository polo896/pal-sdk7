---@meta

---@class UWBP_Ingame_InteractDurability_C : UPalUIMapObjectHPWorldHUD
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Color_NormalToLittle UWidgetAnimation
---@field Horizontal_PlayerName UHorizontalBox
---@field Image UImage
---@field ProgressBar_HP UProgressBar
---@field Text_GuildName UBP_PalTextBlock_C
---@field Text_HP_Current UBP_PalTextBlock_C
---@field Text_HP_MAX UBP_PalTextBlock_C
---@field Text_PlayerName UBP_PalTextBlock_C
---@field VerticalBox_BuildingNameRoot UVerticalBox
---@field DamegeReacted boolean
---@field CurrentHP double
---@field Model UPalMapObjectModel
---@field ['Cache Player UId'] FGuid
---@field ['Cache Player Name'] FString
---@field ['Cache Success'] boolean
---@field bNeedApplyUserInfo boolean
---@field bIsFirstApply boolean
---@field ['Cache Mute Player'] boolean
---@field ['Cache Group Id'] FGuid
---@field ['Cache Guild Name'] FString
local UWBP_Ingame_InteractDurability_C = {}

UWBP_Ingame_InteractDurability_C['Set Hidden Building Info'] = function(self, ) end
---@param PlayerUId FGuid
---@param NewNickName FString
---@param GroupId FGuid
---@param GuildName FString
UWBP_Ingame_InteractDurability_C['On Player Nick Name Updated'] = function(self, PlayerUId, NewNickName, GroupId, GuildName) end
---@param bSuccess boolean
---@param PlayerUId FGuid
---@param PlayerName FString
---@param GroupId FGuid
---@param GuildName FString
UWBP_Ingame_InteractDurability_C['On Get User Info Completed'] = function(self, bSuccess, PlayerUId, PlayerName, GroupId, GuildName) end
---@param UserId FString
---@param ChangeType EPalSessionMemberChange
function UWBP_Ingame_InteractDurability_C:OnSessionMemberChange(UserId, ChangeType) end
---@param InUserId FString
---@param OutResult boolean
---@param OutPlayerUId FGuid
function UWBP_Ingame_InteractDurability_C:GetBlockPlayerUIdByUserId(InUserId, OutResult, OutPlayerUId) end
---@param InUserId FString
---@param OutResult boolean
---@param OutPlayerUId FGuid
function UWBP_Ingame_InteractDurability_C:GetMutePlayerUIdByUserId(InUserId, OutResult, OutPlayerUId) end
---@param OutPlayerUId FGuid
function UWBP_Ingame_InteractDurability_C:GetPlayerUId(OutPlayerUId) end
---@param PlayerUId FGuid
function UWBP_Ingame_InteractDurability_C:UpdateNameInternal(PlayerUId) end
---@param CurrentHP double
---@param MaxHP double
UWBP_Ingame_InteractDurability_C['Update HP Internal'] = function(self, CurrentHP, MaxHP) end
function UWBP_Ingame_InteractDurability_C:OnSetup() end
---@param MapObject APalMapObject
---@param DisplayType EPalHUDDisplayType
function UWBP_Ingame_InteractDurability_C:ShowHP(MapObject, DisplayType) end
---@param Model UPalMapObjectModel
function UWBP_Ingame_InteractDurability_C:UpdateHP(Model) end
function UWBP_Ingame_InteractDurability_C:CollapsePanel() end
---@param CurrentHP float
---@param MaxHP float
function UWBP_Ingame_InteractDurability_C:OnCannonHPUpdate(CurrentHP, MaxHP) end
---@param Model UPalMapObjectModel
function UWBP_Ingame_InteractDurability_C:UpdateName(Model) end
function UWBP_Ingame_InteractDurability_C:OnClosed() end
---@param TextValue FString
function UWBP_Ingame_InteractDurability_C:OnUpdateSignboardText(TextValue) end
---@param EntryPoint int32
function UWBP_Ingame_InteractDurability_C:ExecuteUbergraph_WBP_Ingame_InteractDurability(EntryPoint) end


