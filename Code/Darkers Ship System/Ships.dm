mob/ufo
	Ships
		icon = 'ships.dmi'
		race = "Ship"
		godmode = 1
		var/obj/ufos/Ships/Ship_hatch/hatch
		Del()
			spawn(10)
				src.ZSpawn()
				src.locked = 0
			return ..()
		New()
			. = ..()
			src.zspawn = src.loc
		Click()
			if(locked)
				usr<<output( {"<<font color=black><b>System: </b></font>This ship is locked"},{"Player"})
				//usr << "<font color=black><b>System: </b></font>This ship is locked"
				return 0
			if(src in oview(1))
				if(!hatch)
					usr<<output( {"<font color=black><b>System: </b></font>Ship hatch not found."},{"Player"})
				//	usr << "<font color=black><b>System: </b></font>Ship hatch not found."
					return 0
				if(!hatch.loc)
					usr<<output( {"<font color=black><b>System: </b></font>Ship hatch not found."},{"Player"})
				//	usr << "<font color=black><b>System: </b></font>Ship hatch not found."
					return 0
				else
					usr.loc=hatch.loc
					usr.ship = src
		verb
			Exitt()
				set name="Stop Driving"
				set category="Ship Controls"
				if(usr.client.cont)
					usr.client.eye = usr
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.cont = null
					usr.drive2()
			FlyToSpace()
				set name="Leave Planet"
				set category="Ship Controls"
				var/obj/planets/P
				for(P in world)
					if(!usr.ship.z) return 0
					if(P.lz == usr.ship.z)
						usr << "<font color=black><b>System: </b></font>Leaving Planet... 30 seconds."
						sleep(30)
						usr << "<font color=black><b>System: </b></font>Entering Orbit."
						usr.ship.loc = P.loc
						usr.ship.space = 1
			Land_on_Planet()
				set category="Ship Controls"
				var/obj/planets/P
				for(P in view(1, ship))
					if(!P.lz)
						usr << "<font color=black><b>System: </b></font>You can't land here."
						return 0
					usr << "<font color=black><b>System: </b></font>Leaving Orbit... 30 seconds."
					sleep(30)
					usr << "<font color=black><b>System: </b></font>Landing."
					usr.ship.loc = locate(P.lx, P.ly, P.lz)
					usr.ship.space = 0
					return
			Weapons()
				set category = "Ship Controls"
				set name = "Weapons"
				if(!usr.ship.cloaked1)
					usr << "<font color=black><b>System: </b></font>Charging Weapons... 30 seconds."
					sleep(30)
					usr.weapons1()
				else
					usr << "<font color=black><b>System: </b></font>You can't fire weapons while cloaked."
					return
mob/ufo
	Ships
		Prometheus
		//	icon = 'Prometheus.dmi'
			icon_state = "X-303"
			name = "BC304-Prometheus"
			dmg = 400
			shield = 45000
			shieldM = 45000
			id = 1

		.




