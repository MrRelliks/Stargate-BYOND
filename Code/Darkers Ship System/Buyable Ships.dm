mob/ufo
	Bayableship
		race = "Nox"
		NPC = 1
		density=1
		icon='ships.dmi'
		hp = 9999999999999999999999999999
		var
			bx
			by
			bz
			obj/ships/beam
			owner
			towner = null
		verb
			Get()
				set src in oview(2)
				if(src.towner == usr)
					src.loc = usr
			Drop()
				set src in usr
				src.loc=usr.loc
		verb/Drive_Ship()
			set src in oview(2)
			if(!src.driving)
				if(src.towner == usr)
					usr.oship = src
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
					usr.loc = null
					usr.client.eye = src
					usr.client.perspective = EYE_PERSPECTIVE
					usr.client.cont = src
				else
					usr.oship = src
					src.towner = usr
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
		verb/Exit_Ship()
			set category = "Ship Controls"
			if(usr.ship.space)
				usr << "<font color=red><b>System: </b></font>Can't leave ship while in space!"
				return 0
			if(usr.driving)
				usr.shipdrive = 0
				src.verbs += /mob/ufo/sship/verb/Drive_Ship
				sleep(1)
				usr.loc = usr.ship.loc
				usr.client.eye = usr
				usr.client.perspective = MOB_PERSPECTIVE
				usr.client.cont = null
				usr.verbs -= /mob/ufo/sship/verb/Exit_Ship
				usr.verbs -= /mob/ufo/sship/verb/Leave_ship
				usr.verbs -= /mob/ufo/sship/verb/Enter_ship
				usr.verbs -= /mob/ufo/Ships/verb/Weapons
				usr.verbs -= /mob/ufo/Ships/verb/FlyToSpace
				usr.verbs -= /mob/ufo/Ships/verb/Land_on_Planet
				usr.ship.driving = 0

				var/mob/ufo/Ships/M
				for(M in world)
					if(M.lz == ship.z)
						usr.ship = M
			else
				usr.loc = usr.ship.loc
				usr.client.eye = usr
				usr.client.perspective = MOB_PERSPECTIVE
				usr.client.cont = null
				usr.verbs -= /mob/ufo/sship/verb/Exit_Ship
				usr.shipdrive = 0

		verb/Get_In()
			set src in oview(2)
			usr.ship = src
			usr.verbs += /mob/ufo/sship/verb/Exit_Ship
			sleep(1)
			usr.client.eye = src
			usr.client.perspective = EYE_PERSPECTIVE

			usr.loc = null
		verb/Leave_ship()
			set category = "Ship Controls"
			var/mob/ufo/Ships/S
			for(S in world)
				if(S.lz == ship.z)
					ship.loc = S.loc
					ship.space = S.space
		verb/Enter_ship()
			set category = "Ship Controls"
			if(usr.driving)
				var/mob/ufo/Ships/S
				for(S in view(2, usr.ship))
					usr.ship.loc = locate(S.lx, S.ly, S.lz)
					usr.ship.space = 0
		verb/Weapons()
			set category = "Ship Controls"
			set name = "Weapons"
			if(!usr.ship.cloaked1)
				weapons1()
			else
				usr << "<font color=red><b>System: </b></font>Can't fire while cloaked."
		BuyableShip
			name = "Ship"
			dmg = 100
			shield = 5000
			shieldM = 5000
			attack1 = 5
			Nastrond
				icon_state = "Náströnd"
				name = "Náströnd"
mob
	NPC
		Ship_Merchant
			name = "Ship Merchent"
			//icon = 'NPC.dmi'
			icon_state = "Merchent"
			hp = 10000000000000
			DblClick()
				usr.CreateAlert("Hi I'm currently out of order due to pending updates.")