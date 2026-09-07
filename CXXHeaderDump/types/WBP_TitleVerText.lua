---@meta

---@class UWBP_TitleVerText_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Text_Ver UBP_PalTextBlock_C
---@field BuildConfigDisplayTextMap TMap<FString, FString>
local UWBP_TitleVerText_C = {}

function UWBP_TitleVerText_C:Construct() end
---@param EntryPoint int32
function UWBP_TitleVerText_C:ExecuteUbergraph_WBP_TitleVerText(EntryPoint) end


