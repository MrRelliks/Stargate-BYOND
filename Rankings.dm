


#define DEBUG
/Rank_Entry/
	var{Name;Key;M_Level;S_Level;Kill_Level;E_Level;Date;kills;deaths;Repkills}
	New(mob/person)
		if(!person)return
		Name=(person.name)
		Key=(person.key)
		M_Level=(person.MiningLevel)
		S_Level=(person.SmithingLevel)
	//	C_Level=(person.craft_skill)
	//	Kill_Level=(person.kills+person.Repkills-person.deaths)
	//	E_Level=(person.engineering_skill)
		Date=(time2text(world.realtime))
/proc/
	M_Ranking(var/mob/player)
		if(!player||!player.client)return
		if(player.ckey =="") return
		var/savefile/F=new("SaveFile/mining.sav")
		var/list/MiningLevel=new()
		F[("stuff")]>>(MiningLevel)
		if(!MiningLevel)MiningLevel=new()
		var{character="[(player.client.ckey)]/[(player.name)]"
			score=MiningLevel.Find(character)
			Rank_Entry/newest=new(player)
			Rank_Entry/last}
		if(score)
			var/Rank_Entry/old=(MiningLevel[(character)])
			if(old.M_Level>=player.MiningLevel)return score
			while(score>1)
				last=MiningLevel[(MiningLevel[(score-1)])]
				if(last.M_Level>=player.MiningLevel)break
				MiningLevel[(score)]=(MiningLevel[(score-1)])
				MiningLevel[(--score)]=(character)
				MiningLevel[(MiningLevel[(score+1)])]=(last)
			MiningLevel[(character)]=(newest)
			F[("stuff")]<<(MiningLevel)
			return score
		score=(MiningLevel.len)
		if(score>=50)
			last=(MiningLevel[(MiningLevel[(score)])])
			if(last.M_Level>=player.MiningLevel)return 11
			MiningLevel[(score)]=(character)
		else score=(MiningLevel.len+1),MiningLevel+=(character)
		while(score>1)
			last=(MiningLevel[(MiningLevel[(score-1)])])
			if(last.M_Level>=player.MiningLevel)break
			MiningLevel[(score)]=(MiningLevel[(score-1)])
			MiningLevel[(--score)]=(character)
			MiningLevel[(MiningLevel[(score+1)])]=(last)
		MiningLevel[(character)]=(newest)
		F[("stuff")]<<(MiningLevel)
		return score


	S_Ranking(var/mob/player)
		if(!player||!player.client)return
		if(player.ckey =="") return
		var/savefile/F=new("SaveFile/Smithing.sav")
		var/list/SmithingLevel=new()
		F[("stuff")]>>(SmithingLevel)
		if(!SmithingLevel)SmithingLevel=new()
		var{character="[(player.client.ckey)]/[(player.name)]"
			score=SmithingLevel.Find(character)
			Rank_Entry/newest=new(player)
			Rank_Entry/last}
		if(score)
			var/Rank_Entry/old=(SmithingLevel[(character)])
			if(old.M_Level>=player.SmithingLevel)return score
			while(score>1)
				last=SmithingLevel[(SmithingLevel[(score-1)])]
				if(last.S_Level>=player.SmithingLevel)break
				SmithingLevel[(score)]=(SmithingLevel[(score-1)])
				SmithingLevel[(--score)]=(character)
				SmithingLevel[(SmithingLevel[(score+1)])]=(last)
			SmithingLevel[(character)]=(newest)
			F[("stuff")]<<(SmithingLevel)
			return score
		score=(SmithingLevel.len)
		if(score>=50)
			last=(SmithingLevel[(SmithingLevel[(score)])])
			if(last.S_Level>=player.SmithingLevel)return 11
			SmithingLevel[(score)]=(character)
		else score=(SmithingLevel.len+1),SmithingLevel+=(character)
		while(score>1)
			last=(SmithingLevel[(SmithingLevel[(score-1)])])
			if(last.S_Level>=player.SmithingLevel)break
			SmithingLevel[(score)]=(SmithingLevel[(score-1)])
			SmithingLevel[(--score)]=(character)
			SmithingLevel[(SmithingLevel[(score+1)])]=(last)
		SmithingLevel[(character)]=(newest)
		F[("stuff")]<<(SmithingLevel)
		return score

