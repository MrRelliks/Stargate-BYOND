area
	nofight
mob
	var

		NPC = 0


mob/Enemies
	var
		mob/P
		atom/target = null
		RepLevel = 1
		RepAte = 0
		Resources = 0
		bite = 0
		aggrolevel = 100
		aggrotimer = 600
		AOS=0 //Attack On Sight
		AWA=0 //Attack When Attacked
		walks=0 //Walks
		Mdmg=0  //Maximum damage
		mdmg=0  //Minimum damage
		view=3   //how far a monter can look for a player
		wspeed=5  //walk speed
		aspeed=5  //attack speed
	//	attacked=0
		mob/attacker
		def
		//NPC = 0





	wraith
		icon = 'Icons/Mobs/wraith.dmi'
		icon_state = "neutral"
		NPC = 1
		AOS = 1
		hp = 100
		//powerlevel = 50
		aggrolevel = 100
		aggrotimer = 600
		walks=1


