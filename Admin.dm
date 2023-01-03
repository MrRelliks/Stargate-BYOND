mob
	var
		oldhair = null
		oldicon= null
		oldbody = null
	proc
		Teleport(x as num, y as num, z as num) //Making it easier to teleport a user without repeating the code
			usr.oldhair = usr.hair
			usr.hair = null
			usr.oldbody = usr.body
			usr.body = null

			usr.Overlays()
			flick(/obj/teleport,usr)

			sleep(12)
			usr.loc=locate(x,y,z)
			usr.hair = usr.oldhair
			usr.body = usr.oldbody
			usr.Overlays()
turf
	Ascended
		dHigherPlane
			name = ""
			icon = 'Ascended.dmi'
			icon_state = "HigherPlane"
			plane = 98
			parent_type = /turf/
			mouse_opacity = FALSE
mob
	Ascended
		var
			isinvisible = 0

		verb
			Invisible()
				set category = "Ascended"
				set name = "Toggle Invisible"
				if(src.invisibility >= 1)
					src.icon = src.oldicon
					src.hair = src.oldhair
					src.Overlays()
					src.icon_state = null
					src.invisibility = 0
					src.see_invisible = 0
					src.overlays -= 'Icons/invisible.dmi'
				else
					src.oldicon = src.icon
					src.oldhair = src.hair
					src.hair = null

					src.icon_state = "invisible"
					src.Overlays()
					src.invisibility = 100
					src.see_invisible = 100
					src.overlays += 'Icons/invisible.dmi'
			Heal_Player(mob/M in range(10))
				if(!M.client) return
				if(M.race == "Tau'ri")
					M.hp = 100
				if(M.race == "Wraith")
					M.hp = 150
				else
					M.hp = 100
			ToggleIris()
				set category = "Ascended"
				set name = "Toggle Iris"
				for(var/obj/Pegasus_Gates/P in range(10))
					//var/IrisTarget = P.Target
					if(P.iris.icon_state == "closed")
						P.iris.open()
					else
						P.iris.close()
					//return


turf
	DblClick()
		if(usr.ckey in debug)
			usr.Teleport(src.x,src.y,src.z)

		else return
var

	list/WraithOnline=list()
	list/TauriOnline=list()

client
	New()
		if(!src.key in playerlist)
			playerlist += src.key
		..()
	Del()
		playerlist -= src.key

var

	list
		muted[0]
		jailed[0]
		mods[0]
		admins[0]
		banned=list()
		support[0]
		backup_slist = list()
		poo = list()
		rlock = list()
		debug=list("stargateoffic","drtimelord89","b4ssqontr0ler")
		staff_log=file("staff.log")
		iptracker=file("iplog.log")
		universe=file("universe.log")
		say=file("say.log")
		staff[0]
		messages = file("messages.txt")
		Updates
		gamerules
		motd
		rebootmessage

var/list/known = list()

staff/verb
	list_known_ips()
		set category = "Staff"
		var/html
		for(var/X in known)
			html+="[X] = [known[X]] <br>"
		usr<<browse(html)
obj
	teleport
		icon = 'teleport.dmi'
		plane = 100


staff
	var
		status = "Staff"
	verb
		Chat_Color()
			set category = "Staff"
			set name = "Change Chat Colour"
			var/new_rgb = input("What color would you like?") as color
			usr.chat_color = new_rgb
		Deadalus()
			set category = "Staff"
			set name = "Deadaelus Teleport"
			usr.Teleport(rand(43,53),rand(10,11),9)

		StaffGate()
			set category="Staff"
			set name="Activate Staff Gate"
			var/obj/Pegasus_Gates/S = locate() in range(50)
			for(var/obj/Pegasus_Gates/D in world)if(D.address=="1")S.Connect(D)
			sleep(20)
		Change_Race(X in playerlist)
			set category="Staff"
			set name = "Change Race"
			for(var/mob/M in world)
				if(M.ckey==ckey(X))
					var/switchto = input("Pick A Race") in list("Tau'ri","Wraith","Ascended","Cancel")
					switch(switchto)
						if("Tau'ri")
							var/gender = input("What Gender?") in list ("Male","Female")
							switch(gender)
								if("Male")
									var/whathair = input("What Hair Style would you like?") in list ("Mohawk","Scruffy","Bald")
									switch(whathair)
										if("Mohawk")
											var/new_rgb = input("What hair color would you like?") as color
											var/icon/I = new('Icons/newhair/Mohawk.dmi')
											I.icon *= new_rgb
											M.hair = null
											M.overlays+= M.hair
											M.hair = I
											M.Overlays()
										if("Scruffy")
											var/new_rgb = input("What hair color would you like?") as color
											var/icon/I = new('Icons/newhair/Scruffy.dmi')
											I.icon *= new_rgb
											M.hair = null
											M.overlays+= M.hair
											M.hair = I
											M.Overlays()
										if("Bald")
											M.hair = null
											M.Overlays()
											return
									M.icon = 'Icons/Mobs/male.dmi'
									M.race = "Tau'ri"
								if("Female")
									var/whathair = input("What Hair Style would you like?") in list ("Long Hair","Pony Tail","Bald")
									switch(whathair)
										if("Long Hair")
											var/new_rgb = input("What hair color would you like?") as color
											var/icon/I = new('Icons/mobs/femalehair2.dmi')
											I.icon *= new_rgb
											M.hair = null
											M.overlays+= M.hair
											M.hair = I
											M.Overlays()
										if("Pony Tail")
											var/new_rgb = input("What hair color would you like?") as color
											var/icon/I = new('Icons/newhair/Ponytail.dmi')
											I.icon *= new_rgb
											M.hair = null
											M.overlays+= M.hair
											M.hair = I
											M.Overlays()
										if("Bald")
											M.hair = null
											M.Overlays()
											return
									M.icon = 'Icons/Mobs/female.dmi'
									M.race = "Tau'ri"
							//X.icon = ''
						if("Wraith")
							var/gender = input("What Gender?") in list ("Male","Female")
							switch(gender)
								if("Male")
									M.icon = 'icons/mobs/wraith.dmi'
									M.race = "Wraith"
									M.hair = null
								if("Female")
									M.icon = 'icons/mobs/wraithfemale.dmi'
									M.race = "Wraith"
									var/new_rgb = input("What hair color would you like?") as color
									var/icon/I = new('Icons/mobs/femalehair2.dmi')
									I.icon *= new_rgb
									M.hair = null
									M.hair = I
									M.overlays+= M.hair
									M.Overlays()

						if("Ascended")
							if(!M.ckey in debug)
								src << "Only staff can be Ascended"
								return
							else
								var/gender = input("What Gender?") in list ("Male","Female")
								switch(gender)
									if("Male")
										var/whathair = input("What Hair Style would you like?") in list ("Mohawk","Scruffy","Bald")
										switch(whathair)
											if("Mohawk")
												var/new_rgb = input("What hair color would you like?") as color
												var/icon/I = new('Icons/newhair/Mohawk.dmi')
												I.icon *= new_rgb
												M.hair = null
												M.overlays+= M.hair
												M.hair = I
												M.Overlays()
											if("Scruffy")
												var/new_rgb = input("What hair color would you like?") as color
												var/icon/I = new('Icons/newhair/Scruffy.dmi')
												I.icon *= new_rgb
												M.hair = null
												M.overlays+= M.hair
												M.hair = I
												M.Overlays()
											if("Bald")
												M.hair = null
												M.Overlays()
												return
										M.icon = 'icons/mobs/MAscended.dmi'
										M.race = "Ascended"
										M.density = 0
										M.hp = 999999999999999999999999999999
									if("Female")
										var/whathair = input("What Hair Style would you like?") in list ("Long Hair","Pony Tail","Bald")
										switch(whathair)
											if("Long Hair")
												var/new_rgb = input("What hair color would you like?") as color
												var/icon/I = new('Icons/mobs/femalehair2.dmi')
												I.icon *= new_rgb
												M.hair = null
												M.overlays+= M.hair
												M.hair = I
												M.Overlays()
											if("Pony Tail")
												var/new_rgb = input("What hair color would you like?") as color
												var/icon/I = new('Icons/newhair/Ponytail.dmi')
												I.icon *= new_rgb
												M.hair = null
												M.overlays+= M.hair
												M.hair = I
												M.Overlays()
											if("Bald")
												M.hair = null
												M.Overlays()
												return
										M.icon = 'icons/mobs/FAscended.dmi'
										M.race = "Ascended"
										M.density = 0
										M.hp = 999999999999999999999999999999

							if("Cancel")
								return
		staffchat(msg as text|null)
			set category="Staff"
			set name = "Staffchat"

			if(!msg||msg==">"||msg=="> ")
				winshow(usr,"staffchat",1)
				return
			if(length(msg)>=300)msg=copytext(msg,1,300)
			msg=dd_replacetext(msg,"\n","")
			msg=html_encode(msg)//speechbubble2
			for(var/mob/S in world)
				if(S.staffchat)
					winshow(S,"staffchat",1)
					S<<output("<font color='[usr.chat_color]'><b> [usr.name] ([usr.status]) : </b>[msg]","staff_output")
					S<<sound('Sounds/discord-notification.mp3')
		GiveMedal(X in playerlist)
			set category = "Staff"
			set name = "Give Medal"
			var/givemedal = input("What medal would you like to award?") in list("GFX Artist","Staff Member","Cancel")
			switch(givemedal)
				if("Staff Member")
					world.SetMedal("Staff Member",X)//give them the medal

					//	src.medals("BETA Tester")//check for Login medals
					world << "[X] has been awarded the Staff Member Medal!"
				if("GFX Artist")
					world.SetMedal("GFX Artist",X)//give them the medal

					//	src.medals("BETA Tester")//check for Login medals
					world << "[X] has been awarded the GFX Artist Medal!"
				if("Cancel")
					return
		ServerReboot()
			set category="Staff"
			set name="Reboot Server"
			if(alert(usr,"Are you sure that you want to reboot the server?",,"No","Yes")=="Yes")
				var/reboot_message = input("Please put a reason for reboot","Reboot reason",rebootmessage)as null|message
				rebootmessage = reboot_message
				staff_log<<"[time2text(world.realtime)] - [usr.key]: used Reboot."
				world<< "<font color=\"#6ABB03\">System : Server is about to reboot. You will be logged out to prevent Save File corruption.</font><br><font color=\"#03BBB0\"><strong>Reason: [rebootmessage]</strong></font>"
				//world<<output("")
				sleep(30)
				for(var/mob/M in world)
					M << "<font color=\"#FF9B00\"><strong>Attention [M.name], Logging you out, to prevent SaveFile corruption. Please reconnect in 10 seconds.<strong></font>"
					sleep(20)
					M.Write()
					del(M)
					sleep(10)
					world.Reboot()
				sleep(10)
				world.Reboot()
		ServerShutdown()
			set category="Staff"
			set name="Shutdown Server"
			if(alert(usr,"Are you sure that you want to shutdown the server?",,"No","Yes")=="Yes")
				staff_log<<"[time2text(world.realtime)] - [usr.key]: used Shutdown.<br>"
				world<<output("<font color=\"#FFFFFF\">System : [usr.key] is shutting the server down.")
				sleep(10)
				world<<output( "<font color=\"#FFFFFF\">System : Server shutdown in 10 seconds.")
				sleep(50)
				world<<output( "<font color=\"#FFFFFF\">System : Server shutdown in 5 seconds.")
				sleep(20)
				world<<output("<font color=\"#FFFFFF\">System : Server shutdown in 3...")
				sleep(10)
				world<<output("<font color=\"#FFFFFF\">System : Server shutdown in 2...")
				sleep(10)
				world<<output("<font color=\"#FFFFFF\">System : Server shutdown in 1...")
				sleep(10)
				world<<output("<font color=\"#FFFFFF\">System : Server shutdown... now!")
				for(var/mob/M in world)
					M.Write()
					sleep(10)
					world.Del()

		Edit(atom/O in world)
			set category="Staff"
			var
				variable
				default
				typeof
				dir
				list/builtin=list(\
	"parent_type","animate_movement","pixel_step_size","screen_loc","contents","density","desc","dir","gender",\
	"icon","icon_state","infra_luminosity","invisibility","layer","loc","luminosity","mouse_drag_pointer",\
	"mouse_drop_pointer","mouse_drop_zone","mouse_opacity","mouse_over_pointer","name","opacity","overlays",\
	"pixel_x","pixel_y","suffix","text","underlays","verbs","visibility","x","y","z","vars","group",\
	"see_in_dark","see_invisible","see_infrared","key","ckey","client","sight","tag","type","suffix")
			switch(input(usr,"Please pick a category to edit.")as null|anything in list(\
	"Built-in Variables","Temporary Variables","Misc. Variables"))
				if("Built-in Variables")
					var/list/variables=list()
					for(var/X in O.vars)if(("[X]" in builtin))variables+=X
					variable=input(usr,"Select a variable to edit.")as null|anything in builtin
				if("Temporary Variables")
					var/list/variables=list()
					for(var/X in O.vars)if(!(issaved(O.vars[X]))&&!("[X]" in builtin))variables+=X
					variable=input(usr,"Select a variable to edit.")as null|anything in variables
				if("Misc. Variables")
					var/list/variables=list()
					for(var/X in O.vars)if((issaved(O.vars[X]))&&!("[X]" in builtin))variables+=X
					variable=input(usr,"Select a variable to edit.")as null|anything in variables
			if(!variable)return
			var/vname=variable
			variable=O.vars[vname]
			if(isnull(variable))
				default = "text"
			else if(isnum(variable))
				default = "num"
				dir = 1
			else if(istext(variable))default = "text"
			else if(isloc(variable))default = "reference"
			else if(isicon(variable))
				typeof = "\icon[typeof]"
				default = "icon"
			else if(istype(variable,/atom) || istype(variable,/datum))default = "type"
			else if(istype(variable,/list))default = "list"
			else if(isfile(variable))default = "file"
			var/class = input("Type: [default]\nCurrent Value: [variable]\nInitial: [initial(O.vars[vname])]\nDirection: [dir]\nWhat kind of variable?","Variable Type",default) as null|anything in list("text","num","type","reference","icon","file","list","null","Restore to default")

			if(!class)return
			switch(class)
				if("text")variable=input("Enter new text:",,variable)as null|text
				if("num")variable=input("Enter new number:",,variable)as null|num
				if("type")variable=input("Enter new type:",,variable)as null|anything in typesof(/obj,/mob,/area/,/turf)
				if("reference")variable=input("Enter new reference:",,variable)as null|anything in world

				if("icon")variable=input("Enter new icon:",,)as icon

				if("file")variable=input("Enter new file",,variable)as null|file
				if("list")
					var/x=input("Enter new list:",,dd_list2text(variable,";"))as null|text
					if(x)variable=dd_text2list(x,";")
				if("null")variable=null
				if("Restore to default")variable=initial(O.vars[vname])


			if(vname=="name")
				var/before = O.vars[vname]
				if(variable == null)
					variable = "Sorry, null name protection"
				O.vars[vname]=variable
				staff_log<<"[time2text(world.realtime)] - [usr] used edit to make [before]'s  [vname] = [variable]"
			if((vname == "icon"||vname == "icon_state")&&variable == null &&istype(O,/mob))

				//world<<output("[usr] has attempted to null thier icon/icon_state")
				usr.icon = initial(usr.icon)
				usr.icon_state = initial(usr.icon_state)
			else
				O.vars[vname]=variable
				staff_log<<"[time2text(world.realtime)] - [usr] used edit to make [O]'s  [vname] = [variable]"
		ChangeMOTD()
			set category = "Website"
			set name = "Change Login Message"
			var/new_message = input("Please input a new login message","New login message",motd)as null|message
			if(!new_message||new_message == motd) return
			motd = new_message
			usr << "New login message is , [motd]"
			SaveBans()

		Change_Updates()
			set category = "Website"
			set name = "Change Updates"
			var/new_update = input("Please input a new login message","New login message",Updates)as null|message
			if(!new_update||new_update == Updates) return
			Updates = new_update
			usr << "The Updates have been changed."
			SaveBans()



		Change_Rules()
			set category = "Website"
			set name = "Change Rules"
			var/new_rule = input("Please input a new login message","New login message",gamerules)as null|message
			if(!new_rule||new_rule == gamerules) return
			gamerules = new_rule
			usr << "The Rules have been changed."
			SaveBans()


		DialPegasus()
			set category = "Staff"
			set name = "Dial gates"
			var/list/gates = list()
			for(var/obj/Pegasus_Gates/G in world)
				gates +=G
			var/obj/Pegasus_Gates/T = input("Which gate") in gates|null
			if(T)T.Connect(input("Where would you like to dial?")in gates)


		Restore_Gates()
			set category = "Staff"
			set name = "Restore Stargates"
			for(var/obj/Pegasus_Gates/S in world)
				S.address = initial(S.address)
		CreateObject(O in typesof(/obj))
			set category="Staff"
			set name="Create Object"
			new O(usr.loc)


		CreateItemin(O in typesof(/obj/items)+typesof(/obj/items/ore),mob/D in world)
			set category = null
			set name="Create Object in someone"
			new O(D)

		CreateItem(O in typesof(/obj/items)+typesof(/obj/items/ore))
			set category="Staff"
			set name="Create Item"
			new O(usr)
		ShowIP(X in playerlist)
			set category="Staff"
			set name="Show IP"
			for(var/mob/M in world)
				if(M.ckey==ckey(X))


					usr.CreateAlert("[M]'s IP is: [M.client.address?"[M.client.address]":"127.0.0.1"]")
				//	usr << output("[M]'s IP is: [M.client.address?"[M.client.address]":"127.0.0.1"]","outputannounce")
				//	usr<<"[M]'s IP is: [M.client.address?"[M.client.address]":"127.0.0.1"]"


		Announce123()
			set category="Staff"
			set name="Make Announcement"

			var/msg = input("Announcement message","Announcement") as null|message
			if(!msg) return
			var/html = {"<h2>Announcement from [usr.key]</h2><br><strong>[msg] </strong>"}
			for(var/mob/M in world)
				if(M.client)
					M.CreateAlert(html)
						//	M << output(html,"outputannounce")



		GateTeleportPeg()
			set category="Staff"
			set name="Gate Teleport"
			var/list/gates[0]

			for(var/obj/Pegasus_Gates/O in world)
				gates+=O

			var/obj/Stargate/O=input("")as null|anything in gates
			if(!O) return
			if(O)
				usr.Teleport(O.x+1,O.y-2,O.z)



			//flick('Teleport.dmi',usr)// I got fed up from dieing using this verb
			//if(O)usr.loc=O.loc
			staff_log<<"[time2text(world.realtime)] - [usr.key]: teleported to [O] gate"
			//if(!debug.Find(usr.ckey))
			//	world<<output("<b><font color=red>System: [usr] has teleported to the [O] gate.</font></b>")


		Summon(X in playerlist)
			set name = "Summon"
			set category = "Staff"
			for(var/mob/M in world)
				if(M.ckey==ckey(X))
					M.oldhair = M.hair
					M.hair = null
					M.oldbody = M.body
					M.body = null
					M.Overlays()
					flick(/obj/teleport,M)

					sleep(12)

					M.loc= locate(usr.x,usr.y+1,usr.z)
					M.hair = M.oldhair
					M.body = M.oldbody
					M.Overlays()






					M << "You have been summoned by [usr.name]."

		TP(X in playerlist)
			set name = "Teleport"
			set category = "Staff"
			for(var/mob/M in world)
				if(M.ckey==ckey(X))
					usr.oldhair = usr.hair
					usr.hair = null
					usr.oldbody = usr.body
					usr.body = null
					usr.Overlays()
					flick(/obj/teleport,usr)

					sleep(12)
					usr.loc= locate(M.x,M.y-1,M.z)
					usr.hair = usr.oldhair
					usr.body = usr.oldbody
					usr.Overlays()




					//usr << "You have been summoned by [usr.name]."





		/*Teleport(X in playerlist)
			set name = "Teleport"
			set category = "Staff"
			if(X != src) // so they cant teleport to themself
				src.x = X:x
				src.y = X:y-1
				src.z = X:z
				src.dir = NORTH // face them
				X << "[src.name] magicly appears in front of you"*/
proc
	SaveBans()
		var/savefile/F = new("SaveFile/banned.dat")
		F["banned"] << banned
		var/savefile/M = new("SaveFile/motd.dat")
		M["motd"] << motd
		var/savefile/R =  new("SaveFile/Rules.dat")
		R["gamerules"] <<gamerules
		var/savefile/U =  new("SaveFile/Updates.dat")
		U["Updates"] <<Updates
		var/savefile/I =  new("SaveFile/IDs.dat")
		I["TakenIDs"] <<TakenIDs

		if(fexists("SaveFile/Debuglist"))
			var/savefile/S = new ("SaveFile/Debuglist")
			S["Debug"] <<debug
		if(world.name != initial(world.name))
			var/savefile/W = new("SaveFile/worldn.dat")
			W["name"] << world.name

		var/savefile/D=new("SaveFile/locked.dat")
		D["locked"]<<rlock
	LoadBans()
		var/savefile/F = new("SaveFile/banned.dat")
		if(F["banned"]) F["banned"] >> banned
		var/savefile/M = new("SaveFile/motd.dat")
		if(M["motd"]) M["motd"] >> motd
		//Check for Message of the day

		var/savefile/R =  new("SaveFile/Rules.dat")
		if(R["gamerules"]) R["gamerules"] >> gamerules

		var/savefile/I =  new("SaveFile/IDs.dat")
		if(I["TakenIDs"]) I["TakenIDs"] >> TakenIDs




		// Check for Game Rules
		var/savefile/U =  new("SaveFile/Updates.dat")
		if(U["Updates"]) U["Updates"] >> Updates