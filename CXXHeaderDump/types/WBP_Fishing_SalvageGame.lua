---@meta

---@class UWBP_Fishing_SalvageGame_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Miss UWidgetAnimation
---@field Anm_Success UWidgetAnimation
---@field Anm_Loop UWidgetAnimation
---@field Anm_In UWidgetAnimation
---@field Canvas_Needle_Rotate UCanvasPanel
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_577 UImage
---@field Image_648 UImage
---@field Image_702 UImage
---@field Image_Add UImage
---@field Image_Dot UImage
---@field Image_Dot_1 UImage
---@field Image_Dot_2 UImage
---@field Image_Dot_3 UImage
---@field Image_Dot_4 UImage
---@field Image_Dot_5 UImage
---@field Image_Dot_6 UImage
---@field Image_Dot_7 UImage
---@field Image_Flash UImage
---@field Image_Flash_1 UImage
---@field Image_Gauge_Area UImage
---@field Image_GaugeBase UImage
---@field Image_Glow UImage
---@field Image_Glow_Miss UImage
---@field Image_Glow_Success UImage
---@field Image_Grd UImage
---@field Image_Grd_1 UImage
---@field Image_Grd_2 UImage
---@field Image_Grd_3 UImage
---@field Image_L UImage
---@field Image_L_1 UImage
---@field Image_Needle UImage
---@field Image_R UImage
---@field Image_R_1 UImage
---@field Image_Ripple_0 UImage
---@field Image_Ripple_1 UImage
---@field Image_Ripple_2 UImage
---@field Image_Shadow UImage
---@field Text_Cancel UBP_PalTextBlock_C
---@field WBP_PalKeyGuideIcon_Cancel UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_Interact UWBP_PalKeyGuideIcon_C
local UWBP_Fishing_SalvageGame_C = {}

function UWBP_Fishing_SalvageGame_C:PlaySuccessAnimation() end
function UWBP_Fishing_SalvageGame_C:PlayFailedAnimation() end
function UWBP_Fishing_SalvageGame_C:PlayInAnimation() end
function UWBP_Fishing_SalvageGame_C:HideAnimation() end
---@param EntryPoint int32
function UWBP_Fishing_SalvageGame_C:ExecuteUbergraph_WBP_Fishing_SalvageGame(EntryPoint) end


