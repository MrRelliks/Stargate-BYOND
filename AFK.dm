
Client
	New()
		..()
		Afker()
		return
	proc
		Afker()
			while(usr.client)
				if(usr.client.inactivity>=5)
					if(usr.AFK == 0)
						usr.AFK = 1
						usr.safe = 1
						usr << "You are now AFK"
						usr.overlays+= 'Icons/AFK.dmi'
						usr.AFKLabel = "Away"
						usr.density = 0
				else
					if(usr.AFK == 1)
						return


mob
	var
		playerlevel
		totallevel
		AFK = 0
		AFKLabel = "Online"
		AFKOverlay = 'Icons/AFK.dmi'


	verb
		AFK()
			set name = "Go AFK"
			set category = "Commands"
			if(src.AFK == 0)
				src.AFK = 1
				src.safe = 1
				src.density = 0
				src << "You are now AFK"
				src.overlays+= AFKOverlay
				src.AFKLabel = "Away"
				src.move = 0
			else
				src.AFK = 0
				src.density = 1
				src.safe = 1
				src << "You are no longer AFK"
				src.overlays-= AFKOverlay
				src.AFKLabel = "Online"
				src.move = 1
