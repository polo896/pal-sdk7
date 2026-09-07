---@meta

---@class UWBP_Ingame_Incubator_AllOpen_C : UPalUIObtainCharactersPerformance
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Close UWidgetAnimation
---@field Anm_Open UWidgetAnimation
---@field Text_RewardInfo UBP_PalTextBlock_C
---@field Text_Title UBP_PalTextBlock_C
---@field WBP_CommonButton_Close UWBP_CommonButton_C
---@field WBP_Ingame_Incubator_AllOpen_List UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_1 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_2 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_3 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_4 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_5 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_6 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_7 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_8 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_AllOpen_List_9 UWBP_Ingame_Incubator_AllOpen_List_C
---@field WBP_Ingame_Incubator_PalInfo UWBP_Ingame_Incubator_PalInfo_C
---@field ['Hatched IDs'] TArray<FPalInstanceID>
---@field HatchedList TArray<UWBP_Ingame_Incubator_AllOpen_List_C>
---@field ViewDetailAction FPalUIActionBindData
---@field LastHoveredHandle UPalIndividualCharacterHandle
---@field Closing boolean
---@field PalStorageReplicateKey FName
local UWBP_Ingame_Incubator_AllOpen_C = {}

---@param Handle UPalIndividualCharacterHandle
---@param Parameter UPalIndividualCharacterParameter
function UWBP_Ingame_Incubator_AllOpen_C:OnSyncIndividualParameter(Handle, Parameter) end
---@return UWidget
function UWBP_Ingame_Incubator_AllOpen_C:BP_GetDesiredFocusTarget() end
function UWBP_Ingame_Incubator_AllOpen_C:ViewHatchedDetail() end
function UWBP_Ingame_Incubator_AllOpen_C:OnHatchedInfoUnhovered() end
---@param Index int32
function UWBP_Ingame_Incubator_AllOpen_C:OnHatchedInfoHovered(Index) end
function UWBP_Ingame_Incubator_AllOpen_C:Setup() end
function UWBP_Ingame_Incubator_AllOpen_C:Finished_87D9091741F1283AF653F79A16402783() end
function UWBP_Ingame_Incubator_AllOpen_C:AnmEvent_Open() end
function UWBP_Ingame_Incubator_AllOpen_C:AnmEvent_Close() end
function UWBP_Ingame_Incubator_AllOpen_C:OnSetup() end
function UWBP_Ingame_Incubator_AllOpen_C:OnInitialized() end
function UWBP_Ingame_Incubator_AllOpen_C:BndEvt__WBP_Ingame_Incubator_AllOpen_WBP_CommonButton_Close_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature() end
function UWBP_Ingame_Incubator_AllOpen_C:OnClose() end
---@param EntryPoint int32
function UWBP_Ingame_Incubator_AllOpen_C:ExecuteUbergraph_WBP_Ingame_Incubator_AllOpen(EntryPoint) end


