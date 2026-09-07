---@meta

---@class FAnimBlueprintGeneratedConstantData : FAnimBlueprintConstantData
---@field __NameProperty_77 FName
---@field __NameProperty_78 FName
---@field __NameProperty_79 FName
---@field __NameProperty_80 FName
---@field __NameProperty_81 FName
---@field __NameProperty_82 FName
---@field __NameProperty_83 FName
---@field __NameProperty_84 FName
---@field __NameProperty_85 FName
---@field __StructProperty_86 FAnimNodeFunctionRef
---@field __NameProperty_87 FName
---@field __NameProperty_88 FName
---@field AnimBlueprintExtension_PropertyAccess FAnimSubsystem_PropertyAccess
---@field AnimBlueprintExtension_Base FAnimSubsystem_Base
local FAnimBlueprintGeneratedConstantData = {}



---@class UABP_Serpent_Implementation_C : UAnimInstance
---@field UberGraphFrame FPointerToUberGraphFrame
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
---@field AnimGraphNode_Root_4 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_4 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_3 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_3 FAnimNode_LinkedInputPose
---@field AnimGraphNode_LinkedInputPose_2 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_2 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_1 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_1 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose FAnimNode_LinkedInputPose
---@field AnimGraphNode_ComponentToLocalSpace FAnimNode_ConvertComponentToLocalSpace
---@field AnimGraphNode_LocalToComponentSpace FAnimNode_ConvertLocalToComponentSpace
---@field AnimGraphNode_LookAt_3 FAnimNode_LookAt
---@field AnimGraphNode_LookAt_2 FAnimNode_LookAt
---@field AnimGraphNode_LookAt_1 FAnimNode_LookAt
---@field AnimGraphNode_LookAt FAnimNode_LookAt
---@field AnimGraphNode_Root FAnimNode_Root
---@field LookAtWorldLocation FVector
local UABP_Serpent_Implementation_C = {}

---@param NativePose FPoseLink
---@param ActionPose FPoseLink
---@param UpperOverride FPoseLink
function UABP_Serpent_Implementation_C:UpperOverride(NativePose, ActionPose, UpperOverride) end
---@param DefaultPose FPoseLink
---@param AimRotator FRotator
---@param AimingOverride FPoseLink
function UABP_Serpent_Implementation_C:AimingOverride(DefaultPose, AimRotator, AimingOverride) end
---@param InPose FPoseLink
---@param LookAtWorldLocation FVector
---@param LookAtOverride FPoseLink
function UABP_Serpent_Implementation_C:LookAtOverride(InPose, LookAtWorldLocation, LookAtOverride) end
---@param AnimGraph FPoseLink
function UABP_Serpent_Implementation_C:AnimGraph(AnimGraph) end
---@param EntryPoint int32
function UABP_Serpent_Implementation_C:ExecuteUbergraph_ABP_Serpent_Implementation(EntryPoint) end


