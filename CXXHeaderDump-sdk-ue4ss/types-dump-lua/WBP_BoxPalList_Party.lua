---@meta

---@class UWBP_BoxPalList_Party_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_PalBox UCanvasPanel
---@field WBP_BoxPalList UWBP_BoxPalList_C
---@field WBP_PalCommonCharacterSlotButton UWBP_PalCommonCharacterSlotButton_C
---@field WBP_PalCommonCharacterSlotButton_1 UWBP_PalCommonCharacterSlotButton_C
---@field WBP_PalCommonCharacterSlotButton_2 UWBP_PalCommonCharacterSlotButton_C
---@field WBP_PalCommonCharacterSlotButton_3 UWBP_PalCommonCharacterSlotButton_C
---@field WBP_PalCommonCharacterSlotButton_4 UWBP_PalCommonCharacterSlotButton_C
---@field PartySlots TArray<UWBP_PalCommonCharacterSlotButton_C>
---@field OnLeftClickedSlot FWBP_BoxPalList_Party_COnLeftClickedSlot
---@field OnRightClickedSlot FWBP_BoxPalList_Party_COnRightClickedSlot
---@field OnHoverSlot FWBP_BoxPalList_Party_COnHoverSlot
---@field OnUnhoverSlot FWBP_BoxPalList_Party_COnUnhoverSlot
---@field OnCreatedNewSlot FWBP_BoxPalList_Party_COnCreatedNewSlot
---@field OnPageUpdated FWBP_BoxPalList_Party_COnPageUpdated
---@field OverrideLeftPageInputAction FPalDataTableRowName_UIInputAction
---@field OverrideRightPageInputAction FPalDataTableRowName_UIInputAction
local UWBP_BoxPalList_Party_C = {}

---@param TargetSlot UPalIndividualCharacterSlot
function UWBP_BoxPalList_Party_C:ToggleFavorite(TargetSlot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_BoxPalList_Party_C:OnClickSlot_Internal(Slot, PressType) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:OnUnhoverSlot_Internal(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:OnHoverSlot_Internal(Slot) end
UWBP_BoxPalList_Party_C['Setup Party Slot'] = function(self, ) end
---@param TargetWidget UWidget
function UWBP_BoxPalList_Party_C:GetLastFocusBoxSlot(TargetWidget) end
---@param Slot UPalIndividualCharacterSlot
---@param PressType EPalItemSlotPressType
function UWBP_BoxPalList_Party_C:SelectSlot(Slot, PressType) end
---@param Slot UPalIndividualCharacterSlot
function UWBP_BoxPalList_Party_C:TryMoveToBox(Slot) end
---@param Widget UWidget
function UWBP_BoxPalList_Party_C:GetFirstFocusPartyButton(Widget) end
---@param PartySlots TArray<UWBP_PalCommonCharacterSlotButton_C>
function UWBP_BoxPalList_Party_C:GetPartySlots(PartySlots) end
function UWBP_BoxPalList_Party_C:OnInitialized() end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_BoxPalList_Party_C:BndEvt__WBP_BoxPalList_Party_WBP_BoxPalList_K2Node_ComponentBoundEvent_0_OnLeftClickedSlot__DelegateSignature(Widget, PressType) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:BndEvt__WBP_BoxPalList_Party_WBP_BoxPalList_K2Node_ComponentBoundEvent_1_OnHoveredSlot__DelegateSignature(Widget) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:BndEvt__WBP_BoxPalList_Party_WBP_BoxPalList_K2Node_ComponentBoundEvent_2_OnUnhoveredSlot__DelegateSignature(Widget) end
---@param NewSlot UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:BndEvt__WBP_BoxPalList_Party_WBP_BoxPalList_K2Node_ComponentBoundEvent_3_OnCreatedNewSlot__DelegateSignature(NewSlot) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:BndEvt__WBP_BoxPalList_Party_WBP_BoxPalList_K2Node_ComponentBoundEvent_4_OnRightClickedSlot__DelegateSignature(Widget) end
---@param NowPage int32
function UWBP_BoxPalList_Party_C:BndEvt__WBP_BoxPalList_Party_WBP_BoxPalList_K2Node_ComponentBoundEvent_5_OnUpdatedPage__DelegateSignature(NowPage) end
---@param IsDesignTime boolean
function UWBP_BoxPalList_Party_C:PreConstruct(IsDesignTime) end
---@param EntryPoint int32
function UWBP_BoxPalList_Party_C:ExecuteUbergraph_WBP_BoxPalList_Party(EntryPoint) end
---@param Page int32
function UWBP_BoxPalList_Party_C:OnPageUpdated__DelegateSignature(Page) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:OnRightClickedSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:OnCreatedNewSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:OnUnhoverSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_BoxPalList_Party_C:OnHoverSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_BoxPalList_Party_C:OnLeftClickedSlot__DelegateSignature(Slot, PressType) end


