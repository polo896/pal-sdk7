---@meta

---@class UWBP_BulletChangeList_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_DetailDisplay_Fade UWidgetAnimation
---@field Anm_DetailDisplay_Force UWidgetAnimation
---@field Anm_SimpleDisplay_Fade UWidgetAnimation
---@field Anm_SimpleDisplay_Force UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field Image_Frame UImage
---@field Text_Name UBP_PalTextBlock_C
---@field Text_Num UBP_PalTextBlock_C
---@field WBP_PalInGameMenuItemIcon UWBP_PalInGameMenuItemIcon_C
---@field MyBulletItemId FName
local UWBP_BulletChangeList_C = {}

---@param ItemId FName
function UWBP_BulletChangeList_C:GetBulletItemId(ItemId) end
---@param BulletItemId FName
function UWBP_BulletChangeList_C:Setup(BulletItemId) end
function UWBP_BulletChangeList_C:AnmEvent_Focus() end
function UWBP_BulletChangeList_C:AnmEvent_Unfocus() end
---@param bSkipAnimation boolean
function UWBP_BulletChangeList_C:AnmEvent_SimpleDisplay(bSkipAnimation) end
---@param bSkipAnimatio boolean
function UWBP_BulletChangeList_C:AnmEvent_DetailDisplay(bSkipAnimatio) end
---@param EntryPoint int32
function UWBP_BulletChangeList_C:ExecuteUbergraph_WBP_BulletChangeList(EntryPoint) end


