---@meta

---@class UBP_Action_Coop_ShortDash_PoseidonOrca_C : UPalActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DashDistance double
---@field MaxSpeedMultiply double
---@field flagName FName
---@field RunAnimSpeed double
---@field DashTimerHandle FTimerHandle
---@field DashSkillEffect ABP_SkillEffectBase_C
---@field DashSkillEffectClass TSubclassOf<ABP_SkillEffectBase_C>
---@field IsEffectSpawnOnGround boolean
---@field IsInputMove boolean
---@field MoveComp UPalCharacterMovementComponent
---@field PartnerComp UPalPartnerSkillParameterComponent
---@field CameraOffset FShooterSpringCameraParameter
---@field EffectOffset double
---@field ['Jump Out Of Water Pitch'] float
---@field ['Jumpable In Water Depth'] float
---@field ['Jump Z Velocity'] float
---@field WhileJumpGravityTime double
---@field WhileJumpGravityRate float
---@field DashTime double
---@field Jump_Velocity float
---@field VelocityModify_All float
---@field VelocityModify_Z double
---@field IsExitWaterTimerHandle FTimerHandle
---@field prevZ double
---@field PrevLocation FVector
local UBP_Action_Coop_ShortDash_PoseidonOrca_C = {}

function UBP_Action_Coop_ShortDash_PoseidonOrca_C:Force_Jump() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:SetJumpableDefaultValue() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:EnableJumping() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:GetJumpableDefaultValue() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:SetEffectRotation() end
---@param InputVector FVector
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:GetInputVector(InputVector) end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:EndCamera() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:StartCamera() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:CreateSkillEffect() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:EndDash() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:StartDash() end
---@param Component UPalCharacterMovementComponent
---@param Hit FHitResult
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:OnLanded(Component, Hit) end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:OnWaterEnter() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:NotExitWater() end
---@param DeltaTime float
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:TickAction(DeltaTime) end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:OnEndAction() end
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:OnBeginAction() end
---@param EntryPoint int32
function UBP_Action_Coop_ShortDash_PoseidonOrca_C:ExecuteUbergraph_BP_Action_Coop_ShortDash_PoseidonOrca(EntryPoint) end


