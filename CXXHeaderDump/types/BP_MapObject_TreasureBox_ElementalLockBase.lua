---@meta

---@class ABP_MapObject_TreasureBox_ElementalLockBase_C : APalMapObjectTreasureBox
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TreasureBoxLock UPalMapObjectTreasureBoxLockComponent
---@field VisualActor UChildActorComponent
---@field BP_InteractableSphere UPalInteractableSphereComponentNative
---@field IndicatorOrigin USceneComponent
---@field IsUnlockedElement boolean
---@field DestroyDelay double
local ABP_MapObject_TreasureBox_ElementalLockBase_C = {}

function ABP_MapObject_TreasureBox_ElementalLockBase_C:OnFinishUnlockPerformance() end
function ABP_MapObject_TreasureBox_ElementalLockBase_C:OnProceedUnlockPerformance() end
function ABP_MapObject_TreasureBox_ElementalLockBase_C:OnStartUnlockPerformance() end
function ABP_MapObject_TreasureBox_ElementalLockBase_C:TriggerOpen() end
function ABP_MapObject_TreasureBox_ElementalLockBase_C:OnFinishOpenVisual() end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_TreasureBox_ElementalLockBase_C:BP_OnSetConcreteModel(ConcreteModel) end
function ABP_MapObject_TreasureBox_ElementalLockBase_C:OnNotifiedStartOpen() end
function ABP_MapObject_TreasureBox_ElementalLockBase_C:ReceiveBeginPlay() end
function ABP_MapObject_TreasureBox_ElementalLockBase_C:TriggerUnlockElemental() end
---@param EntryPoint int32
function ABP_MapObject_TreasureBox_ElementalLockBase_C:ExecuteUbergraph_BP_MapObject_TreasureBox_ElementalLockBase(EntryPoint) end


