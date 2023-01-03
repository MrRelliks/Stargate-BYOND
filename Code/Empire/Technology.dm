mob
	var
		tech = 0
		techlvl =0
		techxp = 0
		techmaxxp = 150
		techxprate = 4
		techbarvalue
		techtraining = 0
	verb
		Traintech()
			if(src.techtraining)
				src.techtraining = 0
				src << "tech Stopped."
			else
				src.techtraining = 1
				src.TraintechProc()
				src << "tech Started."
	proc

		TraintechProc()
			while(src.techtraining == 1)
				src.techxp += src.techxprate
				//src << "Your xp rate is [src.techxprate]"
				src.techbarvalue = (src.techxp / techmaxxp)  * 100
				src.techXPCheck()
				sleep(10)


		techXPCheck()
			if(src.techtraining == 1)
				if(src.techxp >= techmaxxp)
					src.techxp = 0
					src.techmaxxp = src.techmaxxp + (src.techmaxxp * 0.3)
					src.techxprate = src.techxprate + (src.techxprate * 0.18)

					src.techlvl += 1
					winset(src, "empire.techlvllabel", "text=[src.techlvl]");
					src << "You have gained a level in tech, you are now level [src.techlvl]."
					winset(src, "empire.tech", "value=0");
				else
					winset(src, "empire.tech", "value=[src.techbarvalue]");
			else
				src.techtraining = 0
				winset(src, "empire.tech", "value=[src.techbarvalue]");