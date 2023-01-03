//////////////////////////////////////////////////
//												//
//			Puddle Jumper Dialing				//
//												//
//////////////////////////////////////////////////
mob
	ufo
		Ship_Dial
			verb
				Dial()
					set category = "Ship Controls"
					set name = "Dial Gate"
					var/list/gates = list()
					var/obj/Pegasus_Gates/G
					for(G in world)
						if(!G.private)
							gates += G
					var/obj/Pegasus_Gates/gate_dial = input("Where would you like to dial?")in gates
					var/obj/Pegasus_Gates/O = locate() in orange(10, usr.ship)
					if(O)
						if(O.incomming || O.outgoing)
							usr << "Current gate is busy"
						else
							if(gate_dial.incomming || gate_dial.outgoing)
								usr << "Gate Failed to connect."
							else
								O.Connect(gate_dial)
					else
						usr << "No gate nearby"
//////////////////////////////////////////////////
//												//
//				ZPM Holder						//
//												//
//////////////////////////////////////////////////
obj



	Move()
		if(!move) return
		..()
	var //ships
		lx
		ly
		lz
		move=1


///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Hyper Drive////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
obj
	ufos
		Hyperdrive
			name = "Hyperdrive"
			density = 1
			Click()
				usr.Hyper()
			Tauri
				icon = 'ships.dmi'
				icon_state="tauri1"
			Asgard
				icon = 'ships.dmi'
				icon_state = "Asgard Driver Controls"
			Ancient
				icon = 'ships.dmi'
				icon_state = "12"
			Goauld
				icon = 'ships.dmi'
				icon_state = "Goauld Consoles"
mob
	proc
		Hyper()
			if(usr.ship.space)
				var/mob/M
				var/enter = input("Would you like to enter Hyperspace?","") in list("Yes", "No")
				switch(enter)
					if("Yes")
						for(M in world)
							if(M.z == usr.z)
								usr<<output( {"<font color=red><b>System: </b></font>Engaging......"},{"Player"})
								//M << "<font color=red><b>System: </b></font>Engaging......"
						sleep(10)
						var/random = rand(1, 10)
						switch(random)
							if(1)
								usr.ship.loc=locate(/turf/hyperspawn1/)
							if(2)
								usr.ship.loc=locate(/turf/hyperspawn2/)
							if(3)
								usr.ship.loc=locate(/turf/hyperspawn3/)
							if(4)
								usr.ship.loc=locate(/turf/hyperspawn4/)
							if(5)
								usr.ship.loc=locate(/turf/hyperspawn5/)
							if(6)
								usr.ship.loc=locate(/turf/hyperspawn6/)
							if(7)
								usr.ship.loc=locate(/turf/hyperspawn7/)
							if(8)
								usr.ship.loc=locate(/turf/hyperspawn8/)
							if(9)
								usr.ship.loc=locate(/turf/hyperspawn9/)
							if(10)
								usr.ship.loc=locate(/turf/hyperspawn10/)
					if("No")
						return 0
				var/X = input("Input horizontal Direction") as num
				var/Y = input("Input verdical Direction") as num
				var/Z = input("Input Galaxy") in list("Milkyway","Pegasus")
				if(!X || !Y || !Z)
					return 0
				switch(Z)
					if("Milkyway")
						Z=9
					if("Pegasus")
						Z=10
				sleep(300)
				usr.ship.loc = locate(X, Y, Z)
obj
	var/fonty="<body bgcoloor=black><center><table border><tr><td align=center><font color=red>"
	var/endfonty="</td></tr></table></body>" //font vars are to make thing easier,,,

obj
	Drive_Control/shipe
		verb/Hyper_Drive()
			set category="Ship Controls"
			usr.Hyper()
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Clocking system////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
mob/ufo/var/Original_ship_icon1
mob/ufo/var/cloaked1
mob
	ufo
		verb
			ShippyCloak()
				set name = "Ship Cloak"
				set category = "Ship Controls"
				if(!usr.ship.cloaked1)
					usr.ship.Original_ship_icon1 = usr.ship.icon_state
					usr.ship.icon_state="cloak"
					usr.ship.cloaked1=1
					usr<<output( {"<font color=red><b>System: </b></font>The ship has been cloaked."},{"Player"})
					//usr << "<font color=red><b>System: </b></font>The ship has been cloaked."
				else
					usr.ship.icon_state = usr.ship.Original_ship_icon1
					usr.ship.cloaked1=0
					usr<<output( {"<font color=red><b>System: </b></font>The ship has been decloaked."},{"Player"})
				//	usr << "<font color=red><b>System: </b></font>The ship has been decloaked."
obj
	ufos
		Cloak
			icon = 'ships.dmi'
			density = 1
			name = "Cloaking Device"
			verb/Cloak_Ship()
				set category="Ship Controls"
				set name = "Cloak Ship"
				set src in oview(1)
				if(!usr.ship.cloaked1)
					usr.ship.Original_ship_icon1 = usr.ship.icon_state
					usr.ship.icon_state="cloak"
					usr.ship.cloaked1=1
					usr.ship.invisibility = 10
					usr<<output( {"<font color=red><b>System: </b></font>The ship has been cloaked."},{"Player"})
					//usr << "<font color=red><b>System: </b></font>The ship has been cloaked."
				else
					usr.ship.icon_state = usr.ship.Original_ship_icon1
					usr.ship.cloaked1=0
					usr.ship.invisibility = 0
					usr<<output( {"<font color=red><b>System: </b></font>The ship has been decloaked."},{"Player"})
					//usr << "<font color=red><b>System: </b></font>The ship has been decloaked."
			Asgard
				icon_state = "Asgard Driver Controls"
			Ancient
				icon_state = "12"
			Tauri
				icon_state = "tauri1"
			Goauld
				icon_state = "Goauld Consoles"
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Shield Repair Proc/////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
mob
	ufo
		proc
			Repair_Shield()
				if(usr.ship.shield >= usr.ship.shieldM)
					usr<<output( {"<font color=red><b>System: </b></font>Shields are at full power"},{"Player"})
					//usr << "<font color=red><b>System: </b></font>Shields are at full power."
					return 0
				else
					var/random = rand(-2, 70)
					usr.ship.shield += random
					//usr << "<font color=red><b>System: </b></font>Recharging......."
					usr<<output( {"<font color=red><b>System: </b></font>Recharging...."},{"Player"})
					sleep(20)
					usr<<output( {"<font color=red><b>System: </b></font>Sheilds are repaired by [random]!"},{"Player"})
					//usr << "<font color=red><b>System: </b></font>Shields are repaired by [random]!"
					sleep(2)
					usr<<output( {"<font color=red><b>System: </b></font>Sheild power is now [usr.ship.shield]."},{"Player"})
				//	usr << "<font color=red><b>System: </b></font>Shield power is now [usr.ship.shield]."
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Sheild Repair System///////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
obj/ufos
	Shield_System
		name="Shield System"
		icon='ships.dmi'
		name = "Sheild Repair System"
		density = 1
		verb/Repair()
			set category = null
			set src in oview(1)
			usr.ship.Repair_Shield()
		Asgard
			icon_state="Asgard Driver Controls"
		Wraith
			icon_state="New wraith Console"
		Tauri
			icon_state="tauri1"
		Ancient
			icon_state = "12"
		Goauld
			icon_state = "Goauld Consoles"
/*obj
	Shield_Systemarora
		verb
			Repair()
				set category = "Ship Controls"
				set name = "Sheild Repair"
				if(!usr.ship) return
				if(usr.ship.shield >= usr.ship.shieldM)
					usr<<output( {"<font color=red><b>System: </b></font>Shields are at full power"},{"Player"})
					usr << "<font color=red><b>System: </b></font>Shields are at full power."
				else
					usr.ship.shield += 60
					usr<<output( {"<font color=red><b>System: </b></font>Recharging...."},{"Player"})
					sleep(20)
					usr<<output( {"<font color=red><b>System: </b></font>Sheilds are repaired by [random]!"},{"Player"})
					//usr << "<font color=red><b>System: </b></font>Shields are repaired by [random]!"
					sleep(2)
					usr<<output( {"<font color=red><b>System: </b></font>Sheild power is now [usr.ship.sheild]."},{"Player"})*/



///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Beaming System/////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
mob
	proc
		Beam()
			var/sship = list()
			for(var/mob/M in world)
				if(M.ship == usr.ship && M.z == usr.z)
					sship += M
			sship<<output( {"<font color=red><b>System: </b></font>Beaming Controls Active."},{"Player"})
		//	sship << "<font color=red><b>System: </b></font>Beaming Controls Active."
			var/Mobs = list()
			var/What = input("What would you like to do?")in list("Beam Up", "Beam Down","Beam Yourself", "Cancel")
			switch(What)
				//Space
				if("Beam Up")
					var/obj/planets/O
					//var/mob/ufo/Ships/M
					var/mob/U
					for(O in oview(2, usr.ship))
						if(!O.lz)
							continue
						for(U in world)
							if(U.client && U.z == O.lz)
								Mobs += U
					for(U in Mobs)
						var/mob/Who = input("Who would you like to beam up?")as null | anything in Mobs
						if(!Who)
							return 0
						else if(Who)
							Who.loc = src.loc
							Who.ship = src.ship
							if(Who.client.cont)
								Who.client.cont = null
								Who.client.eye = usr
								Who.client.perspective = MOB_PERSPECTIVE
							sship << "<font color=red><b>System: </b></font>Beam Controls are ready for use."
						return
					sship<<output( {"<font color=red><b>System: </b></font>Beaming Controls are now charging."},{"Player"})
					//sship << "<font color=red><b>System: </b></font>Beaming Controls are now charging."
				if("Beam Down")
					var
						bx
						by
						bz
						Planet
						Ship
						mob/ufo/Beam
						Destinations = list()
					var/obj/planets/P
					var/mob/ufo/Ships/S
					var/mob/M
					for(P in view(2, usr.ship))
						if(!P.lz)
							return 0
						Planet = 1
						Destinations += P
					for(S in view(9, usr.ship))
						Ship = 1
						Destinations += S
					if(Ship || Planet)
						Beam = input("Where would you like to beam to?","")as null | anything in Destinations
						if(!Beam)
							return 0
						bx = Beam.lx
						by = Beam.ly
						bz = Beam.lz
						for(M in oview(10))
							Mobs += M
							var/mob/Who = input("Who would you like to beam to [Beam]?")as null | anything in Mobs
							if(!Who)
								return 0
							else
								Who.loc = locate(bx, by, bz)
								Who.ship = Beam
				if("Beam Yourself")
					var
						bx
						by
						bz
						Planet
						Ship
						mob/ufo/Beam
						Destinations = list()
						obj/planets/P
						mob/ufo/Ships/S
					for(P in view(2, usr.ship))
						if(!P.lz)
							return 0
						Planet = 1
						Destinations += P
					for(S in view(9, usr.ship))
						Ship = 1
						Destinations += S
					if(Ship || Planet)
						Beam = input("Where would you like to beam to?","")as null | anything in Destinations
						if(!Beam)
							return 0
						bx = Beam.lx
						by = Beam.ly
						bz = Beam.lz
						usr.loc = locate(bx, by, bz)
						usr.ship = Beam
obj/Asgard
	console
		verb
			Beamin()
				set category = "Ship Controls"
				set name = "Beam Controls"
				usr.Beam()
obj/ufos
	Beam_Controls
		icon='ships.dmi'
		density=1
		DblClick()
			usr.Beam()
		kel
			icon_state="Asgard Driver Controls"
			name = "Beaming Controls"
			density=1
		Wraith
			icon_state="New wraith Console"
			name = "Beaming Controls"
			density=1
		asgard
			icon_state="Asgard Driver Controls"
			name = "Beaming Controls"
			density=1
		Goauld
			icon_state="Goauld Consoles"
			name = "Beaming Controls"
			density=1
		Tauri
			icon_state="tauri2"
			name = "Beam Controls"
			density=1
		Ancient
			icon_state = "12"
			name = "Beaming Controls"
			density = 1


///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Sheild System//////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
obj/ufos
	Shield
		icon = 'ships.dmi'
		icon_state = ""
		density = 1
		name = "Shields"
		var/tmp/ShieldActive=0
		var/DamageRedux=100
		var/DrainRate=1
		var/Power=100
		var/tmp/Recharging=0
		verb/Shield_Toggle()
			set name = "Shield Toggle"
			set src in view(2)
			if(!ShieldActive)
				if(Power<DrainRate)
					usr<<output( {"<font color=red><b>System: </b></font>Your shields are out of energy."},{"Player"})
				//	usr << "<font color=red><b>System: </b></font>Your shields are out of energy."
				else
					Activate(usr)
			else
				DeActivate(usr)
		verb/Recharge()
			set category=null
			set src in view(2)
			if(!ShieldActive && !Recharging)
				usr<<output( {"<font color=red><b>System: </b></font>You begin Recharging."},{"Player"})
				//usr << "<font color=red><b>System: </b></font>You begin Recharging."
				while(Power <= 100)
					Power += 20
					sleep(10)
					usr<<output( {"<font color=red><b>System: </b></font>Shields recharged by 20."},{"Player"})
				//	usr << "<font color=red><b>System: </b></font>Shields recharged by 20."
		DblClick()
			if(ShieldActive)
				DeActivate(usr)
			..()
		proc
			Activate()
				Recharging=0
				ShieldActive=1
				usr<<output( {"<font color=red><b>System: </b></font>You activat your sheilds."},{"Player"})
				//usr << "<font color=red><b>System: </b></font>You Activate your shields."
				usr.ship.overlays+=/obj/ufos/Overlays/OddyseyOverlay1
				usr.ship.shield += 10000
				suffix= "Power: [Power]"
				Drain()
			DeActivate()
				ShieldActive = 0
				usr<<output( {"<font color=red><b>System: </b></font>You deactivate your sheilds."},{"Player"})
				//usr << "<font color=red><b>System: </b></font>You deactivate your shields."
				usr.ship.overlays -= /obj/ufos/Overlays/OddyseyOverlay1
				usr.ship.shield -= 10000
				suffix = "Power: [Power]"
			Drain()
				while(Power >= 0)
					if(!ShieldActive)
						return 0
					Power -= DrainRate
					suffix = "Power: [Power]"
					sleep(10)
				DeActivate(usr)
		Tauri
			icon_state = "tauri1"
		Asgard
			icon_state = "Asgard Driver Controls"
		Ancient
			icon_state = "12"
		Goauld
			icon_state = "Goauld Consoles"
obj
	ufos
		Overlays
			ShieldOverlay1
			//	icon='Icons/ForceField.dmi'
				icon_state = "s"
				layer=MOB_LAYER+999
			OddyseyOverlay1
				icon = 'ships.dmi'
				icon_state = "X-304 shield"
				layer = MOB_LAYER+150


///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Systems Computer///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
obj/ufos
	Systems_Computer
		//icon='ships.dmi'
		icon_state="system"
		density = 1
		name = "Systems Computer"
		Click()
			if(src in oview(1)) if(get_dir(usr,src)==usr.dir)
				var/powe = usr.ship.spepower
				var/shields=usr.ship.shield
				var/board
				var/boardn
				var/door
				var/mob/M
				var/locky="unlocked"
				if(usr.ship.locked)
					locky="locked"
				for(M in world)
					if(M.z == usr.z)
						board += "[M.name]<br>"
						boardn += 1
				usr<<browse("[fonty]<br><br>Ship's Power: [powe]<br><br>Ship's Shields: [shields]\
				<br><br>Docking Passcode: 123\
				<br><br>Passangers Boarded-[boardn]:<br><br>\
				[board]<br>Door Status: [door] (<a href='?lock1'>[locky]</a>)<br><br>[endfonty]","window=system")
		goauld
			icon='ships.dmi'
			icon_state="Goauld Consoles"
			name = "Systems Computer"
			density=1
		tauri
			icon='ships.dmi'
			icon_state="tauri1"
			name = "Systems Computer"
			density = 1
		Wraith
			icon='ships.dmi'
			icon_state="New wraith Console"
			name = "Systems Computer"
			density = 1
		Asgard
			icon = 'ships.dmi'
			icon_state = "Asgard Driver Controls"
			name = "Systems Computer"
			density = 1
		Ancient
			icon = 'ships.dmi'
			icon_state = "12"
			name = "Systems Computer"
			density = 1
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Communications Computer////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
obj
	ufos
		Communications
			icon = 'ships.dmi'
			icon_state="communications"
			name = "Communications"
			density = 1
			Click()
				if(src in oview(1))
					var/mob/M
					var/msg=input("What would you like to say?") as text
					for(M in world)
						if(M.z == usr.z)
							var/obj/ufos/Communications/C
							for(C in view(M))
								C<<output( {"<font color=red><b>Intercom: </b></font>[usr] : [html_encode(msg)]"},{"Player"})
								//C << "<font color=red><b>Intercom: </b></font>[usr] : [html_encode(msg)]"
								return
			Tauri
				icon_state = "tauri1"
			Goauld
				icon_state = "Goauld Consoles"
			Ancient
				icon_state = "12"
			Asgard
				icon_state = "Asgard Driver Controls"
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////Weapons_And_Communications/////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
obj
	Arora
		Chair
			verb
				Drons()
					set category = "Ship Controls"
					set name = "Drones"
					usr.ship.attack1 = 6
					usr.weapons1()
					usr.ship.dmg = 700
				weapons()
					set category = "Ship Controls"
					set name = "Weapons"
					usr.ship.attack1 = 0
					usr.weapons1()
					usr.ship.dmg = 450
obj
	Asgard
		console
			verb
				super_Weapon()
					set category = "Ship Controls"
					set name = "High Power Weapons"
					usr.weapons1()
					usr.ship.dmg = 700
					usr.ship.attack1 = 7
				weapons()
					set category = "Ship Controls"
					set name = "Weapons"
					usr.weapons1()
					usr.ship.dmg = 700
					usr.ship.attack1 = 8
		console1
			verb
				weapons()
					set category = "Ship Controls"
					set name = "Weapons"
					usr.weapons1()
					usr.ship.dmg = 550
					usr.ship.attack1 = 2
obj
	ufos
		Weapons_And_Communications
			icon='ships.dmi'
			density = 1
			name = "Weapons And Communications"
			Click()
				if(usr.ship.cloaked1)
					usr<<output( {"you cant use weapons while cloaked"},{"Player"})
					usr<<"you cant use weapons while cloaked"
					return
				if(src in oview(1)) if(get_dir(usr,src)==usr.dir)
					usr.client.weapons = 1
					usr.weapons1()
			Goauld
				icon_state="Goauld Consoles"
			Tauri
				icon_state="tauri1"
			asgard
				icon_state = "Asgard Driver Controls"
			Wraith
				icon_state = "New wraith Console"
			Ancient
				icon_state = "12"