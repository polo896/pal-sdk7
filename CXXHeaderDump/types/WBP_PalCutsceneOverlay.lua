---@meta

---@class UWBP_PalCutsceneOverlay_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Horizontal_SkipCount UHorizontalBox
---@field Image_46 UImage
---@field Image_Base UImage
---@field TextBlock_SkipCount UBP_PalTextBlock_C
---@field SkipInput FPalDataTableRowName_UIInputAction
---@field HideTimerHandle FTimerHandle
---@field InputActionHandle FPalUIActionBindData
---@field isDisplaying boolean
local UWBP_PalCutsceneOverlay_C = {}

---@return UWidget
function UWBP_PalCutsceneOverlay_C:BP_GetDesiredFocusTarget() end
---@param MyGeometry FGeometry
---@param InAnalogInputEvent FAnalogInputEvent
---@return FEventReply
function UWBP_PalCutsceneOverlay_C:OnAnalogValueChanged(MyGeometry, InAnalogInputEvent) end
---@param MyGeometry FGeometry
---@param MouseEvent FPointerEvent
---@return FEventReply
function UWBP_PalCutsceneOverlay_C:OnPreviewMouseButtonDown(MyGeometry, MouseEvent) end
function UWBP_PalCutsceneOverlay_C:Hide() end
function UWBP_PalCutsceneOverlay_C:Display() end
---@param MyGeometry FGeometry
---@param InKeyEvent FKeyEvent
---@return FEventReply
function UWBP_PalCutsceneOverlay_C:OnPreviewKeyDown(MyGeometry, InKeyEvent) end
function UWBP_PalCutsceneOverlay_C:Skip() end
function UWBP_PalCutsceneOverlay_C:Destruct() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalCutsceneOverlay_C:Tick(MyGeometry, InDeltaTime) end
---@param SkipCount int32
---@param TotalCount int32
UWBP_PalCutsceneOverlay_C['OnSkipCountUpdatedDelegate_イベント'] = function(self, SkipCount, TotalCount) end
function UWBP_PalCutsceneOverlay_C:OnSetup() end
function UWBP_PalCutsceneOverlay_C:OnClose() end
---@param EntryPoint int32
function UWBP_PalCutsceneOverlay_C:ExecuteUbergraph_WBP_PalCutsceneOverlay(EntryPoint) end


