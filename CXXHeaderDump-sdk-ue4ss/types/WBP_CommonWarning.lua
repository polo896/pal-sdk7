---@meta

---@class UWBP_CommonWarning_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Close UWidgetAnimation
---@field Anm_Open UWidgetAnimation
---@field BP_PalRichTextBlock UBP_PalRichTextBlock_C
---@field Image_Icon UImage
---@field Displaying boolean
---@field ['Crime Ids'] TArray<FName>
---@field ['Display Type'] EPalUICommonWarningType
---@field OnWarningClear FWBP_CommonWarning_COnWarningClear
local UWBP_CommonWarning_C = {}

---@param Display_Type EPalUICommonWarningType
function UWBP_CommonWarning_C:GetDisplayType(Display_Type) end
function UWBP_CommonWarning_C:Finished_DAD0908E4A3D9DC986076BBB9D0BAB98() end
---@param WarningData FPalUICommonWarningDisplayData
function UWBP_CommonWarning_C:SetWarning(WarningData) end
function UWBP_CommonWarning_C:ClearWarning() end
---@param EntryPoint int32
function UWBP_CommonWarning_C:ExecuteUbergraph_WBP_CommonWarning(EntryPoint) end
---@param WarningType EPalUICommonWarningType
function UWBP_CommonWarning_C:OnWarningClear__DelegateSignature(WarningType) end


