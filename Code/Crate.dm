obj
	crate

		icon_state="crate"
		density=1
		desc = "A crate that contains an item"
		var/items=50
		var/hp

		var/destroyable
		//var/zathits = 0
		name="Crate"
		var/item
		hp = 100
		destroyable = 1
		proc
			zatdie()
				if(src.icon_state == "crate")
					src.icon_state = "cratedead"
					src.items = 0
					spawn(3000)
						icon_state = "crate"
						src.items  = initial(items)
						src.invisibility = 0
						src.density = 1
		Del()
			var/oldx = src.x
			var/oldy = src.y
			var/oldz = src.z
			..()
			spawn(100)
				var/obj/D = new src.type
				D.loc = locate (oldx,oldy,oldz)
		DblClick()
			if(src.item in usr.contents)
				usr << "You already have that"
			else
				if(src in oview(1))
				else return
				if(icon_state == "cratedead")
					alert("This crate is wrecked!")
					return
				if(!item)
					alert("This crate was never used!")
					return
				if(items<=0)
					alert("This crate is empty!")
					return
				if(usr.contents.len>=usr.weight)
					usr << "You have too many items!"
					return

				items-=1
				usr.contents+=new src.item



		TauriRedOutfit
			name="Tauri Outfits (Red)"
			item=/obj/outfits/SGCRed
		TauriBlueOutfit
			name="Tauri Outfits (Blue)"
			item=/obj/outfits/SGCBlue
		TauriYellowOutfit
			name="Tauri Outfits (Yellow)"
			item=/obj/outfits/SGCYellow
		TauriGreenOutfit
			name="Tauri Outfits (Green)"
			item=/obj/outfits/SGC