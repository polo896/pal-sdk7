---@meta

---@class UWBP_Arena_Spectate_List_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anim_NormalToFocus UWidgetAnimation
---@field Image_RankIcon_P1 UImage
---@field Image_RankIcon_P2 UImage
---@field Overlay_Match UOverlay
---@field Overlay_Prepare UOverlay
---@field Text_Condition_TimeNum UBP_PalTextBlock_C
---@field Text_GuildName_P1 UBP_PalTextBlock_C
---@field Text_GuildName_P2 UBP_PalTextBlock_C
---@field Text_PlayerName_P1 UBP_PalTextBlock_C
---@field Text_PlayerName_P2 UBP_PalTextBlock_C
---@field WBP_Arena_PalIcon UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_1 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_2 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_3 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_4 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_10 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_11 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_12 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_13 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_14 UWBP_Arena_PalIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field Player1Otomos TArray<UWBP_Arena_PalIcon_C>
---@field Player2Otomos TArray<UWBP_Arena_PalIcon_C>
---@field OnSpecClicked FWBP_Arena_Spectate_List_COnSpecClicked
---@field OnSpecHovered FWBP_Arena_Spectate_List_COnSpecHovered
---@field OnSpecUnhovered FWBP_Arena_Spectate_List_COnSpecUnhovered
---@field ['Start Time'] FGameDateTime
---@field TimeUpdateTimer FTimerHandle
---@field ['Time Limit'] int32
local UWBP_Arena_Spectate_List_C = {}

function UWBP_Arena_Spectate_List_C:UpdateTimer() end
---@param RoomInfo FPalArenaSpectateRoomInfo
function UWBP_Arena_Spectate_List_C:Setup(RoomInfo) end
function UWBP_Arena_Spectate_List_C:AnmEvent_Focus() end
function UWBP_Arena_Spectate_List_C:AnmEvent_Normal() end
function UWBP_Arena_Spectate_List_C:OnInitialized() end
---@param Button UCommonButtonBase
function UWBP_Arena_Spectate_List_C:BndEvt__WBP_Arena_Spectate_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_Spectate_List_C:BndEvt__WBP_Arena_Spectate_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_Spectate_List_C:BndEvt__WBP_Arena_Spectate_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Arena_Spectate_List_C:Destruct() end
function UWBP_Arena_Spectate_List_C:Construct() end
---@param EntryPoint int32
function UWBP_Arena_Spectate_List_C:ExecuteUbergraph_WBP_Arena_Spectate_List(EntryPoint) end
---@param ListUI UWBP_Arena_Spectate_List_C
function UWBP_Arena_Spectate_List_C:OnSpecUnhovered__DelegateSignature(ListUI) end
---@param ListUI UWBP_Arena_Spectate_List_C
function UWBP_Arena_Spectate_List_C:OnSpecHovered__DelegateSignature(ListUI) end
---@param ListUI UWBP_Arena_Spectate_List_C
function UWBP_Arena_Spectate_List_C:OnSpecClicked__DelegateSignature(ListUI) end


