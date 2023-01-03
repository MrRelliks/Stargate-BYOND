


		// clicking on the lamp turns it on or off

var
//	admin_contact ="Stargate_Offic"
	server_version = "1.0" ; server_build = "Build 005"
	servername = "Alpha"
	tauricount = 0
	wraithcount = 0
client
	default_verb_category=null
	perspective=EDGE_PERSPECTIVE
	//command_text="Universe-> \""
	New()
		. = ..()
		if(!playerlist.Find("[key]"))
			playerlist.Add("[key]")

world
	proc
	hub="StargateOffic.StargateBYOND"
	hub_password = ""
	//mob = /mob/player
	loop_checks = 0
	tick_lag = 0.8
	name = "Stargate BYOND"
	//map_format=ISOMETRIC_MAP
	view="18x19"
	//view="18x25"
	cache_lifespan=0
	//build
	//world.version = "Alpha 0.1"
	New()
		. = ..()
		spawn(0)

			world.name="Stargate BYOND"
			world.status = "<strong> [world.name] - Online</strong> "
			sleep(100)
//			loop_save()
			LoadBans()
			Corrective_Update()
			AutoRestart()
			// tell the dynamic lighting which icon file to use




// Make objects move 8 pixels per tick when walking

mob
//	step_size = 32

obj
	step_size = 8






turf
	SGC
		icon = 'Icons/SGC.dmi'

