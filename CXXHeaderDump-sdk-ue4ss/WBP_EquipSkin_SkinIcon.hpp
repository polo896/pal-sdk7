#ifndef UE4SS_SDK_WBP_EquipSkin_SkinIcon_HPP
#define UE4SS_SDK_WBP_EquipSkin_SkinIcon_HPP

class UWBP_EquipSkin_SkinIcon_C : public UPalUserWidget
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0450 (size: 0x8)
    class UCircularThrobber* CircularThrobber;                                        // 0x0458 (size: 0x8)
    class UImage* Image;                                                              // 0x0460 (size: 0x8)
    FWBP_EquipSkin_SkinIcon_COnLoadedTexture OnLoadedTexture;                         // 0x0468 (size: 0x10)
    void OnLoadedTexture(class UTexture2D* Texture);
    FWBP_EquipSkin_SkinIcon_COnStartLoadTexture OnStartLoadTexture;                   // 0x0478 (size: 0x10)
    void OnStartLoadTexture();
    FWBP_EquipSkin_SkinIcon_COnSetEmpty OnSetEmpty;                                   // 0x0488 (size: 0x10)
    void OnSetEmpty();

    void SetEmpty();
    void Setup(FName SkinName, bool IsEquip);
    void OnLoaded_F4FCEC97410E591228B5AA8532DA5248(class UObject* Loaded);
    void LoadIconEvent_Internal(TSoftObjectPtr<class UTexture2D> SoftTexture);
    void ExecuteUbergraph_WBP_EquipSkin_SkinIcon(int32 EntryPoint);
    void OnSetEmpty__DelegateSignature();
    void OnStartLoadTexture__DelegateSignature();
    void OnLoadedTexture__DelegateSignature(class UTexture2D* Texture);
}; // Size: 0x498

#endif
