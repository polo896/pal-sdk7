-- ===========================================================================
--  PalEggAutoFiller :: Hatch Report UI
-- ===========================================================================

local PalUI = {
    Theme     = {},
    Assets    = {},
    Factory   = {},
    Engine    = {},
    Presenter = {},
}

local function safeCall(func, ...)
    local ok, res = pcall(func, ...)
    if ok then return res end
    return nil
end

local function isObjectValid(obj)
    if not obj or type(obj) ~= "userdata" then return false end
    local ok, valid = pcall(function() return obj:IsValid() end)
    return ok and valid == true
end

local function printLog(text)
    print("[PalEggAutoFiller][UI] " .. tostring(text))
end

local function clampNum(v, lo, hi)
    if v < lo then return lo elseif v > hi then return hi end
    return v
end

local function ellipsize(str, maxLen)
    str = tostring(str or "")
    if #str <= maxLen then return str end
    return str:sub(1, math.max(1, maxLen - 2)) .. ".."
end

local function prettyWords(str)
    local s = tostring(str or ""):gsub(".*::", ""):gsub("_", " ")
    s = s:gsub("(%l)(%u)", "%1 %2")
    s = s:gsub("(%u)(%u%l)", "%1 %2")
    s = s:gsub("(%a)([%w']*)", function(f, r) return f:upper() .. r:lower() end)
    return s
end

local function hexToLinearColor(hexStr, alpha)
    local cleanHex = hexStr:gsub("#", "")
    local r = tonumber(cleanHex:sub(1, 2), 16) / 255.0
    local g = tonumber(cleanHex:sub(3, 4), 16) / 255.0
    local b = tonumber(cleanHex:sub(5, 6), 16) / 255.0

    local function srgbToLinear(val)
        if val <= 0.04045 then return val / 12.92 end
        return ((val + 0.055) / 1.055) ^ 2.4
    end

    return { srgbToLinear(r), srgbToLinear(g), srgbToLinear(b), alpha or 1.0 }
end

local function withAlpha(col, a)
    return { col[1], col[2], col[3], a }
end

PalUI.Theme = {
    PanelBase     = hexToLinearColor("#131A1D", 0.94),
    PanelHeader   = hexToLinearColor("#26333A", 1.00),
    PanelList     = hexToLinearColor("#0F1518", 0.75),
    CardBase      = hexToLinearColor("#1D262B", 0.96),
    CardGold      = hexToLinearColor("#2A2418", 0.96),
    CardBad       = hexToLinearColor("#2A1D1E", 0.96),
    Divider       = hexToLinearColor("#314046", 1.00),
    BorderDefault = hexToLinearColor("#42555C", 1.00),
    BarTrack      = hexToLinearColor("#293439", 1.00),

    TextPrimary   = hexToLinearColor("#FFFFFF", 1.00),
    TextSecond    = hexToLinearColor("#D1E0E8", 1.00),
    TextDim       = hexToLinearColor("#94A9B3", 1.00),

    Gold          = hexToLinearColor("#FCD34D", 1.00),
    Green         = hexToLinearColor("#4ADE80", 1.00),
    GreenSoft     = hexToLinearColor("#A3E635", 1.00),
    Red           = hexToLinearColor("#F87171", 1.00),
    Blue          = hexToLinearColor("#BAE6FD", 1.00),
    Cyan          = hexToLinearColor("#38BDF8", 1.00),
    Purple        = hexToLinearColor("#C084FC", 1.00),
    Male          = hexToLinearColor("#58A6FF", 1.00),
    Female        = hexToLinearColor("#FF8AC4", 1.00),

    PassiveSlotBg = hexToLinearColor("#11181C", 0.90),
}

PalUI.Assets = {
    WindowBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_PalCommonWindow.WBP_PalCommonWindow_C",
    ButtonBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_CommonButton_Activation.WBP_CommonButton_Activation_C",
    DefaultFont     = "/Game/Pal/Font/Ft_PalDefaultFont.Ft_PalDefaultFont",
    OverallLayout   = "WBP_PalOverallUILayout_C",
    HostPanelName   = "CanvasPanel_Root",
}

local ObjectCache = {}
local function resolveStaticObject(path)
    if ObjectCache[path] and isObjectValid(ObjectCache[path]) then
        return ObjectCache[path]
    end
    local obj = StaticFindObject(path)
    if not isObjectValid(obj) then
        pcall(LoadAsset, path)
        obj = StaticFindObject(path)
    end
    if isObjectValid(obj) then
        ObjectCache[path] = obj
        return obj
    end
    return nil
end

local PASSIVE_DB = {
    ["Alien"]                                = { name = "Otherworldly Cells", desc = "Atk +10%, Fire/Lightning resist +15%", tier = 1 },
    ["AutoHPRegeneRate_Passive"]             = { name = "Healing Coach", desc = "Player HP regen +5%", tier = 2 },
    ["CoolTimeReduction_Down_1"]             = { name = "Easygoing", desc = "Skill cooldowns +15% (slower)", tier = -1 },
    ["CoolTimeReduction_Up_1"]               = { name = "Serenity", desc = "Skill CD -30%, Attack +10%", tier = 2 },
    ["CoolTimeReduction_Up_2"]               = { name = "Impatient", desc = "Skill cooldown -15%", tier = 1 },
    ["CraftSpeed_down1"]                     = { name = "Clumsy", desc = "Work speed -10%", tier = -1 },
    ["CraftSpeed_down2"]                     = { name = "Slacker", desc = "Work speed -30%", tier = -1 },
    ["CraftSpeed_up1"]                       = { name = "Serious", desc = "Work speed +20%", tier = 1 },
    ["CraftSpeed_up2"]                       = { name = "Artisan", desc = "Work speed +50%", tier = 2 },
    ["CraftSpeed_up3"]                       = { name = "Remarkable Craftsmanship", desc = "Work speed +75%", tier = 3 },
    ["Deffence_down1"]                       = { name = "Downtrodden", desc = "Defense -10%", tier = -1 },
    ["Deffence_down2"]                       = { name = "Brittle", desc = "Defense -20%", tier = -1 },
    ["Deffence_up1"]                         = { name = "Hard Skin", desc = "Defense +10%", tier = 1 },
    ["Deffence_up2"]                         = { name = "Burly Body", desc = "Defense +20%, no flinch", tier = 2 },
    ["Deffence_up2_2"]                       = { name = "Heavyweight", desc = "Defense +20%, no knockback", tier = 2 },
    ["Deffence_up3"]                         = { name = "Diamond Body", desc = "Defense +30%, no flinch/knockback", tier = 3 },
    ["ElementBoost_Aqua_1_PAL"]              = { name = "Hydromaniac", desc = "Water attack +10%", tier = 1 },
    ["ElementBoost_Aqua_2_PAL"]              = { name = "Lord of the Sea", desc = "Water attack +30%", tier = 2 },
    ["ElementBoost_Dark_1_PAL"]              = { name = "Veil of Darkness", desc = "Dark attack +10%", tier = 1 },
    ["ElementBoost_Dark_2_PAL"]              = { name = "Lord of the Underworld", desc = "Dark attack +30%", tier = 2 },
    ["ElementBoost_Dragon_1_PAL"]            = { name = "Blood of the Dragon", desc = "Dragon attack +10%", tier = 1 },
    ["ElementBoost_Dragon_2_PAL"]            = { name = "Divine Dragon", desc = "Dragon attack +30%", tier = 2 },
    ["ElementBoost_Earth_1_PAL"]             = { name = "Power of Gaia", desc = "Earth attack +10%", tier = 1 },
    ["ElementBoost_Earth_2_PAL"]             = { name = "Earth Emperor", desc = "Earth attack +30%", tier = 2 },
    ["ElementBoost_Fire_1_PAL"]              = { name = "Pyromaniac", desc = "Fire attack +10%", tier = 1 },
    ["ElementBoost_Fire_2_PAL"]              = { name = "Flame Emperor", desc = "Fire attack +30%", tier = 2 },
    ["ElementBoost_Ice_1_PAL"]               = { name = "Coldblooded", desc = "Ice attack +10%", tier = 1 },
    ["ElementBoost_Ice_2_PAL"]               = { name = "Ice Emperor", desc = "Ice attack +30%", tier = 2 },
    ["ElementBoost_Leaf_1_PAL"]              = { name = "Fragrant Foliage", desc = "Grass attack +10%", tier = 1 },
    ["ElementBoost_Leaf_2_PAL"]              = { name = "Spirit Emperor", desc = "Grass attack +30%", tier = 2 },
    ["ElementBoost_Normal_1_PAL"]            = { name = "Spirit of Zen", desc = "Neutral attack +10%", tier = 1 },
    ["ElementBoost_Normal_2_PAL"]            = { name = "Celestial Emperor", desc = "Neutral attack +30%", tier = 2 },
    ["ElementBoost_Thunder_1_PAL"]           = { name = "Capacitor", desc = "Lightning attack +10%", tier = 1 },
    ["ElementBoost_Thunder_2_PAL"]           = { name = "Lord of Lightning", desc = "Lightning attack +30%", tier = 2 },
    ["ElementResist_Aqua_1_PAL"]             = { name = "Waterproof", desc = "Water damage taken -10%", tier = 1 },
    ["ElementResist_Dark_1_PAL"]             = { name = "Cheery", desc = "Dark damage taken -10%", tier = 1 },
    ["ElementResist_Dragon_1_PAL"]           = { name = "Dragonkiller", desc = "Dragon damage taken -10%", tier = 1 },
    ["ElementResist_Earth_1_PAL"]            = { name = "Earthquake Resistant", desc = "Earth damage taken -10%", tier = 1 },
    ["ElementResist_Fire_1_PAL"]             = { name = "Suntan Lover", desc = "Fire damage taken -10%", tier = 1 },
    ["ElementResist_Ice_1_PAL"]              = { name = "Heated Body", desc = "Ice damage taken -10%", tier = 1 },
    ["ElementResist_Leaf_1_PAL"]             = { name = "Botanical Barrier", desc = "Grass damage taken -10%", tier = 1 },
    ["ElementResist_Normal_1_PAL"]           = { name = "Abnormal", desc = "Neutral damage taken -10%", tier = 1 },
    ["ElementResist_Thunder_1_PAL"]          = { name = "Insulated Body", desc = "Lightning dmg taken -10%", tier = 1 },
    ["EternalFlame"]                         = { name = "Eternal Flame", desc = "Fire +30%, Lightning +30%", tier = 3 },
    ["Invader"]                              = { name = "Invader", desc = "Dark +30%, Dragon +30%", tier = 3 },
    ["Legend"]                               = { name = "Legend", desc = "Attack +20%, Def +20%, Move +20%", tier = 3 },
    ["MiniNushi"]                            = { name = "Whopper", desc = "Water/Ice atk +5%, Def +5%", tier = 2 },
    ["MoveSpeed_up_1"]                       = { name = "Nimble", desc = "Movement speed +10%", tier = 1 },
    ["MoveSpeed_up_2"]                       = { name = "Runner", desc = "Movement speed +20%", tier = 2 },
    ["MoveSpeed_up_3"]                       = { name = "Swift", desc = "Movement speed +30%", tier = 3 },
    ["MutationPal_Babysitter"]               = { name = "Babysitter", desc = "Egg production & incubation +30%", tier = 3 },
    ["MutationPal_ExplosionResist"]          = { name = "Heavily Armored", desc = "Immune to explosion damage", tier = 3 },
    ["MutationPal_Immortal"]                 = { name = "Immortality", desc = "Life steal 5%, Regen +100%, Atk +15%", tier = 3 },
    ["MutationPal_Mutant"]                   = { name = "Idiosyncratic", desc = "Regen +50%, Def +25%, no poison/burn", tier = 3 },
    ["NightOwl"]                             = { name = "Night Owl", desc = "Nocturnal, naps during the day", tier = -1 },
    ["Nocturnal"]                            = { name = "Insomnia", desc = "Works through the night", tier = 1 },
    ["NonKilling"]                           = { name = "Mercy Hit", desc = "Never reduces enemy HP below 1", tier = -1 },
    ["Noukin"]                               = { name = "Musclehead", desc = "Attack +30%, Work speed -50%", tier = 2 },
    ["Nushi"]                                = { name = "Lunker", desc = "Water/Ice atk +20%, Def +20%", tier = 3 },
    ["PAL_ALLAttack_down1"]                  = { name = "Coward", desc = "Attack -10%", tier = -1 },
    ["PAL_ALLAttack_down2"]                  = { name = "Pacifist", desc = "Attack -20%", tier = -1 },
    ["PAL_ALLAttack_up1"]                    = { name = "Brave", desc = "Attack +10%", tier = 1 },
    ["PAL_ALLAttack_up2"]                    = { name = "Ferocious", desc = "Attack +20%", tier = 2 },
    ["PAL_ALLAttack_up3"]                    = { name = "Demon God", desc = "Attack +30%, Defense +5%", tier = 3 },
    ["PAL_CorporateSlave"]                   = { name = "Work Slave", desc = "Work speed +30%, Attack -30%", tier = 1 },
    ["PAL_FullStomach_Down_1"]               = { name = "Dainty Eater", desc = "Satiety drops 10% slower", tier = 1 },
    ["PAL_FullStomach_Down_2"]               = { name = "Diet Lover", desc = "Satiety drops 15% slower", tier = 2 },
    ["PAL_FullStomach_Down_3"]               = { name = "Mastery of Fasting", desc = "Satiety drops 20% slower", tier = 3 },
    ["PAL_FullStomach_Up_1"]                 = { name = "Glutton", desc = "Satiety drops 10% faster", tier = -1 },
    ["PAL_FullStomach_Up_2"]                 = { name = "Bottomless Stomach", desc = "Satiety drops 15% faster", tier = -1 },
    ["PAL_Sanity_Down_1"]                    = { name = "Positive Thinker", desc = "SAN drops 10% slower", tier = 1 },
    ["PAL_Sanity_Down_2"]                    = { name = "Workaholic", desc = "SAN drops 15% slower", tier = 2 },
    ["PAL_Sanity_Down_3"]                    = { name = "Heart of the Immovable King", desc = "SAN drops 20% slower", tier = 3 },
    ["PAL_Sanity_Up_1"]                      = { name = "Unstable", desc = "SAN drops 10% faster", tier = -1 },
    ["PAL_Sanity_Up_2"]                      = { name = "Destructive", desc = "SAN drops 15% faster", tier = -1 },
    ["PAL_conceited"]                        = { name = "Conceited", desc = "Work speed +10%, Defense -10%", tier = 1 },
    ["PAL_masochist"]                        = { name = "Masochist", desc = "Defense +15%, Attack -15%", tier = 1 },
    ["PAL_oraora"]                           = { name = "Aggressive", desc = "Attack +10%, Defense -10%", tier = 1 },
    ["PAL_rude"]                             = { name = "Hooligan", desc = "Attack +15%, Work speed -10%", tier = 1 },
    ["PAL_sadist"]                           = { name = "Sadist", desc = "Attack +15%, Defense -15%", tier = 1 },
    ["PlayerSP_DecreaseRate_Passive"]        = { name = "Wellness Watcher", desc = "Player stamina use -5%", tier = 2 },
    ["Rare"]                                 = { name = "Lucky", desc = "Attack +15%, Def +15%, Work +20%", tier = 3 },
    ["ReloadSpeedUp_Passive"]                = { name = "Reload Master", desc = "Player reload speed +4%", tier = 2 },
    ["RideJumpCount_Increase1"]              = { name = "Lightfooted", desc = "Mounted jumps +1", tier = 3 },
    ["RideJumpCount_Increase2"]              = { name = "Sky Strider", desc = "Mounted jumps +2", tier = 3 },
    ["SalePrice_Down_1"]                     = { name = "Shabby", desc = "Sell -10%, buy +10%", tier = -1 },
    ["SalePrice_Up_1"]                       = { name = "Noble", desc = "Sell +5%, buy -5%", tier = 2 },
    ["SalePrice_Up_2"]                       = { name = "Fine Furs", desc = "Sell +3%, buy -3%", tier = 1 },
    ["Salvation"]                            = { name = "Savior", desc = "Neutral +30%, Grass +30%", tier = 3 },
    ["SelfDeathAddItemDrop_up_2"]            = { name = "Service-Minded", desc = "Items dropped by this Pal +50%", tier = 2 },
    ["SelfDeathAddItemDrop_up_3"]            = { name = "Lavish Hospitality", desc = "Items dropped by this Pal +100%", tier = 3 },
    ["Stamina_Down_1"]                       = { name = "Sickly", desc = "Ride stamina -25%", tier = -1 },
    ["Stamina_Up_1"]                         = { name = "Fit as a Fiddle", desc = "Ride stamina +25%", tier = 2 },
    ["Stamina_Up_2"]                         = { name = "Infinite Stamina", desc = "Ride stamina +50%", tier = 1 },
    ["Stamina_Up_3"]                         = { name = "Eternal Engine", desc = "Ride stamina +75%", tier = 3 },
    ["SwimSpeed_up_1"]                       = { name = "Sleek Stroke", desc = "Swim speed +30%", tier = 1 },
    ["SwimSpeed_up_2"]                       = { name = "Ace Swimmer", desc = "Swim speed +40%", tier = 2 },
    ["SwimSpeed_up_3"]                       = { name = "King of the Waves", desc = "Swim speed +50%", tier = 3 },
    ["Test_PalEgg_HatchingSpeed_Up"]         = { name = "Philanthropist", desc = "Breeding speed +100%", tier = 2 },
    ["TrainerATK_UP_1"]                      = { name = "Vanguard", desc = "Player attack +10%", tier = 2 },
    ["TrainerDEF_UP_1"]                      = { name = "Stronghold Strategist", desc = "Player defense +10%", tier = 2 },
    ["TrainerLogging_up1"]                   = { name = "Logging Foreman", desc = "Player logging +25%", tier = 2 },
    ["TrainerMining_up1"]                    = { name = "Mine Foreman", desc = "Player mining +25%", tier = 2 },
    ["TrainerWorkSpeed_UP_1"]                = { name = "Motivational Leader", desc = "Player work speed +25%", tier = 2 },
    ["Vampire"]                              = { name = "Vampiric", desc = "Life steal 5%, works at night", tier = 3 },
    ["Witch"]                                = { name = "Siren of the Void", desc = "Dark +30%, Ice +30%", tier = 3 },
    ["WorkSuitabilityAddRank_MonsterFarm_1"] = { name = "Farmhand", desc = "Farming suitability +1", tier = 2 },
    ["WorkSuitabilityAddRank_MonsterFarm_2"] = { name = "Ranch Master", desc = "Farming suitability +2", tier = 3 },
    ["WorldTree_ATK"]                        = { name = "Twin-Edged Holy Blade", desc = "Attack +50%, Defense -30%", tier = 3 },
    ["WorldTree_ATK_DEF"]                    = { name = "God of Destruction", desc = "Atk +40%, Def +20%, Max HP -50%", tier = 3 },
    ["WorldTree_CraftSpeed"]                 = { name = "Demon's Hand", desc = "Work speed +90%, SAN +15% faster", tier = 3 },
    ["WorldTree_DEF"]                        = { name = "Sanctified Meat Shield", desc = "Defense +50%, Attack -30%", tier = 3 },
    ["WorldTree_FullStomach"]                = { name = "World Tree's Bounty", desc = "Satiety drain -50%, Max HP -20%", tier = 3 },
    ["WorldTree_MoveSpeed"]                  = { name = "Dimensional Leap", desc = "Move +50%, Satiety +15% faster", tier = 3 },
    ["WorldTree_Sanity"]                     = { name = "Hermit Sage", desc = "SAN drain -50%, Work speed -20%", tier = 3 },
}

local LEGACY_ALIASES = {
    ["abnormal"]                = "ElementResist_Normal_1_PAL",
    ["aceswimmer"]              = "SwimSpeed_up_2",
    ["aggressive"]              = "PAL_oraora",
    ["artisan"]                 = "CraftSpeed_up2",
    ["attackdown1"]             = "PAL_ALLAttack_down1",
    ["attackdown2"]             = "PAL_ALLAttack_down2",
    ["attackup1"]               = "PAL_ALLAttack_up1",
    ["attackup2"]               = "PAL_rude",
    ["attackup3"]               = "PAL_ALLAttack_up3",
    ["attackup4"]               = "PAL_ALLAttack_up3",
    ["babysitter"]              = "MutationPal_Babysitter",
    ["bloodofthedragon"]        = "ElementBoost_Dragon_1_PAL",
    ["botanicalorgan"]          = "ElementBoost_Leaf_2_PAL",
    ["bottomlessstomach"]       = "PAL_FullStomach_Up_2",
    ["brave"]                   = "PAL_ALLAttack_up1",
    ["breedspeedup1"]           = "Test_PalEgg_HatchingSpeed_Up",
    ["brittle"]                 = "Deffence_down2",
    ["burlybody"]               = "Deffence_up2",
    ["capacitor"]               = "ElementBoost_Thunder_1_PAL",
    ["celestialemperor"]        = "ElementBoost_Normal_2_PAL",
    ["cheery"]                  = "ElementResist_Dark_1_PAL",
    ["clumsy"]                  = "CraftSpeed_down1",
    ["coldblooded"]             = "ElementBoost_Ice_1_PAL",
    ["coldlover"]               = "ElementBoost_Ice_1_PAL",
    ["conceited"]               = "PAL_conceited",
    ["cooldowndown1"]           = "CoolTimeReduction_Down_1",
    ["cooldowndown2"]           = "CoolTimeReduction_Up_2",
    ["coward"]                  = "PAL_ALLAttack_down1",
    ["daintyeater"]             = "PAL_FullStomach_Down_1",
    ["darkemperor"]             = "ElementBoost_Dark_2_PAL",
    ["darkpower"]               = "ElementBoost_Dark_2_PAL",
    ["deceitful"]               = "PAL_CorporateSlave",
    ["defensedown1"]            = "Deffence_down1",
    ["defensedown2"]            = "Deffence_down2",
    ["defenseup1"]              = "Deffence_up1",
    ["defenseup2"]              = "Deffence_up2",
    ["defenseup3"]              = "Deffence_up3",
    ["defenseup4"]              = "Deffence_up3",
    ["demongod"]                = "PAL_ALLAttack_up3",
    ["demonshand"]              = "WorldTree_CraftSpeed",
    ["depressionup1"]           = "Deffence_down1",
    ["depressionup2"]           = "CoolTimeReduction_Down_1",
    ["destructive"]             = "PAL_Sanity_Up_2",
    ["diamondbody"]             = "Deffence_up3",
    ["dietlover"]               = "PAL_FullStomach_Down_2",
    ["dimensionalleap"]         = "WorldTree_MoveSpeed",
    ["divinedragon"]            = "ElementBoost_Dragon_2_PAL",
    ["downtrodden"]             = "Deffence_down1",
    ["dragonemperor"]           = "ElementBoost_Dragon_2_PAL",
    ["dragonkiller"]            = "ElementResist_Dragon_1_PAL",
    ["dragonorgan"]             = "ElementBoost_Dragon_2_PAL",
    ["dragonslayer"]            = "ElementResist_Dragon_1_PAL",
    ["earthemperor"]            = "ElementBoost_Earth_2_PAL",
    ["earthorgan"]              = "ElementBoost_Earth_2_PAL",
    ["earthpower"]              = "ElementBoost_Earth_1_PAL",
    ["earthquakeresistant"]     = "ElementResist_Earth_1_PAL",
    ["easygoing"]               = "CoolTimeReduction_Down_1",
    ["electricorgan"]           = "ElementBoost_Thunder_2_PAL",
    ["elementboostaqua1"]       = "ElementBoost_Aqua_1_PAL",
    ["elementboostaqua2"]       = "ElementBoost_Aqua_2_PAL",
    ["elementboostdark1"]       = "ElementBoost_Dark_1_PAL",
    ["elementboostdark2"]       = "ElementBoost_Dark_2_PAL",
    ["elementboostdragon1"]     = "ElementBoost_Dragon_1_PAL",
    ["elementboostdragon2"]     = "ElementBoost_Dragon_2_PAL",
    ["elementboostearth1"]      = "ElementBoost_Earth_1_PAL",
    ["elementboostearth2"]      = "ElementBoost_Earth_2_PAL",
    ["elementboostfire1"]       = "ElementBoost_Fire_1_PAL",
    ["elementboostfire2"]       = "ElementBoost_Fire_2_PAL",
    ["elementboostice1"]        = "ElementBoost_Ice_1_PAL",
    ["elementboostice2"]        = "ElementBoost_Ice_2_PAL",
    ["elementboostleaf1"]       = "ElementBoost_Leaf_1_PAL",
    ["elementboostleaf2"]       = "ElementBoost_Leaf_2_PAL",
    ["elementboostnormal1"]     = "ElementBoost_Normal_1_PAL",
    ["elementboostnormal2"]     = "ElementBoost_Normal_2_PAL",
    ["elementboostthunder1"]    = "ElementBoost_Thunder_1_PAL",
    ["elementboostthunder2"]    = "ElementBoost_Thunder_2_PAL",
    ["elementboostwater1"]      = "ElementBoost_Aqua_1_PAL",
    ["elementboostwater2"]      = "ElementBoost_Aqua_2_PAL",
    ["elementresistaqua1"]      = "ElementResist_Aqua_1_PAL",
    ["elementresistdark1"]      = "ElementResist_Dark_1_PAL",
    ["elementresistdragon1"]    = "ElementResist_Dragon_1_PAL",
    ["elementresistearth1"]     = "ElementResist_Earth_1_PAL",
    ["elementresistfire1"]      = "ElementResist_Fire_1_PAL",
    ["elementresistice1"]       = "ElementResist_Ice_1_PAL",
    ["elementresistleaf1"]      = "ElementResist_Leaf_1_PAL",
    ["elementresistnormal1"]    = "ElementResist_Normal_1_PAL",
    ["elementresistthunder1"]   = "ElementResist_Thunder_1_PAL",
    ["elementresistwater1"]     = "ElementResist_Aqua_1_PAL",
    ["eternalengine"]           = "Stamina_Up_3",
    ["farmhand"]                = "WorkSuitabilityAddRank_MonsterFarm_1",
    ["fastrunner3"]             = "MoveSpeed_up_3",
    ["ferocious"]               = "PAL_ALLAttack_up2",
    ["finefur"]                 = "SalePrice_Up_2",
    ["finefurs"]                = "SalePrice_Up_2",
    ["fireorgan"]               = "ElementBoost_Fire_2_PAL",
    ["fitasafiddle"]            = "Stamina_Up_1",
    ["flameemperor"]            = "ElementBoost_Fire_2_PAL",
    ["fragile"]                 = "Deffence_down1",
    ["fragrantfoliage"]         = "ElementBoost_Leaf_1_PAL",
    ["glutton"]                 = "PAL_FullStomach_Up_1",
    ["godofdestruction"]        = "WorldTree_ATK_DEF",
    ["hardskin"]                = "Deffence_up1",
    ["healingcoach"]            = "AutoHPRegeneRate_Passive",
    ["heartoftheimmovableking"] = "PAL_Sanity_Down_3",
    ["heatedbody"]              = "ElementResist_Ice_1_PAL",
    ["heavilyarmored"]          = "MutationPal_ExplosionResist",
    ["heavyweight"]             = "Deffence_up2_2",
    ["hermitsage"]              = "WorldTree_Sanity",
    ["holyemperor"]             = "ElementBoost_Normal_2_PAL",
    ["hooligan"]                = "PAL_rude",
    ["hungerdown1"]             = "PAL_FullStomach_Down_1",
    ["hungerdown2"]             = "PAL_FullStomach_Down_2",
    ["hungerup1"]               = "PAL_FullStomach_Up_1",
    ["hungerup2"]               = "PAL_FullStomach_Up_2",
    ["hydromaniac"]             = "ElementBoost_Aqua_1_PAL",
    ["iceemperor"]              = "ElementBoost_Ice_2_PAL",
    ["iceorgan"]                = "ElementBoost_Ice_2_PAL",
    ["idiosyncratic"]           = "MutationPal_Mutant",
    ["immortality"]             = "MutationPal_Immortal",
    ["impatient"]               = "CoolTimeReduction_Up_2",
    ["infinitestamina"]         = "Stamina_Up_2",
    ["insomnia"]                = "Nocturnal",
    ["insulated"]               = "ElementResist_Thunder_1_PAL",
    ["insulatedbody"]           = "ElementResist_Thunder_1_PAL",
    ["kingofthewaves"]          = "SwimSpeed_up_3",
    ["lavishhospitality"]       = "SelfDeathAddItemDrop_up_3",
    ["leafemperor"]             = "ElementBoost_Leaf_2_PAL",
    ["lightfooted"]             = "RideJumpCount_Increase1",
    ["loggingforeman"]          = "TrainerLogging_up1",
    ["loggingspecialist"]       = "TrainerLogging_up1",
    ["loggingspeedup1"]         = "TrainerLogging_up1",
    ["lucky"]                   = "Rare",
    ["lunker"]                  = "Nushi",
    ["masochist"]               = "PAL_masochist",
    ["masteryoffasting"]        = "PAL_FullStomach_Down_3",
    ["mercyhit"]                = "NonKilling",
    ["mineforeman"]             = "TrainerMining_up1",
    ["miningspeedup1"]          = "TrainerMining_up1",
    ["motivationalleader"]      = "TrainerWorkSpeed_UP_1",
    ["musclehead"]              = "Noukin",
    ["nimble"]                  = "MoveSpeed_up_1",
    ["noble"]                   = "SalePrice_Up_1",
    ["optimistic"]              = "ElementResist_Dark_1_PAL",
    ["otherworldlycells"]       = "Alien",
    ["philanthropist"]          = "Test_PalEgg_HatchingSpeed_Up",
    ["playerattackup1"]         = "TrainerATK_UP_1",
    ["playerdefenseup1"]        = "TrainerDEF_UP_1",
    ["playerworkspeedup1"]      = "TrainerWorkSpeed_UP_1",
    ["positivethinker"]         = "PAL_Sanity_Down_1",
    ["powerofgaia"]             = "ElementBoost_Earth_1_PAL",
    ["pyromaniac"]              = "ElementBoost_Fire_1_PAL",
    ["ranchmaster"]             = "WorkSuitabilityAddRank_MonsterFarm_2",
    ["reloadmaster"]            = "ReloadSpeedUp_Passive",
    ["remarkablecraftsmanship"] = "CraftSpeed_up3",
    ["rubberbody"]              = "ElementResist_Thunder_1_PAL",
    ["runner"]                  = "MoveSpeed_up_2",
    ["sadist"]                  = "PAL_ALLAttack_up2",
    ["sanctifiedmeatshield"]    = "WorldTree_DEF",
    ["sanitydown1"]             = "PAL_Sanity_Down_1",
    ["sanitydown2"]             = "PAL_Sanity_Down_2",
    ["sanityup1"]               = "PAL_Sanity_Up_1",
    ["sanityup2"]               = "PAL_Sanity_Up_2",
    ["savior"]                  = "Salvation",
    ["serenity"]                = "CoolTimeReduction_Up_1",
    ["serious"]                 = "CraftSpeed_up1",
    ["serviceminded"]           = "SelfDeathAddItemDrop_up_2",
    ["shabby"]                  = "SalePrice_Down_1",
    ["shadoworgan"]             = "ElementBoost_Dark_1_PAL",
    ["sickly"]                  = "Stamina_Down_1",
    ["siren"]                   = "Witch",
    ["sirenofthevoid"]          = "Witch",
    ["skymarcher"]              = "RideJumpCount_Increase2",
    ["skystrider"]              = "RideJumpCount_Increase2",
    ["slacker"]                 = "CraftSpeed_down2",
    ["sleekstroke"]             = "SwimSpeed_up_1",
    ["softskin"]                = "Deffence_down2",
    ["spiritozen"]              = "ElementBoost_Normal_1_PAL",
    ["strongholdstrategist"]    = "TrainerDEF_UP_1",
    ["suntanlover"]             = "ElementResist_Fire_1_PAL",
    ["suntanned"]               = "ElementResist_Fire_1_PAL",
    ["swift"]                   = "MoveSpeed_up_3",
    ["thunderemperor"]          = "ElementBoost_Thunder_2_PAL",
    ["trainerfastrunner1"]      = "MoveSpeed_up_1",
    ["trainerfastrunner2"]      = "MoveSpeed_up_2",
    ["trainerfastrunner3"]      = "MoveSpeed_up_3",
    ["twinedgedholyblade"]      = "WorldTree_ATK",
    ["unstable"]                = "PAL_Sanity_Up_1",
    ["vampiric"]                = "Vampire",
    ["vanguard"]                = "TrainerATK_UP_1",
    ["veilofdarkness"]          = "ElementBoost_Dark_1_PAL",
    ["warmbody"]                = "ElementResist_Ice_1_PAL",
    ["wateremperor"]            = "ElementBoost_Aqua_2_PAL",
    ["waterorgan"]              = "ElementBoost_Aqua_2_PAL",
    ["waterproof"]              = "ElementResist_Aqua_1_PAL",
    ["wellnesswatcher"]         = "PlayerSP_DecreaseRate_Passive",
    ["whopper"]                 = "MiniNushi",
    ["workaholic"]              = "PAL_Sanity_Down_2",
    ["workslave"]               = "PAL_CorporateSlave",
    ["workspeeddown1"]          = "CraftSpeed_down1",
    ["workspeeddown2"]          = "CraftSpeed_down2",
    ["workspeedup1"]            = "CraftSpeed_up1",
    ["workspeedup2"]            = "PAL_conceited",
    ["worldtreesbounty"]        = "WorldTree_FullStomach",
    ["zenmind"]                 = "ElementBoost_Normal_1_PAL",
}

local function normSkillKey(s)
    s = tostring(s or "")
    s = s:gsub("%s+", "")
    s = s:gsub(".*::", "")
    s = s:gsub("^PASSIVE_", "")
    s = s:lower()
    s = s:gsub("[^a-z0-9]", "")
    return s
end

local PASSIVE_LOOKUP = {}
for key, entry in pairs(PASSIVE_DB) do
    PASSIVE_LOOKUP[normSkillKey(key)] = entry
end

local function resolvePassiveEntry(rawKey)
    if rawKey == nil or rawKey == "" or rawKey == "None" then return nil, "" end

    local cleaned = tostring(rawKey):gsub("%s+", "")
    cleaned = cleaned:gsub(".*::", "")
    cleaned = cleaned:gsub("^PASSIVE_", "")

    local entry = PASSIVE_DB[cleaned]
    if entry then return entry, cleaned end

    local nk = normSkillKey(cleaned)
    entry = PASSIVE_LOOKUP[nk]
    if not entry and nk:sub(1, 7) == "passive" then
        entry = PASSIVE_LOOKUP[nk:sub(8)]
    end
    if entry then return entry, cleaned end

    local aliasKey = LEGACY_ALIASES[nk]
    if not aliasKey and nk:sub(1, 7) == "passive" then
        aliasKey = LEGACY_ALIASES[nk:sub(8)]
    end
    if aliasKey then
        entry = PASSIVE_DB[aliasKey]
        if entry then return entry, cleaned end
    end

    return nil, cleaned
end

local function tryLocalizedPassiveName(cleaned, worldContext, utilityContext)
    if not isObjectValid(utilityContext) or not isObjectValid(worldContext) then return nil end
    local psm = safeCall(function() return utilityContext:GetPassiveSkillManager(worldContext) end)
    if not isObjectValid(psm) then return nil end
    local textId = safeCall(function() return psm:GetNameTextId(FName(cleaned)) end)
    if not textId then return nil end

    local dtUtils = resolveStaticObject("/Script/Pal.Default__PalMasterDataTablesUtility")
    if not isObjectValid(dtUtils) then return nil end

    for _, category in ipairs({ "PASSIVE_SKILL_NAME", "PASSIVE_SKILL", "SkillName" }) do
        local ok, txt = pcall(function()
            return dtUtils:GetLocalizedText(worldContext, FName(category), textId)
        end)
        if ok and txt then
            local str = safeCall(function() return txt:ToString() end)
            if type(str) == "string" and str ~= "" and str ~= "INVTEXT" and not str:match("^PASSIVE_") then
                return str
            end
        end
    end
    return nil
end

local PassiveCache = {}

local function evaluatePassiveSkill(rawKey, worldContext, utilityContext)
    if rawKey == nil or rawKey == "" or rawKey == "None" then return nil end

    local cached = PassiveCache[rawKey]
    if cached then return cached end

    local entry, cleaned = resolvePassiveEntry(rawKey)

    if not entry then
        local tier = 1
        local lower = cleaned:lower()
        if lower:find("down", 1, true) then
            tier = -1
        elseif lower:find("_3", 1, true) or lower:find("_4", 1, true) or lower:find("emperor", 1, true) then
            tier = 3
        elseif lower:find("_2", 1, true) then
            tier = 2
        end
        local localizedName = tryLocalizedPassiveName(cleaned, worldContext, utilityContext)
        entry = { name = localizedName or prettyWords(cleaned), desc = "", tier = tier }
        printLog("Unknown passive id: " .. tostring(rawKey) .. " -> shown as \"" .. entry.name .. "\"")
    end

    PassiveCache[rawKey] = entry
    return entry
end

local WORK_NAMES = {
    EmitFlame           = "Kindling",
    Watering            = "Watering",
    Seeding             = "Planting",
    GenerateElectricity = "Generating",
    Handcraft           = "Handiwork",
    Collection          = "Gathering",
    Deforest            = "Lumbering",
    Mining              = "Mining",
    OilExtraction       = "Oil Extract",
    ProductMedicine     = "Medicine",
    Cool                = "Cooling",
    Transport           = "Transport",
    MonsterFarm         = "Farming",
}

local function prettyWorkName(raw)
    local s = tostring(raw or "")
    s = s:gsub(".*::", "")
    s = s:gsub("^EPalWorkSuitability_", "")
    return WORK_NAMES[s] or prettyWords(s)
end

function PalUI.Factory.CreateText(tree, message, fontSize, colorTuple, boldFont, justify)
    local cls = resolveStaticObject("/Script/UMG.TextBlock")
    if not cls then return nil end
    local widget = StaticConstructObject(cls, tree)
    if not isObjectValid(widget) then return nil end

    widget:SetText(FText(message or ""))
    widget:SetRenderOpacity(1.0)

    pcall(function()
        local fontInfo = widget.Font
        fontInfo.Size = fontSize or 11
        local fontAsset = resolveStaticObject(PalUI.Assets.DefaultFont)
        if fontAsset then
            fontInfo.FontObject = fontAsset
            fontInfo.TypefaceFontName = FName(boldFont and "Bold" or "Medium")
        end
        widget.Font = fontInfo
    end)

    if colorTuple then
        pcall(function()
            local c = widget.ColorAndOpacity
            c.SpecifiedColor.R = colorTuple[1]
            c.SpecifiedColor.G = colorTuple[2]
            c.SpecifiedColor.B = colorTuple[3]
            c.SpecifiedColor.A = colorTuple[4] or 1.0
            widget.ColorAndOpacity = c
        end)
    end

    if justify then
        pcall(function() widget:SetJustification(justify) end)
    end
    pcall(function() widget:SetClipping(0) end)

    return widget
end

function PalUI.Factory.CreateSolidBorder(tree, colorTuple)
    local cls = resolveStaticObject("/Script/UMG.Border")
    if not cls then return nil end
    local border = StaticConstructObject(cls, tree)
    if not isObjectValid(border) then return nil end

    border:SetRenderOpacity(1.0)
    pcall(function()
        local brush = border.BrushColor
        brush.R = colorTuple[1]
        brush.G = colorTuple[2]
        brush.B = colorTuple[3]
        brush.A = colorTuple[4] or 1.0
        border:SetBrushColor(brush)
    end)
    return border
end

function PalUI.Factory.CreateScrollArea(tree)
    local cls = resolveStaticObject("/Script/UMG.ScrollBox")
    if not cls then return nil end
    local scroll = StaticConstructObject(cls, tree)
    if not isObjectValid(scroll) then return nil end

    scroll:SetRenderOpacity(1.0)
    pcall(function()
        local thickness = scroll.ScrollbarThickness
        thickness.X, thickness.Y = 5, 5
        scroll.ScrollbarThickness = thickness
    end)
    return scroll
end

function PalUI.Factory.CreateContainerBox(tree, width, height, innerContent)
    local cls = resolveStaticObject("/Script/UMG.SizeBox")
    if not cls then return nil end
    local box = StaticConstructObject(cls, tree)
    if not isObjectValid(box) then return nil end

    if width then box:SetWidthOverride(width) end
    if height then box:SetHeightOverride(height) end
    if innerContent then box:SetContent(innerContent) end
    return box
end

function PalUI.Factory.AnchorWidget(parentCanvas, childWidget, x, y, w, h, zOrder)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not isObjectValid(slot) then return end

    slot:SetAutoSize(false)
    local pos = slot:GetPosition()
    pos.X, pos.Y = math.floor(x), math.floor(y)
    slot:SetPosition(pos)

    local size = slot:GetSize()
    size.X, size.Y = math.floor(w), math.floor(h)
    slot:SetSize(size)

    slot:SetZOrder(zOrder or 0)
end

function PalUI.Factory.AnchorCenter(parentCanvas, childWidget, w, h)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not isObjectValid(slot) then return end

    slot:SetAutoSize(false)
    local anchors = slot:GetAnchors()
    anchors.Minimum.X, anchors.Minimum.Y = 0.5, 0.5
    anchors.Maximum.X, anchors.Maximum.Y = 0.5, 0.5
    slot:SetAnchors(anchors)

    local align = slot:GetAlignment()
    align.X, align.Y = 0.5, 0.5
    slot:SetAlignment(align)

    local pos = slot:GetPosition()
    pos.X, pos.Y = 0, 0
    slot:SetPosition(pos)

    local size = slot:GetSize()
    size.X, size.Y = w, h
    slot:SetSize(size)
end

function PalUI.Factory.DrawBar(canvas, tree, x, y, w, h, ratio, fillColor)
    local track = PalUI.Factory.CreateSolidBorder(tree, PalUI.Theme.BarTrack)
    if track then PalUI.Factory.AnchorWidget(canvas, track, x, y, w, h, 1) end
    local fw = math.floor(w * clampNum(ratio or 0, 0, 1))
    if fw > 1 then
        local fill = PalUI.Factory.CreateSolidBorder(tree, fillColor)
        if fill then PalUI.Factory.AnchorWidget(canvas, fill, x, y, fw, h, 2) end
    end
end

function PalUI.Factory.DrawFrame(canvas, tree, x, y, w, h, color)
    local function line(lx, ly, lw, lh)
        local b = PalUI.Factory.CreateSolidBorder(tree, color)
        if b then PalUI.Factory.AnchorWidget(canvas, b, lx, ly, lw, lh, 1) end
    end
    line(x, y, w, 1)
    line(x, y + h - 1, w, 1)
    line(x, y, 1, h)
    line(x + w - 1, y, 1, h)
end

function PalUI.Engine.LocateMainLayout()
    local ok, instances = pcall(FindAllOf, PalUI.Assets.OverallLayout)
    if ok and instances and #instances > 0 then
        return instances[1]
    end
    return nil
end

function PalUI.Engine.FindHostCanvas(outerFullName, panelName)
    local ok, canvasList = pcall(FindAllOf, "CanvasPanel")
    if not ok or not canvasList then return nil end

    local needle = "." .. panelName
    for _, canvas in ipairs(canvasList) do
        if isObjectValid(canvas) then
            local okName, name = pcall(function() return canvas:GetFullName() end)
            if okName and name and name:sub(-#needle) == needle then
                local okOuter, outerObj = pcall(function() return canvas:GetOuter() end)
                if okOuter and isObjectValid(outerObj) then
                    local okOuterName, outerName = pcall(function() return outerObj:GetFullName() end)
                    if okOuterName and outerName == outerFullName then
                        return canvas
                    end
                end
            end
        end
    end
    return nil
end

function PalUI.Engine.DiscoverNamedSlot(windowObj)
    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not isObjectValid(tree) then return nil end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not isObjectValid(root) then return nil end

    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return nil end

    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and isObjectValid(child) then
            local okName, name = pcall(function() return child:GetFullName() end)
            if okName and name and name:match("^NamedSlot%s") then
                return child
            end
        end
    end
    return nil
end

function PalUI.Engine.MuteUnusedChrome(windowObj)
    local slot = PalUI.Engine.DiscoverNamedSlot(windowObj)
    if not slot then return end
    local okName, slotFullName = pcall(function() return slot:GetFullName() end)
    if not okName then return end

    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not isObjectValid(tree) then return end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not isObjectValid(root) then return end

    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return end

    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and isObjectValid(child) then
            local okChildName, childName = pcall(function() return child:GetFullName() end)
            if okChildName and childName ~= slotFullName then
                pcall(function() child:SetVisibility(1) end)
            end
        end
    end
end

function PalUI.Engine.AcquireModalSurface()
    local layout = PalUI.Engine.LocateMainLayout()
    if not isObjectValid(layout) then return nil end
    local ok, modalLayer = pcall(function() return layout.Modal end)
    if ok and isObjectValid(modalLayer) then return modalLayer end
    return nil
end

local ClickDispatcher = {
    subscribers = {},
    hookActive  = false,
}

function ClickDispatcher.Subscribe(buttonWidget, callback)
    if not isObjectValid(buttonWidget) or not callback then return end

    if not ClickDispatcher.hookActive then
        ClickDispatcher.hookActive = true
        pcall(function()
            RegisterHook("/Script/CommonUI.CommonButtonBase:HandleButtonClicked", function(self)
                local okGet, widget = pcall(function() return self:get() end)
                if not okGet or not widget then return end
                local okName, fullName = pcall(function() return widget:GetFullName() end)
                if not okName or not fullName then return end

                local handler = ClickDispatcher.subscribers[fullName]
                if handler then pcall(handler) end
            end)
        end)
    end

    local okName, name = pcall(function() return buttonWidget:GetFullName() end)
    if okName and name then
        ClickDispatcher.subscribers[name] = callback
    end
end

function ClickDispatcher.Reset()
    ClickDispatcher.subscribers = {}
end

local function assembleModalFrame(panel, tree, frameWidth, frameHeight)
    local winCls     = resolveStaticObject(PalUI.Assets.WindowBlueprint)
    local canvasCls  = resolveStaticObject("/Script/UMG.CanvasPanel")
    local sizeBoxCls = resolveStaticObject("/Script/UMG.SizeBox")
    local widgetLib  = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    local modalHost  = PalUI.Engine.AcquireModalSurface()

    if not winCls or not canvasCls or not sizeBoxCls or not widgetLib or not modalHost then
        printLog("Failed to locate core UMG classes for modal assembly")
        return nil
    end

    local frameShell, contentSurface
    local ok, err = pcall(function()
        local player = panel:GetOwningPlayer()
        frameShell = modalHost:BP_AddWidget(winCls)
        if not isObjectValid(frameShell) then error("Modal host rejected window widget") end

        PalUI.Engine.MuteUnusedChrome(frameShell)
        local shellSlot = PalUI.Engine.DiscoverNamedSlot(frameShell)
        if not shellSlot then error("Frame shell named slot not found") end

        local innerWindow = widgetLib:Create(panel, winCls, player)
        if not isObjectValid(innerWindow) then error("Inner window generation failed") end

        local innerSlot = PalUI.Engine.DiscoverNamedSlot(innerWindow)
        if not innerSlot then error("Inner window named slot missing") end

        contentSurface = StaticConstructObject(canvasCls, tree)
        local frameBox = StaticConstructObject(sizeBoxCls, tree)
        frameBox:SetWidthOverride(frameWidth)
        frameBox:SetHeightOverride(frameHeight)
        frameBox:SetContent(contentSurface)
        innerSlot:SetContent(frameBox)

        local hostCanvas = StaticConstructObject(canvasCls, tree)
        shellSlot:SetContent(hostCanvas)
        PalUI.Factory.AnchorCenter(hostCanvas, innerWindow, frameWidth, frameHeight)
    end)

    if not ok or not isObjectValid(frameShell) then
        printLog("assembleModalFrame error: " .. tostring(err))
        return nil
    end

    pcall(function()
        local blurCls = resolveStaticObject("/Script/UMG.BackgroundBlur")
        if blurCls then
            local blur = StaticConstructObject(blurCls, tree)
            if isObjectValid(blur) then
                blur:SetRenderOpacity(1.0)
                pcall(function() blur:SetBlurStrength(6.0) end)
                PalUI.Factory.AnchorWidget(contentSurface, blur, 0, 0, frameWidth, frameHeight, 0)
            end
        end
        local base = PalUI.Factory.CreateSolidBorder(tree, PalUI.Theme.PanelBase)
        if base then PalUI.Factory.AnchorWidget(contentSurface, base, 0, 0, frameWidth, frameHeight, 1) end
    end)

    return { shell = frameShell, surface = contentSurface }
end

local UI_W        = 900
local UI_H        = 780
local PAD         = 16
local HEADER_H    = 46
local FILTER_H    = 34
local FOOTER_H    = 44
local CARD_GAP    = 8
local PAGE_SIZE   = 20

local ControllerState = {
    activeShell  = nil,
    activeSurface= nil,
    widgetTree   = nil,
    isDisplayed  = false,

    all          = {},
    view         = {},
    filter       = "all",
    sortMode     = 1,
    page         = 1,
    pageSize     = PAGE_SIZE,

    scroll       = nil,
    pageLabel    = nil,
    sortButton   = nil,
    filterMarks  = {},
    pageButtons  = {},
    cardW        = 800,
}

local FILTERS = {
    { key = "all",   label = "ALL" },
    { key = "god",   label = "★ GOD" },
    { key = "iv",    label = "3x100" },
    { key = "clean", label = "CLEAN" },
    { key = "bad",   label = "DEBUFF" },
}

local SORT_LABELS = { "SORT: BEST", "SORT: IV", "SORT: NAME", "SORT: HATCH" }

local function ivColor(v)
    v = v or 0
    if v >= 100 then return PalUI.Theme.Gold end
    if v >= 80  then return PalUI.Theme.Green end
    if v >= 60  then return PalUI.Theme.GreenSoft end
    if v >= 30  then return PalUI.Theme.TextSecond end
    return PalUI.Theme.Red
end

local NameCache = {}

local function resolveDisplayName(pal, world, utility)
    local id = pal.characterId or "Unknown"
    if NameCache[id] then return NameCache[id] end

    local resolved = nil
    if isObjectValid(utility) and isObjectValid(world) then
        local db = safeCall(function() return utility:GetDatabaseCharacterParameter(world) end)
        if isObjectValid(db) then
            local ok, outText = pcall(function()
                local outTable = {}
                db:GetLocalizedCharacterName(FName(id), outTable)
                for _, v in pairs(outTable) do return v end
                return nil
            end)
            if ok and outText then
                local nameStr = safeCall(function() return outText:ToString() end)
                if nameStr and nameStr ~= "" and nameStr ~= "INVTEXT" then
                    resolved = nameStr
                end
            end
        end
    end

    resolved = resolved or prettyWords(id)
    NameCache[id] = resolved
    return resolved
end

local function parsePalDataList(palList, ctx)
    local world   = ctx and ctx.world
    local utility = ctx and ctx.utility

    for index, pal in ipairs(palList) do
        pal._order       = index
        pal._displayName = resolveDisplayName(pal, world, utility)

        pal._evaluatedPassives = {}
        pal._goldCount   = 0
        pal._goodCount   = 0
        pal._debuffCount = 0

        local seen = {}
        for _, skillId in ipairs(pal.passiveSkills or {}) do
            local entry = evaluatePassiveSkill(skillId, world, utility)
            if entry and entry.name then
                local dkey = normSkillKey(skillId ~= nil and skillId or entry.name)
                if not seen[dkey] then
                    seen[dkey] = true
                    pal._evaluatedPassives[#pal._evaluatedPassives + 1] = {
                        name = entry.name,
                        desc = entry.desc or "",
                        tier = entry.tier or 1,
                    }
                    if entry.tier == 3 then
                        pal._goldCount = pal._goldCount + 1
                    elseif entry.tier == -1 then
                        pal._debuffCount = pal._debuffCount + 1
                    else
                        pal._goodCount = pal._goodCount + 1
                    end
                end
            end
        end
        table.sort(pal._evaluatedPassives, function(a, b)
            if a.tier ~= b.tier then return a.tier > b.tier end
            return a.name < b.name
        end)

        local hpVal  = pal.talentHP or 0
        local atkVal = pal.talentMelee or 0
        local defVal = pal.talentDefense or 0
        pal._totalIV   = hpVal + atkVal + defVal
        pal._is3x100   = (hpVal == 100 and atkVal == 100 and defVal == 100)
        pal._isClean   = (#pal._evaluatedPassives == 0)
        pal._hasDebuff = (pal._debuffCount > 0)
        pal._isGodRoll = (pal._goldCount >= 4) or (pal._is3x100 and pal._debuffCount == 0)

        local souls = {}
        if (pal.rankHP or 0) > 0         then souls[#souls + 1] = "HP+"   .. pal.rankHP end
        if (pal.rankAttack or 0) > 0     then souls[#souls + 1] = "Atk+"  .. pal.rankAttack end
        if (pal.rankDefence or 0) > 0    then souls[#souls + 1] = "Def+"  .. pal.rankDefence end
        if (pal.rankCraftSpeed or 0) > 0 then souls[#souls + 1] = "Work+" .. pal.rankCraftSpeed end
        pal._soulText = (#souls > 0) and ("SOULS  " .. table.concat(souls, "  ")) or ""

        local rank = pal.rank or 0
        pal._condenseText = (rank > 1) and string.rep("★", math.min(rank - 1, 4)) or ""

        local works = {}
        for i, skill in ipairs(pal.workSuitability or {}) do
            if i > 4 then break end
            works[#works + 1] = prettyWorkName(skill.type) .. " " .. tostring(skill.rank or 0)
        end
        local workLine = ""
        if #works > 0 then workLine = "WORK  " .. table.concat(works, "   ") end
        if (pal.craftSpeed or 0) > 0 then
            workLine = (workLine ~= "" and (workLine .. "   |   ") or "") .. "SPEED " .. pal.craftSpeed
        end
        pal._workText = workLine

        pal._score = pal._totalIV
                   + pal._goldCount * 70
                   + pal._goodCount * 12
                   - pal._debuffCount * 55
                   + rank * 4
    end
end

local function drawPalCard(scrollBox, tree, pal, cardW)
    local canvasCls = resolveStaticObject("/Script/UMG.CanvasPanel")
    if not canvasCls then return end
    local card = StaticConstructObject(canvasCls, tree)
    if not isObjectValid(card) then return end
    card:SetRenderOpacity(1.0)

    local F, T = PalUI.Factory, PalUI.Theme

    local C_GOLD   = hexToLinearColor("#FBBF24", 1.0)
    local C_GREEN  = hexToLinearColor("#34D399", 1.0)
    local C_BLUE   = hexToLinearColor("#93C5FD", 1.0)
    local C_RED    = hexToLinearColor("#F87171", 1.0)
    local C_DESC   = hexToLinearColor("#94A3B8", 1.0)
    local C_SLOTBG = hexToLinearColor("#12191E", 0.95)
    local C_EMPTY  = hexToLinearColor("#1A242B", 0.40)

    local padX  = 14
    local headY = 10
    local headH = 20
    local bodyY = headY + headH + 8
    local rowH  = 18
    local bodyH = 94

    local hasFoot = (pal._workText ~= "" or pal._soulText ~= "" or pal._condenseText ~= "")
    local footY   = bodyY + bodyH + 8
    local cardH   = hasFoot and (footY + 17 + 8) or (bodyY + bodyH + 10)

    local bgColor = T.CardBase
    if pal._isGodRoll then bgColor = T.CardGold
    elseif pal._hasDebuff then bgColor = T.CardBad end

    local bg = F.CreateSolidBorder(tree, bgColor)
    if bg then F.AnchorWidget(card, bg, 0, 0, cardW, cardH, 0) end

    local accent = T.BorderDefault
    if pal._isGodRoll then accent = T.Gold
    elseif pal._hasDebuff then accent = T.Red
    elseif pal._isClean then accent = T.Cyan
    elseif (pal._totalIV or 0) >= 240 then accent = T.Green end

    local accentBar = F.CreateSolidBorder(tree, accent)
    if accentBar then F.AnchorWidget(card, accentBar, 0, 0, 4, cardH, 1) end

    local hair = F.CreateSolidBorder(tree, T.Divider)
    if hair then F.AnchorWidget(card, hair, 4, cardH - 1, cardW - 4, 1, 1) end

    local idxTxt = F.CreateText(tree, "#" .. (pal._order or 0), 10, T.TextDim, false, 0)
    if idxTxt then F.AnchorWidget(card, idxTxt, padX, headY + 4, 46, 14, 2) end

    local gsym, gcol = "", T.TextDim
    if pal.gender == 1 then gsym, gcol = "♂", T.Male
    elseif pal.gender == 2 then gsym, gcol = "♀", T.Female end
    if gsym ~= "" then
        local g = F.CreateText(tree, gsym, 15, gcol, true, 1)
        if g then F.AnchorWidget(card, g, padX + 46, headY, 18, 20, 2) end
    end

    local nameTxt = F.CreateText(tree, ellipsize(pal._displayName, 26), 14, T.TextPrimary, true, 0)
    if nameTxt then F.AnchorWidget(card, nameTxt, padX + 66, headY, 250, 20, 2) end

    local lvlTxt = F.CreateText(tree, "Lv " .. (pal.level or 1), 11, T.TextSecond, true, 0)
    if lvlTxt then F.AnchorWidget(card, lvlTxt, padX + 320, headY + 3, 66, 15, 2) end

    local cursor = cardW - padX
    local function pill(text, col)
        local w = math.max(50, math.floor(#text * 6.6) + 16)
        if cursor - w < padX + 400 then return end
        cursor = cursor - w
        local p = F.CreateSolidBorder(tree, withAlpha(col, 0.16))
        if p then F.AnchorWidget(card, p, cursor, headY + 1, w, 18, 2) end
        local t = F.CreateText(tree, text, 9, col, true, 1)
        if t then F.AnchorWidget(card, t, cursor, headY + 4, w, 13, 3) end
        cursor = cursor - 6
    end

    if pal._isGodRoll then
        pill("★ GOD ROLL", T.Gold)
    elseif (pal._goldCount or 0) > 0 then
        pill("★ " .. pal._goldCount .. " TOP", T.Gold)
    end
    if pal._is3x100 then pill("3x100 IV", T.Gold) end
    if pal.isRarePal then pill("LUCKY", T.Purple) end
    if pal._isClean then
        pill("CLEAN", T.Cyan)
    elseif pal._hasDebuff then
        pill("▼ " .. pal._debuffCount, T.Red)
    end

    local colW   = math.floor((cardW - padX * 2) * 0.41)
    local labelW = 36
    local valW   = 52
    local barX   = padX + labelW
    local barW   = colW - labelW - valW - 10

    local function statRow(i, label, value)
        local y = bodyY + (i - 1) * rowH + 2
        local col = ivColor(value)
        local l = F.CreateText(tree, label, 10, T.TextDim, true, 0)
        if l then F.AnchorWidget(card, l, padX, y, labelW, 14, 2) end
        F.DrawBar(card, tree, barX, y + 4, barW, 7, (value or 0) / 100, col)
        local v = F.CreateText(tree, tostring(value or 0), 11, col, value >= 100, 2)
        if v then F.AnchorWidget(card, v, padX + colW - valW, y - 1, valW, 15, 2) end
    end

    statRow(1, "HP",  pal.talentHP or 0)
    statRow(2, "ATK", pal.talentMelee or 0)
    statRow(3, "DEF", pal.talentDefense or 0)

    local totY  = bodyY + rowH * 3 + 12
    local tot   = pal._totalIV or 0
    local totCol = (tot >= 270 and T.Gold) or (tot >= 210 and T.Green)
                or (tot >= 120 and T.TextSecond) or T.Red
    local tl = F.CreateText(tree, "IV TOTAL", 9, T.TextDim, true, 0)
    if tl then F.AnchorWidget(card, tl, padX, totY, 70, 14, 2) end
    local tv = F.CreateText(tree, tot .. " / 300   " .. math.floor(tot / 3) .. "%", 10, totCol, true, 2)
    if tv then F.AnchorWidget(card, tv, padX + colW - 180, totY, 180, 14, 2) end

    local sep = F.CreateSolidBorder(tree, T.Divider)
    if sep then F.AnchorWidget(card, sep, padX + colW + 10, bodyY - 2, 1, bodyH, 2) end

    local rx = padX + colW + 22
    local rw = cardW - padX - rx
    local list = pal._evaluatedPassives or {}

    local ph = F.CreateText(tree, "PASSIVES  " .. #list .. "/4", 9, T.TextDim, true, 0)
    if ph then F.AnchorWidget(card, ph, rx, bodyY - 2, rw, 14, 2) end

    if #list == 0 then
        local none = F.CreateText(tree, "•  no passives  —  perfect clean base", 10, T.Cyan, false, 0)
        if none then F.AnchorWidget(card, none, rx + 4, bodyY + 24, rw - 4, 16, 2) end
    else
        local cellW = math.floor((rw - 8) / 2)
        local slotH = 35

        for i = 1, 4 do
            local cc = (i - 1) % 2
            local rr = math.floor((i - 1) / 2)
            local x = rx + cc * (cellW + 8)
            local y = bodyY + 15 + rr * (slotH + 5)

            local d = list[i]
            if d then

                local mark, col, accentCol = "• ", C_BLUE, T.BorderDefault
                if d.tier == 3 then
                    mark, col, accentCol = "★ ", C_GOLD, C_GOLD
                elseif d.tier == 2 then
                    mark, col, accentCol = "• ", C_GREEN, C_GREEN
                elseif d.tier == -1 then
                    mark, col, accentCol = "▼ ", C_RED, C_RED
                end

                local slotBg = F.CreateSolidBorder(tree, C_SLOTBG)
                if slotBg then F.AnchorWidget(card, slotBg, x, y, cellW, slotH, 2) end

                local slotBar = F.CreateSolidBorder(tree, accentCol)
                if slotBar then F.AnchorWidget(card, slotBar, x, y, 3, slotH, 3) end

                local t = F.CreateText(tree, mark .. ellipsize(d.name, 22), 10, col, true, 0)
                if t then F.AnchorWidget(card, t, x + 7, y + 3, cellW - 10, 14, 4) end

                if d.desc and d.desc ~= "" then
                    local dsc = F.CreateText(tree, ellipsize(d.desc, 34), 9, C_DESC, false, 0)
                    if dsc then F.AnchorWidget(card, dsc, x + 7, y + 18, cellW - 10, 13, 4) end
                end
            else
                local emptyBg = F.CreateSolidBorder(tree, C_EMPTY)
                if emptyBg then F.AnchorWidget(card, emptyBg, x, y, cellW, slotH, 1) end
                local emptyTxt = F.CreateText(tree, "— empty —", 9, T.Divider, false, 1)
                if emptyTxt then F.AnchorWidget(card, emptyTxt, x, y + 10, cellW, 14, 2) end
            end
        end
    end

    if hasFoot then
        local dv = F.CreateSolidBorder(tree, T.Divider)
        if dv then F.AnchorWidget(card, dv, padX, footY - 8, cardW - padX * 2, 1, 2) end

        local rightCursor = cardW - padX
        if pal._condenseText ~= "" then
            local c = F.CreateText(tree, pal._condenseText, 11, T.Gold, false, 2)
            if c then F.AnchorWidget(card, c, rightCursor - 90, footY, 90, 15, 2) end
            rightCursor = rightCursor - 98
        end
        if pal._soulText ~= "" then
            local s = F.CreateText(tree, pal._soulText, 9, T.Green, false, 2)
            if s then F.AnchorWidget(card, s, rightCursor - 240, footY + 1, 240, 14, 2) end
            rightCursor = rightCursor - 248
        end
        if pal._workText ~= "" then
            local wWidth = math.max(120, rightCursor - padX - 10)
            local w = F.CreateText(tree, pal._workText, 9, T.TextSecond, false, 0)
            if w then F.AnchorWidget(card, w, padX, footY + 1, wWidth, 14, 2) end
        end
    end

    local wrap = PalUI.Factory.CreateContainerBox(tree, cardW, cardH + CARD_GAP, card)
    if wrap then pcall(function() scrollBox:AddChild(wrap) end) end
end

local function drawNoticeCard(scrollBox, tree, cardW, message)
    local canvasCls = resolveStaticObject("/Script/UMG.CanvasPanel")
    if not canvasCls then return end
    local canvas = StaticConstructObject(canvasCls, tree)
    if not isObjectValid(canvas) then return end

    local F, T = PalUI.Factory, PalUI.Theme
    local h = 90
    local bg = F.CreateSolidBorder(tree, T.CardBase)
    if bg then F.AnchorWidget(canvas, bg, 0, 0, cardW, h, 0) end
    local txt = F.CreateText(tree, message, 12, T.TextSecond, false, 1)
    if txt then F.AnchorWidget(canvas, txt, 0, h / 2 - 10, cardW, 20, 2) end

    local wrap = F.CreateContainerBox(tree, cardW, h + CARD_GAP, canvas)
    if wrap then pcall(function() scrollBox:AddChild(wrap) end) end
end

local function applyView()
    local S = ControllerState
    local out = {}

    for _, p in ipairs(S.all) do
        local keep = true
        if     S.filter == "god"   then keep = p._isGodRoll or (p._goldCount or 0) > 0
        elseif S.filter == "iv"    then keep = p._is3x100
        elseif S.filter == "clean" then keep = p._isClean
        elseif S.filter == "bad"   then keep = p._hasDebuff end
        if keep then out[#out + 1] = p end
    end

    if S.sortMode == 1 then
        table.sort(out, function(a, b)
            if a._score ~= b._score then return a._score > b._score end
            return a._order < b._order
        end)
    elseif S.sortMode == 2 then
        table.sort(out, function(a, b)
            if a._totalIV ~= b._totalIV then return a._totalIV > b._totalIV end
            return a._order < b._order
        end)
    elseif S.sortMode == 3 then
        table.sort(out, function(a, b)
            if a._displayName ~= b._displayName then return a._displayName < b._displayName end
            return a._order < b._order
        end)
    else
        table.sort(out, function(a, b) return a._order < b._order end)
    end

    S.view = out
    S.page = 1
end

local function refreshFilterMarks()
    local S = ControllerState
    for i, mark in ipairs(S.filterMarks) do
        if isObjectValid(mark) then
            local active = (FILTERS[i] and FILTERS[i].key == S.filter)
            pcall(function() mark:SetVisibility(active and 0 or 1) end)
        end
    end
end

local function rebuildList()
    local S = ControllerState
    if not isObjectValid(S.scroll) then return end

    pcall(function() S.scroll:ClearChildren() end)

    local total = #S.view
    local pages = math.max(1, math.ceil(total / S.pageSize))
    S.page = math.floor(clampNum(S.page, 1, pages))

    local first = (S.page - 1) * S.pageSize + 1
    local last  = math.min(total, first + S.pageSize - 1)

    if total == 0 then
        drawNoticeCard(S.scroll, S.widgetTree, S.cardW, "No pals match this filter.")
    else
        for i = first, last do
            drawPalCard(S.scroll, S.widgetTree, S.view[i], S.cardW)
        end
    end

    if isObjectValid(S.pageLabel) then
        local label
        if total == 0 then
            label = "0 results"
        else
            label = string.format("Page %d / %d      %d–%d of %d", S.page, pages, first, last, total)
        end
        pcall(function() S.pageLabel:SetText(FText(label)) end)
    end

    for _, btn in ipairs(S.pageButtons) do
        if isObjectValid(btn) then
            pcall(function() btn:SetVisibility(pages > 1 and 0 or 1) end)
        end
    end

    pcall(function() S.scroll:ScrollToStart() end)
end

local function createGameButton(hostCanvas, surface, tree, label, x, y, w, h, onClick, z)
    local btnCls    = resolveStaticObject(PalUI.Assets.ButtonBlueprint)
    local widgetLib = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    if not btnCls or not widgetLib then return nil end

    local ok, btn = pcall(function()
        local owner = hostCanvas:GetOwningPlayer()
        local b = widgetLib:Create(hostCanvas, btnCls, owner)
        if not isObjectValid(b) then error("button create failed") end
        pcall(function() b:Setup(false) end)
        pcall(function() b:SetText(FText(label)) end)
        return b
    end)
    if not ok or not isObjectValid(btn) then return nil end

    PalUI.Factory.AnchorWidget(surface, btn, x, y, w, h, z or 60)

    local target = btn
    local okIn, inner = pcall(function() return btn.WBP_PalInvisibleButton end)
    if okIn and isObjectValid(inner) then target = inner end
    ClickDispatcher.Subscribe(target, onClick)

    return btn
end

function PalUI.Presenter.Show(palDataList, context)
    palDataList = palDataList or {}
    printLog("Opening hatch report for " .. #palDataList .. " pal(s)")
    PalUI.Presenter.Close()

    local layout = PalUI.Engine.LocateMainLayout()
    if not isObjectValid(layout) then printLog("Layout instance not found"); return end

    local tree = layout.WidgetTree
    if not isObjectValid(tree) then printLog("WidgetTree not found"); return end

    local layoutName = safeCall(function() return tree:GetFullName() end)
    if not layoutName then printLog("Unable to resolve layout name"); return end

    local hostCanvas = PalUI.Engine.FindHostCanvas(layoutName, PalUI.Assets.HostPanelName)
    if not isObjectValid(hostCanvas) then printLog("Host canvas panel missing"); return end

    parsePalDataList(palDataList, context)

    local frame = assembleModalFrame(hostCanvas, tree, UI_W, UI_H)
    if not frame then return end

    local S = ControllerState
    S.activeShell   = frame.shell
    S.activeSurface = frame.surface
    S.widgetTree    = tree
    S.all           = palDataList
    S.filter        = "all"
    S.sortMode      = 1
    S.page          = 1
    S.pageSize      = PAGE_SIZE
    S.filterMarks   = {}
    S.pageButtons   = {}
    ClickDispatcher.Reset()

    local F, T   = PalUI.Factory, PalUI.Theme
    local surface = frame.surface
    local contentW = UI_W - PAD * 2

    local headerBg = F.CreateSolidBorder(tree, T.PanelHeader)
    if headerBg then F.AnchorWidget(surface, headerBg, PAD, PAD, contentW, HEADER_H, 5) end
    F.DrawFrame(surface, tree, PAD, PAD, contentW, HEADER_H, T.BorderDefault)

    local goldLine = F.CreateSolidBorder(tree, T.Gold)
    if goldLine then F.AnchorWidget(surface, goldLine, PAD, PAD + HEADER_H - 2, contentW, 2, 6) end

    local title = F.CreateText(tree, "HATCH REPORT", 17, T.TextPrimary, true, 0)
    if title then F.AnchorWidget(surface, title, PAD + 16, PAD + 12, 340, 24, 7) end

    local subtitle = string.format("%d pal(s) collected from incubators", #palDataList)
    local sub = F.CreateText(tree, subtitle, 11, T.TextSecond, false, 2)
    if sub then F.AnchorWidget(surface, sub, PAD + contentW - 420, PAD + 16, 404, 16, 7) end

    local counts = { all = #palDataList, god = 0, iv = 0, clean = 0, bad = 0 }
    for _, p in ipairs(palDataList) do
        if p._isGodRoll or (p._goldCount or 0) > 0 then counts.god = counts.god + 1 end
        if p._is3x100  then counts.iv    = counts.iv + 1 end
        if p._isClean  then counts.clean = counts.clean + 1 end
        if p._hasDebuff then counts.bad  = counts.bad + 1 end
    end

    local filterY = PAD + HEADER_H + 8
    local fBtnW, fGap = 126, 8
    local fx = PAD

    for i, def in ipairs(FILTERS) do
        local key = def.key
        local btn = createGameButton(hostCanvas, surface, tree,
            def.label .. "  " .. (counts[key] or 0),
            fx, filterY, fBtnW, FILTER_H,
            function()
                ControllerState.filter = key
                applyView()
                refreshFilterMarks()
                rebuildList()
            end, 60)

        local mark = F.CreateSolidBorder(tree, T.Gold)
        if mark then
            F.AnchorWidget(surface, mark, fx + 8, filterY + FILTER_H - 2, fBtnW - 16, 3, 70)
            pcall(function() mark:SetVisibility(i == 1 and 0 or 1) end)
        end
        S.filterMarks[i] = mark

        if not btn then
            local ph = F.CreateText(tree, def.label .. " " .. (counts[key] or 0), 10, T.TextSecond, true, 1)
            if ph then F.AnchorWidget(surface, ph, fx, filterY + 10, fBtnW, 16, 60) end
        end

        fx = fx + fBtnW + fGap
    end

    S.sortButton = createGameButton(hostCanvas, surface, tree, SORT_LABELS[1],
        PAD + contentW - 168, filterY, 168, FILTER_H,
        function()
            local st = ControllerState
            st.sortMode = (st.sortMode % 4) + 1
            if isObjectValid(st.sortButton) then
                pcall(function() st.sortButton:SetText(FText(SORT_LABELS[st.sortMode])) end)
            end
            applyView()
            rebuildList()
        end, 60)

    local listY = filterY + FILTER_H + 10
    local listH = UI_H - listY - FOOTER_H - PAD - 8

    local listBg = F.CreateSolidBorder(tree, T.PanelList)
    if listBg then F.AnchorWidget(surface, listBg, PAD, listY, contentW, listH, 5) end
    F.DrawFrame(surface, tree, PAD, listY, contentW, listH, T.Divider)

    local scroll = F.CreateScrollArea(tree)
    if scroll then
        F.AnchorWidget(surface, scroll, PAD + 6, listY + 6, contentW - 12, listH - 12, 10)
    end
    S.scroll = scroll
    S.cardW  = contentW - 20

    local footerY = UI_H - PAD - FOOTER_H
    local footLine = F.CreateSolidBorder(tree, T.Divider)
    if footLine then F.AnchorWidget(surface, footLine, PAD, footerY - 4, contentW, 1, 6) end

    local function stepPage(delta)
        local st = ControllerState
        st.page = st.page + delta
        rebuildList()
    end

    local bY, bH = footerY + 3, 36
    S.pageButtons[#S.pageButtons + 1] =
        createGameButton(hostCanvas, surface, tree, "<< 10", PAD, bY, 66, bH, function() stepPage(-10) end, 60)
    S.pageButtons[#S.pageButtons + 1] =
        createGameButton(hostCanvas, surface, tree, "< PREV", PAD + 72, bY, 96, bH, function() stepPage(-1) end, 60)

    S.pageLabel = F.CreateText(tree, "Page 1 / 1", 11, T.TextSecond, true, 1)
    if S.pageLabel then F.AnchorWidget(surface, S.pageLabel, PAD + 174, bY + 10, 250, 16, 60) end

    S.pageButtons[#S.pageButtons + 1] =
        createGameButton(hostCanvas, surface, tree, "NEXT >", PAD + 430, bY, 96, bH, function() stepPage(1) end, 60)
    S.pageButtons[#S.pageButtons + 1] =
        createGameButton(hostCanvas, surface, tree, "10 >>", PAD + 532, bY, 66, bH, function() stepPage(10) end, 60)

    local closeBtn = createGameButton(hostCanvas, surface, tree, "CLOSE REPORT",
        PAD + contentW - 168, bY, 168, bH,
        function() PalUI.Presenter.Close() end, 60)

    if not closeBtn then
        local fb = F.CreateSolidBorder(tree, T.PanelHeader)
        if fb then F.AnchorWidget(surface, fb, PAD + contentW - 168, bY, 168, bH, 60) end
        local ft = F.CreateText(tree, "CLOSE  [ESC]", 12, T.TextPrimary, true, 1)
        if ft then F.AnchorWidget(surface, ft, PAD + contentW - 168, bY + 10, 168, 16, 61) end
    end

    applyView()
    refreshFilterMarks()
    rebuildList()

    S.isDisplayed = true
    printLog("Report window rendered")
end

function PalUI.Presenter.Close()
    local S = ControllerState
    if isObjectValid(S.activeShell) then
        local modalHost = PalUI.Engine.AcquireModalSurface()
        if modalHost then
            pcall(function() modalHost:RemoveWidget(S.activeShell) end)
        end
    end
    S.activeShell   = nil
    S.activeSurface = nil
    S.widgetTree    = nil
    S.scroll        = nil
    S.pageLabel     = nil
    S.sortButton    = nil
    S.filterMarks   = {}
    S.pageButtons   = {}
    S.all           = {}
    S.view          = {}
    S.isDisplayed   = false
    ClickDispatcher.Reset()
end

function PalUI.Presenter.IsVisible()
    return ControllerState.isDisplayed
end

return {
    show       = PalUI.Presenter.Show,
    close      = PalUI.Presenter.Close,
    is_visible = PalUI.Presenter.IsVisible,
    Show       = PalUI.Presenter.Show,
    Close      = PalUI.Presenter.Close,
    IsVisible  = PalUI.Presenter.IsVisible,
}