---@meta

---@class UWBP_Ingame_WeaponChangeList_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field HorizontalBox_NowBulletNum_1 UHorizontalBox
---@field Icon_Weapon UImage
---@field Image_Infinity_1 UImage
---@field Text_NowBulletNum_1 UBP_PalTextBlock_C
---@field Text_WeaponName UBP_PalTextBlock_C
---@field WBP_PlayerInputKeyGuideIcon_4 UWBP_PlayerInputKeyGuideIcon_C
---@field NoWeaponMsgId FDataTableRowHandle
local UWBP_Ingame_WeaponChangeList_C = {}

---@param WeaponSlot UPalItemSlot
---@param BulletCount int32
function UWBP_Ingame_WeaponChangeList_C:GetDisplayBulletCount(WeaponSlot, BulletCount) end
---@param WeaponSlot UPalItemSlot
function UWBP_Ingame_WeaponChangeList_C:UpdateDisplayBulletCount(WeaponSlot) end
---@param WeaponSlot UPalItemSlot
function UWBP_Ingame_WeaponChangeList_C:SetWeaponSlot(WeaponSlot) end
function UWBP_Ingame_WeaponChangeList_C:AnmEvent_Focus() end
function UWBP_Ingame_WeaponChangeList_C:AnmEvent_Unfocus() end
---@param EntryPoint int32
function UWBP_Ingame_WeaponChangeList_C:ExecuteUbergraph_WBP_Ingame_WeaponChangeList(EntryPoint) end


