client
	var/cont
	North()
	//	if(weapons)
	//		eye=usr
	//		weapons=0
	//		return
		if(cont)
			if(cont=="off")
				eye=usr
				cont=null
				return
			step(cont,NORTH)
			return
		else
			..()
	South()
	//	if(weapons)
	//		eye=usr
	//		weapons=null
		if(cont)
			if(cont=="off")
				eye=usr
				cont=null
				return
			step(cont,SOUTH)
			return
		else
			..()
	East()
	//	if(weapons)
	//		eye=usr
	//		weapons=null
		if(cont)
			if(cont=="off")
				eye=usr
				cont=null
				return
			step(cont,EAST)
			return
		else
			..()
	West()
	//	if(weapons)
	//		eye=usr
	//		weapons=null
		if(cont)
			if(cont=="off")
				eye=usr
				cont=null
				return
			step(cont,WEST)
			return
		else
			..()

mob
	var
		inship = 0
		shipcontrolling
		ship
		shipid

	ships
		verb
			GetOut()
				set category = "Ship"
				set hidden = 0
				set name = "Get Out"
				for(var/obj/ships/C)
					usr.client.verbs -= /mob/ships/verb/GetOut
					//usr.loc = src.maploc
					usr.client.eye = usr
					usr.client.perspective = EYE_PERSPECTIVE
					//usr.verbs += /mob/ships/verb/GetOut
					usr.client.cont = null

obj
	controller
		icon = 'Code/Ships/controller.dmi'
		icon_state = "puddle"
		var
			shipid = 1
		DblClick()
			var/mob/ships/S
			for(S in world)
				if(S.shipid == shipid && istype(S,/obj/ships))
					usr.client.eye = S
					usr.client.perspective = EYE_PERSPECTIVE
					usr.client.cont = S

	ships
		var
			shipid = 1








		Del()
			usr.client.eye = usr
			usr.client.perspective = EYE_PERSPECTIVE
			usr.client.cont = usr

		Atlantis
			PuddleJumper
				name = "Puddle Jumpers"
				icon = 'Icons/PuddleJumper.dmi'
				icon_state = "closed"
				pixel_x =-32
				layer = MOB_LAYER+3
				density = 1