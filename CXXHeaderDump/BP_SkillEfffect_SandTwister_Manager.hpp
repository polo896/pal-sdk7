#ifndef UE4SS_SDK_BP_SkillEfffect_SandTwister_Manager_HPP
#define UE4SS_SDK_BP_SkillEfffect_SandTwister_Manager_HPP

class ABP_SkillEfffect_SandTwister_Manager_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    FVector CenterLocation;                                                           // 0x0438 (size: 0x18)
    int32 CircleTornadoCount;                                                         // 0x0450 (size: 0x4)
    double CircleRadius;                                                              // 0x0458 (size: 0x8)
    TArray<FVector> CircleLocations;                                                  // 0x0460 (size: 0x10)
    float AttackDelay;                                                                // 0x0470 (size: 0x4)
    FTimerHandle AttackTimer;                                                         // 0x0478 (size: 0x8)
    TArray<class ABP_SkillEfffect_SandTwister_Tornado2_C*> CircleTornados;            // 0x0480 (size: 0x10)
    bool AttackAct;                                                                   // 0x0490 (size: 0x1)
    double RotateSpeed;                                                               // 0x0498 (size: 0x8)
    double RotateTimer;                                                               // 0x04A0 (size: 0x8)
    TArray<double> InitialPhase;                                                      // 0x04A8 (size: 0x10)

    void SpawnTornado();
    void SpawnOmen();
    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void CancelAttack();
    void ExecuteUbergraph_BP_SkillEfffect_SandTwister_Manager(int32 EntryPoint);
}; // Size: 0x4B8

#endif
