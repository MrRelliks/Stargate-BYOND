obj
	DHD_New
		var
			dialing = 0
		verb
			Dial()
				var/list/gates = list()
				for(var/obj/Stargate/G in world)
					gates +=G
				var/obj/Stargate/T = input("Which gate") in gates|null
				if(T)T.ConnectGate(input("Where would you like to dial?")in gates)


	Stargate
		var
			active = 0
			address_new = ""
			galaxy_zone = "Milky Way"
		proc
			ConnectGate()
				src.icon_state = "opening"
				sleep(5)
				src.icon_state = "open"
				src.active = 1