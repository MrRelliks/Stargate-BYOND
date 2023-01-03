


mob
	var
		tmp/feeding = 0
		tmp/beingfedupon = 0

	proc // Tooltips - tool tips - coded by Matt 07/06/2021
		/*

		Usage

		MouseEntered(location, control, params)
			..()
			usr.ShowToolTip(src.name,src.desc)
		MouseExited()
			usr.CloseToolTip()



		*/
		ShowToolTip(name,description)
			if(src in usr.contents)
				return
			else
				winset(usr, "mappane.tooltipoutput", "is-visible=true")
				winset(usr, "mappane.tooltiplabel", "is-visible=true")
				winset(usr, "mappane.tooltipicon", "is-visible=true")

				usr<<output(null,"mappane.tooltipoutput") //clear the previous tooltip
				usr<<output("<center><strong>[name]</strong><br>[description]</center>","mappane.tooltipoutput")
		CloseToolTip()
			winset(usr, "mappane.tooltipoutput", "is-visible=false")
			winset(usr, "mappane.tooltiplabel", "is-visible=false")
			winset(usr, "mappane.tooltipicon", "is-visible=false")


	verb
		Feed(mob/X)
			set category = "Wraith"
			set hidden = 0
			if(src.race == "Wraith")
				if(istype(src.loc.loc,/area/nofight))
					src << "This is a protected world, feed your hunger elsewhere."
					return
				if(X.race == "Wraith" || X.race == "Ascended")return
				if(X in range(1))
					if(X == src)
						return
					else
						if(src.feeding)
							return
						else
							src.feeding = 1
							while(feeding)
								src << "You begin to feed on [X.name]"
								X.beingfedupon = 1
								X.move = 0
								X << "You feel the life being sucked out of you"
								X.hp -= 10
								src.hp += 10
								s_damage(src,"10","green")
								src << "You Gain 10 life points"
								X << "You lose 10 life points"
								if(X.hp <= 0)
									if(X.client)
										X.die("Being Fed Upon")
										X.beingfedupon = 0
										src.feeding = 0
										X.move = 1
										src << "You stop feeding"
										break
									else
										src.feeding = 0
										src << "You stop feeding"
										del(X)
										break
								if(src.hp >= 150)
									X.beingfedupon = 0
									src.feeding = 0
									X.move = 1
									src << "You are now at full health and can feed no more!"
									src.hp = 150
									break
								sleep(20)
			else
				src << "Only Wraith can feed"
				src.verbs-=typesof(/mob/verb/Feed)
				return
	TestSubject
		icon = 'Icons/Mobs/Male.dmi'
		name = "Human Cattle"
		hp = 100
		desc = "Live cattle, fresh from the many planets we have culled. Delicious."

		MouseEntered(location, control, params)
			..()
			usr.ShowToolTip(src.name,src.desc)
		MouseExited()
			usr.CloseToolTip()
		Del()
			//var/roll = pick(src.drops)
		//	new roll(src.loc)
			src.loc = null
			sleep(3000)
			//src.restore_stats()
			src.hp = 100
			src.beingfedupon = 0
			src.loc=initial(src.loc)
			if(!z)del src //if it has no initial location [eg: not placed on map), it is deleted





