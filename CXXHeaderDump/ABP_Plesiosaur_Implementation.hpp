#ifndef UE4SS_SDK_ABP_Plesiosaur_Implementation_HPP
#define UE4SS_SDK_ABP_Plesiosaur_Implementation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_92;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_93;                                                          // 0x000C (size: 0x8)
    FName __NameProperty_94;                                                          // 0x0014 (size: 0x8)
    FName __NameProperty_95;                                                          // 0x001C (size: 0x8)
    FName __NameProperty_96;                                                          // 0x0024 (size: 0x8)
    FName __NameProperty_97;                                                          // 0x002C (size: 0x8)
    FName __NameProperty_98;                                                          // 0x0034 (size: 0x8)
    FName __NameProperty_99;                                                          // 0x003C (size: 0x8)
    FName __NameProperty_100;                                                         // 0x0044 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_101;                                        // 0x0050 (size: 0x20)
    FName __NameProperty_102;                                                         // 0x0070 (size: 0x8)
    FName __NameProperty_103;                                                         // 0x0078 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0080 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x0100 (size: 0x18)

}; // Size: 0x118

class UABP_Plesiosaur_Implementation_C : public UPalAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06E0 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x06E8 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x06F0 (size: 0x8)
    FAnimNode_Root AnimGraphNode_Root_8;                                              // 0x06F8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_8;                        // 0x0718 (size: 0xC8)
    FAnimNode_ControlRig AnimGraphNode_ControlRig;                                    // 0x07E0 (size: 0x470)
    FAnimNode_IKRig AnimGraphNode_IKRig;                                              // 0x0C50 (size: 0x1E0)
    FAnimNode_Root AnimGraphNode_Root_7;                                              // 0x0E30 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_7;                        // 0x0E50 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_6;                                              // 0x0F18 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_6;                        // 0x0F38 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_5;                                              // 0x1000 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_5;                        // 0x1020 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_4;                                              // 0x10E8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_4;                        // 0x1108 (size: 0xC8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace_1;     // 0x11D0 (size: 0x20)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_2;                                  // 0x11F0 (size: 0x128)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_1;                                  // 0x1318 (size: 0x128)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace_1;     // 0x1440 (size: 0x20)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone;                                    // 0x1460 (size: 0x128)
    FAnimNode_Root AnimGraphNode_Root_3;                                              // 0x1588 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_3;                        // 0x15A8 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_2;                                              // 0x1670 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_2;                        // 0x1690 (size: 0xC8)
    FAnimNode_LookAt AnimGraphNode_LookAt_1;                                          // 0x1760 (size: 0x250)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x19B0 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x19D0 (size: 0x20)
    FAnimNode_LookAt AnimGraphNode_LookAt;                                            // 0x19F0 (size: 0x250)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x1C40 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_1;                        // 0x1C60 (size: 0xC8)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x1D28 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x1DF0 (size: 0x20)
    double __CustomProperty_PositionAlpha_leg_front_03_l_Goal_339270A3443FB8F62717BF87EE082BE9; // 0x1E10 (size: 0x8)
    double __CustomProperty_PositionAlpha_leg_front_03_r_Goal_339270A3443FB8F62717BF87EE082BE9; // 0x1E18 (size: 0x8)
    double __CustomProperty_PositionAlpha_leg_back_04_r_Goal_339270A3443FB8F62717BF87EE082BE9; // 0x1E20 (size: 0x8)
    double __CustomProperty_PositionAlpha_leg_back_04_l_Goal_339270A3443FB8F62717BF87EE082BE9; // 0x1E28 (size: 0x8)
    FPalCustomAnimOverrideData CustomData;                                            // 0x1E30 (size: 0x50)
    FVector LookAtWorldLocation;                                                      // 0x1E80 (size: 0x18)

    void FootIKOverride(FPoseLink InPose_0, FPoseLink& FootIKOverride);
    void SwimLeaningOverride(FPoseLink InPose_3, FVector2D LeaningVelocity, FPoseLink& SwimLeaningOverride);
    void WalkLeaningOverride(FPoseLink InPose_2, FVector2D LeaningVelocity, FPoseLink& WalkLeaningOverride);
    void FlyLeaningOverride(FPoseLink InPose_1, FVector2D LeaningVelocity, FPoseLink& FlyLeaningOverride);
    void CustomOverride(FPoseLink PrePose, FPalCustomAnimOverrideData CustomData, FPoseLink& CustomOverride);
    void AimingOverride(FPoseLink DefaultPose, FRotator AimRotator, FPoseLink& AimingOverride);
    void LookAtOverride(FPoseLink InPose, FVector LookAtWorldLocation, FPoseLink& LookAtOverride);
    void UpperOverride(FPoseLink NativePose, FPoseLink ActionPose, FPoseLink& UpperOverride);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_Plesiosaur_Implementation_AnimGraphNode_ModifyBone_67F3754F4F9BDB52CF8FF79E82868093();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_Plesiosaur_Implementation_AnimGraphNode_ModifyBone_95E511C44103A81928191D84759B160F();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_Plesiosaur_Implementation_AnimGraphNode_ModifyBone_F48C5239400F0BB5665A259AFE77ABE5();
    void ExecuteUbergraph_ABP_Plesiosaur_Implementation(int32 EntryPoint);
}; // Size: 0x1E98

#endif
