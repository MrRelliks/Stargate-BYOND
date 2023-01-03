
obj
	proc
		Connection(dial_address1 as text,galaxy as num, working as num)

			usr.Interact(src)
			if(working) return
			if(!locate(src) in range(usr,2))
				return
			if(!galaxy||!dial_address1)
				usr << "This system is not operational"
				return
			//viewers(src)<<sound("Sounds/gatemacro1.mp3")
			usr << "Activating gate macro dialing..."
			sleep(10)
			working = 1
			spawn(50)
				working = 0
			var/obj/Pegasus_Gates/S = locate() in range(50)
			for(var/obj/Pegasus_Gates/D in world)if(D.address==dial_address1)S.Connect(D)
			usr << "Iris Open, You may now step through"
			sleep(20)


obj
	GateMacros
		icon='Icons/SGC.dmi'
		var
			galaxy = 1
			dial_address = "1 1 1 1 1 1"
			charge=0
			tmp
				working = 0


		Console
			EarthToAtlantis
				icon_state = "earthatlantis"
				name = "Midway Station Console"
				density = 1
				dial_address = "1 1 1 1 1 1"
				DblClick()
					src.Connection(dial_address,galaxy,working)
			ToAtlantis
				icon_state = "earthatlantis"
				name = "Midway Station Console"
				density = 1
				dial_address = "1 2 3 4 5 6"
				DblClick()
					src.Connection(dial_address,galaxy,working)
			ToEarth
				icon_state = "earthatlantis"
				name = "Midway Station Console"
				density = 1
				dial_address = "3 4 5 6 7 8"

				DblClick()
					src.Connection(dial_address,galaxy,working)
			Atlantis2Earth
				icon_state = "atlantis2earth"
				name = "Midway Station Console"
				density = 1
				dial_address = "2 2 2 2 2 2"

				DblClick()
					src.Connection(dial_address,galaxy,working)