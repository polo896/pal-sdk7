#ifndef UE4SS_SDK_ABP_NPC_Male_Ninja01_Implimentation_HPP
#define UE4SS_SDK_ABP_NPC_Male_Ninja01_Implimentation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_38;                                                          // 0x0004 (size: 0x8)
    FAnimNodeFunctionRef __StructProperty_39;                                         // 0x0010 (size: 0x20)
    FName __NameProperty_40;                                                          // 0x0030 (size: 0x8)
    FName __NameProperty_41;                                                          // 0x0038 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0040 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00C0 (size: 0x18)

}; // Size: 0xD8

class UABP_NPC_Male_Ninja01_Implimentation_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_7;                            // 0x0370 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_6;                            // 0x0BB0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_5;                            // 0x13F0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_4;                            // 0x1C30 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_3;                            // 0x2470 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_2;                            // 0x2CB0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_1;                            // 0x34F0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics;                              // 0x3D30 (size: 0x840)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0x4570 (size: 0x20)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0x4590 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0x45B0 (size: 0x20)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0x45D0 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0x4698 (size: 0x20)

    void NPC_HairClothLayer(FPoseLink InPose, FPoseLink& NPC_HairClothLayer);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_5FCAAC824D4EEC40B7F33C91F4602BD7();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_CEDD8AF24D12CBE62234E98FA0CEA514();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_A3D163CD44BB3DD6D41985A319CEF990();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_B5077E3A47D38186613CB983F4649B4A();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_C0E405F441D96FF95EBE9187A7AF571A();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_22C3B9BB46407711E3E04ABD013619F0();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_DD1A35F545FD9935DAAD408CFFDEBF5D();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation_AnimGraphNode_KawaiiPhysics_05CF87B04D1C3881A2773798B860403A();
    void ExecuteUbergraph_ABP_NPC_Male_Ninja01_Implimentation(int32 EntryPoint);
}; // Size: 0x46B8

#endif
