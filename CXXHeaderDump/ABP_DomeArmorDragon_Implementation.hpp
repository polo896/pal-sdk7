#ifndef UE4SS_SDK_ABP_DomeArmorDragon_Implementation_HPP
#define UE4SS_SDK_ABP_DomeArmorDragon_Implementation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_83;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_84;                                                          // 0x000C (size: 0x8)
    FName __NameProperty_85;                                                          // 0x0014 (size: 0x8)
    FName __NameProperty_86;                                                          // 0x001C (size: 0x8)
    FName __NameProperty_87;                                                          // 0x0024 (size: 0x8)
    FName __NameProperty_88;                                                          // 0x002C (size: 0x8)
    FName __NameProperty_89;                                                          // 0x0034 (size: 0x8)
    FName __NameProperty_90;                                                          // 0x003C (size: 0x8)
    FName __NameProperty_91;                                                          // 0x0044 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_92;                                         // 0x0050 (size: 0x20)
    FName __NameProperty_93;                                                          // 0x0070 (size: 0x8)
    FName __NameProperty_94;                                                          // 0x0078 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0080 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x0100 (size: 0x18)

}; // Size: 0x118

class UABP_DomeArmorDragon_Implementation_C : public UPalAnimInstance
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
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace_1;     // 0x0B80 (size: 0x20)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_2;                                  // 0x0BA0 (size: 0x128)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_1;                                  // 0x0CC8 (size: 0x128)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace_1;     // 0x0DF0 (size: 0x20)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone;                                    // 0x0E10 (size: 0x128)
    FAnimNode_Root AnimGraphNode_Root_3;                                              // 0x0F38 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_3;                        // 0x0F58 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_2;                                              // 0x1020 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_2;                        // 0x1040 (size: 0xC8)
    FAnimNode_LookAt AnimGraphNode_LookAt;                                            // 0x1110 (size: 0x250)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x1360 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x1380 (size: 0x20)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x13A0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_1;                        // 0x13C0 (size: 0xC8)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x1488 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x1550 (size: 0x20)
    FPalCustomAnimOverrideData CustomData;                                            // 0x1570 (size: 0x50)
    FVector LookAtWorldLocation;                                                      // 0x15C0 (size: 0x18)

    void FootIKOverride(FPoseLink InPose_0, FPoseLink& FootIKOverride);
    void SwimLeaningOverride(FPoseLink InPose_3, FVector2D LeaningVelocity, FPoseLink& SwimLeaningOverride);
    void WalkLeaningOverride(FPoseLink InPose_2, FVector2D LeaningVelocity, FPoseLink& WalkLeaningOverride);
    void FlyLeaningOverride(FPoseLink InPose_1, FVector2D LeaningVelocity, FPoseLink& FlyLeaningOverride);
    void CustomOverride(FPoseLink PrePose, FPalCustomAnimOverrideData CustomData, FPoseLink& CustomOverride);
    void AimingOverride(FPoseLink DefaultPose, FRotator AimRotator, FPoseLink& AimingOverride);
    void LookAtOverride(FPoseLink InPose, FVector LookAtWorldLocation, FPoseLink& LookAtOverride);
    void UpperOverride(FPoseLink NativePose, FPoseLink ActionPose, FPoseLink& UpperOverride);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_DomeArmorDragon_Implementation_AnimGraphNode_ModifyBone_11873B7940D688140E5991B678A9F49C();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_DomeArmorDragon_Implementation_AnimGraphNode_ModifyBone_AC67217D4D74233465B284A0FE14A500();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_DomeArmorDragon_Implementation_AnimGraphNode_ModifyBone_59B866F54605A7821707DFA6171C1B09();
    void ExecuteUbergraph_ABP_DomeArmorDragon_Implementation(int32 EntryPoint);
}; // Size: 0x15D8

#endif
