obj
	Pegasus_Gates
		var
			_iris=0
			iris_hp=1000
	PegIris
		icon='Icons/firis/center.dmi'
		name = "Gate Sheild"
		layer = 20
		pixel_y = -32
		pixel_x = -32
		var
			used = 0
			iris_hp = 8000
		Del()
			return ..()
		New()
			. = ..()
			if(type == /obj/Iris/shield)
				AddOverlay('Icons/firis/west.dmi',,32,0,layer)
				AddOverlay('Icons/firis/east.dmi',,-32,0,layer)
				AddOverlay('Icons/firis/north.dmi',,0,32,layer)
				AddOverlay('Icons/firis/south.dmi',,0,-32,layer)
				AddOverlay('Icons/firis/northwest.dmi',,-32,32,layer)
				AddOverlay('Icons/firis/northeast.dmi',,32,32,layer)
				AddOverlay('Icons/firis/southwest.dmi',,-32,-32,layer)
				AddOverlay('Icons/firis/southeast.dmi',,32,-32,layer)


		proc/close()
			if(closed())return
			if(used)return
			for(var/obj/Pegasus_Gates/G in world)
				if(G.iris&&G.iris==src)
					if(G._iris!=3)
						if(G.iris.iris_hp<=0)
							return 0
			used=1
			for(var/obj/Pegasus_Gates/s in world)
			//	if(src==s.iris)
				//	for(var/obj/Gate_Pieces/S/S in s.control)S.density=1
				///	for(var/obj/Gate_Pieces/SW/S in s.control)S.density=1
					//for(var/obj/Gate_Pieces/SE/S in s.control)S.density=1
			flick("closing",src)
			sleep(13)
			icon_state="closed"
			density = 1
			used=0
		proc/open()
			if(opened())return
			if(used)return
		//	used=1

			icon_state=""
		//	for(var/obj/Pegasus_Gates/s in world)if(s.iris==src)if(!s.incomming&&!s.outgoing)
			flick("opening",src)
			sleep(13)
			icon_state= "open"
			density = 0
			used=0
		proc
			closed()
				if(icon_state=="closed"||icon_state=="closing")return 1
				return 0
			opened()
				if(icon_state!="closed"&&icon_state!="closing")return 1
				return 0
		shield //set icon for shield here
			name="Stargate shield"
			icon='icons/firis/Full.dmi'
atom/proc/AddOverlay(icon=src.icon,icon_state=null,pixel_x=0,pixel_y=0,layer=OBJ_LAYER,density=0)
	var/obj/O=new
	O.icon=icon
	O.icon_state=icon_state
	O.name = name
	O.pixel_x=pixel_x-32
	O.pixel_y=pixel_y-32
	O.layer=layer
	O.density=density
	overlays+=O