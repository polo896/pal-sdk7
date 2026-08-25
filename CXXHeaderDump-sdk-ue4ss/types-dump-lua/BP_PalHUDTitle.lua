---@meta

---@class ABP_PalHUDTitle_C : APalHUDInGame
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultSceneRoot USceneComponent
---@field TitleVerTextWidget UWBP_TitleVerText_C
---@field TimerHandle_DisplayVerTextWidget FTimerHandle
local ABP_PalHUDTitle_C = {}

function ABP_PalHUDTitle_C:OnTimerEvent_DelayDisplayVerText() end
---@param FadeWidgetLayerType EPalFadeWidgetLayerType
function ABP_PalHUDTitle_C:OnFadeOut(FadeWidgetLayerType) end
function ABP_PalHUDTitle_C:OnFadeIn() end
function ABP_PalHUDTitle_C:OnUpdateLiftSlot() end
---@param Loaded UClass
function ABP_PalHUDTitle_C:OnLoaded_981603EC4815B7D716BC83B5FE8C3FD0(Loaded) end
function ABP_PalHUDTitle_C:Initialize() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_PalHUDTitle_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_PalHUDTitle_C:ExecuteUbergraph_BP_PalHUDTitle(EntryPoint) end


