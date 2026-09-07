---@meta

---@class FAnimBlueprintGeneratedConstantData : FAnimBlueprintConstantData
---@field __NameProperty_83 FName
---@field __NameProperty_84 FName
---@field __NameProperty_85 FName
---@field __NameProperty_86 FName
---@field __NameProperty_87 FName
---@field __NameProperty_88 FName
---@field __BoolProperty_89 boolean
---@field __FloatProperty_90 float
---@field __FloatProperty_91 float
---@field __BoolProperty_92 boolean
---@field __EnumProperty_93 EAnimSyncMethod
---@field __ByteProperty_94 EAnimGroupRole::Type
---@field __NameProperty_95 FName
---@field __NameProperty_96 FName
---@field __NameProperty_97 FName
---@field __StructProperty_98 FAnimNodeFunctionRef
---@field __NameProperty_99 FName
---@field __NameProperty_100 FName
---@field AnimBlueprintExtension_PropertyAccess FAnimSubsystem_PropertyAccess
---@field AnimBlueprintExtension_Base FAnimSubsystem_Base
local FAnimBlueprintGeneratedConstantData = {}



---@class FAnimBlueprintGeneratedMutableData : FAnimBlueprintMutableData
---@field __FloatProperty float
local FAnimBlueprintGeneratedMutableData = {}



---@class UABP_ElecPanda_Implementation_C : UPalAnimInstance
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
---@field AnimGraphNode_Root_4 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_4 FAnimNode_LinkedInputPose
---@field AnimGraphNode_Root_3 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_3 FAnimNode_LinkedInputPose
---@field AnimGraphNode_RotationOffsetBlendSpace FAnimNode_RotationOffsetBlendSpace
---@field AnimGraphNode_Root_2 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_2 FAnimNode_LinkedInputPose
---@field AnimGraphNode_LocalToComponentSpace FAnimNode_ConvertLocalToComponentSpace
---@field AnimGraphNode_LookAt_2 FAnimNode_LookAt
---@field AnimGraphNode_ComponentToLocalSpace FAnimNode_ConvertComponentToLocalSpace
---@field AnimGraphNode_LookAt_1 FAnimNode_LookAt
---@field AnimGraphNode_LookAt FAnimNode_LookAt
---@field AnimGraphNode_Root_1 FAnimNode_Root
---@field AnimGraphNode_LinkedInputPose_1 FAnimNode_LinkedInputPose
---@field AnimGraphNode_LinkedInputPose FAnimNode_LinkedInputPose
---@field AnimGraphNode_LayeredBoneBlend FAnimNode_LayeredBoneBlend
---@field AnimGraphNode_Root FAnimNode_Root
---@field AimRotator FRotator
---@field LookAtWorldLocation FVector
local UABP_ElecPanda_Implementation_C = {}

---@param PrePose FPoseLink
---@param CustomData FPalCustomAnimOverrideData
---@param CustomOverride FPoseLink
function UABP_ElecPanda_Implementation_C:CustomOverride(PrePose, CustomData, CustomOverride) end
---@param DefaultPose FPoseLink
---@param AimRotator FRotator
---@param AimingOverride FPoseLink
function UABP_ElecPanda_Implementation_C:AimingOverride(DefaultPose, AimRotator, AimingOverride) end
---@param InPose FPoseLink
---@param LookAtWorldLocation FVector
---@param LookAtOverride FPoseLink
function UABP_ElecPanda_Implementation_C:LookAtOverride(InPose, LookAtWorldLocation, LookAtOverride) end
---@param NativePose FPoseLink
---@param ActionPose FPoseLink
---@param UpperOverride FPoseLink
function UABP_ElecPanda_Implementation_C:UpperOverride(NativePose, ActionPose, UpperOverride) end
---@param AnimGraph FPoseLink
function UABP_ElecPanda_Implementation_C:AnimGraph(AnimGraph) end
function UABP_ElecPanda_Implementation_C:EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_ElecPanda_Implementation_AnimGraphNode_RotationOffsetBlendSpace_03753B96488972CD431A1AA078104133() end
---@param EntryPoint int32
function UABP_ElecPanda_Implementation_C:ExecuteUbergraph_ABP_ElecPanda_Implementation(EntryPoint) end


