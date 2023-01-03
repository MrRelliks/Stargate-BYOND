turf
	invisible
		name = "No Entry"
		density = 1
		layer = 99
	Moon
		icon = 'Icons/Moon.dmi'
obj

//	icon='Icons/Icons/Turfs.dmi'


	door
		name="Door"
		var
			times=8*2
			ld = 0
			tmp/opening=0
		DblClick()
			if(src in oview(1))
				toggle()
				//world << "click"
		proc/open()
			icon_state="closed"
		//	ld=0
		proc/close()
			if(icon_state=="open")
				flick("closing",src)
				density=1
				sleep(times)
				icon_state="closed"
				for(var/mob/M in src.loc)
					M.die("being crushed by a door during lockdown")
			ld=1
		proc/toggle()
			//if(ld==1)return
			if(opening)return
			opening=1
			if(icon_state=="open")
				flick("closing",src)
				density=1
				sleep(times)
				icon_state="closed"
				for(var/mob/M in src.loc)
					M.die("being crushed by a door")
			else if(icon_state=="closed")
				flick("opening",src)
				sleep(times)
				density=0
				icon_state="open"
			opening=0


		Gate_Door
			icon='Icons/SGC.dmi'
			icon_state="closed"
			density = 1
			//races = list("Tau'ri")
		Jail_Door
			icon='Icons/SGCJail.dmi'
			icon_state="closed"
			density = 1
			//races = list("Tau'ri")
		Atlantis
			icon = 'Bass/Various Doors.dmi'
			door1
				icon_state = "door1close"

				density = 1
				layer = 51
			door1_blue
				icon = 'Bass/atlantis_blue.dmi'// to all other door's stats just erase close and use opening / closing / open
				icon_state = "closed"
				density = 1
				layer = 51
			door1_green
				icon = 'Bass/altantis_green.dmi'
				icon_state = "closed"
				density = 1
				layer = 51
			door1_grey
				icon = 'Bass/atlantis_grey.dmi'
				icon_state = "closed"
				density = 1
				layer = 51
			blastdoor1
				icon = 'Bass/atlantis_blast.dmi'
				icon_state = "closed"
				density = 1
		Wraith
			icon = 'Bass/wraithdoor.dmi'
			door1
				icon_state = "closed"
				density = 1
				layer = 51
turf
	Stargate
	//	WormHole
		//	icon = 'PNG/wormhole.gif'

		Holder_Right
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "topright"
			layer = 13
			density = 1
		BottomLeftHolder
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "bottomleftholder"
			layer = 13
			density = 1
		BottomRightHolder
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "bottomrightholder"
			layer = 13
			density = 1
		Holder_Left
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "topleft"
			layer = 13
			density = 1
		Holder_Right_Bottom
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "bottomright"
			layer = 13
			density = 1
		Holder_Left_Bottom
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "bottomleft"
			layer = 13
			density = 1
		Holder_Top_Left
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "maintopleft"
			layer = 13
			density = 1
		Holder_Top_Right
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "maintopright"
			layer = 13
			density = 1
		ConnectorBottom
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "connector"
			layer = 13
			density = 1
		Connectortop
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "topconnector"
			layer = 13
			density = 1

		Wall
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "wall"
			density = 1

		Wall2
			icon = 'Icons/Stargate/Holder.dmi'
			icon_state = "wall2"
			density = 1
		WallDecor1
			icon_state = "WallDecor1"
			density = 1
		WallDecor2
			icon_state = "WallDecor2"
			density = 1
		WallDecor21
			icon_state = "WallDecor2.1"
			density = 1
		WallDecor22
			icon_state = "WallDecor2.2"
			density = 1
		WallDecor3
			icon_state = "WallDecor3"
			density = 1
		WallDecor4
			icon_state = "WallDecor4"
			density = 1
		WallDecor5
			icon_state = "WallDecor5"
			density = 1
		WallDecor6
			icon_state = "WallDecor6"
			density = 1
		file1
			icon_state = "file1"
			density = 1
		file2
			icon_state = "file2"
			density = 1
		file3
			icon_state = "file3"
			density = 1
		file4
			icon_state = "file4"
			density = 1

turf
	NewSGC
		icon = 'Icons/NewSGC.dmi'
		LeftBit
			icon_state = "1"
			density = 1
		LeftMainBit
			icon_state = "2"
			density = 1
		MiddleBit
			icon_state = "3"
			density = 1
		RightBitMain
			icon_state = "4"
			density = 1
		LeftBitYellow
			icon_state = "5"
			density = 1
		MiddleBitYellow
			icon_state = "6"
			density = 1
		RightBitYellow
			icon_state = "7"
			density = 1
	SGCTable
		icon = 'Icons/SGC.dmi'
		SGCtabledown
			icon_state = "SGCtabledown"
			density = 1
		SGCtableup
			icon_state = "SGCtableup"
			density = 1
		SGCtableright
			icon_state = "SGCtableright"
			density = 1
		SGCtableleft
			icon_state = "SGCtableleft"
			density = 1
		SGCtablemiddledown
			icon_state = "SGCtablemiddledown"
			density = 1
		SGCtablemiddle
			icon_state = "SGCtablemiddle"
			density = 1
	StargateCommand
		icon = 'Icons/SGC.dmi'
		Poster
			poster1
				icon_state = "poster1"
				density = 1
			poster2
				icon_state = "poster2"
				density = 1
			poster3
				icon_state = "poster3"
				density = 1
			poster4
				icon_state = "poster4"
				density = 1



		Holder
			TopLeft1
				icon_state = "topleft1"
				density = 1
				layer = 13
			TopLeft2
				icon_state = "topleft2"
				density = 1
				layer = 13
			middleleft
				icon_state = "middleleft"
				density = 1
				layer = 13
			middleleft1
				icon_state = "middleleft1"
				density = 1
				layer = 13
			middleleft2
				icon_state = "middleleft2"
				density = 1
				layer = 13
			bottomleft1
				icon_state = "bottomleft1"
				density = 1
				layer = 13
			bottomleft2
				icon_state = "bottomleft2"
				density = 1
				layer = 13
			bottomleft3
				icon_state = "bottomleft3"
				density = 1
				layer = 13

			Topright1
				icon_state = "topright1"
				density = 1
				layer = 13
			Topright2
				icon_state = "topright2"
				density = 1
				layer = 13
			middleright
				icon_state = "middleright1"
				density = 1
				layer = 13
			middleright1
				icon_state = "middleright2"
				density = 1
				layer = 13
			middleright2
				icon_state = "middleright"
				density = 1
				layer = 13
			secondmiddle1
				icon_state = "secondmiddle1"
				density = 1
				layer = 13
			secondmiddle2
				icon_state = "secondmiddle2"
				density = 1
				layer = 13
			bottomright1
				icon_state = "bottomright1"
				density = 1
				layer = 13
			bottomright2
				icon_state = "bottomright2"
				density = 1
				layer = 13


		Wall1
			icon_state = "wall"
			density = 1
		Wall4
			icon_state = "wall4"
			density = 1

		Wall3
			icon_state = "wall3"
			density = 1
		Wall2
			icon_state = "wall2"
			density = 1
		GateWall
			icon_state = "gatewall"
			density = 1
		GateWall1
			icon_state = "gatewall1"
			density = 1
		DestinationDisplay
			icon_state = "destdisplay"
			density = 1
		eleccabin4
			icon_state = "eleccabin4"
			density = 1
		eleccabin3
			icon_state = "eleccabin3"
			density = 1
		Generator
			icon_state = "Generator"
			density = 1
		PowerBox
			icon_state = "powerbox"
			density = 1
		Box1top
			icon_state = "box1top"
			density = 1
		Box1bottom
			icon_state = "box1bottom"
			density = 1
		Floor
			icon_state = "floor"

		FloorDec1
			icon_state = "FP1"

		FloorDec2
			icon_state = "FP2"

		FloorDec3
			icon_state = "FP3"

		FloorDec4
			icon_state = "FP4"

		FloorDec5
			icon_state = "FP5"

		FloorDec6
			icon_state = "FP6"

		FloorDec7
			icon_state = "FP7"

		FloorDec8
			icon_state = "FP8"
		TableTop1
			icon_state = "tabletop1"
			density = 1
		TableTop2
			icon_state = "tabletop2"
			density = 1
		TableTop3
			icon_state = "tabletop3"
			density = 1
		TableBottom1
			icon_state = "tablebottom1"
			density = 1
		TableBottom2
			icon_state = "tablebottom2"
			density = 1
		TableBottom3
			icon_state = "tablebottom3"
			density = 1
		Radio
			icon_state = "radio"
			density = 1
		gateStairsleft
			icon_state = "gatestairsleft"
		gateStairsmiddle
			icon_state = "gatestairsmiddle"
		gateStairsright
			icon_state = "gatestairsright"
		st1
			icon_state = "st1"
		st2
			icon_state = "st2"
		st3
			icon_state = "st3"

		stright
			icon_state = "stright"

		StairsTop
			icon_state = "StairsTop"
			density = 1
		StairsTopLeft
			icon_state = "StairsTopLeft"
			density = 1
		StairsMiddleLeft
			icon_state = "StairsMiddleLeft"
			density = 1
		StairsBottomLeft
			icon_state = "BottomLeft"
			density = 1
		StairsMiddle
			icon_state = "StairsMiddle"
			density = 1
		StairsBottom
			icon_state = "StairsBottom"
		SGCBadge
			icon_state = "sgcbadge"
			density = 1
		UpArrow
			icon_state = "Up"
			Entered(mob/M)
				M.loc = locate(86,17,1)
				M.dir = NORTH
		DownArrow
			icon_state = "Down"
			Entered(mob/M)
				M.loc = locate(65,49,1)
				M.dir = NORTH

		Chair
			icon_state = "chair"
			layer = MOB_LAYER+4
		Divider
			icon_state = "DIVIDER"
			density = 1

		Stairs_Center
			icon_state = "stairs center"
		window1
			icon_state = "window1"
			density = 1
		window2
			icon_state = "window2"
			density = 1
		window3
			icon_state = "window3"
			density = 1
		window4
			icon_state = "window4"
			density = 1
		window5
			icon_state = "window5"
			density = 1
		window26
			icon_state = "window6"
			density = 1
		Broken1
			icon_state = "broken1"
			density = 1
		Broken2
			icon_state = "broken2"
			density = 1
		Broken3
			icon_state = "broken3"
			density = 1
		Computer1
			icon_state = "Computer1"
			density = 1
		Computer2
			icon_state = "Computer2"
			density = 1
		Computer3
			icon_state = "Computer3"
			density = 1
		Computer4
			icon_state = "Computer4"
			density = 1
		WallDecor1
			icon_state = "WallDecor1"
			density = 1
		WallDecor2
			icon_state = "WallDecor2"
			density = 1
		WallDecor21
			icon_state = "WallDecor2.1"
			density = 1
		WallDecor22
			icon_state = "WallDecor2.2"
			density = 1
		WallDecor3
			icon_state = "WallDecor3"
			density = 1
		WallDecor4
			icon_state = "WallDecor4"
			density = 1
		WallDecor5
			icon_state = "WallDecor5"
			density = 1
		WallDecor6
			icon_state = "WallDecor6"
			density = 1
		file1
			icon_state = "file1"
			density = 1
		file2
			icon_state = "file2"
			density = 1
		file3
			icon_state = "file3"
			density = 1
		file4
			icon_state = "file4"
			density = 1

obj
	icon = 'Icons/SGC.dmi'
	Alarms/sirens
		New()
			..()


		layer = 99
		icon = 'Icons/SGC.dmi'
		icon_state = "alarmoff"


obj
	lockdown_door
		icon='Icons/SGC.dmi'
		icon_state="door"
	//	var/used=0
		density = 1



