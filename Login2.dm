mob
	proc
		ShowMedal(t as text)
			src<<output( null,{"MedalOutput"})
			src<<output( {"<b> You recieved the [t] medal!</b>"},{"MedalOutput"})
			winset(src, "mappane.medaltitle", "is-visible=true")
			winset(src, "mappane.MedalOutput", "is-visible=true")
			winset(src, "mappane.medalimage", "is-visible=true")
			sleep(100)
			winset(src, "mappane.medaltitle", "is-visible=false")
			winset(src, "mappane.MedalOutput", "is-visible=false")
			winset(src, "mappane.medalimage", "is-visible=false")


mob
	Login()
		//winset(src, "mainwindow.MapOutput", "left=mappane;")
		//src<<"Rofl, [src] has logged in! He's a noob!!!!"
	/*	while(!src.cansave)
			switch(input("What do you want to do?")in list("Load","Delete","Create"))
				if("Load")
					src.LoadC()
				if("Delete")
					src.DelC()
				if("Create")
					src.Create()*/
		//src.StartupStuff()
		..()

mob
	verb
		Load()
			src.LoadC()

		CreateNew()
			src.Create()
		Delete()
			src.DelC()


mob
	var
	//	Race
		Rank
		//Naquadah
		hair
		status = "Player"
		staffchat = 0
		staffmember = 0
		godmode = 0
		choosingtauri = 0
		choosingwraith = 0
		newname = ""
		atloginscreen = 0
		loggedin = 0
		firsttimelogin = 0



		volu = 10


	verb



		CheckOnline()
			set name = "Check Online Players"
			set category = "Commands"
			src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"
	proc
		ThemeMusic()
			if(src.atloginscreen)
				src<<sound('Sounds/ThemeSong.mp3',volume=10)
			//	sleep(2070)
		AdminCheck()
			for(var/mob/M in world)
				if(M.ckey in debug)
					M.staffchat = 1
					M.status = "Staff"
					M.verbs+=typesof(/staff/verb)
					M.verbs+=typesof(/mob/Ascended/verb)
					winset(src,"Menu.Admin","is-disabled = false")
				else
					M.staffchat = 0
					M.verbs-=typesof(/staff/verb)
					M.verbs-=typesof(/mob/Ascended/verb)
				//	winset(src,"Menu.Admin","is-disabled = true")

client
	Del()
		..()
		world<<output("<center><strong>([src.key]) has left the server!</strong></center>","Server")
		src.mob.SaveC()
		playerlist.Remove("[key]")
		del (mob)


mob
	Write(var/savefile/F)
		..()
		F["x"] << x
		F["y"] << y
		F["z"] << z

	Read(var/savefile/F)
		..()
		var/x
		var/y
		var/z
		F["x"] >> x
		F["y"] >> y
		F["z"] >> z
		loc = locate(x,y,z)

mob/var/tmp/cansave=0

mob
	Logout()
		if(playerlist.Find(src.key))playerlist.Remove("[key]")
	proc
		StartupStuff()
			src.AdminCheck()
			src.updateInventory()
			src.UpdateStats()
			src << "<center>[motd]</center>"
			src.client:screen+= new/obj/hud/b1//this gives you the black bar obj on your screen
			src.client:screen+= new/obj/hud/b2//this gives you the hud obj on your screen
			src.client:screen+= new/obj/hud/b3//this gives you the black bar obj on your screen
			src.client:screen+= new/obj/hud/b4
			src.client:screen+= new/obj/hud/b5
			src.client:screen+= new/obj/hud/b6
			//TOP
			src.client:screen+= new/obj/hud/t1
			src.client:screen+= new/obj/hud/t2
			src.client:screen+= new/obj/hud/t3
			src.client:screen+= new/obj/hud/t4
			src.client:screen+= new/obj/hud/t5
			src.client:screen+= new/obj/hud/t6

		SaveC()
			if(src.cansave)
				var/savefile/F=new("players/[src.key].sav")
				Write(F)
		LoadC()
			if(fexists("players/[src.key].sav"))
				var/savefile/F=new("players/[src.key].sav")
				Read(F)
				src<<"<center>Welcome back, [src.name].</center>"
				src.cansave=1
				src.StartupStuff()
				world<<output("<center><strong>([src.key])[src.name] has logged in!</strong></center>","Server")
				winset(src, "mainwindow.MapOutput", "left=mappane;")
				playerlist += src.key
			else
				src<<"You have no savefile"
		DelC()
			if(fexists("players/[src.key].sav"))
				var/conf=input("Are you sure you want to delete your savefile?")in list("Yes","No")
				if(conf=="Yes")
					fdel("players/[src.key].sav")
					src<<"Savefile deleted sucessfully"
				else
					src<<"Deleting cancelled."
			else
				src<<"You dont have a savefile!"
		Create()
			if(fexists("players/[src.key].sav"))
				src<<"Delete your old savefile first!"
				return
			var/creating=0
			while(!creating)
				usr.name=input("Input a name please.")as text|null
				creating=1
				if(!usr.name) creating=0
			src.cansave=1
			switch(input("Who do you want to play as?")in list("Tau'ri","Wraith"))
				if("Tau'ri")
					switch(input("Pick your gender & Ethnicity")in list("Male","Female"))
						if("Male")
							src.icon = 'Icons/Mobs/male.dmi'
							switch(input("Choose your hair Style")in list("Mohawk","Scruffy","Bald"))
								if("Mohawk")
									var/new_rgb = input("What hair color would you like?") as color
									var/icon/I = new('Icons/newhair/Mohawk.dmi')
									I.icon *= new_rgb
									src.overlays+= src.hair
									src.hair = I
									src.Overlays()
								if("Scruffy")
									var/new_rgb = input("What hair color would you like?") as color
									var/icon/I = new('Icons/newhair/Scruffy.dmi')
									I.icon *= new_rgb
									src.overlays+= src.hair
									src.hair = I
									src.Overlays()
								if("Bald")
									src.Overlays()
						if("Female")
							src.icon = 'Icons/Mobs/female.dmi'
							switch(input("Choose your hair Style")in list("Long Hair","Pony Tail","Bald"))
								if("Long Hair")
									var/new_rgb = input("What hair color would you like?") as color
									var/icon/I = new('Icons/mobs/femalehair.dmi')
									I.icon *= new_rgb
									src.overlays+= src.hair
									src.hair = I
									src.Overlays()
								if("Pony Tail")
									var/new_rgb = input("What hair color would you like?") as color
									var/icon/I = new('Icons/newhair/Ponytail.dmi')
									I.icon *= new_rgb
									src.overlays+= src.hair
									src.hair = I
									src.Overlays()
								if("Bald")
								//	src.overlays+= src.hair
									src.hair = null
									src.Overlays()







					src.contents+=new/obj/outfits/SGC
					src.contents+=new/obj/outfits/helmets/SGC
					src.loc=locate(67,66,7)
					src.race = "Tau'ri"
					src.hp = 100
					M_Ranking(src)
					S_Ranking(src)
					src.naquadah = 400
					world.SetMedal("I guess she's an XBOX, I'm more Tau'ri",src)


					winset(src, "mainwindow.MapOutput", "left=mappane;")
					world<<output("<center><strong>([src.key]) has joined the Tau'ri!</strong></center>","Server")
					var/welcome = "Welcome to Stargate BYOND. To interact with Objects and NPC's hit Space or Enter buttons on your keyboard"
					src.CreateAlert(welcome)

					src.StartupStuff()
					src.ShowMedal("I guess she's an XBOX, I'm more Tau'ri")


				if("Wraith")
					switch(input("Pick your gender & Ethnicity")in list("Male","Female"))
						if("Male")
							src.icon = 'icons/mobs/wraith.dmi'
						if("Female")
							src.icon = 'icons/mobs/wraithfemale.dmi'
							var/new_rgb = input("What hair color would you like?") as color
							var/icon/I = new('Icons/mobs/femalehair.dmi')
							I.icon *= new_rgb
							src.overlays+= src.hair
							src.hair = I
							src.Overlays()


					src.loc=locate(55,63,4)
					src.race = "Wraith"
					src.hp = 150
					src.loggedin = 1
					world.SetMedal("I'm the Baaaaad Guy",src)
					world << "[src.name] has unlocked the Medal : I'm the Baaaaad Guy "



					world.SetMedal("BETA Tester",src)//give them the medal
										//	src.medals("BETA Tester")//check for Login medals
					world << "[src.name] has unlocked the BETA Tester Medal"
					src.contents+=new/obj/outfits/Wraith
					src.contents+=new/obj/outfits/helmets/WraithMask
					world<<output("<center><strong>([src.key]) has joined the Wraith!</strong></center>","Server")
					winset(src, "mainwindow.MapOutput", "left=mappane;")
					var/welcome = "Welcome to Stargate BYOND. To interact with Objects and NPC's hit Space or Enter buttons on your keyboard"
					src.CreateAlert(welcome)

					src.StartupStuff()
					src.ShowMedal("I'm the Baaaaad Guy")


