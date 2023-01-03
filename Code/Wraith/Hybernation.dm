area
	Wraith
		hybernation

obj
	Wraith
		Hybernation_Pod
			//icon = ''
			name = "Wraith Hibernation Pod"
mob
	Wraith
		verb
			Hybernate()
				if(istype(src.loc.loc,/area/Wraith/hybernation))
					src.issleeping = 1
					return