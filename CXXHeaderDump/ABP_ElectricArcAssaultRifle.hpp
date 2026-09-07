#ifndef UE4SS_SDK_ABP_ElectricArcAssaultRifle_HPP
#define UE4SS_SDK_ABP_ElectricArcAssaultRifle_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_26;                                                          // 0x0004 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_27;                                         // 0x0010 (size: 0x20)
    bool __BoolProperty_28;                                                           // 0x0030 (size: 0x1)
    float __FloatProperty_29;                                                         // 0x0034 (size: 0x4)
    FInputScaleBiasClampConstants __StructProperty_30;                                // 0x0038 (size: 0x2C)
    float __FloatProperty_31;                                                         // 0x0064 (size: 0x4)
    bool __BoolProperty_32;                                                           // 0x0068 (size: 0x1)
    EAnimSyncMethod __EnumProperty_33;                                                // 0x0069 (size: 0x1)
    TEnumAsByte<EAnimGroupRole::Type> __ByteProperty_34;                              // 0x006A (size: 0x1)
    FName __NameProperty_35;                                                          // 0x006C (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0078 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00F8 (size: 0x18)

}; // Size: 0x110

class UABP_ElectricArcAssaultRifle_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x0368 (size: 0x20)
    FAnimNode_ApplyAdditive AnimGraphNode_ApplyAdditive;                              // 0x0388 (size: 0xC8)
    FAnimNode_Slot AnimGraphNode_Slot;                                                // 0x0450 (size: 0x48)
    FAnimNode_SequencePlayer AnimGraphNode_SequencePlayer_1;                          // 0x0498 (size: 0x48)
    FAnimNode_SequencePlayer AnimGraphNode_SequencePlayer;                            // 0x04E0 (size: 0x48)
    bool IsShooting;                                                                  // 0x0528 (size: 0x1)

    void AnimGraph(FPoseLink& AnimGraph);
    void ExecuteUbergraph_ABP_ElectricArcAssaultRifle(int32 EntryPoint);
}; // Size: 0x529

#endif
