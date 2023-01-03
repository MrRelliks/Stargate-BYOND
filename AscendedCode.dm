/*
        New Ascension Code      */

mob

ancient/
	verb/
		Ancient_dial()
			set name = "Ancient Teledial"
			set category = "Commands"
			var/list/gates = list()
			for(var/obj/Stargate/G in world)
				if(!G.private)
					gates +=G
			var/obj/Stargate/gate_dial = input("Where would you like to dial?")in gates
			var/obj/Stargate/O = locate() in orange()//what is the closest gate?
			if(O)
				if(O.incomming || O.outgoing)
					usr << "The current gate is busy"
				else
					if(gate_dial.incomming || gate_dial.outgoing)
						usr << "Gate Failed to connect"
					else
						O.Connect(gate_dial)
			else
				usr << "No gate nearby"


		TakeHumanForm()
			set name = "Take Human Form"
			set category = "Commands"
			usr.density = 1
			usr.icon = 'Icons/Mobs/Male.dmi'
		TakeAscendedForm()
			set name = "Take Ascended Form"
			set category = "Commands"
			usr.density = 0
			usr.icon = 'Icons/Mobs/Ascended.dmi'

		HideSelf()
			set name = "Hide Self"
			set category = "Commands"
			usr.invisibility = 100

		RevealSelf()
			set name = "Reveal Self"
			set category = "Commands"
			usr.invisibility = 0


