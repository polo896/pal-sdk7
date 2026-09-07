---@meta

---@class FAnimBlueprintGeneratedConstantData : FAnimBlueprintConstantData
---@field __NameProperty_73 FName
---@field __NameProperty_74 FName
---@field __NameProperty_75 FName
---@field __NameProperty_76 FName
---@field __FloatProperty_77 float
---@field __BoolProperty_78 boolean
---@field __FloatProperty_79 float
---@field __BoolProperty_80 boolean
---@field __EnumProperty_81 EAnimSyncMethod
---@field __ByteProperty_82 EAnimGroupRole::Type
---@field __NameProperty_83 FName
---@field __NameProperty_84 FName
---@field __NameProperty_85 FName
---@field __NameProperty_86 FName
---@field __NameProperty_87 FName
---@field __StructProperty_88 FAnimNodeFunctionRef
---@field __NameProperty_89 FName
---@field __NameProperty_90 FName
---@field AnimBlueprintExtension_PropertyAccess FAnimSubsystem_PropertyAccess
---@field AnimBlueprintExtension_Base FAnimSubsystem_Base
local FAnimBlueprintGeneratedConstantData = {}



---@class FAnimBlueprintGeneratedMutableData : FAnimBlueprintMutableData
---@field __FloatProperty float
---@field __FloatProperty_0 float
local FAnimBlueprintGeneratedMutableData = {}



---@class UABP_GhostDragon_Implementation_C : UPalAnimInstance
---@field UberGraphFrame FPointerToUberGraphFrame
---@field __AnimBlueprintMutables FAnimBlueprintGeneratedMutableData
---@field AnimBlueprintExtension_PropertyAccess FAnimSubsystemInstance
---@field AnimBlueprintExtension_Base FAnimSubsystemInstance
---@field AnimGraphNode_Root_8 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_8 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_7 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_7 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_6 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_6 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_5 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_5 FAnimNode_LinkedInputPose
---@field AnimGraphNode_RotationOffsetBlendSpace FAnimNode_RotationOffsetBlendSpace
---@field AnimGraphNode_Root_4 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_4 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_3 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_3 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_2 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_2 FAnimNode_LinkedInputPose
---@field AnimGraphNode_LookAt FAnimNode_LookAt
---@field AnimGraphNode_LocalToComponentSpace FAnimNode_ConvertLocalToComponentSpace
---@field AnimGraphNode_ComponentToLocalSpace FAnimNode_ConvertComponentToLocalSpace
---@field AnimGraphNode_Root_1 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_1 FAnimNode_LinkedInputPose
---@field AnimGraphNode_LinkedInputPose FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root FAnimNode_Root
---@field LeaningVelocity FVector2D
---@field LookAtWorldLocation FVector
local UABP_GhostDragon_Implementation_C = {}

---@param InPose_0 FPoseLink
---@param FootIKOverride FPoseLink
function UABP_GhostDragon_Implementation_C:FootIKOverride(InPose_0, FootIKOverride) end
---@param InPose_3 FPoseLink
---@param LeaningVelocity FVector2D
---@param SwimLeaningOverride FPoseLink
function UABP_GhostDragon_Implementation_C:SwimLeaningOverride(InPose_3, LeaningVelocity, SwimLeaningOverride) end
---@param InPose_2 FPoseLink
---@param LeaningVelocity FVector2D
---@param WalkLeaningOverride FPoseLink
function UABP_GhostDragon_Implementation_C:WalkLeaningOverride(InPose_2, LeaningVelocity, WalkLeaningOverride) end
---@param InPose_1 FPoseLink
---@param LeaningVelocity FVector2D
---@param FlyLeaningOverride FPoseLink
function UABP_GhostDragon_Implementation_C:FlyLeaningOverride(InPose_1, LeaningVelocity, FlyLeaningOverride) end
---@param PrePose FPoseLink
---@param CustomData FPalCustomAnimOverrideData
---@param CustomOverride FPoseLink
function UABP_GhostDragon_Implementation_C:CustomOverride(PrePose, CustomData, CustomOverride) end
---@param DefaultPose FPoseLink
---@param AimRotator FRotator
---@param AimingOverride FPoseLink
function UABP_GhostDragon_Implementation_C:AimingOverride(DefaultPose, AimRotator, AimingOverride) end
---@param InPose FPoseLink
---@param LookAtWorldLocation FVector
---@param LookAtOverride FPoseLink
function UABP_GhostDragon_Implementation_C:LookAtOverride(InPose, LookAtWorldLocation, LookAtOverride) end
---@param NativePose FPoseLink
---@param ActionPose FPoseLink
---@param UpperOverride FPoseLink
function UABP_GhostDragon_Implementation_C:UpperOverride(NativePose, ActionPose, UpperOverride) end
---@param AnimGraph FPoseLink
function UABP_GhostDragon_Implementation_C:AnimGraph(AnimGraph) end
---@param EntryPoint int32
function UABP_GhostDragon_Implementation_C:ExecuteUbergraph_ABP_GhostDragon_Implementation(EntryPoint) end


