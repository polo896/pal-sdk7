---@meta

---@class UBP_FloatingObject_C : UFloatingObjectComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Scene USceneComponent
---@field BeginPos FVector
---@field Height double
---@field Speed double
local UBP_FloatingObject_C = {}

---@param InScene USceneComponent
---@param InBeginPos FVector
function UBP_FloatingObject_C:Setup(InScene, InBeginPos) end
---@param DeltaSeconds float
function UBP_FloatingObject_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function UBP_FloatingObject_C:ExecuteUbergraph_BP_FloatingObject(EntryPoint) end


