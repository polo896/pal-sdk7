---@meta

---@class ABP_Skill_ThunderFunnel_Funnel_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_CommonSkill_ThunderFunnel_Main UNiagaraComponent
---@field Sphere USphereComponent
---@field FunnelSpeed double
---@field ShotSpan double
---@field TempTime double
---@field EasePos double
---@field EaseRot double
---@field DelayTime double
---@field ['Object Types'] TArray<EObjectTypeQuery>
---@field FunnelSpeedWeight double
---@field FunnelLocationOffset_ FVector
---@field IsReady boolean
---@field FadeOutDelay double
---@field Bullets TArray<ABP_Skill_ThunderFunnel_Bullet_C>
---@field ShootingLifeTime double
---@field TimeUntilFade double
---@field TimeSpanOffset double
---@field EndAkEvent UAkAudioEvent
---@field EnemySearchDistance float
local ABP_Skill_ThunderFunnel_Funnel_C = {}

---@param DeltaTime double
function ABP_Skill_ThunderFunnel_Funnel_C:InitMoveFunnelLocation(DeltaTime) end
---@param Owner AActor
---@param SkillEffect ABP_SkillEffectBase_C
function ABP_Skill_ThunderFunnel_Funnel_C:SpawnSkillEffect(Owner, SkillEffect) end
---@param NearestTargetLocation FVector
function ABP_Skill_ThunderFunnel_Funnel_C:GetNearestTargetLocation(NearestTargetLocation) end
---@param Rotation FRotator
ABP_Skill_ThunderFunnel_Funnel_C['Get Bullet Rotat'] = function(self, Rotation) end
function ABP_Skill_ThunderFunnel_Funnel_C:SpawnBullet() end
function ABP_Skill_ThunderFunnel_Funnel_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_Skill_ThunderFunnel_Funnel_C:ReceiveTick(DeltaSeconds) end
---@param DeltaSecond double
function ABP_Skill_ThunderFunnel_Funnel_C:FadeOutEffect(DeltaSecond) end
function ABP_Skill_ThunderFunnel_Funnel_C:SetLifeTimer() end
function ABP_Skill_ThunderFunnel_Funnel_C:Terminate() end
---@param EntryPoint int32
function ABP_Skill_ThunderFunnel_Funnel_C:ExecuteUbergraph_BP_Skill_ThunderFunnel_Funnel(EntryPoint) end


