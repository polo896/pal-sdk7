---@meta

---@class UWBP_PalCommonInfo_SaveParameter_C : UWBP_PalSaveParameterDisplayWidget_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
local UWBP_PalCommonInfo_SaveParameter_C = {}

---@param IsAwaked boolean
function UWBP_PalCommonInfo_SaveParameter_C:SetAwakening(IsAwaked) end
---@param FriendshipRank int32
---@param FriendshipPoint int32
function UWBP_PalCommonInfo_SaveParameter_C:SetFriendShip(FriendshipRank, FriendshipPoint) end
---@param bImported boolean
function UWBP_PalCommonInfo_SaveParameter_C:SetImportedFlag(bImported) end
---@param DisplayParameter FPalIndividualCharacterSaveParameter
function UWBP_PalCommonInfo_SaveParameter_C:DisplaySaveParameter(DisplayParameter) end
---@param SoulRank int32
function UWBP_PalCommonInfo_SaveParameter_C:SetSoulRank(SoulRank) end
---@param type1 EPalElementType
---@param type2 EPalElementType
function UWBP_PalCommonInfo_SaveParameter_C:SetElement(type1, type2) end
function UWBP_PalCommonInfo_SaveParameter_C:SetEmpty() end
---@param FoddAmount int32
function UWBP_PalCommonInfo_SaveParameter_C:SetFoodAmount(FoddAmount) end
function UWBP_PalCommonInfo_SaveParameter_C:SetupAfterDisplayed() end
---@param GenderType EPalGenderType
function UWBP_PalCommonInfo_SaveParameter_C:SetGender(GenderType) end
---@param Rank int32
function UWBP_PalCommonInfo_SaveParameter_C:SetRank(Rank) end
---@param Level int32
---@param NowExp int64
---@param NextEXP int64
---@param nowExpRate double
function UWBP_PalCommonInfo_SaveParameter_C:SetLevelAndExp(Level, NowExp, NextEXP, nowExpRate) end
---@param wazaArray TArray<EPalWazaID>
function UWBP_PalCommonInfo_SaveParameter_C:SetWaza(wazaArray) end
---@param PassiveSkillNameArray TArray<FName>
function UWBP_PalCommonInfo_SaveParameter_C:SetPassiveSkill(PassiveSkillNameArray) end
---@param SuitabilityMap TMap<EPalWorkSuitability, int32>
function UWBP_PalCommonInfo_SaveParameter_C:SetWorkSuitability(SuitabilityMap) end
---@param NickName FString
function UWBP_PalCommonInfo_SaveParameter_C:SetNickName(NickName) end
---@param nowHunger double
---@param maxHunger double
function UWBP_PalCommonInfo_SaveParameter_C:SetHunger(nowHunger, maxHunger) end
---@param MeleeAttack int32
---@param ShotAttack int32
---@param Defense int32
---@param Support int32
---@param Speed int32
function UWBP_PalCommonInfo_SaveParameter_C:SetBaseParameter(MeleeAttack, ShotAttack, Defense, Support, Speed) end
---@param nowHP int32
---@param MaxHP int32
function UWBP_PalCommonInfo_SaveParameter_C:SetHP(nowHP, MaxHP) end


