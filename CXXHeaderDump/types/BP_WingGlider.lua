---@meta

---@class ABP_WingGlider_C : ABP_Glider_Item_Base_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_WingGlider_C = {}

---@param NotifyName FName
function ABP_WingGlider_C:OnNotifyEnd_BF4C4F184A64D6E26C7312AB7EA510EA(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnNotifyBegin_BF4C4F184A64D6E26C7312AB7EA510EA(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnInterrupted_BF4C4F184A64D6E26C7312AB7EA510EA(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnBlendOut_BF4C4F184A64D6E26C7312AB7EA510EA(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnCompleted_BF4C4F184A64D6E26C7312AB7EA510EA(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnNotifyEnd_801568FB493F6CAB9A9531919F9B39AD(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnNotifyBegin_801568FB493F6CAB9A9531919F9B39AD(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnInterrupted_801568FB493F6CAB9A9531919F9B39AD(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnBlendOut_801568FB493F6CAB9A9531919F9B39AD(NotifyName) end
---@param NotifyName FName
function ABP_WingGlider_C:OnCompleted_801568FB493F6CAB9A9531919F9B39AD(NotifyName) end
function ABP_WingGlider_C:OnEquipJetpack() end
function ABP_WingGlider_C:ReceiveBeginPlay() end
---@param Component UPalCharacterMovementComponent
---@param prevMode EMovementMode
---@param newMode EMovementMode
---@param PrevCustomMode EPalCharacterMovementCustomMode
---@param NewCustomMode EPalCharacterMovementCustomMode
function ABP_WingGlider_C:CustomEvent(Component, prevMode, newMode, PrevCustomMode, NewCustomMode) end
---@param DeltaSeconds float
function ABP_WingGlider_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function ABP_WingGlider_C:ExecuteUbergraph_BP_WingGlider(EntryPoint) end


