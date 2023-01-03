mob
	var
		powerlevel = 1
		defencepower = 0
		attackpower = 0
		reconpower = 0
	proc
		LoginSkillCheck()
		///Research
			winset(src, "empire.research", "value=[src.researchbarvalue]")
			winset(src, "empire.researchlvllabel", "text=[src.researchlvl]");
			///Tech
			winset(src, "empire.tech", "value=[src.techbarvalue]")
			winset(src, "empire.techlvllabel", "text=[src.techlvl]");
			//Production
			winset(src, "resources.miningcost", "text=[src.amountperminer]");
			winset(src, "resources.miningcostiron", "text=[src.amountpermineriron]");
			winset(src, "resources.minerslabel", "text=[src.miners]");
			winset(src, "resources.minerslabeliron", "text=[src.minersiron]");
			///Elements
			winset(src, "resources.iron", "text=[src.iron]");
			winset(src, "resources.bronze", "text=[src.naquadah]");
			winset(src, "resources.naquadria", "text=[src.naquadriah]");
			winset(src, "resources.trinium", "text=[src.trinium]");
			///
			winset(src, "resources.minercost", "text=[src.amountperminer]");
			winset(src, "resources.minerprogress", "value=[miningbarvalue]");
			winset(src, "resources.bronze", "text=[src.naquadah]");
			//winset(src, "resources.techlvllabel", "text=[src.techlvl]");
			/////
			winset(src, "resources.minercostiron", "text=[src.amountpermineriron]");
			winset(src, "resources.minerprogressiron", "value=[miningbarvalueiron]");
			winset(src, "resources.iron", "text=[src.iron]");
			src.TrainResearchProc()
			src.TraintechProc()

			//usr.StartMining()
			sleep(10)
			usr.MiningProductionNaq()
			sleep(10)
			usr.MiningProductionIron()
	verb
		OpenEmpire()
			set category = "Empire"
			winset(src, "mainwindow.MapOutput", "left=empire;")
		OpenResources()
			winset(src, "mainwindow.MapOutput", "left=resources;")
		CloseEmpire()
			winset(src, "mainwindow.MapOutput", "left=mappane;")