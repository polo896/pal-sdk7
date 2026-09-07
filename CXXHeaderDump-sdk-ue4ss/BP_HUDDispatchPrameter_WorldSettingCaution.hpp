#ifndef UE4SS_SDK_BP_HUDDispatchPrameter_WorldSettingCaution_HPP
#define UE4SS_SDK_BP_HUDDispatchPrameter_WorldSettingCaution_HPP

class UBP_HUDDispatchPrameter_WorldSettingCaution_C : public UPalHUDDispatchParameterBase
{
    FPalOptionWorldSettings CheckWorldSettings;                                       // 0x0038 (size: 0x210)
    bool bOutCanceled;                                                                // 0x0248 (size: 0x1)
    TEnumAsByte<E_PalWOrldSettingThresoldCautionDialogOpenType::Type> OpenType;       // 0x0249 (size: 0x1)

}; // Size: 0x24A

#endif
