---@meta

---@class UWBP_CustomTimer_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_1 UImage
---@field TimeText UTextBlock
---@field IconList TArray<UTexture2D>
local UWBP_CustomTimer_C = {}

---@param Text FString
function UWBP_CustomTimer_C:UpdateTimer(Text) end
---@param IconIndex int32
function UWBP_CustomTimer_C:SetIconByID(IconIndex) end
---@param EntryPoint int32
function UWBP_CustomTimer_C:ExecuteUbergraph_WBP_CustomTimer(EntryPoint) end


