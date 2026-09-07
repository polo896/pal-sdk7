#ifndef UE4SS_SDK_ABP_M_Ancient001_Implimentation_HPP
#define UE4SS_SDK_ABP_M_Ancient001_Implimentation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_29;                                                          // 0x0004 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_30;                                         // 0x0010 (size: 0x20)
    FName __NameProperty_31;                                                          // 0x0030 (size: 0x8)
    FName __NameProperty_32;                                                          // 0x0038 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0040 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00C0 (size: 0x18)

}; // Size: 0xD8

class UABP_M_Ancient001_Implimentation_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_2;                            // 0x0370 (size: 0x840)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x0BB0 (size: 0x20)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_1;                            // 0x0BD0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics;                              // 0x1410 (size: 0x840)
    FAnimNode_BoneDrivenController AnimGraphNode_BoneDrivenController_1;              // 0x1C50 (size: 0x118)
    FAnimNode_BoneDrivenController AnimGraphNode_BoneDrivenController;                // 0x1D68 (size: 0x118)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x1E80 (size: 0x20)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x1EA0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x1EC0 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x1F88 (size: 0x20)

    void ClothLayer(FPoseLink InPose, FPoseLink& ClothLayer);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_M_Ancient001_Implimentation_AnimGraphNode_KawaiiPhysics_795F2B2843D3EECE37BA07B66EBFFA84();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_M_Ancient001_Implimentation_AnimGraphNode_KawaiiPhysics_47C9E17A4E321BCDC12EF89905C5CF85();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_M_Ancient001_Implimentation_AnimGraphNode_KawaiiPhysics_84A580E84659C1B7647791AE241E82ED();
    void ExecuteUbergraph_ABP_M_Ancient001_Implimentation(int32 EntryPoint);
}; // Size: 0x1FA8

#endif
