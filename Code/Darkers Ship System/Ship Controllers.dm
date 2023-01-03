obj/ufos/Ships
	controller
		name = "Drive Controls"
		icon = 'ships.dmi'
		density=1
		var
			mob/ufo/Ships
			locked
			id
		New()
			..()
			spawn()
				var/mob/ufo/Ships/M
				for(M in world)
					if(M.id == id && istype(M, /mob/ufo))
						Ships = M
		Click()
			if(src in view(1))
				usr.shipdrive = 1
				sleep(5)
				usr.verbs += /mob/ufo/Ships/verb/Weapons
				usr.verbs += /mob/ufo/Ships/verb/Exitt
				usr.verbs += /mob/ufo/Ships/verb/FlyToSpace
				usr.verbs += /mob/ufo/Ships/verb/Land_on_Planet
				sleep(5)
				usr.shipdrive = 0
				usr.client.eye = Ships
				usr.client.perspective = EYE_PERSPECTIVE
				usr.client.cont = Ships
				var/mob/ufo/Ships/S
				for(S in world)
					if(S.id == id && istype(S,/mob/ufo))
						usr.ship = Ships
		Odyssey
			id=1
			icon_state="tauri1"
		Orion
			id = 2
			icon_state = "12"
		Teltac
			id = 3
			icon_state = "Goauld Consoles"
		baalhatack
			id = 5
			icon_state = "Goauld Consoles"
		anubishatack
			id = 6
			icon_state = "Goauld Consoles"

mob
	proc
		drive3()
			src.verbs -=  /obj/Arora/Chair/verb/weapons
			src.verbs -=  /obj/Drive_Control/shipe/verb/Hyper_Drive
			//src.verbs -=  /obj/Shield_Systemarora/verb/Repair
			src.verbs -=  /obj/Arora/Chair/verb/Drons
			src.verbs -=  /obj/Drive_Control/shipe/verb/Hyper_Drive
			src.verbs -=  /obj/Asgard/console/verb/super_Weapon
			src.verbs -=  /obj/Asgard/console/verb/Beamin
			src.verbs -=  /obj/ufos/Cloak/verb/Cloak_Ship
			src.verbs -= /mob/ufo/Ships/verb/Exitt
			src.verbs -= /mob/ufo/Ships/verb/FlyToSpace
			src.verbs -= /mob/ufo/Ships/verb/Land_on_Planet
			src.verbs -= /mob/ufo/Ships/verb/Weapons
			src.verbs -=  /obj/Asgard/console/verb/weapons
			sleep(5)
			src.client.eye=usr
			src.client.perspective=MOB_PERSPECTIVE
			src.client.cont=null
			..()
mob
	proc
		drive2()
			usr.verbs -=  /obj/Arora/Chair/verb/weapons
			usr.verbs -=  /obj/Drive_Control/shipe/verb/Hyper_Drive
			//usr.verbs -=  /obj/Shield_Systemarora/verb/Repair
			usr.verbs -=  /obj/Arora/Chair/verb/Drons
			usr.verbs -=  /obj/Drive_Control/shipe/verb/Hyper_Drive
			usr.verbs -=  /obj/Asgard/console/verb/super_Weapon
			usr.verbs -=  /obj/Asgard/console/verb/Beamin
			usr.verbs -=  /obj/ufos/Cloak/verb/Cloak_Ship
			usr.verbs -= /mob/ufo/Ships/verb/Exitt
			usr.verbs -= /mob/ufo/Ships/verb/FlyToSpace
			usr.verbs -= /mob/ufo/Ships/verb/Land_on_Planet
			usr.verbs -= /mob/ufo/Ships/verb/Weapons
			usr.verbs -=  /obj/Asgard/console/verb/weapons
			..()