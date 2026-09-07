#ifndef UE4SS_SDK_ABP_GhostDragon_Implementation_HPP
#define UE4SS_SDK_ABP_GhostDragon_Implementation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_73;                                                          // 0x0004 (size: 0x8)
    FName __NameProperty_74;                                                          // 0x000C (size: 0x8)
    FName __NameProperty_75;                                                          // 0x0014 (size: 0x8)
    FName __NameProperty_76;                                                          // 0x001C (size: 0x8)
    float __FloatProperty_77;                                                         // 0x0024 (size: 0x4)
    bool __BoolProperty_78;                                                           // 0x0028 (size: 0x1)
    float __FloatProperty_79;                                                         // 0x002C (size: 0x4)
    bool __BoolProperty_80;                                                           // 0x0030 (size: 0x1)
    EAnimSyncMethod __EnumProperty_81;                                                // 0x0031 (size: 0x1)
    TEnumAsByte<EAnimGroupRole::Type> __ByteProperty_82;                              // 0x0032 (size: 0x1)
    FName __NameProperty_83;                                                          // 0x0034 (size: 0x8)
    FName __NameProperty_84;                                                          // 0x003C (size: 0x8)
    FName __NameProperty_85;                                                          // 0x0044 (size: 0x8)
    FName __NameProperty_86;                                                          // 0x004C (size: 0x8)
    FName __NameProperty_87;                                                          // 0x0054 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_88;                                         // 0x0060 (size: 0x20)
    FName __NameProperty_89;                                                          // 0x0080 (size: 0x8)
    FName __NameProperty_90;                                                          // 0x0088 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0090 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x0110 (size: 0x18)

}; // Size: 0x128

struct FAnimBlueprintGeneratedMutableData : public FAnimBlueprintMutableData
{
    float __FloatProperty;                                                            // 0x0004 (size: 0x4)
    float __FloatProperty_0;                                                          // 0x0008 (size: 0x4)

}; // Size: 0xC

class UABP_GhostDragon_Implementation_C : public UPalAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06E0 (size: 0x8)
    FAnimBlueprintGeneratedMutableData __AnimBlueprintMutables;                       // 0x06E8 (size: 0xC)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x06F8 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0700 (size: 0x8)
    FAnimNode_Root AnimGraphNode_Root_8;                                              // 0x0708 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_8;                        // 0x0728 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_7;                                              // 0x07F0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_7;                        // 0x0810 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_6;                                              // 0x08D8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_6;                        // 0x08F8 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_5;                                              // 0x09C0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_5;                        // 0x09E0 (size: 0xC8)
    FAnimNode_RotationOffsetBlendSpace AnimGraphNode_RotationOffsetBlendSpace;        // 0x0AA8 (size: 0x118)
    FAnimNode_Root AnimGraphNode_Root_4;                                              // 0x0BC0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_4;                        // 0x0BE0 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_3;                                              // 0x0CA8 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_3;                        // 0x0CC8 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root_2;                                              // 0x0D90 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_2;                        // 0x0DB0 (size: 0xC8)
    FAnimNode_LookAt AnimGraphNode_LookAt;                                            // 0x0E80 (size: 0x250)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x10D0 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x10F0 (size: 0x20)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x1110 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose_1;                        // 0x1130 (size: 0xC8)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x11F8 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x12C0 (size: 0x20)
    FVector2D LeaningVelocity;                                                        // 0x12E0 (size: 0x10)
    FVector LookAtWorldLocation;                                                      // 0x12F0 (size: 0x18)

    void FootIKOverride(FPoseLink InPose_0, FPoseLink& FootIKOverride);
    void SwimLeaningOverride(FPoseLink InPose_3, FVector2D LeaningVelocity, FPoseLink& SwimLeaningOverride);
    void WalkLeaningOverride(FPoseLink InPose_2, FVector2D LeaningVelocity, FPoseLink& WalkLeaningOverride);
    void FlyLeaningOverride(FPoseLink InPose_1, FVector2D LeaningVelocity, FPoseLink& FlyLeaningOverride);
    void CustomOverride(FPoseLink PrePose, FPalCustomAnimOverrideData CustomData, FPoseLink& CustomOverride);
    void AimingOverride(FPoseLink DefaultPose, FRotator AimRotator, FPoseLink& AimingOverride);
    void LookAtOverride(FPoseLink InPose, FVector LookAtWorldLocation, FPoseLink& LookAtOverride);
    void UpperOverride(FPoseLink NativePose, FPoseLink ActionPose, FPoseLink& UpperOverride);
    void AnimGraph(FPoseLink& AnimGraph);
    void ExecuteUbergraph_ABP_GhostDragon_Implementation(int32 EntryPoint);
}; // Size: 0x1308

#endif
