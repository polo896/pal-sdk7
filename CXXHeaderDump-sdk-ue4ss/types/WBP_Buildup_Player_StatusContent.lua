---@meta

---@class UWBP_Buildup_Player_StatusContent_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field Anm_RankUp UWidgetAnimation
---@field Canvas_Button_Minus UCanvasPanel
---@field Canvas_Button_Plus UCanvasPanel
---@field Canvas_RequireNum UCanvasPanel
---@field CanvasPanel_0 UCanvasPanel
---@field HorizontalBox_Gauge UHorizontalBox
---@field IconItem UImage
---@field IconStatus UImage
---@field Overlay_Frame UOverlay
---@field StatusArrow UImage
---@field Text_BuildupStoneNum UBP_PalTextBlock_C
---@field Text_Max UBP_PalTextBlock_C
---@field Text_StatusNeme UBP_PalTextBlock_C
---@field Text_StatusNumAfter UBP_PalTextBlock_C
---@field Text_StatusNumBefore UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton_Fill UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Minus UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Plus UWBP_PalInvisibleButton_C
---@field OnHoveredButton_General FWBP_Buildup_Player_StatusContent_COnHoveredButton_General
---@field OnUnhovered_General FWBP_Buildup_Player_StatusContent_COnUnhovered_General
---@field MyRelicType EPalRelicType
---@field GaugeBarWidgets TArray<UWBP_Buildup_Gauge_C>
---@field CurrentRank int32
---@field CurrentSimulateAddRank int32
---@field OnSimulateChanged FWBP_Buildup_Player_StatusContent_COnSimulateChanged
---@field bIsMaxRankFlag boolean
---@field ClickSound UAkAudioEvent
---@field ErrorSound UAkAudioEvent
---@field AcceptInput boolean
local UWBP_Buildup_Player_StatusContent_C = {}

---@param NewAcceptInput boolean
function UWBP_Buildup_Player_StatusContent_C:SetAcceptInput(NewAcceptInput) end
---@param bCanRankup boolean
function UWBP_Buildup_Player_StatusContent_C:CanSimulateRankupToNext(bCanRankup) end
function UWBP_Buildup_Player_StatusContent_C:UpdateSimulationButton() end
---@param Rank int32
---@param Text FText
function UWBP_Buildup_Player_StatusContent_C:BuildEffectValueText(Rank, Text) end
---@param bIsMaxRank boolean
function UWBP_Buildup_Player_StatusContent_C:IsMaxRank(bIsMaxRank) end
---@param ToRank int32
function UWBP_Buildup_Player_StatusContent_C:GetSImulatedRank(ToRank) end
---@param bIsSimulating boolean
function UWBP_Buildup_Player_StatusContent_C:IsSimulating(bIsSimulating) end
---@param RelicType EPalRelicType
function UWBP_Buildup_Player_StatusContent_C:GetBindedRelicType(RelicType) end
function UWBP_Buildup_Player_StatusContent_C:UpdateSimulate() end
function UWBP_Buildup_Player_StatusContent_C:DisplayCurrentRank() end
function UWBP_Buildup_Player_StatusContent_C:SetupRankGauge() end
function UWBP_Buildup_Player_StatusContent_C:ResetSimulation() end
function UWBP_Buildup_Player_StatusContent_C:SimulationMinus() end
function UWBP_Buildup_Player_StatusContent_C:SimlationPlus() end
---@param RelicType EPalRelicType
function UWBP_Buildup_Player_StatusContent_C:SetRelicType(RelicType) end
function UWBP_Buildup_Player_StatusContent_C:AnmEvent_Rankup() end
function UWBP_Buildup_Player_StatusContent_C:AnmEvent_Focus() end
function UWBP_Buildup_Player_StatusContent_C:AnmEvent_Normal() end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Fill_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Fill_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Minus_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Plus_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Minus_K2Node_ComponentBoundEvent_4_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Minus_K2Node_ComponentBoundEvent_5_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Plus_K2Node_ComponentBoundEvent_6_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Player_StatusContent_C:BndEvt__WBP_Buildup_Player_StatusContent_WBP_PalInvisibleButton_Plus_K2Node_ComponentBoundEvent_7_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Buildup_Player_StatusContent_C:ExecuteUbergraph_WBP_Buildup_Player_StatusContent(EntryPoint) end
---@param RelicType EPalRelicType
---@param OriginalRank int32
---@param CurrentSimulationRank int32
function UWBP_Buildup_Player_StatusContent_C:OnSimulateChanged__DelegateSignature(RelicType, OriginalRank, CurrentSimulationRank) end
---@param Widget UWBP_Buildup_Player_StatusContent_C
function UWBP_Buildup_Player_StatusContent_C:OnUnhovered_General__DelegateSignature(Widget) end
---@param Widget UWBP_Buildup_Player_StatusContent_C
function UWBP_Buildup_Player_StatusContent_C:OnHoveredButton_General__DelegateSignature(Widget) end


