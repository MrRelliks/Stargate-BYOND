//////////////////////////////////////////////////
//												//
//					Fighters					//
//												//
//////////////////////////////////////////////////
mob/ufo
	sship
		icon='ships.dmi'
		godmode = 1
		density=1
		verb
			Drive_Ship()
				set src in oview(2)
				if(!src.driving)
					if(src.jumper)
						usr.shipdrive = 1
						usr.ship = src
						usr.verbs += /mob/ufo/Ship_Dial/verb/Dial
						usr.verbs +=  /mob/ufo/verb/ShippyCloak
						usr.verbs += /mob/ufo/sship/verb/Exit_Ship
						usr.verbs += /mob/ufo/sship/verb/Leave_ship
						usr.verbs += /mob/ufo/sship/verb/Enter_ship
						usr.verbs += /mob/ufo/Ships/verb/Weapons
						usr.verbs += /mob/ufo/Ships/verb/FlyToSpace
						usr.verbs += /mob/ufo/Ships/verb/Land_on_Planet
						usr.driving = 1
						src.driving = 1
						sleep(5)
						usr.loc=null
						usr.client.eye=src
						usr.client.perspective=EYE_PERSPECTIVE
						usr.client.cont=src
					else
						usr.shipdrive = 1
						usr.ship = src
						usr.verbs += /mob/ufo/sship/verb/Exit_Ship
						usr.verbs += /mob/ufo/sship/verb/Leave_ship
						usr.verbs += /mob/ufo/sship/verb/Enter_ship
						usr.verbs += /mob/ufo/Ships/verb/Weapons
						usr.verbs += /mob/ufo/Ships/verb/FlyToSpace
						usr.verbs += /mob/ufo/Ships/verb/Land_on_Planet
						usr.driving = 1
						src.driving = 1
						sleep(5)
						usr.loc=null
						usr.client.eye=src
						usr.client.perspective=EYE_PERSPECTIVE
						usr.client.cont=src
			Exit_Ship()
				set category = "Ship Controls"
				if(!usr.ship)
					usr.die("Ship Error")
					usr.verbs -= /mob/ufo/sship/verb/Exit_Ship
					usr.verbs -= /mob/ufo/sship/verb/Leave_ship
					usr.verbs -= /mob/ufo/sship/verb/Enter_ship
					usr.verbs -= /mob/ufo/Ships/verb/Weapons
					usr.verbs -= /mob/ufo/Ships/verb/FlyToSpace
					usr.verbs -= /mob/ufo/Ships/verb/Land_on_Planet
					usr.verbs -= /mob/ufo/verb/ShippyCloak
					usr.verbs -= /mob/ufo/Ship_Dial/verb/Dial
					usr.client.eye=usr
					usr.client.perspective=MOB_PERSPECTIVE
					usr.client.cont=null
					return
				if(!usr.ship.loc)
					usr.die("Ship Eplosion")
					usr.verbs -= /mob/ufo/sship/verb/Exit_Ship
					usr.verbs -= /mob/ufo/sship/verb/Leave_ship
					usr.verbs -= /mob/ufo/sship/verb/Enter_ship
					usr.verbs -= /mob/ufo/Ships/verb/Weapons
					usr.verbs -= /mob/ufo/Ships/verb/FlyToSpace
					usr.verbs -= /mob/ufo/Ships/verb/Land_on_Planet
					usr.verbs -= /mob/ufo/verb/ShippyCloak
					usr.verbs -= /mob/ufo/Ship_Dial/verb/Dial
					usr.client.eye=usr
					usr.client.perspective=MOB_PERSPECTIVE
					usr.client.cont=null
				if(usr.ship.space)
					world<<output( {"<font color=red><b>System: </b></font>Can't leave ship while in space."},{"Player"})
					//usr << "<font color=red><b>System: </b></font>Can't leave ship while in space."
					return
				if(usr.driving)
					src.verbs += /mob/ufo/sship/verb/Drive_Ship
					sleep(5)
					usr.loc = usr.ship.loc
					usr.client.eye=usr
					usr.client.perspective=MOB_PERSPECTIVE
					usr.client.cont=null
					usr.verbs -= /mob/ufo/sship/verb/Exit_Ship
					usr.verbs -= /mob/ufo/sship/verb/Leave_ship
					usr.verbs -= /mob/ufo/sship/verb/Enter_ship
					usr.verbs -= /mob/ufo/Ships/verb/Weapons
					usr.verbs -= /mob/ufo/Ships/verb/FlyToSpace
					usr.verbs -= /mob/ufo/Ships/verb/Land_on_Planet
					usr.verbs -= /mob/ufo/verb/ShippyCloak
					usr.verbs -= /mob/ufo/Ship_Dial/verb/Dial
					usr.ship.driving = 0

				else
					usr.loc=usr.ship.loc
					usr.client.eye=usr
					usr.client.perspective=MOB_PERSPECTIVE
					usr.client.cont=null
					usr.verbs -= /mob/ufo/sship/verb/Exit_Ship

			Get_In()
				set src in oview(1)
				usr.ship = src
				sleep(1)
				usr.verbs += /mob/ufo/sship/verb/Exit_Ship
				sleep(5)
				usr.client.eye = src
				usr.client.perspective = EYE_PERSPECTIVE
			//	usr.JSGStun()
				usr.loc = null
			Leave_ship()
				set category = "Ship Controls"
				var/mob/ufo/Ships/M
				var/obj/ufos/Ships/Ship_hatch/hatch
				for(M in world)
					for(hatch in oview(900, usr.ship))
						if(hatch.id == M.id)
							usr.ship.loc = M
							usr.ship.space = M.space
			Enter_ship()
				set category = "Ship Controls"
				var/mob/ufo/Ships/M
				var/obj/ufos/Ships/Ship_hatch/hatch
				for(hatch in world)
					for(M in oview(1 ,usr.ship))
						if(M.id == hatch.id)
							usr.ship.loc = hatch.loc
							usr.ship.space = 0
							usr.ship = M
			Weapons()
				set category = "Ship Controls"
				set name = "Weapons"
				usr.weapons1()
		Death_Glider
			name="Death Glider"
			icon = 'DGlider.dmi'
			attack1 = 5
			shield = 5000
			shieldM = 5000
			lz = 62
		F_302
			name="F-302 Fighter"
			icon = 'f302.dmi'
			attack1=5
			lz = 62
			shield = 10000
			shieldM = 10000
		Puddle_Jumper
			name = "Puddle Jumpers"
			icon = 'Icons/PuddleJumper.dmi'
			icon_state = "closed"
			jumper = 1
			attack1=6
			dmg = 100
			shield = 5000
			shieldM = 5000
		Wraith_Dart
			name="Wraith Dart"
			icon = 'Dart.dmi'
			attack1 = 4
			dmg = 100
			shield = 5000
			shieldM = 5000

		Teltacs
			name="Teltac"
			icon = 'ships.dmi'
			icon_state = "AlKesh"
			attack1 = 4
			dmg = 100
			shield = 5000
			shieldM = 5000