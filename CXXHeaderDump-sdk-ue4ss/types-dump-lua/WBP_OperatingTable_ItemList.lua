---@meta

---@class UWBP_OperatingTable_ItemList_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field BP_PalRichTextBlock_Info UBP_PalRichTextBlock_C
---@field BP_PalTextBlock_Num UBP_PalTextBlock_C
---@field Image_NoItem UImage
---@field WBP_MainMenu_Pal_Skill_Passive UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_PalInGameMenuItemIcon UWBP_PalInGameMenuItemIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnSelectItem FWBP_OperatingTable_ItemList_COnSelectItem
---@field PassiveId FName
---@field OnHovered FWBP_OperatingTable_ItemList_COnHovered
---@field OnUnhovered FWBP_OperatingTable_ItemList_COnUnhovered
---@field ConsumeItemId FName
local UWBP_OperatingTable_ItemList_C = {}

---@param PassiveId FName
---@param IsValid boolean
function UWBP_OperatingTable_ItemList_C:Setup(PassiveId, IsValid) end
---@param Button UCommonButtonBase
function UWBP_OperatingTable_ItemList_C:BndEvt__WBP_OperatingTable_ItemList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_OperatingTable_ItemList_C:BndEvt__WBP_OperatingTable_ItemList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_OperatingTable_ItemList_C:BndEvt__WBP_OperatingTable_ItemList_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_OperatingTable_ItemList_C:ExecuteUbergraph_WBP_OperatingTable_ItemList(EntryPoint) end
function UWBP_OperatingTable_ItemList_C:OnUnhovered__DelegateSignature() end
---@param SelfWidget UWBP_OperatingTable_ItemList_C
function UWBP_OperatingTable_ItemList_C:OnHovered__DelegateSignature(SelfWidget) end
---@param PassiveId FName
---@param ConsumeItemId FName
function UWBP_OperatingTable_ItemList_C:OnSelectItem__DelegateSignature(PassiveId, ConsumeItemId) end


