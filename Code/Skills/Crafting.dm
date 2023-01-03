mob
	var/CraftingEXP = 0
	var/CraftingMaxEXP = 83
	var/CraftingLevel = 1
	var/tmp/crafting = 0
	var/hascrafted = 0
	var/craftlimit = 10
	var/totalcraftingXP

	Move()
		if(src.crafting == 1)
		//	src<<"You stopped learning"
			src.crafting = 0
		//	src.overlays -= src.miningoverlay
		..()

	proc
		CraftLevel()
			if(CraftingEXP >= CraftingMaxEXP)

				CraftingLevel++
				if(src.craftlimit <= 27)
					craftlimit += 1
				else
					craftlimit = craftlimit
				CraftingMaxEXP+=CraftingMaxEXP + (CraftingMaxEXP * 0.47701149425)
				CraftingEXP=0
			//	Mplayerleveling(src)
				src.overlays+= 'Coding/fireworks.dmi'
				src << sound("Sounds/levelup.ogg",volume=30)
				sleep(20)
				src.overlays-= 'Coding/fireworks.dmi'
				//src <<"<center>Your mining level has increased to [src.MiningLevel].</center>"
				src << "<center>Your crafting level has increased to [src.CraftingLevel].</center>"
				//src<<output( {"<center>Your crafting level has increased to [src.CraftingLevel].</center>"},{"announce"})


obj
	Crafting
		Anvil
			icon = 'Code/Skills/Crafting.dmi'
			icon_state = "Anvil"
		DblClick()
			usr << "Not yet available"




