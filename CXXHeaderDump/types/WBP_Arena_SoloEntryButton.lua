---@meta

---@class UWBP_Arena_SoloEntryButton_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_normal UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field BP_PalTextBlock_Reward UBP_PalTextBlock_C
---@field Canvas_Lock UCanvasPanel
---@field Canvas_Reward UCanvasPanel
---@field Image_RankIcon UImage
---@field Text_Rank UBP_PalTextBlock_C
---@field Text_RankLevelText UBP_PalTextBlock_C
---@field WBP_PalInGameMenuItemSlotButton UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInGameMenuItemSlotButton_1 UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInGameMenuItemSlotButton_2 UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInGameMenuItemSlotButton_3 UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInGameMenuItemSlotButton_4 UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field ArenaRank EPalArenaRank
---@field OnArenaSoloButtonClicked FWBP_Arena_SoloEntryButton_COnArenaSoloButtonClicked
---@field RewardItemSlots TArray<UWBP_PalInGameMenuItemSlotButton_C>
---@field OnArenaSoloButtonHovered FWBP_Arena_SoloEntryButton_COnArenaSoloButtonHovered
---@field OnArenaSoloButtonUnhovered FWBP_Arena_SoloEntryButton_COnArenaSoloButtonUnhovered
---@field CurrentLock boolean
local UWBP_Arena_SoloEntryButton_C = {}

---@param IsLock boolean
function UWBP_Arena_SoloEntryButton_C:SetLock(IsLock) end
---@param Rank EPalArenaRank
function UWBP_Arena_SoloEntryButton_C:Setup(Rank) end
function UWBP_Arena_SoloEntryButton_C:AnmEvent_Focus() end
function UWBP_Arena_SoloEntryButton_C:AnmEvent_Normal() end
---@param Button UCommonButtonBase
function UWBP_Arena_SoloEntryButton_C:BndEvt__WBP_Arena_SoloEntryButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_SoloEntryButton_C:BndEvt__WBP_Arena_SoloEntryButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Arena_SoloEntryButton_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_Arena_SoloEntryButton_C:BndEvt__WBP_Arena_SoloEntryButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Arena_SoloEntryButton_C:OnInitialized() end
---@param IsFocus boolean
function UWBP_Arena_SoloEntryButton_C:ToggleFocusDisplay(IsFocus) end
---@param EntryPoint int32
function UWBP_Arena_SoloEntryButton_C:ExecuteUbergraph_WBP_Arena_SoloEntryButton(EntryPoint) end
---@param Button UWBP_Arena_SoloEntryButton_C
function UWBP_Arena_SoloEntryButton_C:OnArenaSoloButtonUnhovered__DelegateSignature(Button) end
---@param Button UWBP_Arena_SoloEntryButton_C
function UWBP_Arena_SoloEntryButton_C:OnArenaSoloButtonHovered__DelegateSignature(Button) end
---@param ArenaRank EPalArenaRank
function UWBP_Arena_SoloEntryButton_C:OnArenaSoloButtonClicked__DelegateSignature(ArenaRank) end


