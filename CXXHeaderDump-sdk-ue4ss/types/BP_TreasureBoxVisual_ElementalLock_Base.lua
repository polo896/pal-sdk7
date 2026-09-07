---@meta

---@class ABP_TreasureBoxVisual_ElementalLock_Base_C : ABP_TreasureBoxVisual_Base_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field LockEmissive double
---@field UnlockEmissive double
---@field MaterialInstance UMaterialInstanceDynamic
---@field CurrentEmissiveCount double
---@field IsElementalUnlocked boolean
---@field IsAnimationUpdate boolean
local ABP_TreasureBoxVisual_ElementalLock_Base_C = {}

function ABP_TreasureBoxVisual_ElementalLock_Base_C:EnableTicks() end
---@param ElapsedTime double
function ABP_TreasureBoxVisual_ElementalLock_Base_C:ElementalUnlockAnimation(ElapsedTime) end
function ABP_TreasureBoxVisual_ElementalLock_Base_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_TreasureBoxVisual_ElementalLock_Base_C:ReceiveTick(DeltaSeconds) end
---@param isSkipAnim boolean
function ABP_TreasureBoxVisual_ElementalLock_Base_C:ChangeToElementalUnlock(isSkipAnim) end
---@param EntryPoint int32
function ABP_TreasureBoxVisual_ElementalLock_Base_C:ExecuteUbergraph_BP_TreasureBoxVisual_ElementalLock_Base(EntryPoint) end


