---@meta

---@class UWBP_PalOverallUILayout_C : UPalPrimaryGameLayoutBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanel_3 UCanvasPanel
---@field CanvasPanel_Fade UCanvasPanel
---@field CanvasPanel_Root UCanvasPanel
---@field Layer_0 UPalActivatableWidgetContainer
---@field Layer_1 UPalActivatableWidgetContainer
---@field Layer_2 UPalActivatableWidgetContainer
---@field Layer_3 UPalActivatableWidgetContainer
---@field Layer_4 UPalActivatableWidgetContainer
---@field Layer_5 UPalActivatableWidgetContainer
---@field Layer_6 UPalActivatableWidgetContainer
---@field Layer_7 UPalActivatableWidgetContainer
---@field Menu UPalActivatableWidgetContainer
---@field Modal UPalActivatableWidgetContainer
---@field NetworkIcon UWBP_NetworkIcon_C
---@field SizeBox_0 USizeBox
---@field VerticalBox_CommonWarning UVerticalBox
---@field WBP_AutoSave UWBP_AutoSave_C
---@field WBP_CommonReward UWBP_CommonReward_C
---@field WBP_InventoryEquipment_ItemInfo UWBP_InventoryEquipment_ItemInfo_C
---@field WBP_MainMenu_Cursor UWBP_MainMenu_Cursor_C
---@field WBP_MainMenu_Pal_ElementMatchup UWBP_MainMenu_Pal_ElementMatchup_C
---@field WBP_PalActionBar_C_8 UWBP_PalActionBar_C
---@field WBP_PalLiftItem UWBP_PalLiftItem_C
---@field FadeWidgetCanvasMap TMap<EPalFadeWidgetLayerType, UCanvasPanel>
---@field FadeWidgetMap TMap<EPalFadeWidgetType, TSubclassOf<UWBP_PalFadeWidgetBase_C>>
---@field WaitFadeInLayers TArray<EPalFadeWidgetLayerType>
---@field LiftSlotModel UPalUILiftSlotModel
---@field CursorTargetWidget TSoftObjectPtr<UWidget>
---@field WarningWidgets TMap<FGuid, UWBP_CommonWarning_C>
---@field DelayDisplayTimer FTimerHandle
---@field SoundIDMap TMap<EPalUICommonWarningType, int32>
---@field RegistedWarningSound TArray<EPalUICommonWarningType>
---@field FadeInPendingCount int32
local UWBP_PalOverallUILayout_C = {}

---@param WarningType EPalUICommonWarningType
function UWBP_PalOverallUILayout_C:CREATEDELEGATE_PROXYFUNCTION_0(WarningType) end
---@return boolean
function UWBP_PalOverallUILayout_C:IsAnyFadeWidgetActive() end
function UWBP_PalOverallUILayout_C:CheckPause() end
function UWBP_PalOverallUILayout_C:UpdateCursor() end
function UWBP_PalOverallUILayout_C:OnInitialized() end
---@param TargetWidget UWidget
function UWBP_PalOverallUILayout_C:ShowFocusCursor(TargetWidget) end
function UWBP_PalOverallUILayout_C:HideFocusCursor() end
---@param LayerType EPalFadeWidgetLayerType
function UWBP_PalOverallUILayout_C:FadeIn(LayerType) end
---@param DisplayData FPalUICommonItemInfoDisplayData
function UWBP_PalOverallUILayout_C:ShowCommonItemInfo(DisplayData) end
function UWBP_PalOverallUILayout_C:HideCommonItemInfo() end
function UWBP_PalOverallUILayout_C:ShowLiftIcon() end
function UWBP_PalOverallUILayout_C:HideLiftIcon() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalOverallUILayout_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_PalOverallUILayout_C:SetupLiftIcon() end
---@param RewardDisplayData FPalUICommonRewardDisplayData
function UWBP_PalOverallUILayout_C:ShowCommonReward(RewardDisplayData) end
---@param LayerType EPalFadeWidgetLayerType
---@param FadeParameter UPalHUDDispatchParameter_FadeWidget
function UWBP_PalOverallUILayout_C:FadeOut(LayerType, FadeParameter) end
function UWBP_PalOverallUILayout_C:HideCommonReward() end
---@param WarningDisplayData FPalUICommonWarningDisplayData
function UWBP_PalOverallUILayout_C:ShowCommonWarning(WarningDisplayData) end
---@param PreserveID FGuid
function UWBP_PalOverallUILayout_C:HideCommonWarning(PreserveID) end
function UWBP_PalOverallUILayout_C:DelayDisplay() end
---@param WarningType EPalUICommonWarningType
function UWBP_PalOverallUILayout_C:OnWarningClear(WarningType) end
function UWBP_PalOverallUILayout_C:HideOnEmpty() end
---@param NewVisibility ESlateVisibility
function UWBP_PalOverallUILayout_C:SetVisibilityRootLayout(NewVisibility) end
---@param RelativeWidget UWidget
---@param AnchorPosition FVector2D
function UWBP_PalOverallUILayout_C:ShowElementMatchUI(RelativeWidget, AnchorPosition) end
function UWBP_PalOverallUILayout_C:HideElementMatchUI() end
UWBP_PalOverallUILayout_C['OnEndFadeIn_イベント'] = function(self, ) end
---@param EntryPoint int32
function UWBP_PalOverallUILayout_C:ExecuteUbergraph_WBP_PalOverallUILayout(EntryPoint) end


