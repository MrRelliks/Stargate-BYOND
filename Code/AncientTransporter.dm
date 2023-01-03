obj
	Site_2_Site_Transporter
		icon = 'Icons/AtTrans.dmi'
		icon_state = "closed"
		name = "Lantean Transporter"
		density = 1
		var
			Super = null
			Password = null
			name2 = "Unknown"


		DblClick()
			..()
			if(usr in orange(src,1))
				if(src.icon_state == "closed")
					src.icon_state = "opening"
					sleep(6)
					src.icon_state = "open"

				else
					src.icon_state = "closing"
					sleep(6)
					src.icon_state = "closed"
				if(src.Password)
					var/g = input("What's the password?") as text
					if(g != src.Password)
						usr<<"<b>Password incorrect.</b>"
						return
				var/list/Sites = list()
				for(var/obj/Site_2_Site_Transporter/S in world)
					if(S.z == src.z && src != S || src.Super && src != S)
						Sites.Add("[S.name2] \[[S.x],[S.y],[S.z]\]")
				var/S = input("Where to?") as null|anything in Sites
				if(!S)
					return
				var/obj/Site_2_Site_Transporter/Site
				for(var/obj/Site_2_Site_Transporter/O in world)
					if("[O.name2] \[[O.x],[O.y],[O.z]\]" == S)
						Site = O
				if(!Site)
					return
				if(Site.Password)
					var/g = input("What's the password?") as text
					if(g != Site.Password)
						usr<<"<b>Password incorrect.</b>"
						return
				/*if(usr.z !=Site.z)
					usr.die("Site to Site teleporter scrambling [gender==MALE?"his":"[gender==FEMALE?"hers":"thier's"]"] molecules")

				else
					usr.loc = locate(Site.x,Site.y-1,Site.z)*/
				//if(usr.x!=src.x&&usr.y!=src.y-1&&usr.z!=src.z)
				if(!(usr in orange(src,1)))
					usr << "Your to far away to use that"
					return
					//usr.die("Site to Site teleporter scrambling [gender==MALE?"his":"[gender==FEMALE?"hers":"thier's"]"] molecules")
				else
					usr.loc = locate(Site.x,Site.y-1,Site.z)
					if(usr.loc == null)
						usr.loc = Site.loc
						Site.icon_state = "closing"
						sleep(6)
						Site.icon_state = "closed"
						src.icon_state = "closing"
						sleep(6)
						src.icon_state = "closed"