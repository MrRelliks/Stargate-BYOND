area
	nofight

mob/var/MELEEDELAY=0
obj/items/weapon
	var
		MeleePower = 0
		punchdelay = 0
var/image/zat_over=image('Icons/NewWeapons.dmi',icon_state = "zath")
obj/items/Ammo
	icon='Icons/NewWeapons.dmi'
	Rocket_Launcher
		name = "Rocket"
		icon_state = "Rocket_Launcherf"
	Energy_Cannon
		name = "Energy Cannon Crystal"
		icon_state = "Energy_CannonC"

mob
	var/armor
		..()
	proc
		Stunned(timer)
			if(is_stunned)return ..()
			is_stunned=1
			src << "You been Stunned"
			src.overlays += zat_over
			while(timer)
				sleep(10)
				timer--
				if(timer<=0)break ..()
			is_stunned=0
			src.overlays -= zat_over
			src << "You can move again"
			..()


var/invisimax  = 2
obj/var/BeamWeapon=0

obj/var/BeamProj=0
obj/var/body = /obj/Beams
obj/var/list/Beam = list()
mob/var
	firing=0
	poison = null
mob
	var
		tmp/is_stunned = 0



mob/verb/Fire()
	set hidden=1
	if(usr.weapon) usr.weapon.fire()



obj
	items
		weapon
			icon = 'Icons/NewWeapons.dmi'
			var
				tmp
					obj/items/weapon/proj
					fired = 0
					heat = 0
					maxheat = 10
					soundfile
					hitsound
					equipsound
					cooling = 0
					can_heat = 0
					all = 0
				range = 3
				multiplyer = 1
				firedelay = 3
				projdelay = 5
				Needammo = 0
				Givesoverlay = 0
				Whatoverlay = ""
			proc

				fire()
					if(!proj||fired) return
					if(usr)
						if(usr.is_stunned||usr.firing)return
						if(usr.loc)if(usr.loc.loc)if(istype(usr.loc.loc,/area/nofight))return


					fired = 1
					if(soundfile) if(usr)view(usr) << soundfile
					spawn(firedelay*5) if(src)fired = 0

					for(var/i = 0, i <= 16, i ++)
						if(!src)break
						if(!src.loc)break
						var/obj/d = new proj(step_x,loc,range,power,multiplyer,projdelay,hitsound)
						var/b = "[d.x][d.y][d.z]"
						d.dir = src.dir

						step(d,d.dir,2)
						var/a = "[d.x][d.y][d.z]"
						if(a == b) del(d)
				Cool()
					while(heat)
						sleep(10)
						suffix = "(Cooling: [src.heat])"
						heat--
					cooling = 0
					suffix = initial(src.suffix)
					owner << "[src.name] is cooled down."
			verb/Equip()

				if(usr.weapon==src)
					suffix=initial(suffix)

					usr.weapon=null
					if(src.Givesoverlay)
						usr.overlays -= Whatoverlay
					return
				if(usr.weapon)usr.weapon.suffix=initial(usr.weapon.suffix)
				usr.weapon=src

				if(equipsound)
					//volu = winget(usr,"Settings.volumebar","value")
					view(src.loc) << equipsound
				if(src.Givesoverlay)
					usr.overlays += Whatoverlay
				suffix+="Currently Using"




			p90
				icon_state = "p90"
				name = "P90"
				range = 10
				power = 5
				multiplyer = 2
				desc = "A weapon favoured by the Tau'ri"

				firedelay = 1.3
				projdelay = 2
				price = 2000
				Needammo = 1//P90 needs ammo

				MeleePower = 25
				punchdelay = 2
				//brace=list("Tau'ri")
				proj = /obj/items/projectile/p90
				Givesoverlay = 1

				soundfile = 'Sounds/P90-1.ogg'
				hitsound = 'Sounds/ric3.ogg'
				equipsound = 'Sounds/P90recharge.ogg'
			mp5
				icon_state = "mp5"
				name = "MP5"
				desc = "A weapon favoured by the Tau'ri"
				range = 10
				power = 3
				multiplyer = 2
				firedelay = 1
				projdelay = 2
				price = 2500

				MeleePower = 35
				punchdelay = 2
				Givesoverlay = 1

				//brace=list("Tau'ri")
				proj = /obj/items/projectile/mp5
				soundfile = 'Sounds/P90-1.ogg'
				hitsound = 'Sounds/ric3.ogg'
				equipsound = 'Sounds/P90recharge.ogg'

			zat
				icon_state = "zat"
				name="Zat'n'ikatel"
				range = 15
				power = 1
				desc = "A powerful weapon that can be used to stun your enemies!"
				multiplyer = 1
				firedelay = 2
				projdelay = 10
				can_heat = 1
				price = 3000
				MeleePower = 25
				punchdelay = 2
				Givesoverlay = 1

			//	BeamWeapon=1
				proj = /obj/items/projectile/zat
				soundfile = 'Sounds/tirzatb.ogg'
				hitsound = 'Sounds/zatimpact.ogg'
				equipsound = 'Sounds/zatdraw.ogg'

			wstunner
				icon_state = "wraithstunner"
				name="Wraith Stunner"
				range = 15
				power = 1
				desc = "A powerful weapon that can be used to stun your enemies!"
				multiplyer = 1
				firedelay = 2
				projdelay = 10
				can_heat = 1
				price = 3000
				MeleePower = 25
				punchdelay = 2
				Givesoverlay = 1

			//	BeamWeapon=1
				proj = /obj/items/projectile/wstunner
			//	soundfile = 'Sounds/tirzatb.ogg'
			//	hitsound = 'Sounds/zatimpact.ogg'
				//equipsound = 'Sounds/zatdraw.ogg'



			Wrifle
				icon_state = "wraith_rifle"
				name = "Wraith Rifle"
				range = 20
				power = 3
				multiplyer = 2
				firedelay = 3
				projdelay = 2.5
				desc = "A weapon favoured by Wraith Drone Warriors!"
				price = 5000
				//brace=list("wraith","Tok'ra","Goa'uld")
				MeleePower = 45
				punchdelay = 3
				Givesoverlay = 1

				proj = /obj/items/projectile/wrifle
				//soundfile = 'Sounds/staff2.wav'
				//hitsound = 'Sounds/staffhit_1.ogg'
				//equipsound = 'Sounds/staff1.ogg'








		projectile
			layer = MOB_LAYER-1
			icon='Icons/NewWeapons.dmi'
			density=1
			var/tmp/moved = 0
			var
				range = 1
				multiplyer = 1
				delay = 1
				energy
				beamcreator
				dmg=10
				stun
				explosiveroundrange
				tmp
					hashit = 0
					hitsound
			Bump(mob/M)
				if(ismob(M))
					if(M.safe)
						loc=M.loc
						return
					var/dmag=dmg
					if(explosiveroundrange)
						Explode(loc,explosiveroundrange,owner,0)
						del(src)
						return
					if(dmag)
						if(M.npc)
							//DO nothing
						else
							if(M.client)
								if(!BeamWeapon&&M.armor&&(prob(25))) dmag/=2
								M.hp-=dmag
								s_damage(M, dmag, "#FF0000")
								//new/obj/drops/Blood(M.loc)
								if(M.hp<=0)M.die()
								if(energy||dmg==dmag)if(!stun)del(src)
								else
									dmg-=5
									if(dmg<=0)dmg=5
							else // If it is an NPC or Attackable Monster
								if(!BeamWeapon&&M.armor&&(prob(25))) dmag/=2
								M.hp-=dmag
								s_damage(M, dmag, "#FF0000")
								//new/obj/drops/Blood(M.loc)
								M.attacked = 1

								if(M.hp<=0)
									owner.naquadah += M.naquadahgiven
									M.attacked = 0
									del(M)
								owner.kills += 1
								if(energy||dmg==dmag)if(!stun)del(src)
								else
									dmg-=5
									if(dmg<=0)dmg=5


					if(stun)
						loc=null
						M.Stunned(stun)
						del(src)

				else if(istype(M,/obj/crate/))
					if(hitsound)view(M)<<hitsound
					M.hp -= dmg
					s_damage(M, dmg, "#808000")
					if(M.hp <= 0)del(M)
					del(src)

				else if(energy)
					if(hitsound)view(M)<<hitsound
					del(src)
				else
					if(hitsound)view(M)<<hitsound
					dmg-=5
					if(dmg<=0)dmg=5
					walk(src,dir)
					del(src)
			New(location,mob/own,ran,pow,multi,pdelay,hsound,dire)
				src.loc = own.loc
				src.owner = own
				src.dir = own.dir
				hitsound = hsound
				var/turf/T=get_step(src,src.dir)
				if(!T) del(src)
				src.range = ran
				src.power = pow
				src.delay = pdelay
				src.multiplyer = multi
				walk(src,src.dir)
			Move()
				var/oloc=loc
				if(body)
					var/obj/O = new body(loc)
					O.dir=dir
				..()
				if(x==1||x==world.maxx||y==1||y==world.maxy)del(src)
				else if(energy) if(oloc==loc)del(src)
				if(src)
					range--
					if(range<=0)
						if(explosiveroundrange)
							Explode(loc,explosiveroundrange,owner,0)
							del(src)
							return
						else del(src)

			p90
				icon_state = "p90f"
				energy = 0
				dmg=10
				range = 5
				delay = 2
			mp5
				icon_state = "mp5f"
				energy = 0
				dmg=5
				range = 5
				delay = 2

			zat
				icon_state = "zatf"
				//BeamProj=1
				body = /obj/Beams/zatB
				//energy=1
				stun=40
				dmg = 0
				range = 5
				delay = 5
			wrifle
				icon_state = "wrifle_proj"
				dmg=3
				range = 5
				delay = 5
				//energy=1
			wstunner
				icon_state = "stunner_proj"
				//BeamProj=1
				//body = /obj/Beams/zatB
				//energy=1
				stun=40
				dmg = 0
				range = 5
				delay = 5




obj/Beams
	icon='Icons/NewWeapons.dmi'
	zatB
		name="Zats Stream Section"
		icon_state = "zatf"
	Laser
		name="Lasers Stream Section"
		icon_state = "laser"
	New()
		..()
		spawn(10)del(src)
obj
	drops
		//icon='destruction.dmi'
		Blood/name="blood"
		Metal/name="metal"
		New()
			..()
			icon_state="[lowertext(name)] [rand(1,3)]"
			pixel_y=rand(-16,16)
			pixel_x=rand(-16,16)
			spawn(300)del(src)