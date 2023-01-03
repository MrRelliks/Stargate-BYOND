mob
	var
		MidWayNPC = 0
	Injured
		icon = 'NPCSGC.dmi'
		event_ShowText = "Test"

		DblClick()
			usr.Interact(src)

turf
	Alarm1
		layer = 96
		icon = 'Test.png'
		icon_state = "on"
	Darkness11
		icon = 'Darkness.png'
		layer = 99
		parent_type = /turf/

		mouse_opacity = FALSE
	Dark1
		icon = 'Dark1.png'
		plane = 97
		mouse_opacity = FALSE
	Dark0
		icon = 'Darkness2.png'
		plane = 97
		mouse_opacity = FALSE


