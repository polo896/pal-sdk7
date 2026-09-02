---@meta

---@class UWBP_OneStrokeGame_ForDisplay_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ComboBoxString_95 UComboBoxString
---@field Overlay_Debug UOverlay
---@field WBP_Minigame_OneStroke UWBP_Minigame_OneStroke_C
---@field MyGameProcessor UPalOneStrokeGameProcessor
---@field DataAsset UPalOneStrokeGameDataAsset
---@field CloseTimerHandle FTimerHandle
---@field ResetInputAction FPalDataTableRowName_UIInputAction
---@field bRestarting boolean
---@field ResetActionHandle FPalUIActionBindData
---@field bSuccessed boolean
---@field StuckTimer FTimerHandle
local UWBP_OneStrokeGame_ForDisplay_C = {}

function UWBP_OneStrokeGame_ForDisplay_C:OnTimerEvent_Stuck() end
function UWBP_OneStrokeGame_ForDisplay_C:OnStuck() end
function UWBP_OneStrokeGame_ForDisplay_C:RestartFlow() end
function UWBP_OneStrokeGame_ForDisplay_C:OnInputAction_Reset() end
function UWBP_OneStrokeGame_ForDisplay_C:UnregisterInoutAction() end
function UWBP_OneStrokeGame_ForDisplay_C:RegisterInputAction() end
function UWBP_OneStrokeGame_ForDisplay_C:OnTimerEvent_Close() end
---@param SettingKey FName
function UWBP_OneStrokeGame_ForDisplay_C:StartgameByKey_ForDebug(SettingKey) end
function UWBP_OneStrokeGame_ForDisplay_C:SetupDebug() end
---@param NewCurrentCoord FPalOneStrokeGridCoord
function UWBP_OneStrokeGame_ForDisplay_C:OnUndo(NewCurrentCoord) end
---@param Coord FPalOneStrokeGridCoord
---@param NewState EPalOneStrokeTileState
function UWBP_OneStrokeGame_ForDisplay_C:OnUpdateTileState(Coord, NewState) end
---@param NewPosition FPalOneStrokeGridCoord
function UWBP_OneStrokeGame_ForDisplay_C:OnUpdatePosition(NewPosition) end
function UWBP_OneStrokeGame_ForDisplay_C:StartGame() end
---@return UWidget
function UWBP_OneStrokeGame_ForDisplay_C:BP_GetDesiredFocusTarget() end
---@param TargetCoord FPalOneStrokeGridCoord
function UWBP_OneStrokeGame_ForDisplay_C:OnInvalidMove(TargetCoord) end
---@param FromCoord FPalOneStrokeGridCoord
---@param ToCoord FPalOneStrokeGridCoord
function UWBP_OneStrokeGame_ForDisplay_C:OnMove(FromCoord, ToCoord) end
function UWBP_OneStrokeGame_ForDisplay_C:OnFailGame() end
function UWBP_OneStrokeGame_ForDisplay_C:OnSuccessGame() end
---@param SettingData FPalOneStrokeGameSettingData
function UWBP_OneStrokeGame_ForDisplay_C:OnStartGame(SettingData) end
function UWBP_OneStrokeGame_ForDisplay_C:OnSetup() end
function UWBP_OneStrokeGame_ForDisplay_C:Destruct() end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_OneStrokeGame_ForDisplay_C:BndEvt__WBP_OneStrokeGame_ForDisplay_WBP_Minigame_OneStroke_K2Node_ComponentBoundEvent_0_OnClickedAnyPanel__DelegateSignature(Widget) end
---@param Widget UWBP_Minigame_OneStroke_Square_C
function UWBP_OneStrokeGame_ForDisplay_C:BndEvt__WBP_OneStrokeGame_ForDisplay_WBP_Minigame_OneStroke_K2Node_ComponentBoundEvent_1_OnHoveredAnyPanel__DelegateSignature(Widget) end
function UWBP_OneStrokeGame_ForDisplay_C:Construct() end
---@param SelectedItem FString
---@param SelectionType ESelectInfo::Type
function UWBP_OneStrokeGame_ForDisplay_C:BndEvt__WBP_OneStrokeGame_ForDisplay_ComboBoxString_95_K2Node_ComponentBoundEvent_3_OnSelectionChangedEvent__DelegateSignature(SelectedItem, SelectionType) end
function UWBP_OneStrokeGame_ForDisplay_C:BndEvt__WBP_OneStrokeGame_ForDisplay_WBP_Minigame_OneStroke_K2Node_ComponentBoundEvent_4_OnEndResetOutAnim__DelegateSignature() end
function UWBP_OneStrokeGame_ForDisplay_C:BndEvt__WBP_OneStrokeGame_ForDisplay_WBP_Minigame_OneStroke_K2Node_ComponentBoundEvent_5_OnEndOutAnim__DelegateSignature() end
---@param EntryPoint int32
function UWBP_OneStrokeGame_ForDisplay_C:ExecuteUbergraph_WBP_OneStrokeGame_ForDisplay(EntryPoint) end


