#ifndef UE4SS_SDK_ABP_GrassGolem_Implementation_HPP
#define UE4SS_SDK_ABP_GrassGolem_Implementation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_128;                                                         // 0x0004 (size: 0x8)
    FName __NameProperty_129;                                                         // 0x000C (size: 0x8)
    FName __NameProperty_130;                                                         // 0x0014 (size: 0x8)
    FName __NameProperty_131;                                                         // 0x001C (size: 0x8)
    FName __NameProperty_132;                                                         // 0x0024 (size: 0x8)
    class UBlendProfile* __BlendProfile_133;                                          // 0x0030 (size: 0x8)
    class UCurveFloat* __CurveFloat_134;                                              // 0x0038 (size: 0x8)
    bool __BoolProperty_135;                                                          // 0x0040 (size: 0x1)
    EAlphaBlendOption __EnumProperty_136;                                             // 0x0041 (size: 0x1)
    EBlendListTransitionType __EnumProperty_137;                                      // 0x0042 (size: 0x1)
    TArray<float> __ArrayProperty_138;                                                // 0x0048 (size: 0x10)
    FName __NameProperty_139;                                                         // 0x0058 (size: 0x8)
    FName __NameProperty_140;                                                         // 0x0060 (size: 0x8)
    FName __NameProperty_141;                                                         // 0x0068 (size: 0x8)
    FName __NameProperty_142;                                                         // 0x0070 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_143;                                        // 0x0078 (size: 0x20)
    FName __NameProperty_144;                                                         // 0x0098 (size: 0x8)
    FName __NameProperty_145;                                                         // 0x00A0 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x00A8 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x0128 (size: 0x18)

}; // Size: 0x140

struct FAnimBlueprintGeneratedMutableData : public FAnimBlueprintMutableData
{
    bool __BoolProperty;                                                              // 0x0001 (size: 0x1)

}; // Size: 0x2

class UABP_GrassGolem_Implementation_C : public UPalAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06E0 (size: 0x8)
    FAnimBlueprintGeneratedMutableData __AnimBlueprintMutables;                       // 0x06E8 (size: 0x2)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x06F0 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x06F8 (size: 0x8)
    FAnimNode_Root AnimGraphNode_Root_8;                                              // 0x0700 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_8;                        // 0x0720 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_7;                                              // 0x07E8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_7;                        // 0x0808 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_6;                                              // 0x08D0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_6;                        // 0x08F0 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_5;                                              // 0x09B8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_5;                        // 0x09D8 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_4;                                              // 0x0AA0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_4;                        // 0x0AC0 (size: 0xC8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace_3;     // 0x0B88 (size: 0x20)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_5;                                  // 0x0BA8 (size: 0x128)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_4;                                  // 0x0CD0 (size: 0x128)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_3;                                  // 0x0DF8 (size: 0x128)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace_3;     // 0x0F20 (size: 0x20)
    FAnimNode_BlendListByBool AnimGraphNode_BlendListByBool;                          // 0x0F40 (size: 0x48)
    FAnimNode_SaveCachedPose AnimGraphNode_SaveCachedPose_2;                          // 0x0F88 (size: 0x108)
    FAnimNode_SaveCachedPose AnimGraphNode_SaveCachedPose_1;                          // 0x1090 (size: 0x108)
    FAnimNode_UseCachedPose AnimGraphNode_UseCachedPose_3;                            // 0x1198 (size: 0x28)
    FAnimNode_UseCachedPose AnimGraphNode_UseCachedPose_2;                            // 0x11C0 (size: 0x28)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace_2;     // 0x11E8 (size: 0x20)
    FAnimNode_UseCachedPose AnimGraphNode_UseCachedPose_1;                            // 0x1208 (size: 0x28)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace_2;     // 0x1230 (size: 0x20)
    FAnimNode_SaveCachedPose AnimGraphNode_SaveCachedPose;                            // 0x1250 (size: 0x108)
    FAnimNode_UseCachedPose AnimGraphNode_UseCachedPose;                              // 0x1358 (size: 0x28)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_2;                                  // 0x1380 (size: 0x128)
    FAnimNode_Root AnimGraphNode_Root_3;                                              // 0x14A8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_3;                        // 0x14C8 (size: 0xC8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace_1;     // 0x1590 (size: 0x20)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone_1;                                  // 0x15B0 (size: 0x128)
    FAnimNode_ModifyBone AnimGraphNode_ModifyBone;                                    // 0x16D8 (size: 0x128)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace_1;     // 0x1800 (size: 0x20)
    FAnimNode_Root AnimGraphNode_Root_2;                                              // 0x1820 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_2;                        // 0x1840 (size: 0xC8)
    FAnimNode_LookAt AnimGraphNode_LookAt;                                            // 0x1910 (size: 0x250)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x1B60 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x1B80 (size: 0x20)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x1BA0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_1;                        // 0x1BC0 (size: 0xC8)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x1C88 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x1D50 (size: 0x20)
    FPalCustomAnimOverrideData CustomData;                                            // 0x1D70 (size: 0x50)
    FRotator AimRotator;                                                              // 0x1DC0 (size: 0x18)
    FVector LookAtWorldLocation;                                                      // 0x1DD8 (size: 0x18)

    void FootIKOverride(FPoseLink InPose_0, FPoseLink& FootIKOverride);
    void SwimLeaningOverride(FPoseLink InPose_3, FVector2D LeaningVelocity, FPoseLink& SwimLeaningOverride);
    void WalkLeaningOverride(FPoseLink InPose_2, FVector2D LeaningVelocity, FPoseLink& WalkLeaningOverride);
    void FlyLeaningOverride(FPoseLink InPose_1, FVector2D LeaningVelocity, FPoseLink& FlyLeaningOverride);
    void CustomOverride(FPoseLink PrePose, FPalCustomAnimOverrideData CustomData, FPoseLink& CustomOverride);
    void AimingOverride(FPoseLink DefaultPose, FRotator AimRotator, FPoseLink& AimingOverride);
    void LookAtOverride(FPoseLink InPose, FVector LookAtWorldLocation, FPoseLink& LookAtOverride);
    void UpperOverride(FPoseLink NativePose, FPoseLink ActionPose, FPoseLink& UpperOverride);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_GrassGolem_Implementation_AnimGraphNode_ModifyBone_E7D1342E4F22F8AD0D7ED69FD2B80E34();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_GrassGolem_Implementation_AnimGraphNode_ModifyBone_830FA95848073CE85AE424A323C05565();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_GrassGolem_Implementation_AnimGraphNode_ModifyBone_02F5068142BCB23669D8229FF42C9843();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_GrassGolem_Implementation_AnimGraphNode_ModifyBone_E61D3D9F43B9C9CB2EB3B5B49124F67B();
    void ExecuteUbergraph_ABP_GrassGolem_Implementation(int32 EntryPoint);
}; // Size: 0x1DF0

#endif
