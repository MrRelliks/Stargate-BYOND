mob
	var/tmp/atDHD2
	Move()
		if(atDHD2) for(var/obj/HUD/DHD2/D in client.screen)client.screen-=D
		..()
obj
	DHD
		density=1
		icon='Icons/DHD/dhd2.dmi'
		icon_state="0"
		name = "Dial Home Device"
		desc = "The device used to dial other planets"




		var
			tmp/times=0
			tmp/list/symbols=list()
			tmp/obj/Pegasus_Gates/Gate
			tmp/used=0
			tmp/locked=0 //prevent usage of this DHD
			tmp/address
			crystallock=0 //1 to lock the crystal in place, preventing people from inserting another
			galaxy=1 //0 = interstellar; anything else is a galaxy ID, same as gate
			coloor="red"
			crystal_state
			crystal_coloor
			AlteranType
			power=10000
			dhd_type=1 //0 = sgc-style | 1 = dhd-style
			screeny=list()
			tmp/dialing
		Destiny
			coloor="blue"
			dhd_type=0
			icon = 'Icons/DHD/ahd.dmi'
			//icon_state = "Atlantis"
			galaxy=25
		New()
			..()
			if(dhd_type)
				overlays+=image(icon,icon_state="bottom",pixel_x=0,pixel_y=-32,layer=OBJ_LAYER)
				overlays+=image(icon,icon_state="left",pixel_x=-32,pixel_y=0,layer=OBJ_LAYER)
				overlays+=image(icon,icon_state="right",pixel_x=32,pixel_y=0,layer=OBJ_LAYER)
				overlays+=image(icon,icon_state="top",pixel_x=0,pixel_y=32,layer=MOB_LAYER+1)
			spawn(5)Get_Gate()
			for(var/V in typesof(/obj/HUD/DHD2/))
				var/obj/X=new V(master=src)
				X:master=src
				if(dhd_type)X.screen_loc=X:screen_loc2
				screeny+=X
				..()
			loc.density=0
		Bumped(mob/M)
			if(!M.client) return
			for(var/obj/Pegasus_Gates/S in range(20))
			//	usr.client.eye = S
				Show_DHD_Hud(M)
		//	if(ismob(M))Show_DHD_Hud(M)
			..()
		verb/Use()
			set src in view(1)
			Show_DHD_Hud(usr)
			..()
		proc
			Show_DHD_Hud(mob/M)
				if(get_dir(M,src)==NORTH)
					for(var/O in screeny)M.client.screen+=O
					for(var/O in symbols)M.client.screen+=O
					M.atDHD2=1
				..()
			Get_Gate()
				for(var/obj/Pegasus_Gates/O in range(world.maxx+world.maxy,src))
					if(!Gate)
						Gate=O
						galaxy=O.galaxy
						//coloor=O.coloor
					else if(get_dist(src,O)<get_dist(src,Gate)) Gate=O
				switch(coloor)
					if("blue")
						if(dhd_type)icon='Icons/DHD/dhd2.dmi'
						else icon='Icons/DHD/ahd2.dmi'

				..()

			Reset(x)
				if(icon_state!="0")
					icon_state="0"
					for(var/obj/O in symbols)del(O)
					Gate.Stop_Spin()
					symbols=new/list()
					if(!x)
						viewers(src)<<sound(null)
						//viewers(src)<<sound('Sounds/Atlantisdial.ogg')
					for(var/obj/O in screeny)if(istype(O,/obj/HUD/DHD2/symbols2/))O.icon='Icons/NewSymbols.dmi'
					if(Gate)for(var/obj/ChevronsSGU/X in Gate.chevrons)X.Darken()

				..()









obj/HUD/DHD2
	icon='Icons/DHDHud.dmi'
	parent_type=/obj
	layer=9999
	var
		screen_loc2
		obj/DHD_SGU/master
	proc
		YESDIAL()
			if(!master.Gate.incomming&&!master.Gate.outgoing)
				if(master.power>= 100)
					master.power -= 100
				else
					usr << "{ DHD } Error Out of Power"
					return 0
				if(master.coloor=="purple")for(var/obj/Pegasus_Gates/S in world)if(S.address+" [S.galaxy]"==master.address&&S!=master.Gate&&!S.incomming&&!S.outgoing)master.Gate.Connect(S)
				else for(var/obj/Pegasus_Gates/S in world)if(S.address==master.address&&S.galaxy==master.galaxy&&S!=master.Gate&&!S.incomming&&!S.outgoing)master.Gate.Connect(S)
	background
		icon = 'Icons/DHDHud2.dmi'
	//	screen_loc = "2,1"
		screen_loc2 = "2,1"

	backgroundSGC
		icon = 'Icons/AtlantisDHDHud.dmi'

		screen_loc = "2,1"



	no_1



		icon_state="No_1"
		screen_loc="6,2"
		screen_loc2="11,3"
		Click()
			..()
			spawn()master.Reset()
			if(master.Gate.outgoing)
				var/obj/outy=master.Gate.outgoing
				master.Gate.Disengage()
				sleep(40)
				outy:Disengage()
				master.times = 0
	YesSGC
		icon_state = "Yes_Atlantis"
		screen_loc = "15,2"
		Click()
			YESDIAL()

	yes_1
		icon_state="Yes_Atlantis"
		//screen_loc="9,6"
		screen_loc2="9,6"
		Click()
			YESDIAL()
	yes_2
		icon_state="Yes_Atlantis"
		//screen_loc="9,7"
		screen_loc2="9,7"
		Click()
			YESDIAL()
	yes_3
		icon_state="Yes_Atlantis"
		//screen_loc="10,6"
		screen_loc2="10,6"
		Click()
			YESDIAL()

	yes_4
		icon_state="Yes_Atlantis"
		//screen_loc="10,7"
		screen_loc2="10,7"
		Click()
			YESDIAL()
	yes_5
		icon_state="Yes_Atlantis"
		//screen_loc="11,6"
		screen_loc2="11,6"
		Click()
			YESDIAL()

	yes_6
		icon_state="Yes_Atlantis"
	//	screen_loc="11,7"
		screen_loc2="11,7"
		Click()
			YESDIAL()

	symbols2
		icon='Icons/NewSymbols.dmi'
		layer=10000
		Click()
			var/max=6
			if(master)
				if(master.Gate.busy) return
				if(master.coloor=="purple")max++
				//if(master.coloor!=master.Gate.coloor&&master.coloor!="purple")return
				if(master.symbols.len<max&&!master.dialing&&!master.Gate.incomming)
					for(var/obj/O in master.symbols)if(icon_state==O.icon_state)return
					master.dialing=1
					spawn(2)master.dialing=0
					master.Gate.Lock()
				//	if(master.symbols.len+1==1) viewers(master)<<sound('Sounds/Atlantisdial.ogg',1,0,7)
					if(master.symbols.len+1<max)viewers(master)<<sound('Sounds/Atlantisdial.ogg',volume=10)
					if(max==master.symbols.len+1)
						master.Gate.Stop_Spin()
						viewers(master)<<sound(null)
						viewers(master)<<sound('Sounds/Atlantisdial.ogg',volume=10)
					for(var/obj/ChevronsSGU/O in master.Gate.chevrons)if(O==master.Gate.chevrons[master.symbols.len+1]) O.Lighten()
					var/obj/HUD/DHD2/O=new()
					O.screen_loc="[4+master.symbols.len+1],1"
					O.icon=icon
					O.icon_state=icon_state
					O.layer=999999999999
					master.symbols+=O
					if(master.symbols.len>1)master.address+=" [icon_state]"
					else master.address=icon_state
					usr.client.screen+=O
					icon+=rgb(31,102,122)
					master.icon_state="[master.symbols.len]"
		s1
			icon_state="1"
			screen_loc="6,5"
			screen_loc2="9,10"
		s2
			icon_state="2"
			screen_loc="7,5"
			screen_loc2="10,10"
		s3
			icon_state="3"
			screen_loc="8,5"
			screen_loc2="11,10"
		s4
			icon_state="4"
			screen_loc="9,5"
			screen_loc2="7,9"

		s5
			icon_state="5"
			screen_loc="10,5"
			screen_loc2="8,9"

		s6
			icon_state="6"
			screen_loc="11,5"
			screen_loc2="9,9"

		s7
			icon_state="7"
			screen_loc="12,5"
			screen_loc2="10,9"
		s8
			icon_state="8"
			screen_loc="13,5"
			screen_loc2="11,9"
		s9
			icon_state="9"
			screen_loc="14,5"
			screen_loc2="12,9"

		s10
			icon_state="10"
			screen_loc="15,5"
			screen_loc2="13,9"
		s11
			icon_state="11"
			screen_loc="6,4"
			screen_loc2="7,8"

		s12
			icon_state="12"
			screen_loc="7,4"
			screen_loc2="7,7"
		s13
			icon_state="13"
			screen_loc="8,4"
			screen_loc2="13,8"
		s14
			icon_state="14"
			screen_loc="9,4"
			screen_loc2="13,7"
		s15
			icon_state="15"
			screen_loc="10,4"
			screen_loc2="7,6"
		s16
			icon_state="16"
			screen_loc="11,4"
			screen_loc2="13,6"
		s17
			icon_state="17"
			screen_loc="12,4"
			screen_loc2="7,5"
		s18
			icon_state="18"
			screen_loc="13,4"
			screen_loc2="7,4"
		s19
			icon_state="19"
			screen_loc="14,4"
			screen_loc2="6,4"
		s20
			icon_state="20"
			screen_loc="15,4"
			screen_loc2="8,4"
		s21
			icon_state="21"
			screen_loc="6,3"
			screen_loc2="9,4"


		s22
			icon_state="22"
			screen_loc="7,3"
			screen_loc2="10,4"
		s23
			icon_state="23"
			screen_loc="8,3"
			screen_loc2="11,4"
		s24
			icon_state="24"
			screen_loc="9,3"
			screen_loc2="12,4"
		s25
			icon_state="25"
			screen_loc="10,3"
			screen_loc2="13,4"
		s26
			icon_state="26"
			screen_loc="11,3"
			screen_loc2="13,5"

		s27
			icon_state="27"
			screen_loc="12,3"
			screen_loc2="14,4"
		s28
			icon_state="28"
			screen_loc="13,3"
			screen_loc2="14,9"
		s29
			icon_state="29"
			screen_loc="14,3"
			screen_loc2="6,9"
		s30
			icon_state="30"
			screen_loc="15,3"
			screen_loc2="6,8"
		s31
			icon_state="31"
			screen_loc="7,2"
			screen_loc2="6,7"
		s32
			icon_state="32"
			screen_loc="8,2"
			screen_loc2="6,6"
		s33
			icon_state="33"
			screen_loc="9,2"
			screen_loc2="6,5"
		s34
			icon_state="34"
			screen_loc="10,2"
			screen_loc2="14,8"
		s35
			icon_state="35"
			screen_loc="11,2"
			screen_loc2="14,7"
		s36
			icon_state="36"
			screen_loc="12,2"
			screen_loc2="14,6"
		s37
			icon_state="37"
			screen_loc="13,2"
			screen_loc2="14,5"
		s38
			icon_state="38"
			screen_loc="14,2"
			screen_loc2="9,3"
	ssymbols //selected
		icon='icons/NewSymbols.dmi'
		layer=10000
		var/greyed=0
		proc
			grey()
				greyed=1
				overlays+=icon('Icons/DHDHud.dmi',"greyed")
			ungrey()
				greyed=0
				overlays=list()


/*obj/DHD_bottom
	icon='DHD/dhd.dmi'
	icon_state="bottom"
	density=1*/