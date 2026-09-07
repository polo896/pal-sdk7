---@meta

---@class ABP_MapObject_TreasureBox_EnemyCamp_C : APalMapObjectTreasureBox
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalPickingGameData UPalPickingGameDataComponent
---@field VisualActor UChildActorComponent
---@field BP_InteractableSphere UPalInteractableSphereComponentNative
---@field IndicatorOrigin USceneComponent
---@field VisualMap TMap<EPalMapObjectTreasureGradeType, TSubclassOf<AActor>>
local ABP_MapObject_TreasureBox_EnemyCamp_C = {}

---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_TreasureBox_EnemyCamp_C:SetupVisual(ConcreteModel) end
function ABP_MapObject_TreasureBox_EnemyCamp_C:TriggerOpen() end
function ABP_MapObject_TreasureBox_EnemyCamp_C:OnFinishOpenVisual() end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_TreasureBox_EnemyCamp_C:BP_OnSetConcreteModel(ConcreteModel) end
function ABP_MapObject_TreasureBox_EnemyCamp_C:OnNotifiedStartOpen() end
function ABP_MapObject_TreasureBox_EnemyCamp_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_MapObject_TreasureBox_EnemyCamp_C:ExecuteUbergraph_BP_MapObject_TreasureBox_EnemyCamp(EntryPoint) end


