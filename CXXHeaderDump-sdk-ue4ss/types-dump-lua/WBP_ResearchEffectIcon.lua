---@meta

---@class UWBP_ResearchEffectIcon_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Icon UImage
---@field MainTypeIcons TMap<EPalWorkSuitability, TSoftObjectPtr<UTexture2D>>
---@field SubTypeIcons TMap<EPalLabCategorySubType, TSoftObjectPtr<UTexture2D>>
local UWBP_ResearchEffectIcon_C = {}

---@param WorkType EPalWorkSuitability
---@param SubType EPalLabCategorySubType
function UWBP_ResearchEffectIcon_C:SetupIcon(WorkType, SubType) end
---@param EntryPoint int32
function UWBP_ResearchEffectIcon_C:ExecuteUbergraph_WBP_ResearchEffectIcon(EntryPoint) end


