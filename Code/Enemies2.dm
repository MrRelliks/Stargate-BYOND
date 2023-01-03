
//////////////////////////////////////////////////
//												//
//		Coded By CB, Doing it the right way		//
//												//
//////////////////////////////////////////////////


var/
	rep_limit = 10

mob/Replicator_NPC
	name = "wraith"
	icon = 'Icons/wraith.dmi'
	icon_state = "neutral"
	density = 1
	layer=4
	race = "Replicator"
	var/max_hp = 50
	hp = 20

	var
		mob/P
		atom/target = null
		RepLevel = 1
		RepAte = 0
		Resources = 0
		bite = 0

	New()
		. = ..()
		spawn()
			Wander()




	Move()
		..()
		if(istype(src.loc.loc,/area/nofight))
			del(src)

	proc/
		Wander()
			while(src)
				Wander_walk()
				sleep()


		Wander_walk()
			var/Random = rand(1, 4)
			switch(Random)
				if(1)
					walk(src, EAST, 3)
				if(2)
					walk(src, NORTH, 3)
				if(3)
					walk(src, SOUTH, 3)
				if(4)
					walk(src, WEST, 3)
			//Old
			/*var/random = rand(1,4)
			if(random == 1)
				walk(src,EAST,5)
			if(random == 2)
				walk(src,NORTH,5)
			if(random == 3)
				walk(src,SOUTH,5)
			if(random == 4)
				walk(src,WEST,5)*/


