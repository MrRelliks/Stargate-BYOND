proc
	dont_get_stuck(mob/mob)
		if(!mob.ckey in jailed)
			var/turf/T2
			if(mob.loc)
				T2 = mob.loc.loc
				if(T2.density)
					var/gate = 0
					for(var/obj/Stargate/S in world)
						if(!S.private)
							if(S._iris < 3)
								if(S.z == mob.z)
									if(gate == 0)
										gate = 1
										mob.loc = locate (S.x,(S.y-3),S.z)
					if(!gate)
						gate = 0
						for(var/obj/Stargate/G in world)
							if(G.name == "Centropolis")
								mob.loc = locate (G.x,(G.y-3),G.z)
								gate = 1
					if(!gate)
						mob.loc = locate (50,50,2)
					mob << "[mob.name], the Asgard saved you."
			else
				mob << "[mob.name] you will need to Suicide or Relog to fix your self."