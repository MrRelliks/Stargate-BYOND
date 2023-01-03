turf/ship/
	icon = 'Icons/turfs2.dmi'
	stairs
		icon_state = "stairs"
obj/ship/
	icon = 'Icons/turfs2.dmi'
	var/ID
	door
		icon_state = "door"
		Click()
			if(src in oview(1))
				if(icon_state=="door")
					icon_state="closed"
					density=1
				else
					icon_state="door"
					density=0
	forcefield
		icon_state = "forcefield"
		density=1
		ID=1
		name = "Force Field"
	forcefieldpanel
		icon_state = "on"
		ID=1
		name = "Force Field Panel"
		DblClick()
			var/obj/ship/forcefield/f
			if(src in oview(1)) if(usr.dir==get_dir(usr,src))
				for(f in oview(20, src))
					if(f.ID==src.ID)
						if(f.icon_state=="forcefield")
							src.icon_state="off"
							f.icon_state="forceopen"
							f.density=0
						else
							src.icon_state="on"
							f.icon_state="forcefield"
							f.density=1
						continue
					continue
	ForceFields
		Panel
			icon_state = "on"
			name = "Force Field Panel"
			ID = 1
			DblClick()
				var/obj/ship/ForceFields/Shield/S
				if(src in oview(1))
					if(usr.dir == get_dir(usr, src))
						for(S in oview(20, src))
							if(S.ID == src.ID)
								if(S.icon_state == "forcefield")
									src.icon_state = "off"
									S.icon_state = "forceopen"
									S.density = 0
								else
									src.icon_state = "on"
									S.icon_state = "forcefield"
									S.density = 1
							return
		Shield
			icon_state = "forcefield"
			density = 1
			ID = 1
			name = "Force Field"