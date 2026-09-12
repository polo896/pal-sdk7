-- ========================================================================================
-- Mod: Weapon Stats Customizer 
-- ========================================================================================

local Config = {
    -- ====================================================================================
    -- 1. GLOBAL MULTIPLIERS & CHEATS (Affects all weapons unless overridden)
    -- ====================================================================================
    Global = {
        EnableMod = true,                   -- Master mod switch
        DamageMultiplier = 1.0,             -- Global damage multiplier (e.g. 2.0 = double damage)
        MagazineMultiplier = 1.0,           -- Global magazine capacity multiplier (e.g. 2.0 = double mag)
        FireRateMultiplier = 1.0,          -- Global fire rate multiplier
        ReloadSpeedMultiplier = 1.0,       -- Global reload speed multiplier
        ChargeMultiplier = 1.0,            -- Global charge speed multiplier
        HeatCoolMultiplier = 1.0,          -- Global overheat cooling multiplier
        DurabilityMultiplier = 1.0,         -- Global durability multiplier (e.g. 5.0 = 5x durability)
        WeightMultiplier = 1.0,             -- Global weight multiplier (e.g. 0.0 = zero weight)
        ExplosionRadiusMultiplier = 1.0,    -- Global blast radius multiplier for grenades & launchers
        ExplosionDamageMultiplier = 1.0,    -- Global explosion damage multiplier
        
        InfiniteDurability = false,         -- If true, weapons never lose durability
        InfiniteAmmo = false,               -- If true, weapons never consume ammunition
        NoRecoil = false,                   -- If true, removes weapon recoil & camera kick
        IncreasedBulletLifetime = false,    -- If true, maximum bullet range & no dropoff
        
        DebugLogging = true,                -- Print logs to the UE4SS console
    },

    -- ====================================================================================
    -- 2. COMPLETE WEAPON DATABASE (EXACT VANILLA DEFAULT VALUES)
    -- Attack     : Base weapon damage
    -- Mag        : Ammo capacity per magazine
    -- Dur     : Maximum durability before breaking
    -- Wgt     : Inventory weight
    -- Snk     : Stealth damage multiplier
    -- FireRate: Per-weapon fire rate multiplier; nil uses global
    -- Reload  : Per-weapon reload multiplier; nil uses global
    -- ====================================================================================
    Weapons = {
        -- ================================================================================
        -- ASSAULT RIFLES, COMBAT SMGs & SUBMACHINE GUNS
        -- Name map: AssaultRifle_Default1-5 -> Assault Rifle
        --            SkyAssaultRifle[_2.._5] -> Heavy Assault Rifle
        --            ElectricArcAssaultRifle[_2.._5] -> Plasma Rifle
        --            MakeshiftAssaultRifle[_2.._5] -> Makeshift Assault Rifle
        --            SkySubmachineGun[_2.._5] -> Combat SMG
        --            SubmachineGun[_2.._5] -> SMG
        --            MakeshiftSubmachineGun[_2.._5] -> Makeshift SMG
        -- ================================================================================
        ["AssaultRifle_Default1"]       = { Attack = 320,   Mag = 20, Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["AssaultRifle_Default2"]       = { Attack = 400,   Mag = 24, Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["AssaultRifle_Default3"]       = { Attack = 448,   Mag = 26, Dur = 4000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["AssaultRifle_Default4"]       = { Attack = 512,   Mag = 28, Dur = 5000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["AssaultRifle_Default5"]       = { Attack = 560,   Mag = 30, Dur = 6000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyAssaultRifle"]             = { Attack = 1615,  Mag = 30, Dur = 5500, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyAssaultRifle_2"]           = { Attack = 1695,  Mag = 34, Dur = 8250, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyAssaultRifle_3"]           = { Attack = 1776,  Mag = 38, Dur = 11000,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyAssaultRifle_4"]           = { Attack = 1857,  Mag = 42, Dur = 16500,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyAssaultRifle_5"]           = { Attack = 1938,  Mag = 46, Dur = 22000,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["ElectricArcAssaultRifle"]     = { Attack = 1860,  Mag = 38, Dur = 25000,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["ElectricArcAssaultRifle_2"]   = { Attack = 1953,  Mag = 40, Dur = 37500,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["ElectricArcAssaultRifle_3"]   = { Attack = 2046,  Mag = 42, Dur = 50000,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["ElectricArcAssaultRifle_4"]   = { Attack = 2139,  Mag = 44, Dur = 75000,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["ElectricArcAssaultRifle_5"]   = { Attack = 2232,  Mag = 46, Dur = 100000,Wgt = 5.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftAssaultRifle"]       = { Attack = 170,   Mag = 15, Dur = 1500, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftAssaultRifle_2"]     = { Attack = 204,   Mag = 17, Dur = 2250, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftAssaultRifle_3"]     = { Attack = 229,   Mag = 19, Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftAssaultRifle_4"]     = { Attack = 255,   Mag = 21, Dur = 4500, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftAssaultRifle_5"]     = { Attack = 297,   Mag = 23, Dur = 6000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkySubmachineGun"]            = { Attack = 907,   Mag = 42, Dur = 8000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkySubmachineGun_2"]          = { Attack = 1088,  Mag = 44, Dur = 12000,Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkySubmachineGun_3"]          = { Attack = 1224,  Mag = 46, Dur = 16000,Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkySubmachineGun_4"]          = { Attack = 1360,  Mag = 48, Dur = 24000,Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkySubmachineGun_5"]          = { Attack = 1587,  Mag = 50, Dur = 32000,Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SubmachineGun"]               = { Attack = 130,   Mag = 24, Dur = 2000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SubmachineGun_2"]             = { Attack = 156,   Mag = 26, Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SubmachineGun_3"]             = { Attack = 175,   Mag = 28, Dur = 4000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SubmachineGun_4"]             = { Attack = 195,   Mag = 30, Dur = 6000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SubmachineGun_5"]             = { Attack = 227,   Mag = 32, Dur = 8000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftSubmachineGun"]      = { Attack = 100,   Mag = 24, Dur = 1000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftSubmachineGun_2"]    = { Attack = 120,   Mag = 26, Dur = 1500, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftSubmachineGun_3"]    = { Attack = 135,   Mag = 28, Dur = 2000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftSubmachineGun_4"]    = { Attack = 150,   Mag = 30, Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftSubmachineGun_5"]    = { Attack = 175,   Mag = 32, Dur = 4000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- LASER, ENERGY, PULSE RIFLES & SNIPERS
        -- Name map: LaserRifle[_2.._5] -> Laser Rifle
        --            ChargeLaserRifle[_2.._5] -> Charge Rifle
        --            OverHeatRifle[_2.._5] -> Overheat Rifle
        --            SemiAutoRifle[_2.._5] -> Semi-Auto Rifle
        --            SingleShotRifle[_2.._5] -> Single-Shot Rifle
        --            SniperRifle_Default -> Sniper Rifle
        --            Musket[_2.._5] -> Musket
        -- ================================================================================
        ["LaserRifle"]                  = { Attack = 1250,  Mag = 30, Dur = 3000, Wgt = 18.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserRifle_2"]                = { Attack = 1437,  Mag = 30, Dur = 4500, Wgt = 18.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserRifle_3"]                = { Attack = 1562,  Mag = 30, Dur = 6000, Wgt = 18.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserRifle_4"]                = { Attack = 1687,  Mag = 30, Dur = 9000, Wgt = 18.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserRifle_5"]                = { Attack = 1875,  Mag = 30, Dur = 12000,Wgt = 18.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["ChargeLaserRifle"]            = { Attack = 12500, Mag = 6,  Dur = 200,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["ChargeLaserRifle_2"]          = { Attack = 13125, Mag = 7,  Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["ChargeLaserRifle_3"]          = { Attack = 13750, Mag = 8,  Dur = 400,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["ChargeLaserRifle_4"]          = { Attack = 14375, Mag = 9,  Dur = 600,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["ChargeLaserRifle_5"]          = { Attack = 15000, Mag = 10, Dur = 800,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OverHeatRifle"]               = { Attack = 1225,  Mag = 0,  Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OverHeatRifle_2"]             = { Attack = 1286,  Mag = 0,  Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OverHeatRifle_3"]             = { Attack = 1347,  Mag = 0,  Dur = 4000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OverHeatRifle_4"]             = { Attack = 1408,  Mag = 0,  Dur = 5000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OverHeatRifle_5"]             = { Attack = 1470,  Mag = 0,  Dur = 6000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoRifle"]               = { Attack = 1150,  Mag = 8,  Dur = 1000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoRifle_2"]             = { Attack = 1265,  Mag = 9,  Dur = 1500, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoRifle_3"]             = { Attack = 1380,  Mag = 10, Dur = 2000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoRifle_4"]             = { Attack = 1495,  Mag = 11, Dur = 3000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoRifle_5"]             = { Attack = 1610,  Mag = 12, Dur = 4000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SingleShotRifle"]             = { Attack = 1100,  Mag = 1,  Dur = 1000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SingleShotRifle_2"]           = { Attack = 1650,  Mag = 1,  Dur = 2000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SingleShotRifle_3"]           = { Attack = 1870,  Mag = 1,  Dur = 2500, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SingleShotRifle_4"]           = { Attack = 2090,  Mag = 1,  Dur = 3000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SingleShotRifle_5"]           = { Attack = 2310,  Mag = 1,  Dur = 4000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SniperRifle_Default"]         = { Attack = 1000,  Mag = 4,  Dur = 500,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Musket"]                      = { Attack = 1000,  Mag = 1,  Dur = 200,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Musket_2"]                    = { Attack = 1400,  Mag = 1,  Dur = 400,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Musket_3"]                    = { Attack = 1600,  Mag = 1,  Dur = 500,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Musket_4"]                    = { Attack = 1800,  Mag = 1,  Dur = 600,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Musket_5"]                    = { Attack = 2000,  Mag = 1,  Dur = 800,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- SHOTGUNS
        -- Name map: PumpActionShotgun[_2.._5] -> Pump-Action Shotgun
        --            DoubleBarrelShotgun[_2.._5] -> Double-Barreled Shotgun
        --            SemiAutoShotgun[_2.._5] -> Semi-Auto Shotgun
        --            SkyShotgun[_2.._5] -> Prototype Shotgun
        --            EnergyShotgun[_2.._5] -> Energy Shotgun
        --            WidePenetrateShotgun[_2.._5] -> Beam Scatter
        --            OctaviaShotgun[_2.._5] -> Core Eject Shotgun
        --            MakeshiftShotgun[_2.._5] -> Makeshift Shotgun
        -- ================================================================================
        ["PumpActionShotgun"]           = { Attack = 220,   Mag = 8,  Dur = 150,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["PumpActionShotgun_2"]         = { Attack = 275,   Mag = 9,  Dur = 500,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["PumpActionShotgun_3"]         = { Attack = 308,   Mag = 10, Dur = 600,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["PumpActionShotgun_4"]         = { Attack = 352,   Mag = 11, Dur = 700,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["PumpActionShotgun_5"]         = { Attack = 385,   Mag = 12, Dur = 800,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["DoubleBarrelShotgun"]         = { Attack = 190,   Mag = 2,  Dur = 200,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["DoubleBarrelShotgun_2"]       = { Attack = 285,   Mag = 2,  Dur = 400,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["DoubleBarrelShotgun_3"]       = { Attack = 323,   Mag = 2,  Dur = 500,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["DoubleBarrelShotgun_4"]       = { Attack = 361,   Mag = 2,  Dur = 600,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["DoubleBarrelShotgun_5"]       = { Attack = 399,   Mag = 2,  Dur = 800,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoShotgun"]             = { Attack = 195,   Mag = 10, Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoShotgun_2"]           = { Attack = 214,   Mag = 11, Dur = 450,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoShotgun_3"]           = { Attack = 234,   Mag = 12, Dur = 600,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoShotgun_4"]           = { Attack = 253,   Mag = 13, Dur = 900,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SemiAutoShotgun_5"]           = { Attack = 282,   Mag = 14, Dur = 1200, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyShotgun"]                  = { Attack = 1167,  Mag = 12, Dur = 6000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyShotgun_2"]                = { Attack = 1225,  Mag = 14, Dur = 9000, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyShotgun_3"]                = { Attack = 1283,  Mag = 16, Dur = 12000,Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyShotgun_4"]                = { Attack = 1342,  Mag = 18, Dur = 18000,Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyShotgun_5"]                = { Attack = 1400,  Mag = 20, Dur = 24000,Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyShotgun"]               = { Attack = 402,   Mag = 10, Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyShotgun_2"]             = { Attack = 422,   Mag = 11, Dur = 450,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyShotgun_3"]             = { Attack = 442,   Mag = 12, Dur = 600,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyShotgun_4"]             = { Attack = 462,   Mag = 13, Dur = 900,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyShotgun_5"]             = { Attack = 482,   Mag = 14, Dur = 1200, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["WidePenetrateShotgun"]        = { Attack = 508,   Mag = 30, Dur = 950,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["WidePenetrateShotgun_2"]      = { Attack = 533,   Mag = 32, Dur = 1425, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["WidePenetrateShotgun_3"]      = { Attack = 558,   Mag = 34, Dur = 1900, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["WidePenetrateShotgun_4"]      = { Attack = 584,   Mag = 36, Dur = 2850, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["WidePenetrateShotgun_5"]      = { Attack = 609,   Mag = 38, Dur = 3800, Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaShotgun"]              = { Attack = 230,   Mag = 0,  Dur = 150,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaShotgun_2"]            = { Attack = 402,   Mag = 0,  Dur = 225,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaShotgun_3"]            = { Attack = 460,   Mag = 0,  Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaShotgun_4"]            = { Attack = 517,   Mag = 0,  Dur = 450,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaShotgun_5"]            = { Attack = 575,   Mag = 0,  Dur = 600,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftShotgun"]            = { Attack = 215,   Mag = 1,  Dur = 200,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftShotgun_2"]          = { Attack = 258,   Mag = 1,  Dur = 300,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftShotgun_3"]          = { Attack = 290,   Mag = 1,  Dur = 400,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftShotgun_4"]          = { Attack = 322,   Mag = 1,  Dur = 600,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftShotgun_5"]          = { Attack = 376,   Mag = 1,  Dur = 800,  Wgt = 24.0, Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- HEAVY WEAPONS, MINIGUNS & FLAMETHROWERS
        -- Name map: GatlingGun[_2.._5] -> Gatling Gun
        --            LaserGatlingGun[_2.._5] -> Laser Gatling Gun
        --            FlameThrower[_2.._5] -> Flamethrower
        -- ================================================================================
        ["GatlingGun"]                  = { Attack = 375,   Mag = 100,Dur = 6000, Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GatlingGun_2"]                = { Attack = 431,   Mag = 100,Dur = 9000, Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GatlingGun_3"]                = { Attack = 468,   Mag = 100,Dur = 12000,Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GatlingGun_4"]                = { Attack = 506,   Mag = 100,Dur = 18000,Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GatlingGun_5"]                = { Attack = 562,   Mag = 100,Dur = 24000,Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserGatlingGun"]             = { Attack = 530,   Mag = 100,Dur = 8000, Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserGatlingGun_2"]           = { Attack = 583,   Mag = 100,Dur = 12000,Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserGatlingGun_3"]           = { Attack = 609,   Mag = 100,Dur = 16000,Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserGatlingGun_4"]           = { Attack = 636,   Mag = 100,Dur = 24000,Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserGatlingGun_5"]           = { Attack = 689,   Mag = 100,Dur = 32000,Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FlameThrower"]                = { Attack = 636,   Mag = 100,Dur = 6000, Wgt = 45.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FlameThrower_2"]              = { Attack = 731,   Mag = 100,Dur = 9000, Wgt = 45.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FlameThrower_3"]              = { Attack = 795,   Mag = 100,Dur = 12000,Wgt = 45.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FlameThrower_4"]              = { Attack = 858,   Mag = 100,Dur = 18000,Wgt = 45.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FlameThrower_5"]              = { Attack = 954,   Mag = 100,Dur = 24000,Wgt = 45.0, Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- ROCKET, MISSILE, GRENADE & BEAM LAUNCHERS
        -- Name map: Launcher_Default[_2.._5] -> Rocket Launcher
        --            EnergyRocketLauncher[_2.._5] -> Plasma Cannon
        --            Launcher_Meteor / Launcher_Meteor_5 -> Meteor Launcher
        --            Launcher_Meat -> Launcher Meat (special entry)
        --            GuidedMissileLauncher[_2.._5] -> Guided Missile Launcher
        --            MultiGuidedMissileLauncher[_2.._5] -> Multi Guided Missile Launcher
        --            GrenadeLauncher[_2.._5] -> Grenade Launcher
        --            SkyGrenadeLauncher[_2.._5] -> Tactical Grenade Launcher
        --            BeamLauncher[_2.._5] -> Beam Launcher
        --            DroneLauncher[_2.._5] -> Drone Launcher
        --            PenguinLauncher -> Penguin Launcher
        --            SphereLauncher -> Scatter Sphere Launcher
        --            SphereLauncher_Once -> Single-Shot Sphere Launcher
        --            HomingSphereLauncher -> Homing Sphere Launcher
        -- ================================================================================
        ["Launcher_Default"]            = { Attack = 10000, Mag = 1,  Dur = 300,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Launcher_Default_2"]          = { Attack = 11000, Mag = 1,  Dur = 800,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Launcher_Default_3"]          = { Attack = 12000, Mag = 1,  Dur = 1000, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Launcher_Default_4"]          = { Attack = 13000, Mag = 1,  Dur = 1200, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Launcher_Default_5"]          = { Attack = 14000, Mag = 1,  Dur = 1400, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyRocketLauncher"]        = { Attack = 10000, Mag = 2,  Dur = 300,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyRocketLauncher_2"]      = { Attack = 11000, Mag = 2,  Dur = 450,  Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyRocketLauncher_3"]      = { Attack = 11500, Mag = 2,  Dur = 600,  Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyRocketLauncher_4"]      = { Attack = 12000, Mag = 2,  Dur = 900,  Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["EnergyRocketLauncher_5"]      = { Attack = 13000, Mag = 2,  Dur = 1200, Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Launcher_Meteor"]             = { Attack = 2000,  Mag = 1,  Dur = 300,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Launcher_Meteor_5"]           = { Attack = 10500, Mag = 1,  Dur = 450,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Launcher_Meat"]               = { Attack = 20,    Mag = 1,  Dur = 300,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GuidedMissileLauncher"]       = { Attack = 5900,  Mag = 1,  Dur = 300,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GuidedMissileLauncher_2"]     = { Attack = 6785,  Mag = 1,  Dur = 450,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GuidedMissileLauncher_3"]     = { Attack = 7375,  Mag = 1,  Dur = 600,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GuidedMissileLauncher_4"]     = { Attack = 7965,  Mag = 1,  Dur = 900,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GuidedMissileLauncher_5"]     = { Attack = 8850,  Mag = 1,  Dur = 1200, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MultiGuidedMissileLauncher"]  = { Attack = 5900,  Mag = 4,  Dur = 300,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MultiGuidedMissileLauncher_2"]= { Attack = 6785,  Mag = 4,  Dur = 450,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MultiGuidedMissileLauncher_3"]= { Attack = 7375,  Mag = 4,  Dur = 600,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MultiGuidedMissileLauncher_4"]= { Attack = 7965,  Mag = 4,  Dur = 900,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MultiGuidedMissileLauncher_5"]= { Attack = 8850,  Mag = 4,  Dur = 1200, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrenadeLauncher"]             = { Attack = 3000,  Mag = 5,  Dur = 600,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrenadeLauncher_2"]           = { Attack = 3450,  Mag = 5,  Dur = 900,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrenadeLauncher_3"]           = { Attack = 3750,  Mag = 5,  Dur = 1200, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrenadeLauncher_4"]           = { Attack = 4050,  Mag = 5,  Dur = 1800, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrenadeLauncher_5"]           = { Attack = 4500,  Mag = 5,  Dur = 2400, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyGrenadeLauncher"]          = { Attack = 6722,  Mag = 8,  Dur = 800,  Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyGrenadeLauncher_2"]        = { Attack = 7058,  Mag = 10, Dur = 1200, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyGrenadeLauncher_3"]        = { Attack = 7394,  Mag = 10, Dur = 1600, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyGrenadeLauncher_4"]        = { Attack = 7730,  Mag = 12, Dur = 2400, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyGrenadeLauncher_5"]        = { Attack = 8066,  Mag = 12, Dur = 3200, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamLauncher"]                = { Attack = 14000, Mag = 0,  Dur = 3500, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamLauncher_2"]              = { Attack = 14700, Mag = 0,  Dur = 5250, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamLauncher_3"]              = { Attack = 15400, Mag = 0,  Dur = 7000, Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamLauncher_4"]              = { Attack = 16100, Mag = 0,  Dur = 10500,Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamLauncher_5"]              = { Attack = 16800, Mag = 0,  Dur = 14000,Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["DroneLauncher"]               = { Attack = 200,   Mag = 0,  Dur = 6500, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DroneLauncher_2"]             = { Attack = 210,   Mag = 0,  Dur = 9750, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DroneLauncher_3"]             = { Attack = 220,   Mag = 0,  Dur = 13000,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DroneLauncher_4"]             = { Attack = 230,   Mag = 0,  Dur = 19500,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DroneLauncher_5"]             = { Attack = 240,   Mag = 0,  Dur = 26000,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["PenguinLauncher"]             = { Attack = 10000, Mag = 1,  Dur = 0,    Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SphereLauncher"]              = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SphereLauncher_Once"]         = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["HomingSphereLauncher"]        = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 30.0, Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- PISTOLS, REVOLVERS & SHIELDS
        -- Name map: HandGun_Default[_2.._5] -> Handgun
        --            MakeshiftHandgun[_2.._5] -> Makeshift Handgun
        --            OldRevolver[_2.._5] -> Old Revolver
        --            OctaviaRevolver[_2.._5] -> Marksman Revolver
        --            HandgunShield -> Handgun Shield
        --            PalDopingShot -> Boost Gun
        --            PalDopingShot_2 -> Megaboost Gun
        --            PalDopingShot_3 -> Boost Gun variant
        --            DecalGun_1-5 -> Decal Gun 1-5
        -- ================================================================================
        ["HandGun_Default"]             = { Attack = 250,   Mag = 8,  Dur = 400,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["HandGun_Default_2"]           = { Attack = 437,   Mag = 10, Dur = 1200, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["HandGun_Default_3"]           = { Attack = 500,   Mag = 12, Dur = 1600, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["HandGun_Default_4"]           = { Attack = 562,   Mag = 14, Dur = 2000, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["HandGun_Default_5"]           = { Attack = 625,   Mag = 16, Dur = 2400, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftHandgun"]            = { Attack = 320,   Mag = 6,  Dur = 300,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftHandgun_2"]          = { Attack = 560,   Mag = 6,  Dur = 600,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftHandgun_3"]          = { Attack = 640,   Mag = 6,  Dur = 900,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftHandgun_4"]          = { Attack = 720,   Mag = 6,  Dur = 1200, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["MakeshiftHandgun_5"]          = { Attack = 800,   Mag = 6,  Dur = 1500, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["OldRevolver"]                 = { Attack = 600,   Mag = 6,  Dur = 400,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OldRevolver_2"]               = { Attack = 1050,  Mag = 6,  Dur = 600,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OldRevolver_3"]               = { Attack = 1200,  Mag = 6,  Dur = 800,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OldRevolver_4"]               = { Attack = 1350,  Mag = 6,  Dur = 1200, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OldRevolver_5"]               = { Attack = 1500,  Mag = 6,  Dur = 1600, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaRevolver"]             = { Attack = 250,   Mag = 0,  Dur = 400,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaRevolver_2"]           = { Attack = 437,   Mag = 0,  Dur = 1200, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaRevolver_3"]           = { Attack = 500,   Mag = 0,  Dur = 1600, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaRevolver_4"]           = { Attack = 562,   Mag = 0,  Dur = 2000, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["OctaviaRevolver_5"]           = { Attack = 625,   Mag = 0,  Dur = 2400, Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["HandgunShield"]               = { Attack = 250,   Mag = 20, Dur = 400,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["PalDopingShot"]               = { Attack = 250,   Mag = 8,  Dur = 400,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["PalDopingShot_2"]             = { Attack = 250,   Mag = 8,  Dur = 400,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["PalDopingShot_3"]             = { Attack = 250,   Mag = 8,  Dur = 400,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DecalGun_1"]                  = { Attack = 0,     Mag = 99, Dur = 0,    Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DecalGun_2"]                  = { Attack = 0,     Mag = 99, Dur = 0,    Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DecalGun_3"]                  = { Attack = 0,     Mag = 99, Dur = 0,    Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DecalGun_4"]                  = { Attack = 0,     Mag = 99, Dur = 0,    Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["DecalGun_5"]                  = { Attack = 0,     Mag = 99, Dur = 0,    Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- BOWS & CROSSBOWS
        -- Name map: WeakerBow[_2.._5] -> Old Bow
        --            CompoundBow[_2.._5] -> Compound Bow
        --            SFBow[_2.._5] -> Advanced Bow
        --            SkyBow[_2.._5] -> Mechanical Bow
        --            Bow_Poison -> Poison Bow
        --            Bow_Fire -> Fire Bow
        --            Bow_triple -> Three Shot Bow
        --            Bow_Fifth -> Five Shot Bow
        --            RecurveBow -> Recurve Bow
        --            BowGun[_2.._5] -> Crossbow
        --            BowGun_Poison[_2.._5] -> Poison Arrow Crossbow
        --            BowGun_Fire[_2.._5] -> Fire Arrow Crossbow
        -- ================================================================================
        ["WeakerBow"]                   = { Attack = 65,    Mag = 1,  Dur = 150,  Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["WeakerBow_2"]                 = { Attack = 130,   Mag = 1,  Dur = 400,  Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["WeakerBow_3"]                 = { Attack = 169,   Mag = 1,  Dur = 500,  Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["WeakerBow_4"]                 = { Attack = 208,   Mag = 1,  Dur = 600,  Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["WeakerBow_5"]                 = { Attack = 247,   Mag = 1,  Dur = 700,  Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["CompoundBow"]                 = { Attack = 1100,  Mag = 1,  Dur = 400,  Wgt = 17.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["CompoundBow_2"]               = { Attack = 1265,  Mag = 1,  Dur = 600,  Wgt = 17.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["CompoundBow_3"]               = { Attack = 1375,  Mag = 1,  Dur = 800,  Wgt = 17.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["CompoundBow_4"]               = { Attack = 1485,  Mag = 1,  Dur = 1200, Wgt = 17.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["CompoundBow_5"]               = { Attack = 1650,  Mag = 1,  Dur = 1600, Wgt = 17.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SFBow"]                       = { Attack = 5800,  Mag = 1,  Dur = 500,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SFBow_2"]                     = { Attack = 6670,  Mag = 1,  Dur = 750,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SFBow_3"]                     = { Attack = 7250,  Mag = 1,  Dur = 1000, Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SFBow_4"]                     = { Attack = 7830,  Mag = 1,  Dur = 1500, Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SFBow_5"]                     = { Attack = 8700,  Mag = 1,  Dur = 2000, Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBow"]                      = { Attack = 20000, Mag = 1,  Dur = 2000, Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBow_2"]                    = { Attack = 21000, Mag = 1,  Dur = 3000, Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBow_3"]                    = { Attack = 22000, Mag = 1,  Dur = 4000, Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBow_4"]                    = { Attack = 23000, Mag = 1,  Dur = 6000, Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBow_5"]                    = { Attack = 24000, Mag = 1,  Dur = 8000, Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bow_Poison"]                  = { Attack = 65,    Mag = 1,  Dur = 150,  Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bow_Fire"]                    = { Attack = 65,    Mag = 1,  Dur = 150,  Wgt = 6.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bow_triple"]                  = { Attack = 40,    Mag = 1,  Dur = 250,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bow_Fifth"]                   = { Attack = 30,    Mag = 1,  Dur = 350,  Wgt = 8.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["RecurveBow"]                  = { Attack = 40,    Mag = 1,  Dur = 200,  Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun"]                      = { Attack = 280,   Mag = 1,  Dur = 300,  Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_2"]                    = { Attack = 364,   Mag = 1,  Dur = 800,  Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_3"]                    = { Attack = 406,   Mag = 1,  Dur = 1000, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_4"]                    = { Attack = 448,   Mag = 1,  Dur = 1200, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_5"]                    = { Attack = 490,   Mag = 1,  Dur = 1400, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Poison"]               = { Attack = 280,   Mag = 1,  Dur = 300,  Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Poison_2"]             = { Attack = 364,   Mag = 1,  Dur = 800,  Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Poison_3"]             = { Attack = 406,   Mag = 1,  Dur = 1000, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Poison_4"]             = { Attack = 448,   Mag = 1,  Dur = 1200, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Poison_5"]             = { Attack = 490,   Mag = 1,  Dur = 1400, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Fire"]                 = { Attack = 280,   Mag = 1,  Dur = 300,  Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Fire_2"]               = { Attack = 364,   Mag = 1,  Dur = 800,  Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Fire_3"]               = { Attack = 406,   Mag = 1,  Dur = 1000, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Fire_4"]               = { Attack = 448,   Mag = 1,  Dur = 1200, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BowGun_Fire_5"]               = { Attack = 490,   Mag = 1,  Dur = 1400, Wgt = 13.0, Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- MELEE WEAPONS, KATANAS, BEAM SWORDS, SPEARS & YAKUSHIMA BLADES
        -- Name map: Katana[_2.._5] -> Katana
        --            Sword[_2.._5] -> Sword
        --            BronzeSword -> Primitive Sword
        --            BeamSword[_2.._5] -> Beam Sword
        --            SkyBeamSword[_2.._5] -> Laser Sword
        --            YakushimaBlade -> Meowmere
        --            YakushimaBlade002[_2.._5] -> Terra Blade
        --            YakushimaBlade003[_2.._5] -> Terraprisma
        --            YakushimaBlade004[_2.._5] -> Excalibur
        --            YakushimaBlade005 -> Legendary Meowmere
        --            YakushimaGun001[_2.._5] -> Vortex Beater
        --            YakushimaLantern001[_2.._5] -> Nightglow
        --            Spear -> Stone Spear; Spear_2 -> Metal Spear; Spear_3 -> Refined Metal Spear
        --            Spear_Lily / Spear_ForestBoss -> Lily's Spear
        --            Spear_ForestBoss_5 -> Lily's Spear (Legendary)
        --            Spear_ForestBoss2 / Spear_ForestBoss2_5 -> Enhanced Lily's Spear
        --            Spear_QueenBee -> Elizabee's Staff
        --            Spear_SoldierBee -> Beegarde's Spear
        --            ElecBaton -> Stun Baton
        --            Bat -> Wooden Club; Bat2 -> Bat; Bat3[_2.._5] -> Metal Bat
        --            MeatCutterKnife -> Meat Cleaver; Torch -> Hand-Held Torch
        -- ================================================================================
        ["Katana"]                      = { Attack = 780,   Mag = 0,  Dur = 500,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Katana_2"]                    = { Attack = 858,   Mag = 0,  Dur = 750,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Katana_3"]                    = { Attack = 936,   Mag = 0,  Dur = 1000, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Katana_4"]                    = { Attack = 1014,  Mag = 0,  Dur = 1500, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Katana_5"]                    = { Attack = 1170,  Mag = 0,  Dur = 2000, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Sword"]                       = { Attack = 360,   Mag = 0,  Dur = 500,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Sword_2"]                     = { Attack = 396,   Mag = 0,  Dur = 750,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Sword_3"]                     = { Attack = 432,   Mag = 0,  Dur = 1000, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Sword_4"]                     = { Attack = 468,   Mag = 0,  Dur = 1500, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Sword_5"]                     = { Attack = 540,   Mag = 0,  Dur = 2000, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BronzeSword"]                 = { Attack = 180,   Mag = 0,  Dur = 500,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamSword"]                   = { Attack = 930,   Mag = 0,  Dur = 500,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamSword_2"]                 = { Attack = 1023,  Mag = 0,  Dur = 750,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamSword_3"]                 = { Attack = 1116,  Mag = 0,  Dur = 1000, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamSword_4"]                 = { Attack = 1209,  Mag = 0,  Dur = 1500, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["BeamSword_5"]                 = { Attack = 1395,  Mag = 0,  Dur = 2000, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBeamSword"]                = { Attack = 2000,  Mag = 0,  Dur = 1200, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBeamSword_2"]              = { Attack = 2100,  Mag = 0,  Dur = 1800, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBeamSword_3"]              = { Attack = 2200,  Mag = 0,  Dur = 2400, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBeamSword_4"]              = { Attack = 2300,  Mag = 0,  Dur = 3600, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["SkyBeamSword_5"]              = { Attack = 2400,  Mag = 0,  Dur = 4800, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade"]              = { Attack = 200,   Mag = 0,  Dur = 2222, Wgt = 22.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade002"]           = { Attack = 425,   Mag = 0,  Dur = 757,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade002_2"]         = { Attack = 467,   Mag = 0,  Dur = 1135, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade002_3"]         = { Attack = 510,   Mag = 0,  Dur = 1514, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade002_4"]         = { Attack = 552,   Mag = 0,  Dur = 2271, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade002_5"]         = { Attack = 637,   Mag = 0,  Dur = 3028, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade003"]           = { Attack = 90,    Mag = 0,  Dur = 5000, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade003_2"]         = { Attack = 100,   Mag = 0,  Dur = 6000, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade003_3"]         = { Attack = 110,   Mag = 0,  Dur = 7200, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade003_4"]         = { Attack = 125,   Mag = 0,  Dur = 8640, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade003_5"]         = { Attack = 150,   Mag = 0,  Dur = 10368,Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade004"]           = { Attack = 360,   Mag = 0,  Dur = 600,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade004_2"]         = { Attack = 396,   Mag = 0,  Dur = 900,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade004_3"]         = { Attack = 432,   Mag = 0,  Dur = 1200, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade004_4"]         = { Attack = 468,   Mag = 0,  Dur = 1800, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade004_5"]         = { Attack = 540,   Mag = 0,  Dur = 2400, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaBlade005"]           = { Attack = 222,   Mag = 0,  Dur = 22222,Wgt = 22.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaGun001"]             = { Attack = 300,   Mag = 0,  Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaGun001_2"]           = { Attack = 330,   Mag = 0,  Dur = 3000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaGun001_3"]           = { Attack = 360,   Mag = 0,  Dur = 4000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaGun001_4"]           = { Attack = 390,   Mag = 0,  Dur = 5000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaGun001_5"]           = { Attack = 450,   Mag = 0,  Dur = 6000, Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaLantern001"]         = { Attack = 50,    Mag = 0,  Dur = 3000, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaLantern001_2"]       = { Attack = 60,    Mag = 0,  Dur = 3000, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaLantern001_3"]       = { Attack = 70,    Mag = 0,  Dur = 4000, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaLantern001_4"]       = { Attack = 80,    Mag = 0,  Dur = 5000, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["YakushimaLantern001_5"]       = { Attack = 100,   Mag = 0,  Dur = 6000, Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear"]                       = { Attack = 35,    Mag = 0,  Dur = 200,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_2"]                     = { Attack = 80,    Mag = 0,  Dur = 250,  Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_3"]                     = { Attack = 310,   Mag = 0,  Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_Lily"]                  = { Attack = 860,   Mag = 0,  Dur = 500,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_ForestBoss"]            = { Attack = 860,   Mag = 0,  Dur = 500,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_ForestBoss_5"]          = { Attack = 1075,  Mag = 0,  Dur = 2000, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_ForestBoss2"]           = { Attack = 1200,  Mag = 0,  Dur = 600,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_ForestBoss2_5"]         = { Attack = 1500,  Mag = 0,  Dur = 2400, Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_QueenBee"]              = { Attack = 150,   Mag = 0,  Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Spear_SoldierBee"]            = { Attack = 150,   Mag = 0,  Dur = 400,  Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["ElecBaton"]                   = { Attack = 10,    Mag = 0,  Dur = 300,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bat"]                         = { Attack = 25,    Mag = 0,  Dur = 150,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bat2"]                        = { Attack = 50,    Mag = 0,  Dur = 150,  Wgt = 3.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bat3"]                        = { Attack = 500,   Mag = 0,  Dur = 500,  Wgt = 3.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bat3_2"]                      = { Attack = 550,   Mag = 0,  Dur = 750,  Wgt = 3.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bat3_3"]                      = { Attack = 600,   Mag = 0,  Dur = 1000, Wgt = 3.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bat3_4"]                      = { Attack = 650,   Mag = 0,  Dur = 1500, Wgt = 3.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["Bat3_5"]                      = { Attack = 750,   Mag = 0,  Dur = 2000, Wgt = 3.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["MeatCutterKnife"]             = { Attack = 25,    Mag = 0,  Dur = 300,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Torch"]                       = { Attack = 10,    Mag = 0,  Dur = 100,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- ALL 10+ GRENADE TYPES & THROWABLES
        -- Name map: FragGrenade -> Frag Grenade
        --            FragGrenade_Fire -> Incendiary Grenade
        --            FragGrenade_Elec -> Shock Grenade
        --            FragGrenade_Ice -> Ice Grenade
        --            FragGrenade_Dark -> Dark Grenade
        --            FragGrenade_Dragon -> Dragon Grenade
        --            FragGrenade_Ground -> Ground Grenade
        --            FragGrenade_Leaf -> Grass Grenade
        --            FragGrenade_Water -> Water Grenade
        --            FragGrenade_Super -> Frag Grenade Mk2
        --            PalHealingGrenade -> Pal Recovery Grenade
        --            ThrowStone -> Throw Stone
        -- ================================================================================
        ["FragGrenade"]                 = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Fire"]            = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Elec"]            = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Ice"]             = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Dark"]            = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Dragon"]          = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Ground"]          = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Leaf"]            = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Water"]           = { Attack = 750,   Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FragGrenade_Super"]           = { Attack = 4000,  Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["PalHealingGrenade"]           = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["ThrowStone"]                  = { Attack = 50,    Mag = 0,  Dur = 0,    Wgt = 0.1,  Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- HARVESTING TOOLS, MINING & GRAPPLING GUNS
        -- Name map: Axe_Tier_00 -> Stone Axe
        --            Axe_Tier_01 -> Metal Axe
        --            Axe_Tier_02 -> Refined Metal Axe
        --            Axe_Tier_03 -> Pal Metal Axe
        --            Axe_Steal -> Metal Axe variant
        --            Pickaxe_Tier_00 -> Stone Pickaxe
        --            Pickaxe_Tier_01 -> Metal Pickaxe
        --            Pickaxe_Tier_02 -> Refined Metal Pickaxe
        --            Pickaxe_Tier_03 -> Pal Metal Pickaxe
        --            Pickaxe_Steal -> Metal Pickaxe variant
        --            LaserMiningTool -> Plasma Multicutter
        --            GrapplingGun -> Grappling Gun
        --            GrapplingGun2 -> Mega Grappling Gun
        --            GrapplingGun3 -> Giga Grappling Gun
        --            GrapplingGun4 -> Hyper Grappling Gun
        --            GrapplingGun5 -> Ultra Grappling Gun
        --            AirGrapplingGun -> Air Grappling Gun
        --            CaptureRope -> Capture Rope
        --            MetalDetector -> Metal Detector
        --            Axe_Tier_03 -> Pal Metal Axe | Axe_Steal -> Pal Metal Axe
        --            Pickaxe_Tier_00 -> Stone Pickaxe | Pickaxe_Tier_01 -> Metal Pickaxe
        --            Pickaxe_Tier_02 -> Refined Metal Pickaxe | Pickaxe_Tier_03 / Pickaxe_Steal -> Pal Metal Pickaxe
        --            LaserMiningTool -> Plasma Multicutter | GrapplingGun -> Grappling Gun
        --            GrapplingGun2 -> Mega Grappling Gun | GrapplingGun3 -> Giga Grappling Gun
        --            GrapplingGun4 -> Hyper Grappling Gun | GrapplingGun5 -> Ultra Grappling Gun
        --            AirGrapplingGun -> Air Grappling Gun | CaptureRope -> Capture Rope | MetalDetector -> Metal Detector
        -- ================================================================================
        ["Axe_Tier_00"]                 = { Attack = 20,    Mag = 0,  Dur = 150,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Axe_Tier_01"]                 = { Attack = 30,    Mag = 0,  Dur = 250,  Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Axe_Tier_02"]                 = { Attack = 60,    Mag = 0,  Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Axe_Tier_03"]                 = { Attack = 75,    Mag = 0,  Dur = 400,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Axe_Steal"]                   = { Attack = 120,   Mag = 0,  Dur = 400,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Pickaxe_Tier_00"]             = { Attack = 20,    Mag = 0,  Dur = 150,  Wgt = 10.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Pickaxe_Tier_01"]             = { Attack = 30,    Mag = 0,  Dur = 250,  Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Pickaxe_Tier_02"]             = { Attack = 60,    Mag = 0,  Dur = 300,  Wgt = 20.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Pickaxe_Tier_03"]             = { Attack = 75,    Mag = 0,  Dur = 400,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["Pickaxe_Steal"]               = { Attack = 120,   Mag = 0,  Dur = 400,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["LaserMiningTool"]             = { Attack = 250,   Mag = 0,  Dur = 850,  Wgt = 50.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrapplingGun"]                = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 1.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrapplingGun2"]               = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 1.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrapplingGun3"]               = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 1.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrapplingGun4"]               = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 1.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["GrapplingGun5"]               = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 1.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["AirGrapplingGun"]             = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 1.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["CaptureRope"]                 = { Attack = 1000,  Mag = 4,  Dur = 200,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["MetalDetector"]               = { Attack = 0,     Mag = 0,  Dur = 400,  Wgt = 25.0, Snk = 1.0, FireRate = nil, Reload = nil },

        -- ================================================================================
        -- FISHING RODS
        -- Name map: FishingRod_01_1 -> Beginner Fishing Rod (Chillet)
        --            FishingRod_01_2 -> Beginner Fishing Rod (Gumoss)
        --            FishingRod_02_1 -> Intermediate Fishing Rod (Cattiva)
        --            FishingRod_02_2 -> Intermediate Fishing Rod (Croajiro)
        --            FishingRod_03_1 -> Advanced Fishing Rod (Depresso)
        --            FishingRod_03_2 -> Advanced Fishing Rod (Pengullet)
        --            FishingRod_Test -> Fishing Rod Test
        --            FishingRod_Good -> Fishing Rod Good
        --            FishingRod_Old -> Fishing Rod Old
        --            FishingRod_Super -> Fishing Rod Super
        --            FishingRod_Legendary -> Fishing Rod Legendary
        --            FishingRod_02_1 -> Intermediate Fishing Rod (Cattiva) | FishingRod_02_2 -> Intermediate Fishing Rod (Croajiro)
        --            FishingRod_03_1 -> Advanced Fishing Rod (Pengullet) | FishingRod_03_2 -> Advanced Fishing Rod (Depresso)
        --            FishingRod_Test -> Fishing Rod (Test) | FishingRod_Good -> Fishing Rod_Good
        --            FishingRod_Old -> Fishing Rod_Old | FishingRod_Super -> Fishing Rod_Super | FishingRod_Legendary -> Fishing Rod_Legendary
        -- ================================================================================
        ["FishingRod_01_1"]             = { Attack = 25,    Mag = 0,  Dur = 120,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_01_2"]             = { Attack = 25,    Mag = 0,  Dur = 180,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_02_1"]             = { Attack = 25,    Mag = 0,  Dur = 240,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_02_2"]             = { Attack = 25,    Mag = 0,  Dur = 360,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_03_1"]             = { Attack = 25,    Mag = 0,  Dur = 480,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_03_2"]             = { Attack = 25,    Mag = 0,  Dur = 720,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_Test"]             = { Attack = 25,    Mag = 0,  Dur = 150,  Wgt = 5.0,  Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_Good"]             = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_Old"]              = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_Super"]            = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
        ["FishingRod_Legendary"]        = { Attack = 0,     Mag = 0,  Dur = 0,    Wgt = 15.0, Snk = 1.0, FireRate = nil, Reload = nil },
    }
}

-- ========================================================================================
-- HELPER FUNCTIONS
-- ========================================================================================

local function Log(message)
    if Config.Global.DebugLogging then
        print(string.format("[WeaponStatsCustomizer] %s\n", tostring(message)))
    end
end

local function FindWeaponConfig(weaponId)
    if not weaponId then return nil end
    if Config.Weapons[weaponId] then
        return Config.Weapons[weaponId]
    end
    for key, cfg in pairs(Config.Weapons) do
        if string.find(weaponId, "^" .. key) then
            return cfg
        end
    end
    return nil
end


local FIRE_PROP_KEYS = {
    "shotinterval", "shootinterval", "firerate", "fireinterval",
    "attackinterval", "cooldowntime", "intervaltime", "intarvaltime"
}
local CHARGE_PROP_KEYS = { "incrementspeed" }
local HEAT_PROP_KEYS = { "heatdownspeed" }
local RELOAD_PROP_NAMES = { "ReloadSpeedPlayRate", "ReloadPlayRate" }

local HookedPaths = {}
local ClassDone = {}
local ClassInfo = {}
local PropRecords = {}

local function SafeCall(fn)
    local ok, res = pcall(fn)
    return ok and res or nil
end

local function IsValidObj(obj)
    return obj and SafeCall(function() return obj:IsValid() end) == true
end

local function StripTypePrefix(name)
    if type(name) ~= "string" then return nil end
    local sp = name:find(" ", 1, true)
    return sp and name:sub(sp + 1) or name
end

local function NearlyEqual(a, b)
    if a == b then return true end
    return math.abs(a - b) <= math.max(math.abs(a), math.abs(b), 1.0) * 1e-4
end

local function ClassifyProp(name)
    local n = name:lower()

    for _, key in ipairs(CHARGE_PROP_KEYS) do
        if n:find(key, 1, true) then return "charge" end
    end

    for _, key in ipairs(HEAT_PROP_KEYS) do
        if n:find(key, 1, true) then return "heat" end
    end

    for _, key in ipairs(FIRE_PROP_KEYS) do
        if n:find(key, 1, true) then return "fire" end
    end

    return nil
end

local function GetWeaponMultipliers(weapon)
    local fireRate = Config.Global.FireRateMultiplier or 1.0
    local reload = Config.Global.ReloadSpeedMultiplier or 1.0

    if IsValidObj(weapon) and IsValidObj(weapon.ownWeaponStaticData) then
        local weaponId = SafeCall(function()
            return weapon.ownWeaponStaticData.ID:ToString()
        end)

        local cfg = FindWeaponConfig(weaponId)

        if cfg then
            if type(cfg.FireRate) == "number" then
                fireRate = cfg.FireRate
            end

            if type(cfg.Reload) == "number" then
                reload = cfg.Reload
            end
        end
    end

    return fireRate, reload
end

local function SetReloadProps(weapon, rate)
    if not IsValidObj(weapon) then return end

    pcall(function()
        for _, name in ipairs(RELOAD_PROP_NAMES) do
            if type(SafeCall(function() return weapon[name] end)) == "number" then
                weapon[name] = rate
            end
        end
    end)
end

local function AccelerateMontage(weapon, rate)
    if not IsValidObj(weapon) then return end

    local function Apply()
        pcall(function()
            if not IsValidObj(weapon) then return end

            local owner = SafeCall(function() return weapon:GetOwner() end)
            if not IsValidObj(owner) then return end

            local mesh = SafeCall(function() return owner.Mesh end)
            if not IsValidObj(mesh) then return end

            local anim = SafeCall(function() return mesh:GetAnimInstance() end)
            if not IsValidObj(anim) then return end

            local montage = SafeCall(function()
                return anim:GetCurrentActiveMontage()
            end)

            if IsValidObj(montage) then
                anim:Montage_SetPlayRate(montage, rate)
            end
        end)
    end

    Apply()

    for _, delay in ipairs({ 20, 60, 150 }) do
        ExecuteWithDelay(delay, Apply)
    end
end

local function MakeCallback(kind)
    if kind == "interval" then
        return function(Context, Time)
            pcall(function()
                local weapon = Context and Context:get()
                local fireRateMult = GetWeaponMultipliers(weapon)

                local t = (Time and Time.get) and Time:get() or nil
                if type(t) == "number" and t > 0.0 and Time.set and fireRateMult > 0.0 then
                    Time:set(t / fireRateMult)
                end
            end)
        end

    elseif kind == "reload_start" then
        return function(Context, InReloadSpeedPlayRate)
            pcall(function()
                local weapon = Context and Context:get()
                local _, reloadMult = GetWeaponMultipliers(weapon)

                local r = (InReloadSpeedPlayRate and InReloadSpeedPlayRate.get and InReloadSpeedPlayRate:get()) or 1.0
                if type(r) ~= "number" or r <= 0.0 then
                    r = 1.0
                end

                local nr = r * reloadMult

                if InReloadSpeedPlayRate and InReloadSpeedPlayRate.set then
                    InReloadSpeedPlayRate:set(nr)
                end

                SetReloadProps(weapon, nr)
                AccelerateMontage(weapon, nr)
            end)
        end

    elseif kind == "reload_restart" or kind == "reload_anim" then
        return function(Context)
            pcall(function()
                local weapon = Context and Context:get()
                local _, reloadMult = GetWeaponMultipliers(weapon)

                SetReloadProps(weapon, reloadMult)
                AccelerateMontage(weapon, reloadMult)
            end)
        end
    end

    return function() end
end

local HOOKABLE_FUNCS = {
    ["GetShootInterval"] = "interval",
    ["OnReloadStart"] = "reload_start",
    ["OnRestartReload"] = "reload_restart",
    ["PlayReloadAnimation"] = "reload_anim",
}

local function RegisterClassHooks(classPath, funcs)
    if ClassDone[classPath] then return end
    ClassDone[classPath] = true

    ExecuteWithDelay(10, function()
        for _, f in ipairs(funcs) do
            if not HookedPaths[f.path] then
                local kind = HOOKABLE_FUNCS[f.name]
                if kind and pcall(RegisterHook, f.path, MakeCallback(kind)) then
                    HookedPaths[f.path] = true
                end
            end
        end
    end)
end

local function BuildClassInfo(weaponClass)
    local info = { funcs = {}, props = {}, ownHasGSI = false }
    local propSeen = {}
    local cur = weaponClass
    local depth = 0
    local first = true

    while IsValidObj(cur) and depth < 24 do
        local cname = SafeCall(function()
            return cur:GetFName():ToString()
        end)

        if type(cname) ~= "string" then
            break
        end

        local classPath = StripTypePrefix(SafeCall(function()
            return cur:GetFullName()
        end))

        if type(classPath) == "string" and classPath:sub(1, 6) == "/Game/" then
            pcall(function()
                cur:ForEachFunction(function(fn)
                    local fname = SafeCall(function()
                        return fn:GetFName():ToString()
                    end)

                    if type(fname) == "string" and HOOKABLE_FUNCS[fname] then
                        local fpath = StripTypePrefix(SafeCall(function()
                            return fn:GetFullName()
                        end))

                        if type(fpath) == "string" then
                            table.insert(info.funcs, { path = fpath, name = fname })

                            if fname == "GetShootInterval" and first then
                                info.ownHasGSI = true
                            end
                        end
                    end
                end)
            end)
        end

        pcall(function()
            cur:ForEachProperty(function(prop)
                local pname = SafeCall(function()
                    return prop:GetFName():ToString()
                end)

                if type(pname) == "string" and not propSeen[pname] then
                    local mode = ClassifyProp(pname)

                    if mode then
                        propSeen[pname] = true
                        table.insert(info.props, { name = pname, mode = mode })
                    end
                end
            end)
        end)

        if cname == "PalWeaponBase" then
            break
        end

        local sup = SafeCall(function()
            return cur:GetSuperStruct()
        end)

        cur = IsValidObj(sup) and sup or nil
        depth = depth + 1
        first = false
    end

    return info
end

local function ApplyProp(obj, classPath, prop)
    local v = SafeCall(function()
        return obj[prop.name]
    end)

    if type(v) ~= "number" or v <= 0.0001 or v > 100000.0 then
        return
    end

    local weaponKey = SafeCall(function()
        if IsValidObj(obj.ownWeaponStaticData) then
            return obj.ownWeaponStaticData.ID:ToString()
        end
        return obj:GetFullName()
    end)

    if type(weaponKey) ~= "string" or weaponKey == "" then
        weaponKey = classPath
    end

    local key = weaponKey .. "#" .. classPath .. "#" .. prop.name
    local rec = PropRecords[key]

    if not rec then
        local scaled = v

        if prop.mode == "fire" then
            local fireRateMult = GetWeaponMultipliers(obj)
            scaled = v / fireRateMult
        elseif prop.mode == "charge" then
            scaled = v * (Config.Global.ChargeMultiplier or 1.0)
        elseif prop.mode == "heat" then
            scaled = v * (Config.Global.HeatCoolMultiplier or 1.0)
        end

        rec = { orig = v, scaled = scaled }
        PropRecords[key] = rec
    end

    if NearlyEqual(v, rec.orig) then
        SafeCall(function()
            obj[prop.name] = rec.scaled
        end)

        local back = SafeCall(function()
            return obj[prop.name]
        end)

        if type(back) == "number" then
            rec.scaled = back
        end
    end
end

local function ProcessWeaponInstance(weapon)
    if not IsValidObj(weapon) then return end

    local cls = SafeCall(function()
        return weapon:GetClass()
    end)

    if not IsValidObj(cls) then return end

    local classPath = StripTypePrefix(SafeCall(function()
        return cls:GetFullName()
    end))

    if type(classPath) ~= "string" then return end

    local info = ClassInfo[classPath]

    if not info then
        info = BuildClassInfo(cls)
        ClassInfo[classPath] = info

        if #info.funcs > 0 then
            RegisterClassHooks(classPath, info.funcs)
        end
    end

    for _, prop in ipairs(info.props) do
        if prop.mode ~= "fire" or not info.ownHasGSI then
            ApplyProp(weapon, classPath, prop)
        end
    end

    local _, reloadMult = GetWeaponMultipliers(weapon)
    SetReloadProps(weapon, reloadMult)
end

local function ApplyStaticWeaponStats(weaponStaticData)
    if not weaponStaticData or not weaponStaticData:IsValid() then return end

    local weaponId = weaponStaticData.ID:ToString()
    local customCfg = FindWeaponConfig(weaponId)

    if customCfg and customCfg.Attack ~= nil then
        weaponStaticData.AttackValue = math.floor(customCfg.Attack * Config.Global.DamageMultiplier)
    elseif Config.Global.DamageMultiplier ~= 1.0 then
        weaponStaticData.AttackValue = math.floor(weaponStaticData.AttackValue * Config.Global.DamageMultiplier)
    end

    if customCfg and customCfg.Mag ~= nil then
        weaponStaticData.MagazineSize = math.floor(customCfg.Mag * Config.Global.MagazineMultiplier)
    elseif Config.Global.MagazineMultiplier ~= 1.0 then
        weaponStaticData.MagazineSize = math.floor(weaponStaticData.MagazineSize * Config.Global.MagazineMultiplier)
    end

    if Config.Global.InfiniteDurability then
        weaponStaticData.Durability = 999999.0
    elseif customCfg and customCfg.Dur ~= nil then
        weaponStaticData.Durability = customCfg.Dur * Config.Global.DurabilityMultiplier
    elseif Config.Global.DurabilityMultiplier ~= 1.0 then
        weaponStaticData.Durability = weaponStaticData.Durability * Config.Global.DurabilityMultiplier
    end

    if customCfg and customCfg.Wgt ~= nil then
        weaponStaticData.Weight = customCfg.Wgt * Config.Global.WeightMultiplier
    elseif Config.Global.WeightMultiplier ~= 1.0 then
        weaponStaticData.Weight = weaponStaticData.Weight * Config.Global.WeightMultiplier
    end

    if customCfg and customCfg.Snk ~= nil then
        weaponStaticData.SneakAttackRate = customCfg.Snk
    end
end

local function UpdateAllStaticWeapons()
    if not Config.Global.EnableMod then return end

    local staticWeapons = FindAllOf("PalStaticWeaponItemData")
    local count = 0

    if staticWeapons then
        for _, weaponData in ipairs(staticWeapons) do
            if weaponData:IsValid() then
                ApplyStaticWeaponStats(weaponData)
                count = count + 1
            end
        end
    end
    Log(string.format("Successfully applied stats to %d weapons & grenades!", count))
end


RegisterHook("/Script/Pal.PalWeaponBase:OnAttachWeapon", function(Context, AttachActor)
    if not Config.Global.EnableMod then return end

    local Weapon = Context:get()
    if not Weapon or not Weapon:IsValid() then return end

    ProcessWeaponInstance(Weapon)

    local weaponIdStr = ""
    if Weapon.ownWeaponStaticData and Weapon.ownWeaponStaticData:IsValid() then
        weaponIdStr = Weapon.ownWeaponStaticData.ID:ToString()
        ApplyStaticWeaponStats(Weapon.ownWeaponStaticData)
    end

    local customCfg = FindWeaponConfig(weaponIdStr)

    if Config.Global.NoRecoil then
        Weapon.RecoilPowerRate = 0.0
        Weapon.RecoilYawRange = 0.0
        Weapon.RecoilCurve = nil
        Weapon.ShotCameraShake = nil
    elseif customCfg and customCfg.RecoilRate ~= nil then
        Weapon.RecoilPowerRate = customCfg.RecoilRate
        Weapon.RecoilYawRange = Weapon.RecoilYawRange * customCfg.RecoilRate
    end

    if Config.Global.IncreasedBulletLifetime then
        Weapon.BulletDeleteTime = 30.0
        Weapon.BulletDecayStartRate = 1.0
    end

    if customCfg and customCfg.CoolDownTime ~= nil then
        Weapon.CoolDownTime = customCfg.CoolDownTime
    end

    if Weapon.ownWeaponDynamicData and Weapon.ownWeaponDynamicData:IsValid() then
        local dynamicData = Weapon.ownWeaponDynamicData
        if Config.Global.InfiniteDurability then
            dynamicData.Durability = 999999.0
            dynamicData.MaxDurability = 999999.0
        end
        if Weapon.ownWeaponStaticData and Weapon.ownWeaponStaticData:IsValid() then
            dynamicData.MaxMagazineSize = Weapon.ownWeaponStaticData.MagazineSize
        end
    end
end)


RegisterHook("/Script/Pal.PalWeaponBase:OnReloadStart", function(Context, InReloadSpeedPlayRate)
    if not Config.Global.EnableMod then return end

    local weapon = Context and Context:get()
    local _, reloadMult = GetWeaponMultipliers(weapon)

    local r = (InReloadSpeedPlayRate and InReloadSpeedPlayRate.get and InReloadSpeedPlayRate:get()) or 1.0
    if type(r) ~= "number" or r <= 0.0 then
        r = 1.0
    end

    local nr = r * reloadMult

    if InReloadSpeedPlayRate and InReloadSpeedPlayRate.set then
        InReloadSpeedPlayRate:set(nr)
    end

    SetReloadProps(weapon, nr)
    AccelerateMontage(weapon, nr)
end)


RegisterHook("/Script/Pal.PalWeaponBase:IsExistBulletInPlayerInventory", function(Context)
    if Config.Global.EnableMod and Config.Global.InfiniteAmmo then
        return true
    end
end)

RegisterHook("/Script/Pal.PalWeaponBase:GetInventoryBulletCount", function(Context)
    if Config.Global.EnableMod and Config.Global.InfiniteAmmo then
        return 9999
    end
end)

RegisterHook("/Script/Pal.PalWeaponBase:IsEmptyMagazine", function(Context)
    if Config.Global.EnableMod and Config.Global.InfiniteAmmo then
        return false
    end
end)

RegisterHook("/Script/Pal.PalWeaponBase:GetRemainBulletCount", function(Context)
    if Config.Global.EnableMod and Config.Global.InfiniteAmmo then
        return 9999
    end
end)

RegisterHook("/Script/Pal.PalShooterComponent:CanShoot", function(Context)
    if Config.Global.EnableMod and Config.Global.InfiniteAmmo then
        return true
    end
end)

RegisterHook("/Script/Pal.PalWeaponBase:RequestConsumeItem", function(Context, StaticItemId, ConsumeNum)
    if Config.Global.EnableMod and Config.Global.InfiniteAmmo then
        return true
    end
end)

RegisterHook("/Script/Pal.PalWeaponBase:RequestConsumeItem_ForThrowWeapon", function(Context, StaticItemId, ConsumeNum)
    if Config.Global.EnableMod and Config.Global.InfiniteAmmo then
        return true
    end
end)

RegisterHook("/Script/Pal.PalWeaponBase:DecreaseDurabilityWithValue", function(Context, DurabilityParam)
    if Config.Global.EnableMod and Config.Global.InfiniteDurability then
        return true
    end
end)

RegisterHook("/Script/Engine.Actor:ReceiveBeginPlay", function(Context)
    if not Config.Global.EnableMod then return end

    local Actor = Context:get()
    if not Actor or not Actor:IsValid() then return end

    if Actor:IsA("/Script/Pal.PalExplosionAttackBase") or string.find(Actor:GetFullName(), "ExplosionAttack") then
        local ownerIdStr = ""
        if Actor.OwnerStaticItemId then
            ownerIdStr = Actor.OwnerStaticItemId:ToString()
        end

        local customCfg = FindWeaponConfig(ownerIdStr)

        if customCfg and customCfg.Attack ~= nil then
            Actor.AttackPower = math.floor(customCfg.Attack * Config.Global.ExplosionDamageMultiplier)
        elseif Config.Global.ExplosionDamageMultiplier ~= 1.0 then
            Actor.AttackPower = math.floor(Actor.AttackPower * Config.Global.ExplosionDamageMultiplier)
        end

        if customCfg and customCfg.ExplosionRadius ~= nil then
            if Actor.SetRadius then
                Actor:SetRadius(math.floor(customCfg.ExplosionRadius * Config.Global.ExplosionRadiusMultiplier))
            end
        elseif Config.Global.ExplosionRadiusMultiplier ~= 1.0 and Actor.SetRadius then
            Actor:SetRadius(math.floor(500 * Config.Global.ExplosionRadiusMultiplier))
        end

        if customCfg and customCfg.BlowPower ~= nil then
            Actor.BlowPower = customCfg.BlowPower
        end
    end
end)

RegisterHook("/Script/Pal.PalPlayerCharacter:OnCompleteInitializeParameter", function(Context, InCharacter)
    ExecuteWithDelay(1500, function()
        UpdateAllStaticWeapons()
    end)
end)

ExecuteWithDelay(2000, function()
    pcall(function()
        local weapons = FindAllOf("PalWeaponBase")
        if weapons then
            for _, weapon in ipairs(weapons) do
                ProcessWeaponInstance(weapon)
            end
        end
    end)
end)

ExecuteWithDelay(4000, function()
    UpdateAllStaticWeapons()
end)

Log("WeaponStatsCustomizer Loaded")

