---@meta

---@class ABP_ElectricArc_Bullet_C : ABP_NormalBullet_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field StartTransform FTransform
local ABP_ElectricArc_Bullet_C = {}

---@param NiagaraEffect UNiagaraSystem
function ABP_ElectricArc_Bullet_C:GetHitEffect(NiagaraEffect) end
function ABP_ElectricArc_Bullet_C:ReceiveBeginPlay() end
---@param HitComp UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
function ABP_ElectricArc_Bullet_C:OnHit(HitComp, OtherActor, OtherComp, Hit) end
---@param EntryPoint int32
function ABP_ElectricArc_Bullet_C:ExecuteUbergraph_BP_ElectricArc_Bullet(EntryPoint) end


