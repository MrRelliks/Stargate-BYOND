mob
	var

		////
		////Research Skill
		////
		researchtraining = 0
		researchxp = 0
		researchmaxxp = 100
		researchxprate = 5
		researchbarvalue
		researchlvl = 0

	verb
		TrainResearch()
			if(src.researchtraining)
				src.researchtraining = 0
				src << "Research Stopped."
			else
				src.researchtraining = 1
				src.TrainResearchProc()
				src << "Research Started."
	proc

		TrainResearchProc()
			while(src.researchtraining == 1)
				src.researchxp += src.researchxprate
				//src << "Your xp rate is [src.researchxprate]"
				src.researchbarvalue = (src.researchxp / researchmaxxp)  * 100
				src.ResearchXPCheck()
				sleep(10)


		ResearchXPCheck()
			if(src.researchtraining == 1)
				if(src.researchxp >= researchmaxxp)
					src.researchxp = 0
					src.researchmaxxp = src.researchmaxxp + (src.researchmaxxp * 0.3)
					src.researchxprate = src.researchxprate + (src.researchxprate * 0.18)

					src.researchlvl += 1
					winset(src, "empire.researchlvllabel", "text=[src.researchlvl]");
					src << "You have gained a level in research, you are now level [src.researchlvl]."
					winset(src, "empire.research", "value=0");
				else
					winset(src, "empire.research", "value=[src.researchbarvalue]");
			else
				src.researchtraining = 0
				winset(src, "empire.research", "value=[src.researchbarvalue]");


