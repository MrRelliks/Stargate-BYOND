/*
Recoded by Killer22.
*/
atom
	var
		tmp
			backup
			old_name
			old_icon
			old_state
			old_density
			old_layer
			rep_mess

	proc
		Explosion_Damage()
			if(!backup)
				old_name = name
				old_icon = icon
				old_state = icon_state
				old_density = density
				old_layer = layer
				backup = 1
			icon = 'Icons/Explode/fire.dmi'
			density=0
			opacity=0
			layer= 10000000000000
			spawn(50)
				layer = 2
				icon = 'Icons/Explode/Dirt.dmi'
				icon_state=""
				name = "Wreckage"
				sleep(1200)
				if(!src)return
				if(backup)
					name = old_name
					icon = old_icon
					icon_state = old_state
					density = old_density
					layer = old_layer
					backup = 0
			..()

area
	antibomb

atom
	proc
		Explode(turf/T,range,atom/ow,ininventory,energy,fromweapon=0)
			for(var/atom/t in range(range,T))if(!(isarea(t)))
				if(istype(t,/obj/outfits/)||istype(t,/obj/Iris/)||istype(t,/obj/Chevrons/)||istype(t,/obj/Gate_Pieces/)||istype(t,/obj/DHD/)||istype(t,/obj/Stargate/)||istype(t,/obj/items/))continue
				if(ismob(t))
					var/gdist=get_dist(t,T)+1
					t:hp-=(200/gdist)
					t<<"You lose [200/gdist] health."
					if(t:hp<=0)t:die("was killed by [ow]'s explosion")
					continue
				else if(t.density)continue
				var/cont
				for(var/atom/x in range(get_dist(T,t),T))if(!ismob(x))if(get_dir(T,x)==get_dir(T,t)&&get_dist(T,x)<get_dist(T,t))if(x.density)
					cont=1
					break ..()
				if(cont) continue
				t.Explosion_Damage()
			..()
		Explode2(turf/T,range,mob/ow,ininventory,energy)
			var/owner = ow

			for(var/mob/M in world)
				if(M.z == T.z)
					if(!istype(M.loc.loc,/area/antibomb))
						M.die(owner,1,"World Nuke")