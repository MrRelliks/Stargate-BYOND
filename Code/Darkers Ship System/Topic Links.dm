client/Topic(href,href_list[])
	if(href_list["type"]=="comm1")
		var/com = input("What is your message?")as text
		var/mob/ufo/M
		var/mob/U
		for(M in world)
			if(M.id*98 == text2num(href_list["name"]))
				if(M in view(usr.ship))
					for(U in world)
						if(U.ship == M)
							M << "<font color=black><b>Communications: [usr] : [html_encode(com)].</b></font>"
	if(href_list["type"]=="attk1")
		var/mob/ufo/S
		for(S in world)
			if(S.id*98 == text2num(href_list["name"]))
				if(!usr.ship) return
				if(!usr) return
				if(!usr.ship.loc) return
				if(!usr.ship.attack1)
					if(!usr.ship) return
					usr.ship.targ = S
					usr.ship.attack()
				if(usr.ship.attack1==2)
					usr.ship.targ = S
					if(!usr.ship) return
					usr.ship.attack1()
				if(usr.ship.attack1==3)
					usr.ship.targ = S
					if(!usr.ship) return
					usr.ship.attack2()
				if(usr.ship.attack1==4)
					usr.ship.targ = S
					if(!usr.ship) return
					usr.ship.attack3()
				if(usr.ship.attack1==5)
					usr.ship.targ = S
					if(!usr.ship) return
					usr.ship.attack4()
				if(usr.ship.attack1==6)
					usr.ship.targ = S
					if(!usr.ship) return
					usr.ship.attack5()
				if(usr.ship.attack1==7)
					usr.ship.targ = S
					if(!usr.ship) return
					usr.ship.attack6()
				if(usr.ship.attack1==8)
					usr.ship.targ = S
					if(!usr.ship) return
					usr.ship.attack7()
	if(href_list["type"]=="Rescan1")
		var/mob/ufo/S
		for(S in world)
			usr.weapons1()
	if(href=="lock1")
		if(usr.ship.locked)
			usr.ship.locked=0
		else
			usr.ship.locked=1
		usr<<browse(null,"window=system")
	..()