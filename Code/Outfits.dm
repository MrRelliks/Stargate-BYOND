obj
	OutfitsToShow
		SGC

			//name = "Airforce Uniform (Green)"
			icon = 'Icons/Outfits/sgc2.dmi'

		SGCBlue

		//	name = "Airforce Uniform (Blue)"
			icon = 'Icons/Outfits/SGCBlue.dmi'

		SGCRed

			//name = "Airforce Uniform (Red)"
			icon = 'Icons/Outfits/SGCRed.dmi'

		SGCYellow

		//	name = "Airforce Uniform (Yellow)"
			icon = 'Icons/Outfits/SGCYellow.dmi'


var/const
	HEAD=1
	BODY=2
	BACK=3
	LEGS=4
	OUTFIT=5
	FACE=6

mob
	var/obj
		outfits
			face
			head
			body
			back
			legs
			outfit
			tmp/online
			tmp/use
			tmp/addlist=list()
		olays=list()
	proc
		Overlays()
			..()
			overlays=null
			if(!outfit)
				if(face)overlays+=face
				if(head)overlays+=head
				if(body)overlays+=body
				if(back)overlays+=back
				if(legs)overlays+=legs
				if(hair)overlays+=hair
				//if(cloaked)overlays += cloak_overlay
			else overlays+=outfit
			for(var/obj/O in olays)overlays+=O
	verb
		fixoverlays()
			set name = "Fix Overlays"
			set category = "Commands"
			usr << "SYSTEM: Fixing Overlays!"
			usr.Overlays()
			usr << "SYSTEM: Overlays Should Be Fixed!"


/*
	Stat()
		..()
		Overlays()
*/

obj/outfits
	//icon='Icons/Outfits/base.dmi'
	var
		nomove=0
		lockpick=0
		list/allowed_races = list("Tau'ri","wraith","Goa'uld","Asgard","Nox","Ascended","Ori","Stephonian","Aurian","Kull","Tok'ra","Ancients","Ori Followers","Wraith")
		minplayerlevel = 0
		mob/owner
		pos
		wearing
		worn = 0
		tmp
			coloor_r = 0
			coloor_g = 0
			coloor_b = 0
	layer = MOB_LAYER+2

	New()
		..()
		if(coloor_r||coloor_g||coloor_b)

			src.icon *= rgb(coloor_r,coloor_g,coloor_b)
	DblClick()
		if(src in usr)
			Remove()
			loc=usr.loc
		else if(src in oview(1))loc=usr
	proc
		Remove()
			var/remove
			switch(pos)
				if(HEAD)if(usr.head==src)
					usr.head=null
					remove=1
				if(BODY)if(usr.body==src)
					usr.body=null
					remove=1
				if(BACK)if(usr.back==src)
					usr.back=null
					remove=1
				if(LEGS)if(usr.legs==src)
					usr.legs=null
					remove=1
				if(OUTFIT)if(usr.outfit==src)
					usr.outfit=null
					remove=1
				if(FACE)if(usr.outfit==src)
					usr.face=null
					remove=1
			if(remove)
				usr<<"You removed [src]."
				wearing=0
				suffix="Not Wearing"
			usr.Overlays()
			..()
		Wear()
			switch(pos)
				if(HEAD)
					usr.head=src
				if(BODY)
					usr.body=src
				if(BACK)
					usr.back=src
				if(LEGS)
					usr.legs=src
				if(OUTFIT)
					usr.outfit=src
				if(FACE)
					usr.face=src
			usr<<"You wear [src]."
			wearing=1
			suffix="Wearing"
			usr.Overlays()

	verb
		Use()
			usr.Overlays()
			if(usr.playerlevel<minplayerlevel||!(usr.race in allowed_races))
				usr<<"You can not wear [src]."
				Remove()
			else
				if(src in usr.olays)
					Remove()
				else
					var/remove
					switch(pos)
						if(HEAD)if(usr.head==src)remove=1
						if(BODY)if(usr.body==src)remove=1
						if(BACK)if(usr.back==src)remove=1
						if(LEGS)if(usr.legs==src)remove=1
						if(OUTFIT)if(usr.outfit==src)remove=1
						if(OUTFIT)if(usr.face==src)remove=1
					if(remove)Remove()
					else Wear()
			usr.Overlays()
/*
         ###############################################
         ################# New Outfits #################
         ###############################################
*/




	SGC
		pos=BODY
		name = "Airforce Uniform (Green)"
		icon = 'Icons/Outfits/sgc2.dmi'
		allowed_races = list("Tau'ri")
		worn = 0
	SGCBlue
		pos=BODY
		name = "Airforce Uniform (Blue)"
		icon = 'Icons/Outfits/SGCBlue.dmi'
		allowed_races = list("Tau'ri")
		worn = 0
	SGCRed
		pos=BODY
		name = "Airforce Uniform (Red)"
		icon = 'Icons/Outfits/SGCRed.dmi'
		allowed_races = list("Tau'ri")
		worn = 0
	SGCYellow
		pos=BODY
		name = "Airforce Uniform (Yellow)"
		icon = 'Icons/Outfits/SGCYellow.dmi'
		allowed_races = list("Tau'ri")
		worn = 0

	Wraith
		pos=BODY
		name = "Wraith Armour"
		icon = 'Icons/Outfits/W_Armor.dmi'
		allowed_races = list("Wraith")
		worn = 0




	helmets
		pos=HEAD
		layer = MOB_LAYER+2

/*
         ###############################################
         ################ New Helmates #################
         ###############################################
*/


		//blanket
/*
         ###############################################
         ################ Old Helmates #################
         ###############################################
*/

		SGC
			name = "SGC Hat (Green)"
			icon = 'Icons/Outfits/TauriHelm.dmi'
			icon_state = ""
			suffix = "(Not Wearing)"
			worn = 0
			allowed_races = list("Tau'ri")
		SGCBlue
			name = "SGC Hat (Blue)"
			icon = 'Icons/Outfits/TauriHelmBlue.dmi'
			icon_state = ""
			suffix = "(Not Wearing)"
			worn = 0
			allowed_races = list("Tau'ri")
		SGCRed
			name = "SGC Hat (Red)"
			icon = 'Icons/Outfits/TauriHelmRed.dmi'
			icon_state = ""
			suffix = "(Not Wearing)"
			worn = 0
			allowed_races = list("Tau'ri")
		SGCYellow
			name = "SGC Hat (Yellow)"
			icon = 'Icons/Outfits/TauriHelmYellow.dmi'
			icon_state = ""
			suffix = "(Not Wearing)"
			worn = 0
			allowed_races = list("Tau'ri")
		WraithMask
			name = "Wraith Drone Mask"
			icon = 'Icons/Outfits/W_Drone_Mask.dmi'
			icon_state = ""
			suffix = "(Not Wearing)"
			worn = 0
			allowed_races = list("Wraith")




obj/outfits
	helmets






