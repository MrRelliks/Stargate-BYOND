obj
	Stargate
		New()
			..()

		var
			_iris=0
			iris_hp=1000
	Iris
		icon='icons/iris/Full.dmi'
		name = "Stargate iris"
		layer=30
		density = 1
		pixel_y = -32
		pixel_x = -32
	//	pixel.y = -32
		var
			used = 0
			iris_hp = 8000
		Del()
			return ..()
		New()
			. = ..()
			if(type == /obj/Iris/shield)
				AddOverlay('icons/firis/west.dmi',,32,0,30)
				AddOverlay('icons/firis/east.dmi',,-32,0,30)
				AddOverlay('icons/firis/north.dmi',,0,32,30)
				AddOverlay('icons/firis/south.dmi',,0,-32,30)
				AddOverlay('icons/firis/northwest.dmi',,-32,32,30)
				AddOverlay('icons/firis/northeast.dmi',,32,32,30)
				AddOverlay('icons/firis/southwest.dmi',,-32,-32,30)
				AddOverlay('icons/firis/southeast.dmi',,32,-32,30)
			else
				//AddOverlay('icons/iris/Full.dmi',,32,32,layer,density = 1)
			//	AddOverlay('icons/iris/Full.dmi',,-32,-32,layer)
				//AddOverlay('icons/iris/west.dmi',,32,0,layer)
				//AddOverlay('icons/iris/east.dmi',,-32,0,layer)
				//AddOverlay('icons/iris/north.dmi',,0,32,layer)
			//	AddOverlay('icons/iris/south.dmi',,64,32,layer)
			//	AddOverlay('icons/iris/northwest.dmi',,-32,32,layer)
				//AddOverlay('icons/iris/northeast.dmi',,32,32,layer)
				//AddOverlay('icons/iris/southwest.dmi',,-32,-32,layer)
				//AddOverlay('icons/iris/southeast.dmi',,32,-32,layer)
		proc/close()
			if(closed())return
			if(used)return
			for(var/obj/Stargate/G in world)
				if(G.iris&&G.iris==src)
					if(G._iris!=3)
						if(G.iris.iris_hp<=0)
							return 0
			used=1
			for(var/obj/Stargate/s in world)
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
		//	for(var/obj/Stargate/s in world)if(s.iris==src)if(!s.incomming&&!s.outgoing)
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
			icon='icons/firis/center.dmi'
