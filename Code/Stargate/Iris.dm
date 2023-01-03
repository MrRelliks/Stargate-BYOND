obj
	Stargate
		var
			_iris=0
			iris_hp=1000
	Iris
		icon='icons/iris/center.dmi'
		name = "Stargate iris"
		layer=10
	//	layer2 = 6
		var
			used = 0
			iris_hp = 8000
		Del()
			return ..()
		New()
			. = ..()
			if(type == /obj/Iris/shield)
				AddOverlay('icons/firis/west.dmi',,32,0,layer)
				AddOverlay('icons/firis/east.dmi',,-32,0,layer)
				AddOverlay('icons/firis/north.dmi',,0,32,layer)
				AddOverlay('icons/firis/south.dmi',,0,-32,layer)
				AddOverlay('icons/firis/northwest.dmi',,-32,32,layer)
				AddOverlay('icons/firis/northeast.dmi',,32,32,layer)
				AddOverlay('icons/firis/southwest.dmi',,-32,-32,layer)
				AddOverlay('icons/firis/southeast.dmi',,32,-32,layer)
			else
				AddOverlay('icons/iris/west.dmi',,32,0,layer)
				AddOverlay('icons/iris/east.dmi',,-32,0,layer)
				AddOverlay('icons/iris/north.dmi',,0,32,layer)
				AddOverlay('icons/iris/south.dmi',,0,-32,layer)
				AddOverlay('icons/iris/northwest.dmi',,-32,32,layer)
				AddOverlay('icons/iris/northeast.dmi',,32,32,layer)
				AddOverlay('icons/iris/southwest.dmi',,-32,-32,layer)
				AddOverlay('icons/iris/southeast.dmi',,32,-32,layer)
		proc/close()
			if(closed())return
			if(used)return
			for(var/obj/Stargate/G in world)
				if(G.iris&&G.iris==src)
					if(G._iris!=3)
						if(G.iris.iris_hp<=0)
							return 0
			used=1
			if(type==/obj/Iris/shield)
				for(var/obj/Stargate/G in world)if(G.iris&&G.iris==src)for(var/obj/console/iriscontrol/O in world)
					if(!O.Gate)continue
					if(O.Gate==G)O.icon_state="fieldiris1"
				viewers(src)<<sound('Sounds/iris.ogg')
			else
				for(var/obj/Stargate/G in world)if(G.iris&&G.iris==src)for(var/obj/console/iriscontrol/O in world)
					if(!O.Gate)continue
					if(O.Gate==G)O.icon_state="iris0"
				viewers(src)<<sound('Sounds/iris_close.ogg')

			for(var/obj/Stargate/s in world)
				if(src==s.iris)
					for(var/obj/Gate_Pieces/S/S in s.control)S.density=1
					for(var/obj/Gate_Pieces/SW/S in s.control)S.density=1
					for(var/obj/Gate_Pieces/SE/S in s.control)S.density=1
			//icon_state = "closing"
			flick("closing",src)
			sleep(13)
			icon_state="closed"
			used=0
		proc/open()
			if(opened())return
			if(used)return
		//	used=1
			if(type==/obj/Iris/shield)
				for(var/obj/Stargate/G in world)if(G.iris&&G.iris==src)for(var/obj/console/iriscontrol/O in world)
					if(!O.Gate)continue
					if(O.Gate==G)O.icon_state="fieldiris0"
				viewers(src)<<sound('Sounds/iris.ogg')
			else
				for(var/obj/Stargate/G in world)if(G.iris&&G.iris==src)for(var/obj/console/iriscontrol/O in world)
					if(!O.Gate)continue
					if(O.Gate==G)O.icon_state="iris1"
				viewers(src)<<sound('Sounds/iris_open.ogg')
		//	icon_state=""
			for(var/obj/Stargate/s in world)if(s.iris==src)if(!s.incomming&&!s.outgoing)for(var/obj/Gate_Pieces/S/S in s.control)S.density=0
		//	icon_state = "opening"
			flick("opening",src)
			sleep(13)
			icon_state= "open"
			used=0
		proc
			closed()
				if(icon_state=="closed"||icon_state=="closing")return 1
				return 0
			opened()
				if(icon_state!="closed"&&icon_state!="opening")return 1
				return 0
		shield //set icon for shield here
			name="Stargate shield"
			icon='icons/firis/center.dmi'
atom/proc/AddOverlay(icon=src.icon,icon_state=null,pixel_x=0,pixel_y=0,layer=OBJ_LAYER,density=0)
	var/obj/O=new
	O.icon=icon
	O.icon_state=icon_state
	O.name = name
	O.pixel_x=pixel_x
	O.pixel_y=pixel_y
	O.layer=layer
	O.density=density
	overlays+=O