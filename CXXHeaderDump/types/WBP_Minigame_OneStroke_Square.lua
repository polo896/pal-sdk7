---@meta

---@class UWBP_Minigame_OneStroke_Square_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_Highlight UImage
---@field Image_Square UImage
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OriginalState EPalOneStrokeTileState
---@field OnClicked FWBP_Minigame_OneStroke_Square_COnClicked
---@field OverridedState EPalOneStrokeTileState
---@field MyCoord FPalOneStrokeGridCoord
---@field OnHovered FWBP_Minigame_OneStroke_Square_COnHovered
local UWBP_Minigame_OneStroke_Square_C = {}

---@param Coord FPalOneStrokeGridCoord
function UWBP_Minigame_OneStroke_Square_C:GetCoord(Coord) end
---@param Coord FPalOneStrokeGridCoord
function UWBP_Minigame_OneStroke_Square_C:SetPanelCoord(Coord) end
---@param OutState EPalOneStrokeTileState
function UWBP_Minigame_OneStroke_Square_C:GetCurrentState(OutState) end
---@param OutState EPalOneStrokeTileState
function UWBP_Minigame_OneStroke_Square_C:GetOriginalState(OutState) end
function UWBP_Minigame_OneStroke_Square_C:ResetState() end
---@param NewTileState EPalOneStrokeTileState
function UWBP_Minigame_OneStroke_Square_C:ChangeTextureInternal(NewTileState) end
---@param NewTileState EPalOneStrokeTileState
function UWBP_Minigame_OneStroke_Square_C:OverrideState(NewTileState) end
---@param NewTileState EPalOneStrokeTileState
function UWBP_Minigame_OneStroke_Square_C:SetOriginalState(NewTileState) end
---@param Button UCommonButtonBase
function UWBP_Minigame_OneStroke_Square_C:BndEvt__WBP_Minigame_OneStroke_Square_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Minigame_OneStroke_Square_C:BndEvt__WBP_Minigame_OneStroke_Square_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Minigame_OneStroke_Square_C:ExecuteUbergraph_WBP_Minigame_OneStroke_Square(EntryPoint) end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_Minigame_OneStroke_Square_C:OnHovered__DelegateSignature(Widget) end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_Minigame_OneStroke_Square_C:OnClicked__DelegateSignature(Widget) end


