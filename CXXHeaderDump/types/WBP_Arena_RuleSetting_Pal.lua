---@meta

---@class UWBP_Arena_RuleSetting_Pal_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Horizontal_Title_Ban_1 UHorizontalBox
---@field HorizontalBox_65 UHorizontalBox
---@field ScrollBox UScrollBox
---@field WBP_CommonButton_BanAll UWBP_CommonButton_C
---@field WBP_CommonButton_EnableAll UWBP_CommonButton_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WrapBox UWrapBox
---@field OnCloseButtonClicked FWBP_Arena_RuleSetting_Pal_COnCloseButtonClicked
---@field PalList TMap<FName, UWBP_Arena_RuleSetting_PalListButton_C>
---@field OnToggleCharacterRestrict FWBP_Arena_RuleSetting_Pal_COnToggleCharacterRestrict
---@field OnChangeAll FWBP_Arena_RuleSetting_Pal_COnChangeAll
local UWBP_Arena_RuleSetting_Pal_C = {}

---@param CharacterID FName
---@param Encounted boolean
function UWBP_Arena_RuleSetting_Pal_C:IsCharacterEncounted(CharacterID, Encounted) end
---@param CharacterID FName
function UWBP_Arena_RuleSetting_Pal_C:OnCharacterButtonClick(CharacterID) end
function UWBP_Arena_RuleSetting_Pal_C:SetupPalList() end
---@param RestrictPals TArray<FPalDataTableRowName_PalMonsterData>
---@param Changeable boolean
function UWBP_Arena_RuleSetting_Pal_C:Setup(RestrictPals, Changeable) end
function UWBP_Arena_RuleSetting_Pal_C:BndEvt__WBP_Arena_RuleSetting_Pal_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_Arena_RuleSetting_Pal_C:OnInitialized() end
function UWBP_Arena_RuleSetting_Pal_C:BndEvt__WBP_Arena_RuleSetting_Pal_WBP_CommonButton_BanAll_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
function UWBP_Arena_RuleSetting_Pal_C:BndEvt__WBP_Arena_RuleSetting_Pal_WBP_CommonButton_EnableAll_K2Node_ComponentBoundEvent_2_OnClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_Arena_RuleSetting_Pal_C:ExecuteUbergraph_WBP_Arena_RuleSetting_Pal(EntryPoint) end
---@param IsBan boolean
function UWBP_Arena_RuleSetting_Pal_C:OnChangeAll__DelegateSignature(IsBan) end
---@param CharacterID FName
---@param Widget UWBP_Arena_RuleSetting_PalListButton_C
function UWBP_Arena_RuleSetting_Pal_C:OnToggleCharacterRestrict__DelegateSignature(CharacterID, Widget) end
function UWBP_Arena_RuleSetting_Pal_C:OnCloseButtonClicked__DelegateSignature() end


