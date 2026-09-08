#ifndef UE4SS_SDK_ABP_FlowerDinosaur_Implementation_HPP
#define UE4SS_SDK_ABP_FlowerDinosaur_Implementation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_86;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_87;                                                          // 0x000C (size: 0x8)
    FName __NameProperty_88;                                                          // 0x0014 (size: 0x8)
    FName __NameProperty_89;                                                          // 0x001C (size: 0x8)
    FName __NameProperty_90;                                                          // 0x0024 (size: 0x8)
    FName __NameProperty_91;                                                          // 0x002C (size: 0x8)
    FName __NameProperty_92;                                                          // 0x0034 (size: 0x8)
    FName __NameProperty_93;                                                          // 0x003C (size: 0x8)
    FName __NameProperty_94;                                                          // 0x0044 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_95;                                         // 0x0050 (size: 0x20)
    FName __NameProperty_96;                                                          // 0x0070 (size: 0x8)
    FName __NameProperty_97;                                                          // 0x0078 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0080 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x0100 (size: 0x18)

}; // Size: 0x118

class UABP_FlowerDinosaur_Implementation_C : public UPalAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06E0 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x06E8 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x06F0 (size: 0x8)
    FAnimNode_Root AnimGraphNode_Root_8;                                              // 0x06F8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_8;                        // 0x0718 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_7;                                              // 0x07E0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_7;                        // 0x0800 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_6;                                              // 0x08C8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_6;                        // 0x08E8 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_5;                                              // 0x09B0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_5;                        // 0x09D0 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_4;                                              // 0x0A98 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_4;                        // 0x0AB8 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_3;                                              // 0x0B80 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_3;                        // 0x0BA0 (size: 0xC8)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_2;                                  // 0x0C68 (size: 0x128)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_1;                                  // 0x0D90 (size: 0x128)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone;                                    // 0x0EB8 (size: 0x128)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace_1;     // 0x0FE0 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace_1;     // 0x1000 (size: 0x20)
    FAnimNode_Root AnimGraphNode_Root_2;                                              // 0x1020 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_2;                        // 0x1040 (size: 0xC8)
    FAnimNode_LookAt AnimGraphNode_LookAt;                                            // 0x1110 (size: 0x250)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x1360 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x1380 (size: 0x20)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x13A0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_1;                        // 0x13C0 (size: 0xC8)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x1488 (size: 0xC8)
    FAnimNode_LayeredBoneBlend AnimGraphNode_LayeredBoneBlend;                        // 0x1550 (size: 0xE0)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x1630 (size: 0x20)
    FRotator AimRotator;                                                              // 0x1650 (size: 0x18)
    FVector LookAtWorldLocation;                                                      // 0x1668 (size: 0x18)

    void AimingOverride(FPoseLink DefaultPose, FRotator AimRotator, FPoseLink& AimingOverride);
    void LookAtOverride(FPoseLink InPose, FVector LookAtWorldLocation, FPoseLink& LookAtOverride);
    void UpperOverride(FPoseLink NativePose, FPoseLink ActionPose, FPoseLink& UpperOverride);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_FlowerDinosaur_Implementation_AnimGraphNode_ModifyBone_449458F84CE84ACCA5248BABCE5F2286();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_FlowerDinosaur_Implementation_AnimGraphNode_ModifyBone_CE9F704F457E1302C63D74A651BB500A();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_FlowerDinosaur_Implementation_AnimGraphNode_ModifyBone_CABB92F6463F0421C2D0308F8874F541();
    void ExecuteUbergraph_ABP_FlowerDinosaur_Implementation(int32 EntryPoint);
}; // Size: 0x1680

#endif
