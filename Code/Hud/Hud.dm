

//Hud Variables

//Top Layer = 16,2 - 16,7
// Bottom Layer = 15,2 - 15,7

var
	TakenIDs = list()
mob
	var
		PlayerID
		galaxychoice
	proc
		PlayerIDCheck()
			if(usr.PlayerID in TakenIDs)
				usr.PlayerID = rand(11000,99999)
			else
				return
mob/proc
	ShowWebsite()
		if(!src.client)
			return
		else
			winset(src, "website", "is-visible=true")
	HideWebsite()
		winset(src, "website", "is-visible=false")

mob
	verb
		CloseWebsite1()
			set
				hidden = 1
			src.HideWebsite()

mob/proc
	ShowScores()
		if(!src.client)
			return
		else
			winset(src, "Scores", "is-visible=true")
	HideScores()
		winset(src, "Scores", "is-visible=false")

mob
	verb
		CloseScores()
			set
				hidden = 1
			src.HideScores()





mob
	proc
		SHOWHUD(mob/M in world)
			M.client:screen+= new/obj/hud/b1//this gives you the black bar obj on your screen
			M.client:screen+= new/obj/hud/b2//this gives you the hud obj on your screen
			M.client:screen+= new/obj/hud/b3//this gives you the black bar obj on your screen
			M.client:screen+= new/obj/hud/b4
			M.client:screen+= new/obj/hud/b5
			M.client:screen+= new/obj/hud/b6
			//TOP
			M.client:screen+= new/obj/hud/t1
			M.client:screen+= new/obj/hud/t2
			M.client:screen+= new/obj/hud/t3
			M.client:screen+= new/obj/hud/t4
			M.client:screen+= new/obj/hud/t5
			M.client:screen+= new/obj/hud/t6

obj/hud/a1
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="a1"//this is the obj's icon_state
	screen_loc="1,17"//this is the obj's screen location
	plane = 110

obj/hud/a2
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="a2"//this is the obj's icon_state
	screen_loc="2,17"//this is the obj's screen location
	plane = 1100
obj/hud/a3
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="a3"//this is the obj's icon_state
	screen_loc="3,17"//this is the obj's screen location
	plane = 110
	DblClick()
		usr.ShowWebsite()
		usr<<link("byond://?sgo=gateaddress")

obj/hud/at2
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="at2"//this is the obj's icon_state
	screen_loc="2,18"//this is the obj's screen location
	plane = 110
obj/hud/b1
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="b1"//this is the obj's icon_state
	screen_loc="1,17"//this is the obj's screen location
	plane = 110

obj/hud/b2
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="b2"//this is the obj's icon_state
	screen_loc="2,17"//this is the obj's screen location
	plane = 110
obj/hud/b3
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="b3"//this is the obj's icon_state
	screen_loc="3,17"//this is the obj's screen location
	desc = "Gate addresses for the server"
	plane = 110
	DblClick()
		usr.ShowWebsite()
		usr<<link("byond://?sgo=gateaddress")

obj/hud/b4
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="b4"//this is the obj's icon_state
	screen_loc="4,17"//this is the obj's screen location
	plane = 110
	DblClick()
		usr.ShowWebsite()
		usr<<link("byond://?sgo=archive")
obj/hud/b5
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="b5"//this is the obj's icon_state
	screen_loc="5,17"//this is the obj's screen location
	plane = 110

obj/hud/b6
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="b6"//this is the obj's icon_state
	screen_loc="6,17"//this is the obj's screen location
	plane = 110
	DblClick()
		//usr.ShowWebsite()
		//usr<<link("byond://?sgo=Quests")
		usr.ShowScores()
		usr<<link("byond://?score=ranks_mine")
//TOP
obj/hud/t1
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="t1"//this is the obj's icon_state
	screen_loc="1,18"//this is the obj's screen location
	plane = 110

obj/hud/t2
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="t2"//this is the obj's icon_state
	screen_loc="2,18"//this is the obj's screen location
	plane = 110
obj/hud/t3
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="t3"//this is the obj's icon_state
	screen_loc="3,18"//this is the obj's screen location
	plane = 110
obj/hud/t4
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="t4"//this is the obj's icon_state
	screen_loc="4,18"//this is the obj's screen location
	plane = 110
obj/hud/t5
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="t5"//this is the obj's icon_state
	screen_loc="5,18"//this is the obj's screen location
	plane = 110
obj/hud/t6
	icon='SGOHud.dmi'//this makes the obj's icon
	icon_state="t6"//this is the obj's icon_state
	screen_loc="6,18"//this is the obj's screen location
	plane = 110


obj
	SGOHUD
		name = "SGO Hud"
		icon = 'SGOHud.dmi'
		layer =MOB_LAYER

		b1
			//icon='Macro_Hud.dmi'
			icon_state = "b1"
			New(client/c)
				screen_loc="15,2"
				c.screen+=src
		b2
		//	icon='Macro_Hud.dmi'
			icon_state = "b2"
			New(client/c)
				screen_loc="15,3"
				c.screen+=src
		b3
			//icon='Macro_Hud.dmi'
			icon_state = "b3"
			New(client/c)
				screen_loc="15,4"
				c.screen+=src
		b4
			//icon='Macro_Hud.dmi'
			icon_state = "b4"
			New(client/c)
				screen_loc="15,5"
				c.screen+=src
		b5
			//icon='Macro_Hud.dmi'
			icon_state = "b5"
			New(client/c)
				screen_loc="15,6"
				c.screen+=src
		b6
			//icon='Macro_Hud.dmi'
			icon_state = "b6"
			New(client/c)
				screen_loc="15,7"
				c.screen+=src

client
	 var/obj/SGOHUD = new()









