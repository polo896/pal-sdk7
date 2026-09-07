---@meta

---@class UWBP_Altar_SelectStage_Button_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Selected UWidgetAnimation
---@field Anm_Default UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field Frame_Focus_Flare UImage
---@field Image UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_61 UImage
---@field Image_Button_Base UImage
---@field Image_Button_Base_Selected UImage
---@field Image_Button_Base_Selected_1 UImage
---@field Image_Button_Dot UImage
---@field Image_Button_Dot_1 UImage
---@field Image_Button_Dot_2 UImage
---@field Image_Button_Dot_3 UImage
---@field Image_Button_Frame UImage
---@field Image_Button_Frame_1 UImage
---@field Image_Pic UImage
---@field Overlay_Focus UOverlay
---@field RichText_StageInfo UBP_PalRichTextBlock_C
---@field Text_StageName UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClickedButton FWBP_Altar_SelectStage_Button_COnClickedButton
---@field Selected boolean
---@field BattleType EPalRaidBossBattleType
local UWBP_Altar_SelectStage_Button_C = {}

function UWBP_Altar_SelectStage_Button_C:Setup() end
---@param InBattleType EPalRaidBossBattleType
function UWBP_Altar_SelectStage_Button_C:SetupVisual(InBattleType) end
---@param bForce boolean
function UWBP_Altar_SelectStage_Button_C:SetUnselect(bForce) end
function UWBP_Altar_SelectStage_Button_C:SetSelected() end
---@param IsDesignTime boolean
function UWBP_Altar_SelectStage_Button_C:PreConstruct(IsDesignTime) end
---@param Button UCommonButtonBase
function UWBP_Altar_SelectStage_Button_C:BndEvt__WBP_Altar_SelectStage_Button_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Altar_SelectStage_Button_C:BndEvt__WBP_Altar_SelectStage_Button_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Altar_SelectStage_Button_C:BndEvt__WBP_Altar_SelectStage_Button_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Altar_SelectStage_Button_C:ExecuteUbergraph_WBP_Altar_SelectStage_Button(EntryPoint) end
---@param SelfSlot UWBP_Altar_SelectStage_Button_C
function UWBP_Altar_SelectStage_Button_C:OnClickedButton__DelegateSignature(SelfSlot) end


