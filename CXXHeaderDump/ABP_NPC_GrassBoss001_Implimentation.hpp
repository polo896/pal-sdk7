#ifndef UE4SS_SDK_ABP_NPC_GrassBoss001_Implimentation_HPP
#define UE4SS_SDK_ABP_NPC_GrassBoss001_Implimentation_HPP

struct FAnimBlueprintGeneratedConstantData : public FAnimBlueprintConstantData
{
    FName __NameProperty_107;                                                         // 0x0004 (size: 0x8)
    bool __BoolProperty_108;                                                          // 0x000C (size: 0x1)
    float __FloatProperty_109;                                                        // 0x0010 (size: 0x4)
    FInputScaleBiasClampConstants __StructProperty_110;                               // 0x0014 (size: 0x2C)
    float __FloatProperty_111;                                                        // 0x0040 (size: 0x4)
    bool __BoolProperty_112;                                                          // 0x0044 (size: 0x1)
    EAnimSyncMethod __EnumProperty_113;                                               // 0x0045 (size: 0x1)
    TEnumAsByte<EAnimGroupRole::Type> __ByteProperty_114;                             // 0x0046 (size: 0x1)
    FAnimNodeFunctionRef __StructProperty_115;                                        // 0x0048 (size: 0x20)
    FName __NameProperty_116;                                                         // 0x0068 (size: 0x8)
    FName __NameProperty_117;                                                         // 0x0070 (size: 0x8)
    FAnimSubsystem_PropertyAccess AnimBlueprintExtension_PropertyAccess;              // 0x0078 (size: 0x80)
    FAnimSubsystem_Base AnimBlueprintExtension_Base;                                  // 0x00F8 (size: 0x18)

}; // Size: 0x110

class UABP_NPC_GrassBoss001_Implimentation_C : public UAnimInstance
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0350 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_PropertyAccess;                     // 0x0358 (size: 0x8)
    FAnimSubsystemInstance AnimBlueprintExtension_Base;                               // 0x0360 (size: 0x8)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_25;                           // 0x0370 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_24;                           // 0x0BB0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_23;                           // 0x13F0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_22;                           // 0x1C30 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_21;                           // 0x2470 (size: 0x840)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace_1;     // 0x2CB0 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace_1;     // 0x2CD0 (size: 0x20)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_20;                           // 0x2CF0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_19;                           // 0x3530 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_18;                           // 0x3D70 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_17;                           // 0x45B0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_16;                           // 0x4DF0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_15;                           // 0x5630 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_14;                           // 0x5E70 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_13;                           // 0x66B0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_12;                           // 0x6EF0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_11;                           // 0x7730 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_10;                           // 0x7F70 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_9;                            // 0x87B0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_8;                            // 0x8FF0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_7;                            // 0x9830 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_6;                            // 0xA070 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_5;                            // 0xA8B0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_4;                            // 0xB0F0 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_3;                            // 0xB930 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_2;                            // 0xC170 (size: 0x840)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics_1;                            // 0xC9B0 (size: 0x840)
    FAnimNode_Root AnimGraphNode_Root_1;                                              // 0xD1F0 (size: 0x20)
    FAnimNode_LinkedAnimLayer AnimGraphNode_LinkedAnimLayer;                          // 0xD210 (size: 0xC8)
    FAnimNode_ConvertLocalToComponentSpace AnimGraphNode_LocalToComponentSpace;       // 0xD2D8 (size: 0x20)
    FAnimNode_ConvertComponentToLocalSpace AnimGraphNode_ComponentToLocalSpace;       // 0xD2F8 (size: 0x20)
    FAnimNode_SequencePlayer AnimGraphNode_SequencePlayer;                            // 0xD318 (size: 0x48)
    FAnimNode_KawaiiPhysics AnimGraphNode_KawaiiPhysics;                              // 0xD360 (size: 0x840)
    FAnimNode_LinkedInputPose AnimGraphNode_LinkedInputPose;                          // 0xDBA0 (size: 0xC8)
    FAnimNode_Root AnimGraphNode_Root;                                                // 0xDC68 (size: 0x20)

    void NPC_HairClothLayer(FPoseLink InPose, FPoseLink& NPC_HairClothLayer);
    void AnimGraph(FPoseLink& AnimGraph);
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_1C1119534691E64A0B6A31A3E084FA5E();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_A4F714624D0AA81E02754AA1057137A2();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_8A522F804B9D45F27A750A9F9D105C44();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_AE79F1F24F9F95B84266698327FE04FF();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_1CB2977549C57A5972963796286C0A19();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_F7A5502A4EB33E5ED3F223A9FD01674B();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_48D103BA4F21159435FF4BA8CE79675F();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_D0A253074BA5A672F16854A56DCC238C();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_E6ACBF0944C1D76F46DE2A988C4D7443();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_34BA03164EBFE7D45D0BADB05FC414C1();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_FCEC9C9648353098CCC312A8C0BE056D();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_7E55D3234B45D5261D30BDB936EF962F();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_F35296B5409B423EB5636EA56135DFE4();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_8236EBFF471B471109B28499C0A96EB6();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_82AE135848847187DA9B2B9B0CEABDFF();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_8872B3F74C95A7F187A3AEA16858466D();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_6D23889D40017F98BC98F9877452AEA0();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_82377C084C2367114F29E1B1CBA2A561();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_A478E1C2417F6AAE791E04AC5524EAB6();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_8EA901314C7BC3DE917F369C4DE59BC9();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_D4A5DE3A4D2A919A7EAEDE9C1F75D7A4();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_AEB4AFE74F4759997DD362B0C046FF5D();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_36CC12B343EB9B90CCE90BAE85EA1920();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_A90B944646F11E9861DB6BBF597C5FFA();
    void EvaluateGraphExposedInputs_ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation_AnimGraphNode_KawaiiPhysics_39FD29A54CA1D4B33B5D6BA480CD4811();
    void ExecuteUbergraph_ABP_NPC_GrassBoss001_Implimentation(int32 EntryPoint);
}; // Size: 0xDC88

#endif
