---@meta

---@class UWBP_IngameMenu_ChestSetting_SecurityBlock_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ButtonPrivateLockToggle UWBP_PalInvisibleButton_C
---@field CheckBox_80 UCheckBox
---@field CheckBox_Guest UCheckBox
---@field CheckBox_Member UCheckBox
---@field CheckBox_SubMaster UCheckBox
---@field CheckBoxPrivateLock UCheckBox
---@field HorizontalBox UHorizontalBox
---@field HorizontalBox_0 UHorizontalBox
---@field HorizontalBox_PrivateLock UHorizontalBox
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Guest UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Member UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_SubMaster UWBP_PalInvisibleButton_C
---@field PasswordLockModule UPalMapObjectPasswordLockModule
---@field OnGetLockedNotLocal FWBP_IngameMenu_ChestSetting_SecurityBlock_COnGetLockedNotLocal
---@field ['As Pal HUDDispatch Parameter Map Object'] UPalHUDDispatchParameter_MapObject
local UWBP_IngameMenu_ChestSetting_SecurityBlock_C = {}

---@param Role EPalGuildRole
---@param CheckBox UCheckBox
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:GetRoleCheckBox(Role, CheckBox) end
---@param Module UPalMapObjectGuildSecurityModule
---@param NewRoles TArray<EPalGuildRole>
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:OnUpdateGuildSecurityAllowedRoles(Module, NewRoles) end
---@param _____ UCheckBox
---@return boolean
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:IsCheckedBox(_____) end
---@param TargetRole EPalGuildRole
---@param bCurrentDisplayChecked boolean
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:RequestApplyGuildSecurityLevel(TargetRole, bCurrentDisplayChecked) end
---@param Navigation EUINavigation
---@return UWidget
UWBP_IngameMenu_ChestSetting_SecurityBlock_C['Custom Navigation To Bottom'] = function(self, Navigation) end
---@param ConcreteModel UPalMapObjectItemChestModel
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:OnUpdateItemChestPrivateLock(ConcreteModel) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:SetupForGuildSecurity(ConcreteModel) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:SetupForPrivateLock(ConcreteModel) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:SetupForPassword(ConcreteModel) end
---@return UWidget
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:BP_GetDesiredFocusTarget() end
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:BndEvt__WBP_IngameMenu_Chest_LockSettings_WBP_CommonButton_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:BndEvt__WBP_IngameMenu_Chest_LockSettings_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_4_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:BndEvt__WBP_IngameMenu_Chest_LockSettings_WBP_PalInvisibleButton_1_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:BndEvt__WBP_IngameMenu_Chest_LockSettings_WBP_PalInvisibleButton_SubMaster_K2Node_ComponentBoundEvent_8_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:BndEvt__WBP_IngameMenu_Chest_LockSettings_WBP_PalInvisibleButton_Member_K2Node_ComponentBoundEvent_5_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:BndEvt__WBP_IngameMenu_Chest_LockSettings_WBP_PalInvisibleButton_Guest_K2Node_ComponentBoundEvent_6_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Param UPalHUDDispatchParameterBase
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:Setup(Param) end
---@param EntryPoint int32
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:ExecuteUbergraph_WBP_IngameMenu_ChestSetting_SecurityBlock(EntryPoint) end
function UWBP_IngameMenu_ChestSetting_SecurityBlock_C:OnGetLockedNotLocal__DelegateSignature() end


