


mob
	var
		friends = list()
		friendssuffix = "Offline"
	verb
		AddFriend(X in playerlist)
			for(var/mob/M in world)
				if(!M in usr.friends)
					var/AddFriends = input("Are you sure you want to add [X] as a friend?") in list("Yes","No")
					switch(AddFriends)
						if("Yes")
							src.friends+=X
						if("No")
							return
		FriendsList()
			var/i=1
			for(var/mob/X in usr.friends)
				if(X in world)
					usr<<output(X.name,"friendslist.friends:1,[i]")
					X.friendssuffix = "Online"
					usr<<output(X.friendssuffix,"friendslist.friends:2,[i]")
				else
					return

				i++


		OpenBag()
			winset(src, "mainwindow.interface", "left=Inventory;")
		OpenSkills()
			winset(src, "mainwindow.interface", "left=Skills;")
		OpenFriends()
			winset(src, "mainwindow.interface", "left=friendslist;")
		OpenCommands()
			winset(src, "mainwindow.interface", "left=Commands;")

		PM(X in playerlist)

			var/newmessage = input("What do you want to say?") as text
			for(var/mob/M in world)
				if(M.ckey==ckey(X))

					src << "<font face='Arial' color=[usr.chat_color]>(PM) To [M.name] : [newmessage]</font>"
					M << "<font face='Arial' color=[usr.chat_color]>(PM) From [src.name] : [newmessage]</font>"
	proc

		UpdateStats()
			spawn(2)
			//Update Name
				src << output(null,"Skills.namelabel")
				src << output("[src.name]","Skills.namelabel")
			//Update Race
				src << output(null,"Skills.racelabel")
				src << output("[src.race]","Skills.racelabel")
			//Update Naquada
				src << output(null,"Skills.naquadalabel")
				src << output("[src.naquadah]","Skills.naquadalabel")

			//updateSkills

			//Mining Level
				src << output(null,"Skills.mininglvl")
				src << output("[src.MiningLevel]","Skills.mininglvl")
			//Mining XP
				src << output(null,"Skills.miningxp")
				src << output("[src.totalminingXP]","Skills.miningxp")
			//Mining Progress
				src << output(null,"Skills.miningprogress")
				src << output("[round((usr.MiningEXP/usr.MiningMaxEXP)*100,1)]%","Skills.miningprogress")




			//Smithing Level
				src << output(null,"Skills.smithinglvl")
				src << output("[src.SmithingLevel]","Skills.smithinglvl")
			//Smithing XP
				src << output(null,"Skills.smithingxp")
				src << output("[src.totalSmithingXP]","Skills.smithingxp")
			//Smithing Progress
				src << output(null,"Skills.smithingprogress")
				src << output("[round((usr.SmithingEXP/usr.SmithingMaxEXP)*100,1)]%","Skills.smithingprogress")

				sleep(10)

				UpdateStats()