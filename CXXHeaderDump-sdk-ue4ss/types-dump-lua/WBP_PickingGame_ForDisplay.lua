---@meta

---@class UWBP_PickingGame_ForDisplay_C : UPalUIPickingGame
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_SetPick UWidgetAnimation
---@field Anm_Fail UWidgetAnimation
---@field Anm_In UWidgetAnimation
---@field Anm_Success UWidgetAnimation
---@field Anm_KeyShake UWidgetAnimation
---@field BP_PalTextBlock_Hold UBP_PalTextBlock_C
---@field Canvas_Key UCanvasPanel
---@field Canvas_KeyHole UCanvasPanel
---@field Canvas_PickingTool UCanvasPanel
---@field Canvas_ResultText_Fail UCanvasPanel
---@field Canvas_ResultText_Success UCanvasPanel
---@field Image_Eff_RoundBlur UImage
---@field Image_Eff_Square_0 UImage
---@field Image_Eff_Square_1 UImage
---@field Image_Frame_Shadow UImage
---@field Image_Key UImage
---@field Image_KeyHole UImage
---@field Image_LockBase UImage
---@field Image_PickingTool UImage
---@field Text_Break UBP_PalTextBlock_C
---@field Text_Success UBP_PalTextBlock_C
---@field WBP_PalKeyGuideIcon_Cancel UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_TurnKey UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_TurnPick UWBP_PalKeyGuideIcon_C
---@field IsTurningKey boolean
---@field IsLeftInput boolean
---@field IsRightInput boolean
---@field IsStoppedKey boolean
---@field LastKeyPosition float
---@field KeyTurnSpeedCurve UCurveFloat
---@field KeyTurnTime double
---@field ToolMoveSpeedPerSecond double
---@field RestartTimer FTimerHandle
---@field ClearGameCloseTimer FTimerHandle
---@field IsClear boolean
---@field AnalogValue double
---@field KeyTurnStopForceFeedback UForceFeedbackComponent
---@field KeyHoleTextureMap TMap<EPalPickingGameDifficultyType, TSoftObjectPtr<UTexture2D>>
---@field CachedFinalAKETriggerToolPosition float
---@field BlockAKETriggerTImer FTimerHandle
---@field bIsBlockPickAKE boolean
---@field IsFailed boolean
local UWBP_PickingGame_ForDisplay_C = {}

function UWBP_PickingGame_ForDisplay_C:SequenceEvent__ENTRYPOINTWBP_PickingGame_ForDisplay_2() end
function UWBP_PickingGame_ForDisplay_C:SequenceEvent__ENTRYPOINTWBP_PickingGame_ForDisplay_1() end
function UWBP_PickingGame_ForDisplay_C:SequenceEvent__ENTRYPOINTWBP_PickingGame_ForDisplay_0() end
function UWBP_PickingGame_ForDisplay_C:SequenceEvent__ENTRYPOINTWBP_PickingGame_ForDisplay() end
---@param bResult boolean
function UWBP_PickingGame_ForDisplay_C:SetGameResult(bResult) end
---@return UPalPickingGameProcessor
function UWBP_PickingGame_ForDisplay_C:RegisterPickinGameProcessor() end
function UWBP_PickingGame_ForDisplay_C:StartForceFeedback() end
function UWBP_PickingGame_ForDisplay_C:StopForceFeedback() end
function UWBP_PickingGame_ForDisplay_C:CalcToolPosition_ForMouse() end
---@param DeltaTime double
---@param Speed double
function UWBP_PickingGame_ForDisplay_C:CalcToolTurnSpeed(DeltaTime, Speed) end
function UWBP_PickingGame_ForDisplay_C:OnTimer_ClearGame() end
function UWBP_PickingGame_ForDisplay_C:StopTurnPick_L() end
function UWBP_PickingGame_ForDisplay_C:StartTurnPick_L() end
function UWBP_PickingGame_ForDisplay_C:StopTurnPick_R() end
function UWBP_PickingGame_ForDisplay_C:StartTurnPick_R() end
function UWBP_PickingGame_ForDisplay_C:StopTurnKey() end
function UWBP_PickingGame_ForDisplay_C:StartTurnKey() end
---@param MyGeometry FGeometry
---@param InAnalogInputEvent FAnalogInputEvent
---@return FEventReply
function UWBP_PickingGame_ForDisplay_C:OnAnalogValueChanged(MyGeometry, InAnalogInputEvent) end
---@param bNewInputType ECommonInputType
function UWBP_PickingGame_ForDisplay_C:OnChangedInputMethod(bNewInputType) end
---@param DeltaTime double
---@param Speed double
function UWBP_PickingGame_ForDisplay_C:CalcKeyTurnSpeed(DeltaTime, Speed) end
function UWBP_PickingGame_ForDisplay_C:OnTimer_Restart() end
---@param MyGeometry FGeometry
---@param InKeyEvent FKeyEvent
---@return FEventReply
function UWBP_PickingGame_ForDisplay_C:OnKeyUp(MyGeometry, InKeyEvent) end
---@param MyGeometry FGeometry
---@param InKeyEvent FKeyEvent
---@return FEventReply
function UWBP_PickingGame_ForDisplay_C:OnKeyDown(MyGeometry, InKeyEvent) end
---@param NewSettingData FPalPickingGameSettingData
function UWBP_PickingGame_ForDisplay_C:OnStartGame(NewSettingData) end
function UWBP_PickingGame_ForDisplay_C:OnFailGame() end
function UWBP_PickingGame_ForDisplay_C:OnSuccessGame() end
---@param KeyPositon float
function UWBP_PickingGame_ForDisplay_C:OnUpdateKeyPosition(KeyPositon) end
---@param ToolPosition float
function UWBP_PickingGame_ForDisplay_C:OnUpdatePickingToolPosition(ToolPosition) end
function UWBP_PickingGame_ForDisplay_C:OnStopTurningKey() end
function UWBP_PickingGame_ForDisplay_C:UnbindEvent() end
function UWBP_PickingGame_ForDisplay_C:SetupEvent() end
function UWBP_PickingGame_ForDisplay_C:UpdateKeyHoleTexture() end
function UWBP_PickingGame_ForDisplay_C:SequenceEvent() end
function UWBP_PickingGame_ForDisplay_C:SequenceEvent_0() end
function UWBP_PickingGame_ForDisplay_C:SequenceEvent_1() end
function UWBP_PickingGame_ForDisplay_C:SequenceEvent_2() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PickingGame_ForDisplay_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_PickingGame_ForDisplay_C:OnSetup() end
function UWBP_PickingGame_ForDisplay_C:Destruct() end
---@param InFocusEvent FFocusEvent
function UWBP_PickingGame_ForDisplay_C:OnFocusLost(InFocusEvent) end
---@param InFocusEvent FFocusEvent
function UWBP_PickingGame_ForDisplay_C:OnRemovedFromFocusPath(InFocusEvent) end
function UWBP_PickingGame_ForDisplay_C:Construct() end
function UWBP_PickingGame_ForDisplay_C:PlayPickSound() end
UWBP_PickingGame_ForDisplay_C['カスタムイベント'] = function(self, ) end
---@param EntryPoint int32
function UWBP_PickingGame_ForDisplay_C:ExecuteUbergraph_WBP_PickingGame_ForDisplay(EntryPoint) end


