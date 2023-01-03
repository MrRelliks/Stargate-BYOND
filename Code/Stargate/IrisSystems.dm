


obj/console/iriscontrol_manual
	var
		hp
	icon='Icons/SGC.dmi'
	icon_state="sgc"
	hp = 1000
	var/tmp/obj/Pegasus_Gates/Gate
	var
		list
			gdo[0]
	proc/gdo(code,key,race,team)
		for(var/GDO/X in gdo)
			if(X.disabled)continue //disabled = disabled
			if(X.gtype==0&&X.data==code)return 1 //correct code sent
			if(X.gtype==1&&X.data==key)return 1 //correct key/player
			if(X.gtype==2&&X.data==race)return 1 //correct race
			if(X.gtype==3&&X.data==team)return 1 //correct team
		return 0 //all incorrect
	proc/gdo_signal(code,key,race,team)
		viewers(src)<<sound('Sounds/iriscode.ogg')
		if(Gate&&Gate.iris.closed())Gate.iris.open()
	New()
		..()
		spawn(5)Move(src.loc)
	Move(atom/newloc,newdir)
		..()
		for(var/obj/Pegasus_Gates/G in view(src))
			Gate=G
			break
	DblClick()
		if(usr in oview(src,1))
			if(!Gate)
				for(var/obj/Pegasus_Gates/G in view(src))
					Gate=G
					break
			if(Gate&&Gate.iris)
				if(!Gate.iris.closed())Gate.iris.close()
				else Gate.iris.open()

obj/console/Desk_iriscontrol_manual
	var
		hp
	icon='Icons/SGC.dmi'
	icon_state="irisconsole"
	hp = 1000
	var/tmp/obj/Pegasus_Gates/Gate
	New()
		..()
		spawn(5)Move(src.loc)
	Move(atom/newloc,newdir)
		..()
		for(var/obj/Pegasus_Gates/G in view(src))
			Gate=G
			break
	DblClick()
		if(usr in oview(src,1))
			if(!Gate)
				for(var/obj/Pegasus_Gates/G in view(src))
					Gate=G
					break
			if(Gate&&Gate.iris)
				if(!Gate.iris.closed())Gate.iris.close()
				else Gate.iris.open()

obj/console/Atlantis_iriscontrol_manual
	var
		hp
	icon='Icons/AtlantisTurfs.dmi'
	icon_state="console2"
	name = "Atlantis Manual Iris Controls"
	hp = 1000

	desc = "Stops stuff getting in."

	MouseEntered(location, control, params)
		..()
		usr.ShowToolTip(src.name,src.desc)
	MouseExited()
		usr.CloseToolTip()

	var/tmp/obj/Pegasus_Gates/Gate
	New()
		..()
		spawn(5)Move(src.loc)
	Move(atom/newloc,newdir)
		..()
		for(var/obj/Pegasus_Gates/G in range(src,30))
			Gate=G
			break
	DblClick()
		if(usr in oview(src,1))
			if(!Gate)
				for(var/obj/Pegasus_Gates/G in view(src))
					Gate=G
					break
			if(Gate&&Gate.iris)
				if(!Gate.iris.closed())Gate.iris.close()
				else Gate.iris.open()
GDO
	var
		gtype=0 //0 = code; 1 = key; 2 = race; 3 = team
		disabled=0 //1 = disabled; 0 = activated
		desc //description
		data //code, key, race or team
		name //aka label
		locked=0