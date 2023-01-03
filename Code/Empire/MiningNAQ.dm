mob
	var
		miners = 0
		mininggeneration = 1
		amountperminer = 1
		naquadagained
		miningjobsavailable = 10
		miningprogress = 0
		miningprogressmax = 600 //seconds
		miningbarvalue
		iron = 0
		activemining = 0
		trinium = 0
		naquadriah = 0
		elementpick
		bronzeoriron
		naquadahlabel
		timeleft = 0

	verb
		StartMining()
			src.MiningProductionNaq()
			src.MiningProductionIron()
			//	src << "tech Stopped."

		BuyMiner()
			if(src.naquadah >= amountperminer)
				if(!src.activemining == 1)

					src.naquadah -= amountperminer
					src.miners+= 1
					src.activemining = 1
					winset(src, "resources.minercost", "text=[src.amountperminer]");
					winset(src, "resources.minerslabel", "text=[src.miners]");
					winset(src, "resources.bronze", "text=[src.naquadah]");
					src.MiningProductionNaq()
				else

					src.naquadah -= amountperminer
					src.miners+= 1
					src.amountperminer += src.amountperminer * 0.34
					winset(src, "resources.minercost", "text=[src.amountperminer]");
					winset(src, "resources.minerslabel", "text=[src.miners]");
					winset(src, "resources.bronze", "text=[src.naquadah]");
					src.MiningProductionNaq()
			else
				src << "You do not have enough Naquada to fullfil that order"

	proc
		MiningProductionNaq()
			//src.activemining = 1
			if(src.miners >= 1)

				src.miningbarvalue = ((src.miningprogress / src.miningprogressmax) * 100)
				winset(src, "resources.minercost", "text=[src.amountperminer]");
				src.miningprogress += 1
				winset(src, "resources.timeleft", "text=[src.timeleft]");
				src.ProgressCheck()
				winset(src, "resources.minerprogress", "value=[miningbarvalue]");
				src.MiningProductionNaq()
			else
				return


		ProgressCheck()
			if(src.miningprogress >= miningprogressmax)
				src.miningprogress -= src.miningprogressmax
				winset(src, "resources.minerprogress", "value=0");
				src.timeleft = src.miningprogressmax - src.miningprogress
				//src.miningprogressmax += miningprogressmax * 0.13
				src.naquadah += (src.mininggeneration * src.miners) * 10
				src.miningprogress = 0
				//src.mininggeneration += src.mininggeneration * 0.002
				winset(src, "resources.bronze", "text=[src.naquadah]");
				winset(src, "resources.techlvllabel", "text=[src.techlvl]");





