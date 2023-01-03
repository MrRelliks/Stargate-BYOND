


mob
	proc
		Color_Checker()
			if(src.key == "stargateoffic")
				src.chat_color = "#528b00"


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
					M.verbs+=typesof(/staff/verb)
					M.verbs+=typesof(/mob/Ascended/verb)
					winset(src,"Menu.Admin","is-disabled = false")
				else
					M.verbs-=typesof(/staff/verb)
					M.verbs-=typesof(/mob/Ascended/verb)
				//	winset(src,"Menu.Admin","is-disabled = true")




	Login()
		//Welcome()
		..()
		if(!src.client)
			return
		else
			iptracker<<"[src.key] >> [src.client.address?"[src.client.address]":"127.0.0.1"]"
			src.loc = null
			winset(src, "Settings.volumebar", "value=[src.volu]");
			src.atloginscreen = 1

			//src.ThemeMusic()
			playerlist += src.key
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
			AdminCheck()
			for(var/mob/M in world)
				if(M.ckey in debug)
					M.staffchat = 1
					M.chat_color = "#8b9304"
					M.unlockedpegasus = 1
					if(M.ckey == "stargateoffic")
						M.chat_color = "#e50d0d"
				else
					return
	Logout()
		TauriOnline -= src.key
		WraithOnline -= src.key
	//	world << "[src.name]([src.key]) Logged out!"
		//src.SaveMob()

	verb
		QuitGame()
			usr << "Saving your character."
			usr.SaveMob()
			usr << "character saved."
			world<<output("<center><strong>([src.key]) has left the server!</strong></center>","Server")
			usr << "Logging out in 1 second(s)"
			sleep(10)
			winset(src, null, "command = .quit")
		FixMyLogin()
			winset(src, "mainwindow.MapOutput", "left=Login;")
			src << "Press ''Create New'' again and you should be able to log in, press yes when it says delete save."

		LoadCharacter()
			src.Load()


		DeleteCharacter()
			src.Delete()

		NewLogin()
			if(fexists("savefile/[src.ckey].sav"))
				var/CharacterExists = input("You already have a Save File, Do you want to delete it and create a new character?") in list ("Yes","No")
				switch(CharacterExists)
					if("Yes")
						winset(src, "mainwindow.MapOutput", "left=chooserace;")
						fdel("savefile/[src.ckey].sav")//deletes the save file, plain and simple lol
						//var/savefile/F=new("savefile/[src.ckey].sav") // creates a new save file
						//src.Write(F) // writes your variables/lists onto it
						AdminCheck()

					if("No")
						winset(src, "mainwindow.MapOutput", "left=Login;")
						return
			else

				winset(src, "mainwindow.MapOutput", "left=chooserace;")




		ChooseGenderMale()
			var/pickethnicity = input("Please pick your ethnicity") in list ("White","Black")
			switch(pickethnicity)
				if("White")
					src.icon = 'Icons/Mobs/male.dmi'
					winset(src, "mainwindow.MapOutput", "left=ChooseHair;")
				if("Black")
					src.icon = 'Icons/Mobs/Black.dmi'
					winset(src, "mainwindow.MapOutput", "left=ChooseHair;")
		ChooseGenderFeMale()
			var/pickethnicitywoman = input("Please pick your ethnicity") in list ("White","Black")
			switch(pickethnicitywoman)
				if("White")
					src.icon = 'Icons/Mobs/female.dmi'
					winset(src, "mainwindow.MapOutput", "left=ChooseHairFemale;")
				if("Black")
					src.icon = 'Icons/Mobs/FemaleBlack.dmi'
					winset(src, "mainwindow.MapOutput", "left=ChooseHairFemale;")
		ChooseHairMohawk()
			var/new_rgb = input("What hair color would you like?") as color
			var/icon/I = new('Icons/newhair/Mohawk.dmi')
			I.icon *= new_rgb
			src.overlays+= src.hair
			src.hair = I
			src.Overlays()
			sleep(10)
			src.RaceChecker()
			winset(src, "mainwindow.MapOutput", "left=mappane;")


		ChooseHairScruffy()
			var/new_rgb = input("What hair color would you like?") as color
			var/icon/I = new('Icons/newhair/Scruffy.dmi')
			I.icon *= new_rgb
			src.overlays+= src.hair
			src.hair = I
			src.Overlays()
			sleep(10)
			src.RaceChecker()
			winset(src, "mainwindow.MapOutput", "left=mappane;")

		/////////WOMAN//////
		ChooseHairLong()
			var/new_rgb = input("What hair color would you like?") as color
			var/icon/I = new('Icons/mobs/femalehair.dmi')
			I.icon *= new_rgb
			src.overlays+= src.hair
			src.hair = I
			src.Overlays()
			src.RaceChecker()
			winset(src, "mainwindow.MapOutput", "left=mappane;")

		ChooseBald()
			src.hair = null
			src.Overlays()
			src.RaceChecker()
			winset(src, "mainwindow.MapOutput", "left=mappane;")



		ChooseHairPonyTail()
			var/new_rgb = input("What hair color would you like?") as color
			var/icon/I = new('Icons/newhair/Ponytail.dmi')
			I.icon *= new_rgb
			src.overlays+= src.hair
			src.hair = I
			src.Overlays()
			src.RaceChecker()

		ChooseWraithFemale()
			var/new_rgb = input("What hair color would you like?") as color
			var/icon/I = new('Icons/mobs/femalehair.dmi')
			I.icon *= new_rgb
			src.overlays+= src.hair
			src.hair = I
			src.Overlays()
		//	src.RaceChecker()
			winset(src, "mainwindow.MapOutput", "left=mappane;")
		//	winset(src, "mainwindow.MapOutput", "left=mappane;")
			M_Ranking(src)
			S_Ranking(src)
			src<<sound(null)
					//	usr.loc = null
			winset(src, "mainwindow.MapOutput", "left=mappane;")
			src.icon = 'icons/mobs/wraithfemale.dmi'
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

			world<<output("<center><strong>[src.name]([src.key]) has logged in!</strong></center>","Server")

						//world << "<center><strong>[src.name]([src.key]) has logged in!</strong></center>"
						//src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"
			src << "<center>[motd]</center>"
			src.updateInventory()

			src.step_size = src.base_speed
			AdminCheck()
			WraithOnline += src.key
			src.Color_Checker()
			world.loop_save(1)

		ChooseWraithMale()
			winset(src, "mainwindow.MapOutput", "left=mappane;")
		//	winset(src, "mainwindow.MapOutput", "left=mappane;")
			M_Ranking(src)
			S_Ranking(src)
			src<<sound(null)
					//	usr.loc = null
			winset(src, "mainwindow.MapOutput", "left=mappane;")
			src.icon = 'icons/mobs/wraith.dmi'
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

			world<<output("<center><strong>[src.name]([src.key]) has logged in!</strong></center>","Server")


						//world << "<center><strong>[src.name]([src.key]) has logged in!</strong></center>"
						//src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"
			src << "<center>[motd]</center>"
			src.updateInventory()

			src.step_size = src.base_speed
			AdminCheck()
			WraithOnline += src.key
			src.Color_Checker()
			world.loop_save(1)


		Choosewraith()
			if(fexists("savefile/[src.ckey].sav"))//if an existing save file exists in the folder located in the game folder
				var/AreYouSureTauri = input("You already have a Save File, Do you want to delete it and create a new character?") in list ("Yes","No")
				switch(AreYouSureTauri)
					if("Yes")
						fdel("savefile/[src.ckey].sav")//deletes the save file, plain and simple lol
						src << "Deleted Old Save ... Creating New Character ..."
						src.choosingtauri = 1
						src.choosingwraith = 0
						src.race = "Wraith"
					//	src.RaceChecker()
					//	winset(src, "mainwindow.MapOutput", "left=mappane;")
						winset(src, "mainwindow.MapOutput", "left=ChooseGenderWraith;")
					if("No")
						winset(src, "mainwindow.MapOutput", "left=Login;")
						return
			var/n_name
			while(!n_name||length(n_name)>21)
				if(!n_name)
					var/choose = input("Please select the name of your character: (Please don't use name from the show without permission)",,"[key]")
					if(choose)
						n_name = html_encode(choose)
						n_name=dd_replacetext(n_name,"\n","")
						src.name = n_name
						winset(src, "mainwindow.MapOutput", "left=ChooseGenderWraith;")

				else
					var/choose = input("Too long of a name \n Please select the name of your character: (Please don't use name from the show without permission)",,"[key]")
					if(choose)
						n_name = html_encode(choose)
						n_name=dd_replacetext(n_name,"\n","")






		Choosetauri()
			if(fexists("savefile/[src.ckey].sav"))//if an existing save file exists in the folder located in the game folder
				var/AreYouSureTauri = input("You already have a Save File, Do you want to delete it and create a new character?") in list ("Yes","No")
				switch(AreYouSureTauri)
					if("Yes")
						fdel("savefile/[src.ckey].sav")//deletes the save file, plain and simple lol
						src << "Deleted Old Save ... Creating New Character ..."
						src.choosingtauri = 1
						src.choosingwraith = 0
						src.race = "Tau'ri"
					//	src.RaceChecker()
					//	winset(src, "mainwindow.MapOutput", "left=mappane;")
						winset(src, "mainwindow.MapOutput", "left=ChooseGender;")
					if("No")
						winset(src, "mainwindow.MapOutput", "left=Login;")
						return
			var/n_name
			while(!n_name||length(n_name)>21)
				if(!n_name)
					var/choose = input("Please select the name of your character: (Please don't use name from the show without permission)",,"[key]")
					if(choose)
						n_name = html_encode(choose)
						n_name=dd_replacetext(n_name,"\n","")
						src.name = n_name
						winset(src, "mainwindow.MapOutput", "left=ChooseGender;")

				else
					var/choose = input("Too long of a name \n Please select the name of your character: (Please don't use name from the show without permission)",,"[key]")
					if(choose)
						n_name = html_encode(choose)
						n_name=dd_replacetext(n_name,"\n","")
		RaceChecker()
			var/favouritecolor = input("Pick your favourite color") in list ("Green","Blue","Red", "Yellow")
			switch(favouritecolor)
				if("Green")
					src.contents+=new/obj/outfits/SGC
					src.contents+=new/obj/outfits/helmets/SGC
					src.loc=locate(67,35,5)
					src.race = "Tau'ri"
					src.hp = 100
					M_Ranking(src)
					S_Ranking(src)
					src.naquadah = 400
					winset(src, "mainwindow.MapOutput", "left=mappane;")
					//src.loc=locate(261,264,2)

					src.step_size = src.base_speed
					src.Color_Checker()
					AdminCheck()
					world.loop_save(1)
					TauriOnline += src.key
					src.loggedin = 1
					src<<sound(null)
					src.updateInventory()
					world.SetMedal("I guess she's an XBOX, I'm more Tau'ri",src)
					world << "[src.name] has unlocked the Medal: Godspeed!!!"
					world.SetMedal("BETA Tester",src)//give them the medal						//	src.medals("BETA Tester")//check for Login medals
					world << "[src.name] has unlocked the BETA Tester Medal"


					world<<output("<center><strong>[src.name]([src.key]) has logged in!</strong></center>","Server")
					//src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"

					src << "<center>[motd]</center>"
				//SHOWHUD()
				if("Blue")
					src.contents+=new/obj/outfits/SGCBlue
					src.contents+=new/obj/outfits/helmets/SGCBlue
					src.loc=locate(67,35,5)
					src.race = "Tau'ri"
					src.hp = 100
					M_Ranking(src)
					S_Ranking(src)
					src.naquadah = 400
					winset(src, "mainwindow.MapOutput", "left=mappane;")
					//src.loc=locate(261,264,2)

					src.step_size = src.base_speed
					src.Color_Checker()
					AdminCheck()
					world.loop_save(1)
					TauriOnline += src.key
					src.loggedin = 1
					src<<sound(null)
					src.updateInventory()
					world.SetMedal("I guess she's an XBOX, I'm more Tau'ri",src)
					world << "[src.name] has unlocked the Medal: Godspeed!!!"
					world.SetMedal("BETA Tester",src)//give them the medal						//	src.medals("BETA Tester")//check for Login medals
					world << "[src.name] has unlocked the BETA Tester Medal"


					world<<output("<center><strong>[src.name]([src.key]) has logged in!</strong></center>","Server")
					//src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"

					src << "<center>[motd]</center>"
				//SHOWHUD()
				if("Red")
					src.contents+=new/obj/outfits/SGCRed
					src.contents+=new/obj/outfits/helmets/SGCRed
					src.loc=locate(67,35,5)
					src.race = "Tau'ri"
					src.hp = 100
					M_Ranking(src)
					S_Ranking(src)
					src.naquadah = 400
					winset(src, "mainwindow.MapOutput", "left=mappane;")
					//src.loc=locate(261,264,2)

					src.step_size = src.base_speed
					src.Color_Checker()
					AdminCheck()
					world.loop_save(1)
					TauriOnline += src.key
					src.loggedin = 1
					src<<sound(null)
					src.updateInventory()
					world.SetMedal("I guess she's an XBOX, I'm more Tau'ri",src)
					world << "[src.name] has unlocked the Medal: Godspeed!!!"
					world.SetMedal("BETA Tester",src)//give them the medal						//	src.medals("BETA Tester")//check for Login medals
					world << "[src.name] has unlocked the BETA Tester Medal"


					world<<output("<center><strong>[src.name]([src.key]) has logged in!</strong></center>","Server")
					//src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"

					src << "<center>[motd]</center>"
				//SHOWHUD()
				if("Yellow")
					src.contents+=new/obj/outfits/SGCYellow
					src.contents+=new/obj/outfits/helmets/SGCYellow
					src.loc=locate(67,35,5)
					src.race = "Tau'ri"
					src.hp = 100
					M_Ranking(src)
					S_Ranking(src)
					src.naquadah = 400
					winset(src, "mainwindow.MapOutput", "left=mappane;")
					//src.loc=locate(261,264,2)

					src.step_size = src.base_speed
					src.Color_Checker()
					AdminCheck()
					world.loop_save(1)
					TauriOnline += src.key
					src.loggedin = 1
					src<<sound(null)
					src.updateInventory()
					world.SetMedal("I guess she's an XBOX, I'm more Tau'ri",src)
					world << "[src.name] has unlocked the Medal: Godspeed!!!"
					world.SetMedal("BETA Tester",src)//give them the medal						//	src.medals("BETA Tester")//check for Login medals
					world << "[src.name] has unlocked the BETA Tester Medal"


					world<<output("<center><strong>[src.name]([src.key]) has logged in!</strong></center>","Server")
					//src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"

					src << "<center>[motd]</center>"
				//SHOWHUD()












		SaveMob()
			fdel("savefile/[src.ckey].sav") // deletes the old save file
			var/savefile/F=new("savefile/[src.ckey].sav") // creates a new save file
			src.Write(F) // writes your variables/lists onto it
			F["lastx"] << src.x //saves your x coord
			F["lasty"] << src.y //saves your y coord
			F["lastz"] << src.z //saves your z coord




		Load()
			if(fexists("savefile/[src.ckey].sav"))//if an existing save file exists in the folder located in the game folder
				var/savefile/F=new("savefile/[src.ckey].sav") // it creates a new save file
				src.Read(F) //it reads it
				var/newX
				var/newY
				var/newZ

				F["lastx"] >> newX//it takes the lastx variable in the save and puts it into the newx variable
				F["lasty"] >> newY//same as above with a new variable
				F["lastz"] >> newZ//same as above with a new variable
				src.loc=locate(newX,newY,newZ)//makes the player located in those locations
			//	sleep(20)
				//src << "Welcome Back to Stargate BYOND" //outputs message to the user
				//src << "<center>There are currently <strong><font color=#B50A0A>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>"

				src << "[motd]"
				src.updateInventory()
				world<<output("<center><strong>[src.name]([src.key]) has logged in!</strong></center>","Server")

			//	world << "<center><strong>[src.name]([src.key]) has logged in!</strong></center>"
				src.Overlays()
				M_Ranking(src)
				S_Ranking(src)
				src.Color_Checker()
				src.step_size = src.base_speed
				AdminCheck()

				winset(src, "mainwindow.MapOutput", "left=mappane;")
				//src.LoginSkillCheck()
				//src.MiningProductionIron()
				src.loggedin = 1
				src<<sound(null)
				//MiningProductionNaq()

			else //if no save file was found
				//	src << "Welcome to A Heroes Adventure!" //outputs message to the user
				src << "No Save File found"
				winset(src, "mainwindow.MapOutput", "left=Login;")
				src.atloginscreen = 1
				//Welcome()


		Delete()
			fdel("savefile/[src.ckey].sav")//deletes the save file, plain and simple lol
			src << "DELETED"
			winset(src, "mainwindow.MapOutput", "left=Login;")
			//Welcome()


//now many ppl have had troubles making auto saving in their game, ITS SO EASY!

client
	Del()//when the client is deleted
		..()
		del (mob)//delete the mob *NOTE* always make sure to delete the mob AFTER you saved it
