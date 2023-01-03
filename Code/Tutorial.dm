obj
	NPCMarker
		icon = 'Icons/tutover.dmi'
		icon_state = "help"
	//	pixel_y=32


		TestQuest
	ObjectMarker
		icon = 'Icons/tutover.dmi'
		icon_state = "object"

mob
	var
		Tut1 = 0
		Tut2 = 0
		Tut3 = 0
		Tut4 = 0
		Tut5 = 0
		tmp/MessageTut = ""

	Tutorial
		icon = 'Icons/tutmobs.dmi'
		icon_state = "SGC"
		density = 1
		npc = 1
		WelcomeTauri
			name = "Max - Welcome Tau'ri"
			MessageTut = "Hey there. Welcome, use the Gates List to dial earth You have a GDO in your Bag already!"
			DblClick()
				usr.Tut1 = 1
				usr.ShowTutWindow(MessageTut)


		Gateearth
			name = "Walter"
			icon_state = "general"
			MessageTut = "Ah hello there, The DHD computer is an amazing device ... it can input symbols that correspond to star systems in the galaxy, these symbols inputted correctly will take you to an array of worlds! ... why dont you dial 2,3,4,5,6,7 and go to Neutral to test it out, make sure you have a GDO to get back and use the HUD's Gate Icon if you need the address!!!"
			DblClick()
				if(src in view(1))
					usr.Tut2 = 1
					usr.ShowTutWindow(MessageTut)
				else
					return

		//DblClick()
		//	usr.ShowTutWindow(MessageTut)
mob/proc
	ShowTutWindow(MessageTut)
		if(src in view(1))
			if(!src.client)
				return
			else
				src << output(null, "outputtut")
				src << output(MessageTut, "outputtut")
				winset(src, "wintut", "is-visible=true")
		else
			return
	CloseTutWindow()
		src << output(null, "outputtut")
		winset(src, "wintut", "is-visible=false")
	CloseLogWindow()
		src << output(null, "output1")
		winset(src, "winlog", "is-visible=false")
	CloseQuest()
		src << output(null, "outputquest")
		src << output(null, "questtitle")
		winset(src, "winquest", "is-visible=false")

mob
	verb
		CloseWindowNowe438759872987979837938475()//This is to prevent this from being found
			set hidden = 1//Make's it invisible
			usr.CloseTutWindow()
		CloseWindowNew3w843897598372089nfyhe8rgf83w7()
			set hidden = 1
			usr.CloseLogWindow()
		Closequest999hhh8y4384323897434836874328736247326432076()
			set hidden = 1
			usr.CloseQuest()
