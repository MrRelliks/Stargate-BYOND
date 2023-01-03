
world
	New()
		..()
		spawn()Corrective_Update2()
	proc/Corrective_Update2()
		sleep(5000)
		for(var/obj/Stargate/S in world)if(S.incomming)if(S.incomming:outgoing!=S)S.Disengage()
atom/proc/Bumped2(atom/a)
atom/movable/Bump(atom/a)a.Bumped(src)
atom/var/tmp/
	obj/Stargate/destin2
	vspeed2=0
atom/var/gatesafe2
mob/vspeed=1
obj/unstable2
	Move()
		for(var/mob/M in loc)M.die("an unstable vortex.")
		for(var/obj/items/M in loc)del(M)
		..()
		for(var/mob/M in loc)M.die("an unstable vortex.")
		for(var/obj/items/M in loc)del(M)


obj/MilkyWay_Gates/proc
	Connect(obj/Pegasus_Gates/Target)
		for(var/obj/ChevronsSGU/X in Target.chevrons+chevrons)X.Lighten()
		viewers(Target)<<sound("Sounds/locked.ogg",volume=10)
		if(Target.name == "Atlantis")
			for(var/obj/Alarms/sirens/A in range(20))
				A.icon_state = "alarmon"


		for(var/obj/Chevrons/X in Target.chevrons+chevrons)X.Lighten()
		Target.Spin()
		sleep(20)
		if(Target.name == "Atlantis")
			for(var/mob/M in range(Target))
			//	M << sound("Sounds/offworldactivation.ogg",volume=100)
				M << "Atlantis Gate Computer : Incoming wormhole!"
		sleep(10)
		if(outgoing||incomming||Target.incomming||Target.outgoing)return
		outgoing=Target
		Target.incomming=src
		viewers(src)<<sound('Sounds/dhd_press7.ogg',volume=10)
		viewers(Target)<<sound('Sounds/dhd_press7.ogg',volume=10)
		for(var/obj/Gate_Pieces_SGU/S in Target.control)S.density=0
		for(var/obj/ChevronsSGU/X in Target.chevrons+chevrons)X.Lighten()
		for(var/obj/Gate_Pieces_SGU/S in control)S.density=0
		Woosh(Target)
		//if(Target.iris)Target.iris.close()
		stable=1
		spawn()Idle(Target)
		..()
	Spin()
		for(var/obj/Gate_Pieces_SGU/S in control)S.icon_state="light"
		..()
	Stop_Spin()
		for(var/obj/Gate_Pieces_SGU/S in control)S.icon_state="stop"
		..()
	Lock()
		if(galaxy!=5)
			Stop_Spin()
			flick("Locking",chevlock)
			sleep(6)
			Spin()
		else
			var
				obj/DHD/D
			for(var/obj/DHD/d in world)if(d.Gate==src)D=d
			if(D)
				var
					obj/O1
					obj/O2
					obj/O3
					obj/O4
					obj/O5
					obj/O6
					obj/O7
					L=D.symbols.len
				for(var/obj/O in control)
					if(istype(O,/obj/Gate_Pieces_SGU/N/))O1=O
					if(istype(O,/obj/Gate_Pieces_SGU/NE/))O2=O
					if(istype(O,/obj/Gate_Pieces_SGU/E/))O3=O
					if(istype(O,/obj/Gate_Pieces_SGU/SE/))O4=O
					if(istype(O,/obj/Gate_Pieces_SGU/NW/))O5=O
					if(istype(O,/obj/Gate_Pieces_SGU/W/))O6=O
					if(istype(O,/obj/Gate_Pieces_SGU/SW/))O7=O
				switch(L)
					if(0)
						flick("light",O1)
						flick("light",O2)
					if(1)
						flick("light",O1)
						flick("light 2",O2)
						flick("light 2",O3)
					if(2)
						flick("light",O1)
						flick("light 2",O2)
						flick("light",O3)
						flick("light",O4)
					if(5)
						flick("light 2",O1)
						flick("light",O5)
					if(4)
						flick("light 2",O1)
						flick("light 2",O5)
						flick("light 2",O6)
					if(3)
						flick("light 2",O1)
						flick("light 2",O5)
						flick("light",O6)
						flick("light",O7)
		..()

	Idle(obj/MilkyWay_Gates/Target)
		var/X
		var/ticker
		while(outgoing)
			ticker++
			sleep(10)
			viewers(src)<<sound('Sounds/gate_horizon.ogg',volume=10)
			viewers(Target)<<sound('Sounds/gate_horizon.ogg',volume=10)
			X=0
			for(var/mob/M in viewers(src))if(M.client)if(M.client.inactivity<500)X=1
			if(ticker==30)X=0
			if(!X)
				sleep(40)
				viewers(Target)<<sound('Sounds/gate_horizon.ogg',volume=10)
				Disengage()
				sleep(40)
				if(Target.name == "Atlantis")
					for(var/mob/M in range(Target))
					//	M << sound("Sounds/offworldactivation.ogg",volume=100)
						M << "Atlantis Gate Computer : Wormhole disengaged!"
				Target.Disengage()
				sleep(100)
				for(var/obj/Alarms/sirens/A in range(20))
					A.icon_state = "alarmoff"
				break ..()
		..()

	Disengage()
		for(var/obj/ChevronsMilkyWay/Z in chevrons)Z.Darken()
		viewers(src)<<sound(null)
		viewers(src)<<sound('Sounds/gate_shutdown.ogg',volume=10)
		for(var/obj/X in control+src)X.icon_state="dewoosh"
		sleep(3)
		for(var/obj/X in control+src)X.icon_state=""
		for(var/obj/Gate_Pieces_SGU/S in control)S.density=initial(S.density)
	//	if(iris)iris.open()

		outgoing=null
		incomming=null
		for(var/obj/DHD_SGU/D in range(src,10))
			D.dialing=0
			D.Reset()
		..()
	ison()
		if(outgoing||incomming)return 1
		else return 0



	Woosh(obj/MilkyWay_Gates/T)
		var/nowoosh
		if(T.iris)if(T.iris.iris_hp>0)
			nowoosh=1
		//	spawn()T.iris.close()
		if(iris)spawn()iris.open()
		for(var/obj/X in T:control+control+T+src)X.icon_state="woosh"
		sleep(3)
		for(var/obj/X in T:control+control+T+src)X.icon_state="on"
		var/obj/unstable/A = new(loc)
		var/obj/unstable/B = new(T.loc)
		A.icon=icon
		A.icon_state="spoon"
		if(!nowoosh)B.icon=icon
		if(!nowoosh)B.icon_state="spoon"
		sleep(2)
		step(A,SOUTH)
		if(!nowoosh)step(B,SOUTH)
		A.layer=15
		if(!nowoosh)B.layer=15
		var/obj/unstable/A1 = new(A.loc)
		var/obj/unstable/B1 = new(B.loc)
		if(!nowoosh)B1.icon=icon
		A1.icon=icon
		if(!nowoosh)B1.icon_state="feed"
		A1.icon_state="feed"
		A1.layer=14
		if(!nowoosh)B1.layer=14
		sleep(4)
		step(A1,SOUTH)
		if(!nowoosh)step(B1,SOUTH)
		sleep(10)
		step(A1,NORTH)
		if(!nowoosh)step(B1,NORTH)
		sleep(3)
		step(A,NORTH)
		step(B,NORTH)
		sleep(2)
		del(A)
		del(B)
		sleep(2)
		step(A1,NORTH)
		if(!nowoosh)step(B1,NORTH)
		sleep(1)
		del(A1)
		del(B1)
		..()














turf/DestinSGU
	Enter(atom/movable/M)
		return 0
		if(ismob(M))
			M<<sound('Sounds/gate_horizon.ogg',volume=10)
			if(M.destin.iris)if(M.destin.iris.closed())
				usr.die("hitting [M.destin]'s Defense.")
				return
			usr.FadeScreen()
			usr.loc=null
			sleep(20)
			usr.loc=usr.destin.loc
			usr.UnFadeScreen()
			if(usr.dir==SOUTH)
				usr.dir=NORTH
			else
				usr.y-=2
				usr.dir=SOUTH
		else
			if(M.destin.iris)
				if(M.destin.iris.closed())
					del(M)
			else
				usr.FadeScreen()
				M.loc=null
				sleep(20)
				M.loc=M.destin.loc
				usr.UnFadeScreen()








//STARGATE BUILD
turf
	VortexSGU
		icon='Icons/AtlantisGate/misc.dmi'
		icon_state="vortex"
		Entered(atom/movable/A)
			return 0
			sleep(rand(0,A.vspeed))
			A.y++
			if(istype(A.loc,/turf/Destin/))
				A.loc.Enter(A)
				return
			A.loc.Entered(A)
		Top
			icon_state="blue"
			layer=20
			//angey4477@hotmail.com
obj
	Pegasus_Gates
/*		verb
			Manual_Dial(address as text)
				set src in oview(2)
				if(!incomming&&!outgoing)*/
		icon='Icons/AtlantisGate/center.dmi'
		icon_state="X"
		var
			control=list()
			chevrons[9]
			coloor = "blue"
			tmp/obj/incomming
			tmp/obj/outgoing
			stable
			galaxy=5
			alterangate
			address
			obj/Iris/iris
			obj/chevlock
			tmp/busy
			private = 0
		layer=MOB_LAYER-2
		New()

			icon_state=null
			..()
			switch(galaxy)
				if(5)coloor="blue"

			for(var/V in typesof(/obj/Gate_Pieces_SGU/)) control+=new V(loc)//Don't tuch it !!!
			chevrons[4]=new/obj/ChevronsSGU(x-1,y-1,SOUTHWEST,coloor,z)
			chevrons[5]=new/obj/ChevronsSGU(x-1,y,WEST,coloor,z)
			chevrons[6]=new/obj/ChevronsSGU(x-1,y+1,NORTHWEST,coloor,z)
			chevrons[7]=new/obj/ChevronsSGU(x,y+1,NORTH,coloor,z)
			chevrons[1]=new/obj/ChevronsSGU(x+1,y+1,NORTHEAST,coloor,z)
			chevrons[2]=new/obj/ChevronsSGU(x+1,y,EAST,coloor,z)
			chevrons[3]=new/obj/ChevronsSGU(x+1,y-1,SOUTHEAST,coloor,z)
			chevlock=new/obj/ChevronsSGU/Locking_Chevron(x,y+1,NORTH,0,z)
			spawn(5)
			for(var/obj/Gate_Pieces_SGU/G in control)
				if(galaxy==5)G.gtype=2
				G.mastergate=src
			switch(_iris)
				if(1)iris=new/obj/PegIris(loc)
				if(2)iris=new/obj/PegIris/shield(loc)
				if(3)iris=new/obj/PegIris/shield(loc)





	Gate_Pieces_SGU
		Entered(atom/movable/A)
			if(!A||(istype(A,/obj/unstable/)))return
			if(mastergate)
				if(istype(A,/obj/items/projectile/))
					if(mastergate.outgoing)
						if(mastergate.outgoing:iris)if(mastergate.outgoing:iris.iris_hp>0)
							//if(A:hitsound)view(mastergate.outgoing:iris)<<A:hitsound
							//mastergate.outgoing:iris.iris_hp-=A:dmg
							//new/obj/drops/Metal(mastergate.outgoing.loc)
							if(mastergate.outgoing:iris.iris_hp<=0)mastergate.outgoing:iris.open()
						else
							A.loc=mastergate.outgoing.loc
							A.y--
							walk(A,SOUTH)
					del(A)
				if(ismob(A))
					if(A.gatesafe)
						if(mastergate.outgoing)
							A.loc=mastergate.outgoing:loc
							A.y-=2
							A.dir=SOUTH
						if(mastergate.incomming)
							A.loc=mastergate.incomming:loc
							A.y-=2
							A.dir=SOUTH
						return
				if(mastergate.incomming)
					if(mastergate.iris)if(mastergate.iris.closed())return
					if(ismob(A))A:die("stepping into an incomming wormhole.")
					else del(A)
				if(mastergate.outgoing)
					if(mastergate.iris)if(mastergate.iris.closed())return
					if(mastergate.stable)
						if(ismob(A))
							A<<sound('Sounds/gate_horizon.ogg',volume=10)
							if(mastergate.outgoing:iris)if(mastergate.outgoing:iris.closed())
								usr.die("hit [mastergate.outgoing]'s [mastergate.outgoing:iris].")
								return
							A.loc=null
							// Make null location = to whereever the Vortext image will be.
							usr.FadeScreen()
							//A.loc=null
							sleep(5)

							//A.loc=mastergate.outgoing.loc
							usr.UnFadeScreen()
							A.loc=mastergate.outgoing.loc
							A.y-=1
							if(usr.dir==SOUTH) usr.dir=NORTH
							else
								A.y-=2
								A.dir=SOUTH
						else
							if(mastergate.outgoing:iris)if(mastergate.outgoing:iris.closed())del(A)
							else
								A.loc=mastergate.outgoing:loc
								A.y-=2
								A.dir=SOUTH

						//A.loc.Entered(A)
						//A.destin=mastergate.outgoing
					else if(A)if(!A.gatesafe)
						if(ismob(A))A:die("stepping into an unstable wormhole.")
						else del(A)
		layer=10
		var
			gtype=1
			ax
			ay
			chev=0
			obj/Stargate/mastergate
		New()
			..()
			if(!icon)del(src)
		verb/Enter_()
			set src in view(1)
			Entered(usr)
			..()
		N
			icon='Icons/AtlantisGate/north.dmi'
			dir=NORTH
			ay=1
			Entered()return
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/north.dmi'
		NE
			icon='Icons/AtlantisGate/northeast.dmi'
			dir=NORTHEAST
			ay=1
			ax=1
			Entered()return
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/northeast.dmi'
		NW
			icon='Icons/AtlantisGate/northwest.dmi'
			dir=NORTHWEST
			ay=1
			ax=-1
			Entered()return
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/northwest.dmi'
		W
			icon='Icons/AtlantisGate/west.dmi'
			dir=WEST
			ax=-1
			Entered()return
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/west.dmi'
		E
			icon='Icons/AtlantisGate/east.dmi'
			dir=EAST
			ax=1
			Entered()return
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/east.dmi'
		S
			icon='Icons/AtlantisGate/south.dmi'
			dir=SOUTH
			ay=-1
			chev=0
			density=0
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/south.dmi'
		SE
			icon='Icons/AtlantisGate/southeast.dmi'
			dir=SOUTHEAST
			ay=-1
			ax=1
			density=1
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/southeast.dmi'
		SW
			icon='Icons/AtlantisGate/southwest.dmi'
			dir=SOUTHWEST
			ay=-1
			ax=-1
			density=1
			New()
				..()
				spawn(10)if(gtype==2)icon='Icons/AtlantisGate/southwest.dmi'

		New()
			..()
			if(chev)overlays+=image('Icons/AtlantisGate/chevrons.dmi',dir,icon_state = "Locking")
			x+=ax
			y+=ay
	ChevronsSGU
		layer=10
		icon='Icons/AtlantisGate/chevrons.dmi'
		icon_state = "atlantis"
		var/tmp
			oic
			col
		New(ax,ay,d,coloor,az)
			..()
			loc=locate(ax,ay,az)
			dir=d
			col=coloor
			if(coloor)switch(coloor)
				//if("blue")icon+=rgb(0,0,0)
				if("blue")icon+=rgb(0,43,70)

			oic=icon
		proc
			Lighten()
				if(col)switch(col)
					//if("blue")icon+=rgb(0,0,0)
					if("blue")icon+=rgb(0,106,197)

				..()
			Darken()
				if(oic)icon=oic
				..()
		Locking_Chevron
			layer=10
			icon_state="North"