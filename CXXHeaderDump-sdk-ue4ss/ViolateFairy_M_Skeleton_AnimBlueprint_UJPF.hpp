#ifndef UE4SS_SDK_ViolateFairy_M_Skeleton_AnimBlueprint_UJPF_HPP
#define UE4SS_SDK_ViolateFairy_M_Skeleton_AnimBlueprint_UJPF_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_13;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_14;                                                          // 0x000C (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_15;                                         // 0x0018 (size: 0x20)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0038 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00B8 (size: 0x18)

}; // Size: 0xD0

class UViolateFairy_M_Skeleton_AnimBlueprint_UJPF_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x0368 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x0388 (size: 0xC8)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics;                              // 0x0450 (size: 0x840)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x0C90 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x0CB0 (size: 0x20)

    void AnimGraph(FPoseLink InPose, FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ViolateFairy_M_Skeleton_AnimBlueprint_UJPF_AnimGraphNode_KawaiiPhysics_D829A6B34AA7E9A418E1F79590DEE6D6();
    void ExecuteUbergraph_ViolateFairy_M_Skeleton_AnimBlueprint_UJPF(int32 EntryPoint);
}; // Size: 0xCD0

#endif
