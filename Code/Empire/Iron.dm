mob
	var
		minersiron = 0
		irongeneration = 1
		amountpermineriron = 5
		irongained
		miningjobsavailableiron = 10
		miningprogressiron = 0
		miningprogressmaxiron = 600
		miningbarvalueiron
		miningactive = 0


	verb
		BuyMineriron()
			if(src.naquadah >= amountpermineriron)
				if(!src.miningactive == 1)
					src.naquadah -= amountpermineriron
					src.minersiron+= 1
					src.miningactive = 1
					src.amountpermineriron += src.amountpermineriron * 0.34
					winset(src, "resources.minercostiron", "text=[src.amountpermineriron]");
					winset(src, "resources.minerslabeliron", "text=[src.minersiron]");
					winset(src, "resources.iron", "text=[src.iron]");
					src.MiningProductionIron()
				else
					src.naquadah -= amountpermineriron
					src.minersiron+= 1
					//src.miningactive = 1
					src.amountpermineriron += src.amountpermineriron * 0.34
					winset(src, "resources.minercostiron", "text=[src.amountpermineriron]");
					winset(src, "resources.minerslabeliron", "text=[src.minersiron]");
					winset(src, "resources.iron", "text=[src.iron]");
					src.MiningProductionIron()
			else
				src << "You do not have enough Naquada to fullfil that order"

	proc
		MiningProductionIron()
			//src.miningactive = 1
			if(src.minersiron >= 1)
				src.miningbarvalueiron = (src.miningprogressiron / src.miningprogressmaxiron) * 100
				winset(src, "resources.minercostiron", "text=[src.amountpermineriron]");
				src.miningprogressiron += 1
				src.ProgressCheckIron()
				winset(src, "resources.minerprogressiron", "value=[miningbarvalueiron]");
				sleep(10)
				src.MiningProductionIron()
			else
				return

		ProgressCheckIron()
			if(src.miningprogressiron >= miningprogressmaxiron)
				src.miningprogressiron -= miningprogressmaxiron
				winset(src, "resources.minerprogressiron", "value=0");
			//	src.miningprogressmaxiron += miningprogressmaxiron * 0.13
				src.iron += (src.irongeneration * src.minersiron) * 10
				src.miningprogressiron = 0
				//src.irongeneration += src.irongeneration * 0.12
				winset(src, "resources.iron", "text=[src.iron]");

				//winset(src, "resources.techlvllabel", "text=[src.techlvl]");








