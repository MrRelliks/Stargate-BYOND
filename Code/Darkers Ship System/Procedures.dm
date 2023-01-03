mob
	ufo
		New()
			. = ..()
			src.zspawn = src.loc
		Del()
			return ..()
		Read()
			return
		Write()
			return
mob
	proc
		ZSpawn()
			src.loc = src.zspawn
			usr.ship.shield = usr.ship.shieldM
			var/turf/ufos/glider/Space/S
			if(isturf(S))
				usr.ship.space = 1
			else
				usr.ship.space = 0