/*

				if(usr.style == 1)
						usr.attackxp += M.xpgiven
						usr.XPCalculator()
					else if(usr.style == 2)
						usr.strengthxp += M.xpgiven
						usr.hitpointsxp += M.hitpointxpgiven
						usr.XPCalculator()
					else if(usr.style == 3)
						usr.defencexp += M.xpgiven
						usr.hitpointsxp += M.hitpointxpgiven
						usr.XPCalculator()
					else if(usr.style == 4)
						usr.attackxp += M.xpgiven / 3
						usr.strengthxp += M.xpgiven / 3
						usr.defencexp += M.xpgiven / 3
						usr.hitpointsxp += M.hitpointxpgiven
						usr.XPCalculator()

*/
obj/overlays/levelup
	//icon ='Skills/levelup.dmi'
	layer = 999
#define DEBUG
mob
	var
		style = 4 //1 = Attack   2 = Strength  3 = Defence  4 = Mix of all three
		mhp=500 /// as above except the MAX hp.

		mstr=40//max strength
		matk = 0
		mdef=100/// max defence
	//	npc=0//npc var for npc mobs
		exp=0//exp for lvling
		mexp=10//max exp.
		level=1///level var
		equiped = 0
		ishitting = 0
		attackxpgiven = 0
		strengthxpgiven = 0
		defencexpgiven = 0
		damage = 0
		incombat = 0
		isdead = 0

		combatlevel
		minhit
		maxhit
		attackxp
		strengthxp
		strengthbonus
		attackclicked = 0
		defencelvl = 1
		defencexp = 0
		attackxpneeded = 87
		strengthxpneeded = 87
		defencexpneeded = 87
		hitpointsxpneeded = 87
		attacklvl = 1
		strengthlvl = 1
		hitpointmax = 100
		hitpointsxp = 0
		xpgiven = 0
		hitpointxpgiven = 0

	proc
		LevelUpAnimations()
			usr << sound("Sounds/levelup.ogg",volume=30)
			usr.overlays += /obj/overlays/levelup
			sleep(10)
			usr.overlays -= /obj/overlays/levelup


		XPCalculator()
			for(var/mob/M in world)


				if(M.attackxp >= attackxpneeded)
					M.attacklvl +=1
					usr << "Congratulations you advanced an attack level, you are now level [attacklvl]"
					usr.LevelUpAnimations()
					M.attackxpneeded = attackxpneeded + (attackxpneeded * 1.10409)

				if(M.strengthxp >= strengthxpneeded)
					M.strengthlvl +=1
					usr << "Congratulations you advanced your strength level, you are now level [strengthlvl]"
					usr.LevelUpAnimations()
					M.strengthxpneeded = strengthxpneeded+ (strengthxpneeded * 1.10409)

				if(M.defencexp >= defencexpneeded)
					M.defencelvl +=1
					usr << "Congratulations you advanced your defence level, you are now level [defencelvl]"
					usr.LevelUpAnimations()
					M.defencexpneeded = defencexpneeded + (defencexpneeded * 1.10409)







/// variables finished.

// just a grass turf & dirt turf here lol


/// onto the verbs!












mob
	NPC

	var
		respawnloc
		naquadahgiven = 0
		common = 50
		rare = 30
		superrare = 15
		ultrarare = 5

	//	attacked = 0
		cardinal_dirs = list(NORTH,SOUTH,EAST,WEST)
		list
			commondrops
			raredrops
			superraredrops
			ultrararedrops

			bones
			alwaysdrops


	New()
		..()
		//	spawn()


	Del()
		var/roll = pick(1,100)
		if(roll > common)
			var/commondo = pick(commondrops)
			new commondo(src.loc)
		else if(roll > rare && roll < common)
			var/raredo = pick(raredrops)
			new raredo(src.loc)
		else if(roll > superrare && roll < rare)
			var/superraredo = pick(superraredrops)
			new superraredo(src.loc)
		else if(roll > ultrarare && roll < superrare)
			var/ultrararedo = pick(ultrararedrops)
			new ultrararedo(src.loc)
		new alwaysdrops(src.loc)
		src.loc = null
		sleep(300)
		//src.restore_stats()
		src.hp = src.maxhp
		src.attacked = 0
		src.loc=initial(src.loc)
		if(!z)del src //if it has no initial location [eg: not placed on map), it is deleted




		//loot = list()




		//////////
		// NPC's //
		///////////
	Wraith
		icon='Icons/Mobs/wraith.dmi'
		//icon_state = "wraith"
		name="{NPC} Wraith"
		npc=0
		mstr = 3
		mdef = 2
		matk = 1
		hp=100
		maxhp = 100
		combatlevel = 5
		minhit = 1
		maxhit = 10
		xpgiven = 28
		naquadahgiven = 100
		respawntime = 100

	//	drops = new list(/obj/items/ore/Copper = 40,/obj/items/ore/Iron = 30,/obj/items/Bar/Bronze = 20,/obj/items/Bar/Iron = 10)
		commondrops = list(/obj/items/ore/Copper,/obj/items/ore/Iron,/obj/items/Bar/Bronze,/obj/items/Bar/Iron)
		raredrops = list()
		superraredrops = list()
		ultrararedrops = list()
		alwaysdrops = list()














/// Optional Respawn verb.
	verb
		Respawn()
			world.Repop()