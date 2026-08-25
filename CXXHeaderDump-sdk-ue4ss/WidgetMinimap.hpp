#ifndef UE4SS_SDK_WidgetMinimap_HPP
#define UE4SS_SDK_WidgetMinimap_HPP

class UWidgetMinimap_C : public UPalUserWidgetWorldHUD
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0450 (size: 0x8)
    class UTextBlock* coords;                                                         // 0x0458 (size: 0x8)
    class UImage* Image_0;                                                            // 0x0460 (size: 0x8)
    class UOverlay* MinimapOverlay;                                                   // 0x0468 (size: 0x8)
    class URichTextBlock* OverlayText;                                                // 0x0470 (size: 0x8)
    class AModActor_C* ModActorDelegate;                                              // 0x0478 (size: 0x8)
    class UMaterialInstanceDynamic* MinimapDynamicMaterial;                           // 0x0480 (size: 0x8)
    bool bOverlayTextLocalized;                                                       // 0x0488 (size: 0x1)

    void GetCoordinateText(FText& Text);
    void UpdateSizeAndPosition();
    void GetMapPositionMode();
    void GetMapVisibility();
    void Tick(FGeometry MyGeometry, float InDeltaTime);
    void OnSetup();
    void ExecuteUbergraph_WidgetMinimap(int32 EntryPoint);
}; // Size: 0x489

#endif
