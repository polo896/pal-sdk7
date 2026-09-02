local palConfig = {

    palModName = "Speedy Grapple Gun - ",
    palModVersion = "1.1",
    palGameVersion = "1.4.1",

    palRedColorWrapperFront = "\27[31m",
    palRedColorWrapperBack = "\27[0m\n",

	CableMaxLength = 22000, --How far the grapple can shoot. Default = 2100
	CableShootSpeed = 80000, --How fast the grapple leaves the gun. Default = 8000
	CableReturnSpeed = 120000, --How fast the grapple returns to the gun. Default = 12000
	PlayerMoveSpeed = 40000 --How fast the grapple pulls the player. Default = 4000
	
}
return palConfig
