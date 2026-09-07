---@meta

---@class UWBP_Altar_SelectStage_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_Dot UImage
---@field Image_Dot_1 UImage
---@field Image_Dot_2 UImage
---@field Image_Dot_3 UImage
---@field Image_Title_Base UImage
---@field Image_Title_Dot UImage
---@field Image_Title_Dot_1 UImage
---@field Image_Title_Dot_2 UImage
---@field Image_Title_Dot_3 UImage
---@field Image_Title_Line UImage
---@field Text_Title UBP_PalTextBlock_C
---@field WBP_Altar_SelectStage_Button_0 UWBP_Altar_SelectStage_Button_C
---@field WBP_Altar_SelectStage_Button_1 UWBP_Altar_SelectStage_Button_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
---@field OnClickedCloseButton FWBP_Altar_SelectStage_COnClickedCloseButton
---@field OnClickedBattleTypeButton FWBP_Altar_SelectStage_COnClickedBattleTypeButton
---@field OnClickedSubmitButton FWBP_Altar_SelectStage_COnClickedSubmitButton
local UWBP_Altar_SelectStage_C = {}

function UWBP_Altar_SelectStage_C:SetUnselectAll() end
function UWBP_Altar_SelectStage_C:Setup() end
function UWBP_Altar_SelectStage_C:BndEvt__WBP_Altar_SelectStage_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_Altar_SelectStage_C:ExecuteUbergraph_WBP_Altar_SelectStage(EntryPoint) end
function UWBP_Altar_SelectStage_C:OnClickedSubmitButton__DelegateSignature() end
---@param BattleType EPalRaidBossBattleType
function UWBP_Altar_SelectStage_C:OnClickedBattleTypeButton__DelegateSignature(BattleType) end
function UWBP_Altar_SelectStage_C:OnClickedCloseButton__DelegateSignature() end


