---@meta

---@class ABP_ElectricArc_Spawner_C : ABP_NormalBullet_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Hit FHitResult
---@field MaxArcHit int32
---@field HitActor TArray<AActor>
---@field TargetActor AActor
---@field ArcRadius float
---@field StartTransform FTransform
---@field ['Hit Actor'] AActor
---@field TargetArray TArray<AActor>
---@field IsHit boolean
local ABP_ElectricArc_Spawner_C = {}

---@param NiagaraEffect UNiagaraSystem
function ABP_ElectricArc_Spawner_C:GetHitEffect(NiagaraEffect) end
function ABP_ElectricArc_Spawner_C:ReceiveBeginPlay() end
---@param HitComp UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
function ABP_ElectricArc_Spawner_C:OnHit(HitComp, OtherActor, OtherComp, Hit) end
function ABP_ElectricArc_Spawner_C:ArcLoopBreak() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_ElectricArc_Spawner_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_ElectricArc_Spawner_C:ExecuteUbergraph_BP_ElectricArc_Spawner(EntryPoint) end


