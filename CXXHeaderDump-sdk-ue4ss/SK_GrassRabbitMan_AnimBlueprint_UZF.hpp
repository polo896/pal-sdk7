#ifndef UE4SS_SDK_SK_GrassRabbitMan_AnimBlueprint_UZF_HPP
#define UE4SS_SDK_SK_GrassRabbitMan_AnimBlueprint_UZF_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_22;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_23;                                                          // 0x000C (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_24;                                         // 0x0018 (size: 0x20)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0038 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00B8 (size: 0x18)

}; // Size: 0xD0

class USK_GrassRabbitMan_AnimBlueprint_UZF_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x0368 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x0388 (size: 0xC8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x0450 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x0470 (size: 0x20)
    FAnimNode_SpringBone AnimGraphNode_SpringBone_3;                                  // 0x0490 (size: 0x158)
    FAnimNode_SpringBone AnimGraphNode_SpringBone_2;                                  // 0x05E8 (size: 0x158)
    FAnimNode_SpringBone AnimGraphNode_SpringBone_1;                                  // 0x0740 (size: 0x158)
    FAnimNode_SpringBone AnimGraphNode_SpringBone;                                    // 0x0898 (size: 0x158)

    void AnimGraph(FPoseLink InPose, FPoseLink& AnimGraph);
    void ExecuteUbergraph_SK_GrassRabbitMan_AnimBlueprint_UZF(int32 EntryPoint);
}; // Size: 0x9F0

#endif
