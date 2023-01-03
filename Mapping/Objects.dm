obj
	Stargate
		icon='Icons/Stargate/center.dmi'
		icon_state="X"

obj
	DHD
		density=1
		icon='Icons/DHD/dhd.dmi'
		icon_state="0"
		name = "Dial Home Device"

obj
	icon = 'Icons/SGC.dmi'
	Alarms/sirens
		New()
			..()


		layer = 99
		icon = 'Icons/SGC.dmi'
		icon_state = "alarmoff"

obj
	NPCMarker
		icon = 'Icons/tutover.dmi'
		icon_state = "help"
	//	pixel_y=32


		TestQuest
	ObjectMarker
		icon = 'Icons/tutover.dmi'
		icon_state = "object"

obj
	Site_2_Site_Transporter
		icon = 'Icons/AtTrans.dmi'
		icon_state = "closed"
		name = "Lantean Transporter"
		density = 1


obj/console/Atlantis_iriscontrol_manual
	var
		hp
	icon='Icons/AtlantisTurfs.dmi'
	icon_state="console2"
	hp = 1000

obj/console/Desk_iriscontrol_manual
	var
		hp
	icon='Icons/SGC.dmi'
	icon_state="irisconsole"
	hp = 1000

obj/console/iriscontrol_manual
	var
		hp
	icon='Icons/SGC.dmi'
	icon_state


obj
	door
		Jail_Door
			icon='Icons/SGCJail.dmi'
			icon_state="closed"
			density = 1
		Atlantis
			icon = 'Bass/Various Doors.dmi'
			door1
				icon_state = "door1close"
				density = 1
				layer = 51
			door1_blue
				icon_state = "door1blueclose"// to all other door's stats just erase close and use opening / closing / open
				density = 1
				layer = 51
			door1_green
				icon_state = "door1greenclose"
				density = 1
				layer = 51
			door1_grey
				icon_state = "door1greyclose"
				density = 1
				layer = 51
			blastdoor1
				icon_state = "door1sideclose"
				density = 1
		Wraith
			icon = 'Bass/Various Doors.dmi'
			door1
				icon_state = "wraithdoor1close"
				density = 1
				layer = 51
obj
	lockdown_door
		icon='Icons/SGC.dmi'
		icon_state="door"
	//	var/used=0
		density = 1
obj
	rock
		icon='Code/Skills/MiningObjects.dmi'
		density=1
		var/canmine
		var/res = 20
		var/timetomine
		var/lvlrequired

		Click()

		Copper
			icon_state="copperrocks"
			name ="Copper Ore"
			lvlrequired = 1
			timetomine = 100

		Iron
			icon_state="ironrocks"
			name ="Iron Ore"
			lvlrequired = 3
			timetomine = 120
obj
	Smithing
		Furnace
			New()

			icon = 'Code/Skills/Smithing.dmi'
			icon_state = "furnace"
			density = 1
