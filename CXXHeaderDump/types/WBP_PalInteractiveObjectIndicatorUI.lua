---@meta

---@class UWBP_PalInteractiveObjectIndicatorUI_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Default_In UWidgetAnimation
---@field WBP_Ingame_Interact UWBP_Ingame_Interact_C
---@field Offset FVector
---@field InteractKeyTextIdMap TMap<EPalInteractiveObjectActionType, FDataTableRowHandle>
---@field ['Action Type'] EPalInteractiveObjectActionType
---@field ActionTypeNameMap TMap<EPalInteractiveObjectActionType, FPalDataTableRowName_UIInputAction>
---@field InteractiveObject TScriptInterface<IPalInteractiveObjectComponentInterface>
---@field buttonType EPalInteractiveObjectButtonType
---@field longPushTime double
---@field TriggerActionHandle FPalUIActionBindData
---@field EndTriggerActionhandle FPalUIActionBindData
---@field CachedIsValidInteract boolean
---@field bIsRegisteredActionInput boolean
---@field IsEnableSelf boolean
---@field LockedByRideMSGID FDataTableRowHandle
---@field CanToggle boolean
---@field IsInteractInterval boolean
---@field bConflictingCoopAction boolean
---@field DiscardInteractTimer double
---@field CachedActionInfo FPalInteractiveObjectActionInfoData
---@field bDisablingSelectingBullet boolean
local UWBP_PalInteractiveObjectIndicatorUI_C = {}

---@param ActionInfo FPalInteractiveObjectActionInfoData
function UWBP_PalInteractiveObjectIndicatorUI_C:SetActionInfo(ActionInfo) end
---@param bConflicted boolean
function UWBP_PalInteractiveObjectIndicatorUI_C:IsConflictingWeaponChangeNext(bConflicted) end
---@param bConflicted boolean
function UWBP_PalInteractiveObjectIndicatorUI_C:IsConflictingCoopAction(bConflicted) end
---@return boolean
function UWBP_PalInteractiveObjectIndicatorUI_C:IsInteracting() end
---@param ActionType EPalInteractiveObjectActionType
---@param IsSame boolean
function UWBP_PalInteractiveObjectIndicatorUI_C:IsSameTriggeringActionType(ActionType, IsSame) end
function UWBP_PalInteractiveObjectIndicatorUI_C:ResetInteractInterval() end
function UWBP_PalInteractiveObjectIndicatorUI_C:ReleaseInteractButton() end
function UWBP_PalInteractiveObjectIndicatorUI_C:PressInteractButton() end
---@param IsEnable boolean
function UWBP_PalInteractiveObjectIndicatorUI_C:SetEnable(IsEnable) end
---@param isInputConsume boolean
---@param Parent UPalUserWidget
function UWBP_PalInteractiveObjectIndicatorUI_C:RegisterAction(isInputConsume, Parent) end
---@param newButtonType EPalInteractiveObjectButtonType
---@param newLongPushTime double
---@param IsValidInteract boolean
---@param CanToggle boolean
UWBP_PalInteractiveObjectIndicatorUI_C['Update Button Type'] = function(self, newButtonType, newLongPushTime, IsValidInteract, CanToggle) end
---@param Parent UPalUserWidget
UWBP_PalInteractiveObjectIndicatorUI_C['Unregister Action'] = function(self, Parent) end
function UWBP_PalInteractiveObjectIndicatorUI_C:EndTriggerInteract() end
function UWBP_PalInteractiveObjectIndicatorUI_C:StartTriggerInteract() end
---@param Parent UPalUserWidget
function UWBP_PalInteractiveObjectIndicatorUI_C:Deactivate(Parent) end
---@param isInputConsume boolean
---@param Parent UPalUserWidget
function UWBP_PalInteractiveObjectIndicatorUI_C:Activate(isInputConsume, Parent) end
---@param bInteractable boolean
---@param Parent UPalUserWidget
UWBP_PalInteractiveObjectIndicatorUI_C['Update Interactable'] = function(self, bInteractable, Parent) end
---@param Visible boolean
function UWBP_PalInteractiveObjectIndicatorUI_C:UpdateVisible(Visible) end
---@param InText FText
---@param IsLockedByRide boolean
function UWBP_PalInteractiveObjectIndicatorUI_C:UpdateText(InText, IsLockedByRide) end
---@param ActionType EPalInteractiveObjectActionType
---@param Interface TScriptInterface<IPalInteractiveObjectComponentInterface>
function UWBP_PalInteractiveObjectIndicatorUI_C:Setup(ActionType, Interface) end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalInteractiveObjectIndicatorUI_C:Tick(MyGeometry, InDeltaTime) end
---@param EntryPoint int32
function UWBP_PalInteractiveObjectIndicatorUI_C:ExecuteUbergraph_WBP_PalInteractiveObjectIndicatorUI(EntryPoint) end


