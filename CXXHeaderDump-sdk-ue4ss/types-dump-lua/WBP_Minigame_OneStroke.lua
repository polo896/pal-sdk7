---@meta

---@class UWBP_Minigame_OneStroke_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Retry_In UWidgetAnimation
---@field Anm_Retry_Out UWidgetAnimation
---@field Anm_Success UWidgetAnimation
---@field Anm_In UWidgetAnimation
---@field Canvas_ResultText_Fail UCanvasPanel
---@field Canvas_ResultText_Success UCanvasPanel
---@field UniformGridPanel_Square UUniformGridPanel
---@field WBP_Minigame_OneStroke_Square_0_0 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_0_1 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_0_2 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_0_3 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_0_4 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_1_0 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_1_1 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_1_2 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_1_3 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_1_4 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_2_0 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_2_1 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_2_2 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_2_3 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_2_4 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_3_0 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_3_1 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_3_2 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_3_3 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_3_4 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_4_0 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_4_1 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_4_2 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_4_3 UWBP_Minigame_OneStroke_Square_C
---@field WBP_Minigame_OneStroke_Square_4_4 UWBP_Minigame_OneStroke_Square_C
---@field WBP_PalKeyGuideIcon_Cancel UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_Move UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_Reset UWBP_PalKeyGuideIcon_C
---@field PanelArray TArray<UWBP_Minigame_OneStroke_Square_C>
---@field OriginalGridData TArray<FPalOneStrokeTileInfo>
---@field MyGridSize int32
---@field OnClickedAnyPanel FWBP_Minigame_OneStroke_COnClickedAnyPanel
---@field OnHoveredAnyPanel FWBP_Minigame_OneStroke_COnHoveredAnyPanel
---@field WaitResetOutAnimationHandle FTimerHandle
---@field OnEndResetOutAnim FWBP_Minigame_OneStroke_COnEndResetOutAnim
---@field OnEndOutAnim FWBP_Minigame_OneStroke_COnEndOutAnim
---@field WaitResetInAnimationHandle FTimerHandle
---@field WaitEndAnimationHandle FTimerHandle
---@field MyProcessor UPalOneStrokeGameProcessor
---@field lastHoveredPanel UWBP_Minigame_OneStroke_Square_C
local UWBP_Minigame_OneStroke_C = {}

---@param Target UWidget
function UWBP_Minigame_OneStroke_C:GetStartPointFocusTarget(Target) end
---@param Coord FPalOneStrokeGridCoord
function UWBP_Minigame_OneStroke_C:GetCurrentOrLastHoveredPanelCoord(Coord) end
---@param Offset FPalOneStrokeGridCoord
---@param Target UWidget
function UWBP_Minigame_OneStroke_C:GetFocusTargetByCoordOffset(Offset, Target) end
---@param CoordOffset FPalOneStrokeGridCoord
---@param bCanMove boolean
function UWBP_Minigame_OneStroke_C:CanMoveTo(CoordOffset, bCanMove) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Minigame_OneStroke_C:DoCustomNavi_Down(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Minigame_OneStroke_C:DoCustomNavi_Up(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Minigame_OneStroke_C:DoCustomNavi_Right(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Minigame_OneStroke_C:DoCustomNavi_Left(Navigation) end
---@param Processor UPalOneStrokeGameProcessor
function UWBP_Minigame_OneStroke_C:RegisterProcessor(Processor) end
function UWBP_Minigame_OneStroke_C:OnTimerEvent_EndResetInAnim() end
function UWBP_Minigame_OneStroke_C:OnTImerEvent_EndOutAnimation() end
function UWBP_Minigame_OneStroke_C:OnTimerEvent_EndResetOutAnim() end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_Minigame_OneStroke_C:OnHoveredPanel(Widget) end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_Minigame_OneStroke_C:OnClickedPanel(Widget) end
---@param Coord FPalOneStrokeGridCoord
---@param NewState EPalOneStrokeTileState
function UWBP_Minigame_OneStroke_C:OverrideTileState(Coord, NewState) end
---@param Coord FPalOneStrokeGridCoord
---@param PanelWidget UWBP_Minigame_OneStroke_Square_C
function UWBP_Minigame_OneStroke_C:GetPanelByCoord(Coord, PanelWidget) end
---@param Target UWidget
function UWBP_Minigame_OneStroke_C:GetTopLeftPanelFocusTarget(Target) end
function UWBP_Minigame_OneStroke_C:ClearGrid() end
function UWBP_Minigame_OneStroke_C:ResetGrid() end
---@param NewGridData TArray<FPalOneStrokeTileInfo>
---@param GridSize int32
function UWBP_Minigame_OneStroke_C:SetNewGrid(NewGridData, GridSize) end
function UWBP_Minigame_OneStroke_C:AnmEvent_Clear() end
function UWBP_Minigame_OneStroke_C:AnmEvent_Out() end
function UWBP_Minigame_OneStroke_C:AnmEvent_In() end
function UWBP_Minigame_OneStroke_C:AnmEvent_ResetFlow() end
function UWBP_Minigame_OneStroke_C:AnmEvent_ResetIn() end
function UWBP_Minigame_OneStroke_C:AnmEvent_InstantReset() end
function UWBP_Minigame_OneStroke_C:Destruct() end
function UWBP_Minigame_OneStroke_C:Construct() end
---@param EntryPoint int32
function UWBP_Minigame_OneStroke_C:ExecuteUbergraph_WBP_Minigame_OneStroke(EntryPoint) end
function UWBP_Minigame_OneStroke_C:OnEndOutAnim__DelegateSignature() end
function UWBP_Minigame_OneStroke_C:OnEndResetOutAnim__DelegateSignature() end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_Minigame_OneStroke_C:OnHoveredAnyPanel__DelegateSignature(Widget) end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_Minigame_OneStroke_C:OnClickedAnyPanel__DelegateSignature(Widget) end


