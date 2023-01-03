obj


	items
		var/canStack=0


obj
	var
		price = 0

	MiningOverlay
		icon='Coding/Skills/MiningAnimation.dmi'
		layer = 999
mob
	verb
		FilterMessages()
			set name = "Filter Game Messages"
			set category = "Commands"
			if(src.miningfiltered || src.smithingfiltered)
				src.miningfiltered = 0
				src.smithingfiltered = 0

			else
				src.miningfiltered = 1
				src.smithingfiltered = 1
				src << "Game Messages are now being filtered"
mob
	var/MiningEXP = 0
	var/MiningMaxEXP = 83
	var/MiningLevel = 1
	var/tmp/mining = 0
	var/hasmined = 0
	var/minelimit = 10
	var/totalminingXP = 0
	var/miningoverlay = /obj/MiningOverlay
	var/miningfiltered = 0
	var/smithingfiltered = 0


	Move()
		if(usr.move == 0)
			return



		if(usr.AFK == 1)
			usr.AFK = 0
			usr.safe = 0
			usr << "You are no longer AFK"
			usr.move = 1
			usr.AFKLabel = "Online"
			usr.overlays-= AFKOverlay
			usr.density = 1
		if(src.mining == 1)
		//	src<<"You stopped learning"
			src.mining = 0
			src.overlays -= src.miningoverlay
		..()



//	overlays += my_overlay
	proc
		MineLevel()
			if(MiningEXP >= MiningMaxEXP)

				MiningLevel++
				M_Ranking(src)
				if(src.minelimit <= 27)
					minelimit += 1
				else
					minelimit = minelimit
				MiningMaxEXP+=MiningMaxEXP + (MiningMaxEXP * 0.47701149425)
				MiningEXP=0

				src.overlays+= 'Coding/fireworks.dmi'
				src << sound("Sounds/levelup.ogg",volume=30)
				sleep(20)
				src.overlays-= 'Coding/fireworks.dmi'
				//src <<"<center>Your mining level has increased to [src.MiningLevel].</center>"
				src<<"<center>Your mining level has increased to [src.MiningLevel].</center>"



obj
	rock
		New()

		icon='Code/Skills/MiningObjects.dmi'
		density=1
		var/canmine
		var/res = 20
		var/timetomine
		var/lvlrequired
		var/Inventory

		Click()
			Mine(usr)
		Copper
			icon_state="copperrocks"
			name ="Copper Ore"
			lvlrequired = 1
			timetomine = 100
			canmine = list(new/obj/items/ore/Copper)
			Inventory = /obj/items/ore/Copper
		Iron
			icon_state="ironrocks"
			name ="Iron Ore"
			lvlrequired = 3
			timetomine = 120
			canmine = list(new/obj/items/ore/Iron)
			Inventory = /obj/items/ore/Iron




		proc
			Reset()
				return

			Mine(mob/M)
				if(!M) return// idk why here but i was getting run time errors so yeah
				if(M.mining)
					return

				if(!(locate(/obj/items/PickAxe) in M.contents))
					M<<"You Require a pickaxe."
					return
			//	M.move = 0
				M.mining=1
				if(M.MiningLevel >= src.lvlrequired)
					if(M.contents.len >= M.weight)
						M << "Your pack is full!"
						M.move = 1
						M.mining = 0
						return

					M.overlays += M.miningoverlay
				//	M<<output({"<strong><font color=\"#ffffff\">You swing your pick at the rock...</strong>"},{"announce"})
					M << sound("Sounds/mining.ogg",volume=30)
					sleep(timetomine)
					if(!M)return
					var/obj/items/ore/o = pick(canmine)

					if(M.mining==1)
						if(M.miningfiltered == 1)
						else
							M<<"<strong><font color=\"#93FE56\">You uncover some [o]</strong>"

						new o.type(M)
						M.updateInventory()
						M.MiningEXP+=o.xpgiven
						M.totalminingXP += o.xpgiven
						s_damage(M,o.xpgiven,"green")
						M.MineLevel()
						//Coding/MiningAnimation.dmi'
						//M.move = 1
						M.mining=0
						M.overlays -= M.miningoverlay
						Reset()
						M.hasmined += 1
						//M.overlays -= M.miningoverlay
						if(M.hasmined >= M.minelimit)
							M.hasmined = 0
							//M.move = 1
							M<<"<strong><font color=\"#CF21DE\">You grow tired and have to stop to catch your breath!</strong>"
							//M << "You grow tired and have to stop to catch your breath!"
							return
						else
							//var/SleepTime = round(src.m
							sleep(30)
							Mine(M)
				else
					M<<"<strong><font color=\"#93FE56\">You do not have the level required to mine this, Required level: [src.lvlrequired]</strong>"
					M.move = 1
					M.mining = 0

			//	M.mining = 0

obj
	items





		Bar
			icon = 'Bars.dmi'
			Bronze
				name = "Bronze Bar"
				icon_state = "bronze"
				price = 60
				suffix = "A refined Bronze bar"
			Iron
				name = "Iron Bar"
				icon_state = "iron"
				price = 96
				suffix = "A refined Iron bar"

obj/items/ore
	icon='Code/Skills/MiningObjects.dmi'

	var
		Probability
		LevelReq
		Allowmove = 1
		xpgiven
		Bar
		smithingxpgained
		BarName = ""




	New()
		..()
		spawn(1)
			if(ismob(src.loc))
				src.owner = src.loc

	Copper
		icon_state="copper"
		name="Copper Ore"
		Probability=5
		LevelReq=1
		canStack=1
		smithingxpgained = 10
		Bar = new /obj/items/Bar/Bronze
		BarName = "Bronze bar"
		xpgiven = 10
		price = 28
		suffix = "Some unrefined Ore."


	Iron
		icon_state="iron"
		name="Iron ore"
		Probability=5
		LevelReq=3
		canStack=1
		smithingxpgained = 15
		Bar = new /obj/items/Bar/Iron
		BarName = "Iron Bar"
		xpgiven = 15
		price = 53
		suffix = "Some unrefined Ore."
