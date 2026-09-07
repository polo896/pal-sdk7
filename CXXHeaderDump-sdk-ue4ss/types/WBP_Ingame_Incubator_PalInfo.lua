---@meta

---@class UWBP_Ingame_Incubator_PalInfo_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_MainMenu_Pal_Skill_Passive UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_MainMenu_Pal_Skill_Passive_1 UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_MainMenu_Pal_Skill_Passive_2 UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_MainMenu_Pal_Skill_Passive_3 UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field PassiveSkillPanelArray TArray<UWBP_MainMenu_Pal_Skill_Passive_C>
local UWBP_Ingame_Incubator_PalInfo_C = {}

---@param passiveList TArray<FName>
function UWBP_Ingame_Incubator_PalInfo_C:Setup(passiveList) end
function UWBP_Ingame_Incubator_PalInfo_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_Ingame_Incubator_PalInfo_C:ExecuteUbergraph_WBP_Ingame_Incubator_PalInfo(EntryPoint) end


