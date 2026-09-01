#ifndef UE4SS_SDK_ABP_Player_Hair008_Implementation_HPP
#define UE4SS_SDK_ABP_Player_Hair008_Implementation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_35;                                                          // 0x0004 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_36;                                         // 0x0010 (size: 0x20)
    FName __NameProperty_37;                                                          // 0x0030 (size: 0x8)
    FName __NameProperty_38;                                                          // 0x0038 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0040 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00C0 (size: 0x18)

}; // Size: 0xD8

class UABP_Player_Hair008_Implementation_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x0368 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x0388 (size: 0x20)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_6;                            // 0x03B0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_5;                            // 0x0BF0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_4;                            // 0x1430 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_3;                            // 0x1C70 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_2;                            // 0x24B0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_1;                            // 0x2CF0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics;                              // 0x3530 (size: 0x840)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x3D70 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x3D90 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x3E58 (size: 0x20)
    FKawaiiPhysicsSettings PhysicsSettings;                                           // 0x3E78 (size: 0x18)
    double Alpha;                                                                     // 0x3E90 (size: 0x8)

    void HairLayer(FPoseLink InPose, FPoseLink& HairLayer);
    void AnimGraph(FPoseLink& AnimGraph);
    void ExecuteUbergraph_ABP_Player_Hair008_Implementation(int32 EntryPoint);
}; // Size: 0x3E98

#endif
