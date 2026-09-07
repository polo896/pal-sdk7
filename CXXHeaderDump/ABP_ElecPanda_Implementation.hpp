#ifndef UE4SS_SDK_ABP_ElecPanda_Implementation_HPP
#define UE4SS_SDK_ABP_ElecPanda_Implementation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_83;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_84;                                                          // 0x000C (size: 0x8)
    FName __NameProperty_85;                                                          // 0x0014 (size: 0x8)
    FName __NameProperty_86;                                                          // 0x001C (size: 0x8)
    FName __NameProperty_87;                                                          // 0x0024 (size: 0x8)
    FName __NameProperty_88;                                                          // 0x002C (size: 0x8)
    bool __BoolProperty_89;                                                           // 0x0034 (size: 0x1)
    float __FloatProperty_90;                                                         // 0x0038 (size: 0x4)
    float __FloatProperty_91;                                                         // 0x003C (size: 0x4)
    bool __BoolProperty_92;                                                           // 0x0040 (size: 0x1)
    EAnimSyncMethod __EnumProperty_93;                                                // 0x0041 (size: 0x1)
    TEnumAsByte<EAnimGroupRole::Type> __ByteProperty_94;                              // 0x0042 (size: 0x1)
    FName __NameProperty_95;                                                          // 0x0044 (size: 0x8)
    FName __NameProperty_96;                                                          // 0x004C (size: 0x8)
    FName __NameProperty_97;                                                          // 0x0054 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_98;                                         // 0x0060 (size: 0x20)
    FName __NameProperty_99;                                                          // 0x0080 (size: 0x8)
    FName __NameProperty_100;                                                         // 0x0088 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0090 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x0110 (size: 0x18)

}; // Size: 0x128

struct FAnimBlueprintGeneratedMutableData : public FAnimBlueprintMutableData
{
    float __FloatProperty;                                                            // 0x0004 (size: 0x4)

}; // Size: 0x8

class UABP_ElecPanda_Implementation_C : public UPalAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06E0 (size: 0x8)
    FAnimBlueprintGeneratedMutableData __AnimBlueprintMutables;                       // 0x06E8 (size: 0x8)
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
    FAnimNode_Root AnimGraphNode_Root_3;                                              // 0x0B88 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_3;                        // 0x0BA8 (size: 0xC8)
    FAnimNode_RotationOffsetBlendSpace AnimGraphNode_RotationOffsetBlendSpace;        // 0x0C70 (size: 0x118)
    FAnimNode_Root AnimGraphNode_Root_2;                                              // 0x0D88 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_2;                        // 0x0DA8 (size: 0xC8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x0E70 (size: 0x20)
    FAnimNode_LookAt AnimGraphNode_LookAt_2;                                          // 0x0E90 (size: 0x250)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x10E0 (size: 0x20)
    FAnimNode_LookAt AnimGraphNode_LookAt_1;                                          // 0x1100 (size: 0x250)
    FAnimNode_LookAt AnimGraphNode_LookAt;                                            // 0x1350 (size: 0x250)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x15A0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_1;                        // 0x15C0 (size: 0xC8)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x1688 (size: 0xC8)
    FAnimNode_LayeredBoneBlend AnimGraphNode_LayeredBoneBlend;                        // 0x1750 (size: 0xE0)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x1830 (size: 0x20)
    FRotator AimRotator;                                                              // 0x1850 (size: 0x18)
    FVector LookAtWorldLocation;                                                      // 0x1868 (size: 0x18)

    void CustomOverride(FPoseLink PrePose, FPalCustomAnimOverrideData CustomData, FPoseLink& CustomOverride);
    void AimingOverride(FPoseLink DefaultPose, FRotator AimRotator, FPoseLink& AimingOverride);
    void LookAtOverride(FPoseLink InPose, FVector LookAtWorldLocation, FPoseLink& LookAtOverride);
    void UpperOverride(FPoseLink NativePose, FPoseLink ActionPose, FPoseLink& UpperOverride);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_ElecPanda_Implementation_AnimGraphNode_RotationOffsetBlendSpace_03753B96488972CD431A1AA078104133();
    void ExecuteUbergraph_ABP_ElecPanda_Implementation(int32 EntryPoint);
}; // Size: 0x1880

#endif
