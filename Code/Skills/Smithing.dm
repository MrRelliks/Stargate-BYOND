mob
	var/SmithingEXP = 0
	var/SmithingMaxEXP = 83
	var/SmithingLevel = 1
	var/tmp/Smithing = 0
	var/hassmithed = 0
	var/smithlimit = 10
	var/totalSmithingXP = 0

	Move()
		if(src.Smithing == 1)
		//	src<<"You stopped learning"
			src.Smithing = 0
		//	src.overlays -= src.miningoverlay
		..()

	proc
		SmithingLevel()

			if(SmithingEXP >= SmithingMaxEXP)

				SmithingLevel++
				S_Ranking(src)
				if(src.smithlimit <= 27)
					smithlimit += 1
				else
					smithlimit = smithlimit
				SmithingMaxEXP+=SmithingMaxEXP + (SmithingMaxEXP * 0.47701149425)
				SmithingEXP=0
			//	Mplayerleveling(src)
				src.overlays+= 'Coding/fireworks.dmi'
				src << sound("Sounds/levelup.ogg",volume=30)
				sleep(20)
				src.overlays-= 'Coding/fireworks.dmi'
				//src <<"<center>Your mining level has increased to [src.MiningLevel].</center>"
				src<<"<center>Your Smithing level has increased to [src.SmithingLevel].</center>"
				//src<<link("byond://?aha=skills")
		//	else
				//src<<link("byond://?aha=skills")

obj
	Smithing
		Furnace
			New()

			icon = 'Code/Skills/Smithing.dmi'
			icon_state = "furnace"
			density = 1
		proc
			Smith(mob/M)
				for(var/obj/items/ore/O in usr.contents)
					usr << "You begin smithing"
					usr.move = 0
					usr.safe = 1
					sleep(2)
					usr.contents += O.Bar
					usr.SmithingEXP += O.smithingxpgained
					usr.totalSmithingXP += O.smithingxpgained
					s_damage(usr,O.smithingxpgained,"green")
					usr.SmithingLevel()
					if(usr.smithingfiltered)
						//do nothing
					else
						usr << "You recieve a [O.BarName]"
					del(O)
						//var/obj/items/ore/o = o.Bar
						//usr.contents += O.Bar
					//sleep(0.6)
					usr.move = 1
					usr.safe = 0


		DblClick()
			switch(input("Are you sure you want to smith the ore in your inventory?")in list("Yes","No"))
				if("Yes")
					for(var/obj/items/ore/O in usr.contents)
						usr.Smithing = 1
						Smith()



				if("No")
					return
		//	usr << "Not yet available"




