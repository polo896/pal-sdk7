#ifndef UE4SS_SDK_SK_KingBahamut_AnimBlueprint_Z3N_F_HPP
#define UE4SS_SDK_SK_KingBahamut_AnimBlueprint_Z3N_F_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_16;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_17;                                                          // 0x000C (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_18;                                         // 0x0018 (size: 0x20)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0038 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00B8 (size: 0x18)

}; // Size: 0xD0

class USK_KingBahamut_AnimBlueprint_Z3N_F_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x0368 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x0388 (size: 0xC8)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x0450 (size: 0x20)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x0470 (size: 0x20)
    FAnimNode_Trail AnimGraphNode_Trail_1;                                            // 0x0490 (size: 0x2A0)
    FAnimNode_Trail AnimGraphNode_Trail;                                              // 0x0730 (size: 0x2A0)

    void AnimGraph(FPoseLink InPose, FPoseLink& AnimGraph);
    void ExecuteUbergraph_SK_KingBahamut_AnimBlueprint_Z3N_F(int32 EntryPoint);
}; // Size: 0x9D0

#endif
