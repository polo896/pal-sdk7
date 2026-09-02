---@meta

---@class UWBP_PalInteractiveObjectIndicatorCanvas_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Default_In UWidgetAnimation
---@field AdditionalWidgetBOx UVerticalBox
---@field CanvasPanel_1 UCanvasPanel
---@field Image UImage
---@field Image_78 UImage
---@field IndicatorVerticalBox UVerticalBox
---@field Overlay_CustomName UOverlay
---@field Text_InteractTargetName UBP_PalTextBlock_C
---@field IndicatorUIs TMap<EPalInteractiveObjectActionType, UWBP_PalInteractiveObjectIndicatorUI_C>
---@field ZOrder int32
---@field bInteracting boolean
---@field ['Interactive Object'] TScriptInterface<IPalInteractiveObjectComponentInterface>
---@field IndicatorBoxOffset FVector
---@field OtomoIndicatorActionInfo FPalInteractiveObjectActionInfoData
---@field bOtomoIndicatorDisplaying boolean
---@field otomoInteractDistance double
local UWBP_PalInteractiveObjectIndicatorCanvas_C = {}

---@param PrevSettings FPalKeyConfigSettings
---@param NewSettings FPalKeyConfigSettings
function UWBP_PalInteractiveObjectIndicatorCanvas_C:CREATEDELEGATE_PROXYFUNCTION_0(PrevSettings, NewSettings) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:HideInteractTargetName() end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:UpdateInteractTargetName() end
---@param PreSetting FPalKeyConfigSettings
---@param NewSetting FPalKeyConfigSettings
function UWBP_PalInteractiveObjectIndicatorCanvas_C:OnKeyConfigChanged(PreSetting, NewSetting) end
---@param InteractiveObject TScriptInterface<IPalInteractiveObjectComponentInterface>
---@param IndicatorType EPalInteractiveObjectIndicatorType
---@param buttonType EPalInteractiveObjectButtonType
---@param CanToggle boolean
---@param NewParam FText
function UWBP_PalInteractiveObjectIndicatorCanvas_C:GetIndicatorText(InteractiveObject, IndicatorType, buttonType, CanToggle, NewParam) end
---@param RideActor AActor
function UWBP_PalInteractiveObjectIndicatorCanvas_C:OnRide(RideActor) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:SetupEvent() end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:HideInteractHUDInterfaceWidget() end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:ShowInteractHUDInterfaceWidget() end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:OnChangeOtomo() end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:SetupAfterCreatePlayer() end
---@param ActionType EPalInteractiveObjectActionType
---@param ActionInfo FPalInteractiveObjectActionInfoData
function UWBP_PalInteractiveObjectIndicatorCanvas_C:ShowOtomoIndicator(ActionType, ActionInfo) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:ShowOtomoIndicators() end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:UpdateOtomoIndicators() end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:UpdateOtomoIndicatorPosition() end
---@param CanDisplay boolean
function UWBP_PalInteractiveObjectIndicatorCanvas_C:CanDisplayCoop(CanDisplay) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:UpdateIndicatorBoxPosition() end
UWBP_PalInteractiveObjectIndicatorCanvas_C['Update Indicator UIs'] = function(self, ) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:HideIndicators() end
---@param ActionType EPalInteractiveObjectActionType
---@param actionInfoData FPalInteractiveObjectActionInfoData
function UWBP_PalInteractiveObjectIndicatorCanvas_C:ShowIndicator(ActionType, actionInfoData) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:ShowIndicators() end
---@param ZOrder int32
function UWBP_PalInteractiveObjectIndicatorCanvas_C:SetZOrder(ZOrder) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:CreateIndicatorUI() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalInteractiveObjectIndicatorCanvas_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:Construct() end
---@param InteractiveObject TScriptInterface<IPalInteractiveObjectComponentInterface>
function UWBP_PalInteractiveObjectIndicatorCanvas_C:OnUpdateTargetInteractiveObject(InteractiveObject) end
function UWBP_PalInteractiveObjectIndicatorCanvas_C:OnInitialized() end
---@param bIsFocused boolean
function UWBP_PalInteractiveObjectIndicatorCanvas_C:OnApplicationActivationStateChanged(bIsFocused) end
---@param EntryPoint int32
function UWBP_PalInteractiveObjectIndicatorCanvas_C:ExecuteUbergraph_WBP_PalInteractiveObjectIndicatorCanvas(EntryPoint) end


