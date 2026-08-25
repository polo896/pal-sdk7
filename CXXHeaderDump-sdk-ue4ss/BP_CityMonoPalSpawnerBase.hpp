#ifndef UE4SS_SDK_BP_CityMonoPalSpawnerBase_HPP
#define UE4SS_SDK_BP_CityMonoPalSpawnerBase_HPP

class ABP_CityMonoPalSpawnerBase_C : public APalNPCSpawnerBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0528 (size: 0x8)
    class UStaticMeshComponent* DebugMesh;                                            // 0x0530 (size: 0x8)
    class USphereComponent* SpawnCollision;                                           // 0x0538 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0540 (size: 0x8)
    bool NotSleepFlag;                                                                // 0x0548 (size: 0x1)
    class ABP_MonsterBase_C* tempSpawnedMonster;                                      // 0x0550 (size: 0x8)
    TArray<class UPalIndividualCharacterHandle*> IndividualHandleList;                // 0x0558 (size: 0x10)
    double ReturnTerritoryRadius;                                                     // 0x0568 (size: 0x8)
    double WanderingRadius;                                                           // 0x0570 (size: 0x8)
    FVector BattleStartLocation;                                                      // 0x0578 (size: 0x18)
    double SpawnRadius;                                                               // 0x0590 (size: 0x8)
    double RayStartUpOffset;                                                          // 0x0598 (size: 0x8)
    double WildLifeWalkingAreaRadius;                                                 // 0x05A0 (size: 0x8)
    TEnumAsByte<ELeashType::Type> LeashType;                                          // 0x05A8 (size: 0x1)
    double DespawnPlusDistance;                                                       // 0x05B0 (size: 0x8)
    bool IsLoading;                                                                   // 0x05B8 (size: 0x1)
    bool IsWorldLoadComplete;                                                         // 0x05B9 (size: 0x1)
    FName SpawnerName;                                                                // 0x05BC (size: 0x8)
    EPalSpawnedCharacterType SpawnerType;                                             // 0x05C4 (size: 0x1)
    double ReturnRadiusRate_Combat;                                                   // 0x05C8 (size: 0x8)
    int32 Level;                                                                      // 0x05D0 (size: 0x4)
    FPalDataTableRowName_PalMonsterData PalName;                                      // 0x05D4 (size: 0x8)
    TSubclassOf<class UPalActionBase> DefaultAction;                                  // 0x05E0 (size: 0x8)
    EPalFacialEyeType StartFacial;                                                    // 0x05E8 (size: 0x1)
    EPalOrganizationType OverridePalOrganizationType;                                 // 0x05E9 (size: 0x1)

    FName GetSpawnerName();
    void GetAllSpawnedNPCHandle(TArray<class UPalIndividualCharacterHandle*>& Handles);
    float GetSpawnPointRadius();
    void BlueprintTick_Despawning(float DeltaTime);
    void BlueprintTick_Spawning(float DeltaTime);
    void Spawn Reauest();
    void ExistAliveCharacter(bool& Exist);
    void IsWorldPartitionLoadComplete(bool& IsLoading);
    void IsCharacterLoading(bool& IsLoading);
    void CheckIntervalByDistance();
    void BP_PalSpawner_Standard_AutoGenFunc(class AActor* DestroyedActor);
    void CheckWorldLoadCompleted();
    void IsAlwaysSpawn(bool& Always);
    void RemoveHandleList(class APalCharacter* Monster);
    void FindIndividualHandle(FPalInstanceID ID, class UPalIndividualCharacterHandle*& Handle);
    void DespawnDelegate(FPalInstanceID ID);
    void Spawn Delegate(FPalInstanceID ID);
    void CheckSpawn(double DeltaTime);
    void Despawn();
    void Spawn();
    void ReceiveBeginPlay();
    void カスタムイベント_0();
    void SetAllNPCLocation();
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void SpawnRequest_ByOutside(bool IsDeleteAliveCharacter);
    void ExecuteUbergraph_BP_CityMonoPalSpawnerBase(int32 EntryPoint);
}; // Size: 0x5EA

#endif
