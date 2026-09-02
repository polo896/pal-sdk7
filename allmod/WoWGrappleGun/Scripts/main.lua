local palConfig = require "config"

print(palConfig.palRedColorWrapperFront .. palConfig.palModName .. "Mod Version " .. palConfig.palModVersion .. " - Working as of game version " .. palConfig.palGameVersion .. palConfig.palRedColorWrapperBack)

NotifyOnNewObject("/Script/Pal.PalWeaponBase", function(PalWeaponBase)
	PalWeaponBase.CableMaxLength = palConfig.CableMaxLength
	PalWeaponBase.CableShootSpeed = palConfig.CableShootSpeed
	PalWeaponBase.CableReturnSpeed = palConfig.CableReturnSpeed
	PalWeaponBase.PlayerMoveSpeed = palConfig.PlayerMoveSpeed
end)

-- Made by pleby
-- FYI I got no fucking clue what im doing, but aye it works.