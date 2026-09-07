---@meta

---@class FAnimBlueprintGeneratedConstantData : FAnimBlueprintConstantData
---@field __NameProperty_68 FName
---@field __NameProperty_69 FName
---@field __NameProperty_70 FName
---@field __NameProperty_71 FName
---@field __NameProperty_72 FName
---@field __NameProperty_73 FName
---@field __NameProperty_74 FName
---@field __NameProperty_75 FName
---@field __NameProperty_76 FName
---@field __StructProperty_77 FAnimNodeFunctionRef
---@field __NameProperty_78 FName
---@field __NameProperty_79 FName
---@field AnimBlueprintExtension_PropertyAccess FAnimSubsystem_PropertyAccess
---@field AnimBlueprintExtension_Base FAnimSubsystem_Base
local FAnimBlueprintGeneratedConstantData = {}



---@class UABP_LazyCatfish_Implementation_C : UPalAnimInstance
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
---@field AnimGraphNode_Root_2 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_2 FAnimNode_LinkedInputPose
---@field AnimGraphNode_LookAt FAnimNode_LookAt
---@field AnimGraphNode_LocalToComponentSpace FAnimNode_ConvertLocalToComponentSpace
---@field AnimGraphNode_ComponentToLocalSpace FAnimNode_ConvertComponentToLocalSpace
---@field AnimGraphNode_Root_1 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_1 FAnimNode_LinkedInputPose
---@field AnimGraphNode_LinkedInputPose FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root FAnimNode_Root
---@field LookAtWorldLocation FVector
local UABP_LazyCatfish_Implementation_C = {}

---@param DefaultPose FPoseLink
---@param AimRotator FRotator
---@param AimingOverride FPoseLink
function UABP_LazyCatfish_Implementation_C:AimingOverride(DefaultPose, AimRotator, AimingOverride) end
---@param InPose FPoseLink
---@param LookAtWorldLocation FVector
---@param LookAtOverride FPoseLink
function UABP_LazyCatfish_Implementation_C:LookAtOverride(InPose, LookAtWorldLocation, LookAtOverride) end
---@param NativePose FPoseLink
---@param ActionPose FPoseLink
---@param UpperOverride FPoseLink
function UABP_LazyCatfish_Implementation_C:UpperOverride(NativePose, ActionPose, UpperOverride) end
---@param AnimGraph FPoseLink
function UABP_LazyCatfish_Implementation_C:AnimGraph(AnimGraph) end
---@param EntryPoint int32
function UABP_LazyCatfish_Implementation_C:ExecuteUbergraph_ABP_LazyCatfish_Implementation(EntryPoint) end


