#ifndef UE4SS_SDK_F_Pal_TalkableLevelObjectVisibilityCondition_HPP
#define UE4SS_SDK_F_Pal_TalkableLevelObjectVisibilityCondition_HPP

struct FF_Pal_TalkableLevelObjectVisibilityCondition
{
    FName QuestId_2_D9B7606F4D3DB528F17220BE3FDFFB8B;                                 // 0x0000 (size: 0x8)
    TEnumAsByte<E_PalQuestState::Type> State_10_BA3ED0E440A013B313AF37B99E1D72A4;     // 0x0008 (size: 0x1)
    TSubclassOf<class UPalQuestBlock> Block_15_0276D8934E105B50A62AE298D3936387;      // 0x0010 (size: 0x8)
    bool Visibility_7_3D41B029498511674D48729FD0847C29;                               // 0x0018 (size: 0x1)
    bool Immediately_21_E0A3216843DFF0809FD000BD2264D0CD;                             // 0x0019 (size: 0x1)
    bool OnlyBeginPlay_12_5EF77F294465B6E0DDB8839E52D7851F;                           // 0x001A (size: 0x1)

}; // Size: 0x1B

#endif
