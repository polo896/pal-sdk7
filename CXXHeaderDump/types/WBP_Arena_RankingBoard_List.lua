---@meta

---@class UWBP_Arena_RankingBoard_List_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_Base_Myself UImage
---@field Image_Icon_NPC UImage
---@field Image_RankIcon UImage
---@field Text_GuildName UBP_PalTextBlock_C
---@field Text_PlayerName UBP_PalTextBlock_C
---@field Text_RankNum UBP_PalTextBlock_C
---@field Text_RankPointNum UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnListHovered FWBP_Arena_RankingBoard_List_COnListHovered
local UWBP_Arena_RankingBoard_List_C = {}

---@param RankingInfo FPalArenaWorldRankingRecord
function UWBP_Arena_RankingBoard_List_C:Setup(RankingInfo) end
---@param Button UCommonButtonBase
function UWBP_Arena_RankingBoard_List_C:BndEvt__WBP_Arena_RankingBoard_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Arena_RankingBoard_List_C:ExecuteUbergraph_WBP_Arena_RankingBoard_List(EntryPoint) end
---@param Widget UWidget
function UWBP_Arena_RankingBoard_List_C:OnListHovered__DelegateSignature(Widget) end


