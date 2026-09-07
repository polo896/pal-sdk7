---@meta

---@class UWBP_Expedition_StageList_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field Canvas_Recruit UCanvasPanel
---@field Image_Base UImage
---@field Overlay_Lock UOverlay
---@field Text_Difficulty UBP_PalTextBlock_C
---@field Text_DungeonName UBP_PalTextBlock_C
---@field Text_UnlockCondition_1 UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClicked FWBP_Expedition_StageList_COnClicked
---@field MyMissionInfo FPalCharacterTeamMissionInfo
---@field DifficultyMsgIDMap TMap<EPalCharacterTeamMissionDifficulty, FDataTableRowHandle>
---@field DifficultyTextColorMap TMap<EPalCharacterTeamMissionDifficulty, FSlateColor>
---@field OnHovered FWBP_Expedition_StageList_COnHovered
---@field OnUnhovered FWBP_Expedition_StageList_COnUnhovered
local UWBP_Expedition_StageList_C = {}

function UWBP_Expedition_StageList_C:SetupDisabledMissionInfo() end
function UWBP_Expedition_StageList_C:SetupDungeonTexture() end
---@param bIsVisible boolean
function UWBP_Expedition_StageList_C:SetVisibilityRecruiting(bIsVisible) end
---@param MissionInfo FPalCharacterTeamMissionInfo
function UWBP_Expedition_StageList_C:GetMissionInfo(MissionInfo) end
function UWBP_Expedition_StageList_C:SetupDifficulty() end
function UWBP_Expedition_StageList_C:SetupMissionName() end
---@param MissionId FName
function UWBP_Expedition_StageList_C:GetMissionID(MissionId) end
---@param MissionInfo FPalCharacterTeamMissionInfo
function UWBP_Expedition_StageList_C:Setup(MissionInfo) end
function UWBP_Expedition_StageList_C:AnmEvent_Focus() end
function UWBP_Expedition_StageList_C:AnmEvent_Normal() end
---@param Button UCommonButtonBase
function UWBP_Expedition_StageList_C:BndEvt__WBP_Expedition_StageList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Expedition_StageList_C:BndEvt__WBP_Expedition_StageList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Expedition_StageList_C:BndEvt__WBP_Expedition_StageList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Expedition_StageList_C:ExecuteUbergraph_WBP_Expedition_StageList(EntryPoint) end
---@param Widget UWBP_Expedition_StageList_C
function UWBP_Expedition_StageList_C:OnUnhovered__DelegateSignature(Widget) end
---@param Widget UWBP_Expedition_StageList_C
function UWBP_Expedition_StageList_C:OnHovered__DelegateSignature(Widget) end
---@param Widget UWBP_Expedition_StageList_C
function UWBP_Expedition_StageList_C:OnClicked__DelegateSignature(Widget) end


