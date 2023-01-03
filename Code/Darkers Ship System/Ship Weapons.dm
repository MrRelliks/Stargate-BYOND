obj
	Ship_Weapons
		icon='ships.dmi'
	//	icon_state="eproj"
/*		New(mob/ufo/targ,loc,dmg)
			. = ..()
			dir=get_dir(src,targ)
			src.loc=loc
			var/oloc
			spawn()
				while(src)
					sleep(2)
					oloc=src.loc
					if(!targ) del(src)
					step_towards(src,targ)
					if(oloc==src.loc) del(src)
					if(src.loc==targ.loc)
						targ.shield-=dmg
						if(targ.shield<=0)
							targ.loc = null
							spawn(10)
								targ.ZSpawn()
							var/mob/M
							for(M in world)
								if(M.ship == targ)
									M.shipdrive = 0
									M.die("Ship Exploding")
									if(M.client.cont)
										M.drive2()
										M.shipdrive = 0
										M.client.cont = null
										M.client.eye = M
										M.client.perspective = MOB_PERSPECTIVE
							world << "<font color=red><center><b>[targ] has been destroyed!</b></center></font>"
							del(src)
							return
					if(targ)
						continue*/
		New(mob/ufo/targ, loc, dmg)
			. = ..()
			var
				oloc
				mob/M
			dir = get_dir(src, targ)
			src.loc = loc
			spawn(0)
				while(src)
					sleep(1)
					oloc = src.loc
					if(!targ)
						del(src)
					step_towards(src, targ)
					if(oloc == src.loc)
						del(src)
					if(src.loc == targ.loc)
						if(targ.shield <= 0)
							targ.loc = null
							spawn(10)
								targ.ZSpawn()
							for(M in world)
								if(M.ship == targ)
									M.drive2()
									M.shipdrive = 0
									M.client.cont = null
									M.client.eye = M
									M.client.perspective = MOB_PERSPECTIVE

							//world << "<font color=#000033><center><b>[targ] has been destroyed!</b></center></font>"
							world<<output( {"<font color=#000033><center><b>[targ] has been destroyed!</b></center></font>"},{"Player"})
							targ.shield -= dmg
						del(src)
						return
					if(targ) continue
		superpulse
			icon='ships.dmi'
			icon_state="superpulse"
		eproj
			icon='ships.dmi'
			icon_state="eproj"
		pulse
			icon='ships.dmi'
			icon_state="pulse"
		gliders
			icon='ships.dmi'
			icon_state="gliders"
		bullets
			icon='ships.dmi'
			icon_state="bullets"
		Drone
			icon='ships.dmi'
			icon_state="Drone"
		asgardf
			icon='ships.dmi'
			icon_state="asgardf"
		red
			icon='ships.dmi'
			icon_state="red"
obj/var/attack1 = 0
obj/var/alive
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Weapon Procs///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
obj
	ships
		density=1
		icon='ships.dmi'
		var/ID //each ship should have a different ID
		var/space //changes when the user is in space
		var/locked //door lock
		var/shield=10000
		var/targ //shooting purposes
		var/zpawn //the spawn point
		var/attack //attack var, use to check to see if its already attacking
		var/dmg=10 //damage
		proc/attack()
			if(attack) return
			attack=1
			while(src)
				sleep(50)
				if(!targ)
					attack=0
					return
				if(targ in view(src))
					new/obj/Ship_Weapons/eproj(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
					continue
				attack=0
				return
		proc/attack1()
			if(attack) return
			attack=1
			while(src)
				sleep(50)
				if(targ in view(src))
					new/obj/Ship_Weapons(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
					continue
				attack=0
				return
		proc/attack2()
			if(attack) return
			attack=1
			while(src)
				sleep(50)

				if(!targ)
					attack=0
					return
				if(targ in view(src))
					new/obj/Ship_Weapons/pulse(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
					continue
				attack=0
				return
		proc/attack3()
			if(attack) return
			attack=1
			while(src)
				sleep(50)

				if(!targ)
					attack=0
					return
				if(targ in view(src))
					new/obj/Ship_Weapons/gliders(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
					continue
				attack=0
				return
		proc/attack4()
			if(attack) return
			attack=1
			while(src)
				sleep(50)

				if(!targ)
					attack=0
					return
				if(targ in view(src))
					new/obj/Ship_Weapons/bullets(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
					continue
				attack=0
				return
		proc/attack5()
			if(attack)
				attack=1
			while(src)
				sleep(50)
				if(!targ)
					attack=0
					return
				if(targ in view(src))
					new/obj/Ship_Weapons/Drone(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
					continue
				attack=0
				return
		proc/attack6()
			if(attack) return
			attack=1
			while(src)
				sleep(50)
				if(!targ)
					attack=0
				if(targ in view(src))
					new/obj/Ship_Weapons/asgardf(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
					continue
				attack=0
				return
		proc/attack7()
			if(attack) return
			attack=1
			while(src)
				sleep(50)
				if(!targ)
					attack=0
					return
				if(targ in view(src))
					new/obj/Ship_Weapons/red(targ)
					sleep(1)
				if(targ in view(src))
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
					sleep(1)
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(1)
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(3)
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				if(targ in view(src))
					sleep(2)
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
					sleep(3)
				if(targ in view(src))
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
					sleep(4)
				if(targ in view(src))
					new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
					continue
				attack=0
				return
mob
	var/fonty="<body bgcoloor=black><center><table border><tr><td align=center><font color=#555555>"
	var/endfonty="</td></tr></table></body>" //font vars are to make thing easier,,,
	proc
		weapons1()
			usr<<browse("[fonty]Scanning area for ships...[endfonty]","window=comm")
			var/ships
			var/found
			var/mob/ufo/s
			for(s in view(usr.ship))
				if(s==usr.ship) continue
				found+=1
				ships+="[s.name]-<a href='?src=\ref[src];type=comm1;name=[s.id*98]'>Communicate</a><br>\
						[s.name]-<a href='?src=\ref[src];type=attk1;name=[s.id*98]'>Attack</a><br><br>\
						[s.name]-<a href='?src=\ref[src];type=Rescan1;'>Rescan</a><br><br>"
			if(found)
				usr<<browse("[fonty][found] ships found.<br><br>[ships][endfonty]","window=comm")
				usr.client.eye=usr.ship
				usr.client.perspective=EYE_PERSPECTIVE
			else
				if(src in oview(1)) usr<<browse("[fonty]No ships were found.[endfonty]","window=comm")
				usr.client.eye=usr.ship
				usr.client.perspective=EYE_PERSPECTIVE
		Weapons3()
			usr << browse("[fonty]Scanning for Planets[endfonty]","window=comm")
			var/Ships
			var/Found
			var/obj/planets/P
			for(P in view(usr.ship, 10))
				Found += 1
				Ships += "[P.name]-<a href='?src=\ref[src];type=attkp'>Attack</a>"
mob/ufo
	proc/attack()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(!targ)
				attack=0
				return
			if(targ in view(src))
				new/obj/Ship_Weapons/eproj(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/eproj(targ,src.loc,src.dmg)
				continue
			attack=0
			return
	proc/attack1()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(targ in view(src))
				new/obj/Ship_Weapons/superpulse(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/superpulse(targ,src.loc,src.dmg)
				continue
			attack=0
			return
	proc/attack2()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(!targ)
				attack=0
				return
			if(targ in view(src))
				new/obj/Ship_Weapons/pulse(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/pulse(targ,src.loc,src.dmg)
				continue
			attack=0
			return
	proc/attack3()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(!targ)
				attack=0
				return
			if(targ in view(src))
				new/obj/Ship_Weapons/gliders(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/gliders(targ,src.loc,src.dmg)
				continue
			attack=0
			return
	proc/attack4()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(!targ)
				attack=0
				return
			if(targ in view(src))
				new/obj/Ship_Weapons/bullets(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/bullets(targ,src.loc,src.dmg)
				continue
			attack=0
			return
	proc/attack5()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(!targ)
				attack=0
				return
			if(targ in view(src))
				new/obj/Ship_Weapons/Drone(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/Drone(targ,src.loc,src.dmg)
				continue
			attack=0
			return
	proc/attack6()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(!targ)
				attack=0
				return
			if(targ in view(src))
				new/obj/Ship_Weapons/asgardf(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/asgardf(targ,src.loc,src.dmg)
				continue
			attack=0
			return
	proc/attack7()
		if(attack) return
		attack=1
		while(src)
			sleep(50)
			if(!targ)
				attack=0
				return
			if(targ in view(src))
				new/obj/Ship_Weapons/red(targ)
				sleep(1)
			if(targ in view(src))
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				sleep(1)
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(1)
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(3)
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
			if(targ in view(src))
				sleep(2)
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				sleep(3)
			if(targ in view(src))
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				sleep(4)
			if(targ in view(src))
				new/obj/Ship_Weapons/red(targ,src.loc,src.dmg)
				continue
			attack=0
			return