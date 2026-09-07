---@meta

---@class UWBP_Ingame_WeaponChange_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_In UWidgetAnimation
---@field VerticalBox_List UVerticalBox
---@field WBP_Ingame_WeaponChangeList UWBP_Ingame_WeaponChangeList_C
---@field WBP_Ingame_WeaponChangeList_1 UWBP_Ingame_WeaponChangeList_C
---@field WBP_Ingame_WeaponChangeList_2 UWBP_Ingame_WeaponChangeList_C
---@field WBP_Ingame_WeaponChangeList_3 UWBP_Ingame_WeaponChangeList_C
---@field WBP_Ingame_WeaponChangeList_4 UWBP_Ingame_WeaponChangeList_C
---@field WBP_Ingame_WeaponChangeList_5 UWBP_Ingame_WeaponChangeList_C
---@field ChangeWeaponNextAction FPalDataTableRowName_UIInputAction
---@field ChangeWeaponPrevAction FPalDataTableRowName_UIInputAction
---@field ChangeWeaponNextActionHandle FPalUIActionBindData
---@field ChangeWeaponPrevHandle FPalUIActionBindData
---@field WeaponListWidgetMap TMap<int32, UWBP_Ingame_WeaponChangeList_C>
---@field NonWeaponWidget UWBP_Ingame_WeaponChangeList_C
---@field CachedSelectedWeaponListWidget UWBP_Ingame_WeaponChangeList_C
---@field WeaponListToSlotMap TMap<UWBP_Ingame_WeaponChangeList_C, UPalItemSlot>
---@field BoundLoadoutConatiner UPalItemContainer
---@field LastSelectedWeaponActor APalWeaponBase
---@field bRefreshPending boolean
local UWBP_Ingame_WeaponChange_C = {}

function UWBP_Ingame_WeaponChange_C:RefreshWeaponList() end
function UWBP_Ingame_WeaponChange_C:UpdateAllBulletCount() end
function UWBP_Ingame_WeaponChange_C:OnInputAction_PrevWeapon() end
function UWBP_Ingame_WeaponChange_C:OnInputAction_NextWeapon() end
---@param WeaponActor APalWeaponBase
function UWBP_Ingame_WeaponChange_C:SelectWeapon(WeaponActor) end
function UWBP_Ingame_WeaponChange_C:UnregisterWeaponChangeAction() end
function UWBP_Ingame_WeaponChange_C:RegisterWeaponChangeAction() end
UWBP_Ingame_WeaponChange_C['Setup Weapon List'] = function(self, ) end
function UWBP_Ingame_WeaponChange_C:AnmEvent_In() end
function UWBP_Ingame_WeaponChange_C:AnmEvent_Out() end
---@param Container UPalItemContainer
function UWBP_Ingame_WeaponChange_C:OnWeaponLoadoutContaierUpdated(Container) end
---@param EntryPoint int32
function UWBP_Ingame_WeaponChange_C:ExecuteUbergraph_WBP_Ingame_WeaponChange(EntryPoint) end


