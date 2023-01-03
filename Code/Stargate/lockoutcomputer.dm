obj/console/lockoutcompy
	name = "Lockout Computer"
	icon = 'Icons/sgc_computer.dmi'
	icon_state = "dnascanner"
	var
		locked = list("Hell")
		users = list("")
		drank = 0
	Del()
		var/savefile/F=new("SaveFile/lockoutcompy/[x]_[y]_[z].sav")
		Write(F)
		..()
	New()
		..()
		if(fexists("SaveFile/lockoutcompy/[x]_[y]_[z].sav"))
			var/savefile/F=new("SaveFile/lockoutcompy/[x]_[y]_[z].sav")
			Read(F)

	proc
		save()
			var/savefile/F=new("SaveFile/lockoutcompy/[x]_[y]_[z].sav")
			Write(F)

		load()
			if(fexists("SaveFile/lockoutcompy/[x]_[y]_[z].sav"))
				var/savefile/F=new("SaveFile/lockoutcompy/[x]_[y]_[z].sav")
				Read(F)
	DblClick()
		if(usr.playerlevel >= 15)
			switch(input("What do you want to do?")in list("Add Trusted User","Unlock a gate","Lockout a Gate","Cancel"))
				if("Cancel")return
				if("Unlock a gate")
					var/list/locked2 = locked
					locked2 += "Cancel"
					var/D = input ("What gate to unblock?") in locked2
					if(D!="Cancel")
						locked -= D
						usr<<"Gate [D] unlocked"
					save()
				if("Lockout a Gate")
					var/planets = list()
					for(var/obj/Stargate/H in world)
						if(!H.private)
							if(!(H.name in locked))
								planets += H.name
					planets +="Cancel"
					var/D = input ("What gate to lock?") in planets
					if(D!="Cancel")
						locked += D
						usr<<"Gate [D] locked"
					save()
				if("Add Trusted User")
					var/D = input("Enter the KEY of the user?") as text|null
					if(D)
						users += D
						usr<<"Key [D] now added"
					save()
	proc
		islocked(var/gatename)
			if(gatename in locked)
				return TRUE
			return FALSE
		isrank(var/rank)
			if(rank<=drank)
				return TRUE
			return FALSE