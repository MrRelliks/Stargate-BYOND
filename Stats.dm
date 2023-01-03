//recoded by  Due to the old stats looking like a peice of crap lol



mob
	var
		ability
		powering
		tmp/oloc
		tmp/canmed
		tmp/whung
		AbletoSell
		issleeping = 0 //Hybernation variable

	Move()
		..()
		spawn(5)oloc=loc
	proc/HPSet()
		switch(race)
			if("Asgard")maxhp = 100
			if("Nox")maxhp = 100
			if("Tolan")maxhp = 100
			if("Tok'ra")maxhp = 120
			if("Kull")maxhp = 120
			if("Ascended")maxhp = 150
			if("Goa'uld")maxhp = 120
			if("Tau'ri")maxhp = 100
			if("Ori")maxhp = 150
			if("wraith")maxhp = 120
			if("Atlantean")maxhp = 100
			if("Ori Followers")maxhp = 110
			if("Wraith")maxhp = 150
			if("Ancients")maxhp = 120
			if("Aurian")maxhp = 100
		..()
	Stat()
		HPSet()
		if(oloc==loc||!oloc)canmed++
		else canmed=0
		if(!isnum(playerlevel))playerlevel=4
		if(race in list("Goa'uld","Tok'ra","Nox","wraith"))
			if(canmed>=10)if(hp < maxhp)
				if(prob(40))
					hp = min(hp+rand(1,2),maxhp)
		if(race=="Wraith") //Wraith hunger
			if(issleeping)return
			if(hp>30)
				whung++
				if(whung>=5)
					whung=0
					sleep(100)
					hp-=1
	/*	if(myship)
			if("Auto Repair" in myship.custs)
				if(myship.hp >= initial(myship.hp))
					myship.hp = initial(myship.hp)
				else
					myship.hp += 20*/

		if(ability&&powering <=7000)
			powering +=5
			if(powering >7000)
				powering = 7000
		/*if(statpanel("Empire"))
			//stat("<b><font color=black size=3>[src.key] ([src.PlayerID])</font></b>",d)
			var/obj/Q = new()
			Q.name = "Power Level\nOffensive Power\nDefensive Power"
			Q.suffix = "[PowerLevel]\n[OffensivePower]\n[DefensivePower]"
			stat("<b><font color=#9e9e9e size=3>Empire</font></b>",Q)
			var/obj/E = new()
			E.name = "Untrained Units\nOffensive Troops\nDefensive Troops"
			E.suffix = "[Proc_CovertToAbbreviatedForm(num2text(untrainedunits))]\n[Proc_CovertToAbbreviatedForm(num2text(offensivetroops))]\n[Proc_CovertToAbbreviatedForm(num2text(defensivetroops))]"
			stat("<b><font color=#9e9e9e size=3>Army</font></b>",E)

		if(statpanel("Player"))
			var/obj/d = new /obj
			d.icon = src.icon
			for(var/G in src.overlays)
				d.overlays +=G
			d.name = null
			stat("<b><font color=black size=3>[src.key] ([src.AFKLabel])</font></b>",d)
			var/obj/D = new()
			D.name = "HP\nRace\nQuest Points\nCPU Usage"
			D.suffix = "[hp]/[maxhp]\n[race]\n[qpoints]\n[world.cpu]%"
			stat("<b><font color=#9e9e9e size=3>Player</font></b>",D)
			////////////////////////////////////////////////
			var/obj/P = new()
			P.name = "Naquadah"
			P.suffix = "[naquadah]"
			stat("<b><font color=#9e9e9e size=2>Info</font></b>", P)

			////////////////////////////////////////////////
			var/obj/M = new()
			M.name = "Mining Lvl\nMining XP\nProgress"
			M.suffix = "[usr.MiningLevel]\n[usr.totalminingXP]\n[round((usr.MiningEXP/usr.MiningMaxEXP)*100,1)]%"
			stat("<b><font color=#D15CDB size=2>Mining</font></b>", M)
			var/obj/S = new()
			S.name = "Smithing Lvl\nSmithing XP\nProgress"
			S.suffix = "[usr.SmithingLevel]\n[usr.totalSmithingXP]\n[round((usr.SmithingEXP/usr.SmithingMaxEXP)*100,1)]%"
			stat("<b><font color=#CC680F size=2>Smithing</font></b>", S)*/



/*
		if(statpanel("Skills"))
			var/obj/O = new()
			O.name = "Crafting Level : [craft_skill] /n Exp : [craft_exp] /nExp Needed : [craft_expmax] \n Engineering /nLevel : [engineering_skill] /nExp : [engineering_exp] /nExp Needed : [engineering_expmax]\n Mining /nLevel : [MiningLevel] /nExp : [MiningEXP] /nExp Needed : [MiningMaxEXP] \n Archeology /nLevel : [ArchLevel] /nExp : [ArchEXP] /nExp Needed : [ArchMaxEXP]"
			O.suffix = ""
			stat("<b><font color=red size=4>Skills</font></b>", O)
	*/







		/*if(statpanel("Inventory"))
			var/list/items[0]
			for(var/obj/X in src.contents)
				if((X.name in items))continue
				items+=X.name
				var/i=0
				for(var/obj/Y in src.contents)if(Y.name==X.name)i++
				if(i>1)
					stat(new/stat/stack(X.name,X.type,"x[i]",X.icon,X.icon_state,src))
					if(X.name in stack_selected)
						stat("----")
						for(var/obj/Y in src.contents)if(Y.name==X.name)
							stat(Y)
						stat("----")
				else stat(X)
			stat("Total:","[contents.len]/28")*/






	/*	if(statpanel("Friends"))


			for(var/X in Buddies)

				if(X in playerlist)

					for(var/mob/M in world)
						if(M.ckey == ckey(X)&&src.key in M.Buddies)
							if(Buddies[X] !=M.name)
								Buddies[X] = M.name
							var/obj/d = new /obj

							d.icon = M.icon


							for(var/G in M.overlays)
								d.overlays +=G
							d.name = null
							stat("[M.name]",d)
							//stat("<font color=green size=2>Friend Stats</font>","Health Stats : [M.hp]/[M.maxhp]\nRank/Race : [M.Rank]/[M.race]\nLocation : [M.cplanet()]")
							stat("Health Stats","[M.hp]/[M.maxhp]")
							stat("Rank/Race","[M.Rank]/[M.race]")

						else if(M.ckey == ckey(X)&&!istype(M,/mob/other/choosing_character))
							stat("[Buddies[X]]-- Offline","")
							stat("This user hasnt added you to thier list","Stats Unknown")
						else if(M.ckey == ckey(X)&&istype(M,/mob/other/choosing_character))
							stat("[Buddies[X]] Offline","")
				else
					stat("[Buddies[X]]-- Offline","")
		..()

*/



