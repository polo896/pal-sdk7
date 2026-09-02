---@meta

---@class UWBP_IngameConstruction_Paint_Color_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_ColorUpdate UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field Horizontal_KeyGuide UHorizontalBox
---@field Image UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_4 UImage
---@field Image_5 UImage
---@field Image_6 UImage
---@field Image_7 UImage
---@field Image_50 UImage
---@field Image_81 UImage
---@field Image_Color UImage
---@field Image_Frame UImage
---@field Image_Frame_Focus UImage
---@field Image_GuideIconShadow UImage
---@field Image_Icon UImage
---@field WBP_PlayerInputKeyGuideIcon_0 UWBP_PlayerInputKeyGuideIcon_C
local UWBP_IngameConstruction_Paint_Color_C = {}

---@param Info FFPalUIPaintPaletteInfo
function UWBP_IngameConstruction_Paint_Color_C:SetPaletteInfo(Info) end
function UWBP_IngameConstruction_Paint_Color_C:UnSelect() end
function UWBP_IngameConstruction_Paint_Color_C:Select() end
function UWBP_IngameConstruction_Paint_Color_C:PlayAnimatio_Select() end
function UWBP_IngameConstruction_Paint_Color_C:PlayAnimation_Unselect() end
function UWBP_IngameConstruction_Paint_Color_C:PlayAnimation_ChangeColor() end
---@param EntryPoint int32
function UWBP_IngameConstruction_Paint_Color_C:ExecuteUbergraph_WBP_IngameConstruction_Paint_Color(EntryPoint) end


