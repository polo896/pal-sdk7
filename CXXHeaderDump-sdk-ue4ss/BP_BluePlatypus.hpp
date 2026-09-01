#ifndef UE4SS_SDK_BP_BluePlatypus_HPP
#define UE4SS_SDK_BP_BluePlatypus_HPP

class ABP_BluePlatypus_C : public ABP_MonsterBase_C
{
    class UPalBodyPartsSphereComponent* PalBodyPartsSphere1;                          // 0x0D30 (size: 0x8)
    class UPalBodyPartsSphereComponent* PalBodyPartsSphere;                           // 0x0D38 (size: 0x8)

    void GetWazaPowerRate(EPalWazaID Waza);
}; // Size: 0xD40

#endif
