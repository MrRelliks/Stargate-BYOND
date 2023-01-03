obj
	ufos
		Ships
			Ship_hatch
				//icon = 'Icons/Glider.dmi'
				icon_state = "hatch"
				name = "Hatch"
				var
					id
					mob/ufo/Ships
				New()
					..()
					spawn()
						var/mob/ufo/Ships/M
						for(M in world)
							if(M.id == id && istype(M,/mob/ufo/Ships))
								Ships = M
								M.hatch = src
				Click()
					if(src in oview(1))
						if(Ships && Ships.loc)
							if(Ships.space)
								usr<<output( {"<font color=red><b>System: </b></font>You cant leave a ship while in space."},{"Player"})
								usr << "<font color=red><b>System: </b></font>You cant leave a ship while in space."
								return
							else
								usr.loc = Ships.loc
				Prom/id=1
				baalhatack/id=5
				Ori1/id=4
				anubishatack/id=6