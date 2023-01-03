mob
/*	New()
		x = 13
		y = 14*/ // I dont even remember what this does.

var
	obj/staffbadge = new()

obj/staffbadge
	icon = 'StaffIcons.dmi'
	icon_state = "staff"

client

	// I made key_info literally just to grab your member icon URL from the hub.
	var key_info/key_info



	New()
		key_info = new(key)
		return ..()

	verb


		Suicide()
			set name = "Suicide"
			set category = "Commands"
			var/AreYouSure = input("Are you sure you want to commit suicide?")in list ("Yes","No")
			switch(AreYouSure)
				if("Yes")
					usr.die("Suicide")
				if("No")
					return
		// Basic chat command, but with an added webhook.
		Universe(msg as message)
			set category = null
			if(ckey in debug)
				if(!msg)
					return
				else
					world << "<b>Universe >><font face='Arial' color=[usr.chat_color] size='1'>  [usr.key]  :  [msg] </font></b>"
			else
				if(!msg)
					return
				else
					world << "<b>Universe >><font face='Arial' color=[usr.chat_color] size='1'>  [usr.key]  :  [msg] </font></b>"
			universe<<"[time2text(world.realtime)] - [usr.key]: [msg] "

			// Send the message to the Discord webhook.
			HttpPost(
				/* Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					It's best to use a global const for this and keep it secret so others can't use it.
				*/
				"https://discord.com/api/webhooks/944972131295453214/sTIJrMCKhKJv61ntVJa8P_eACu4HWyXTGPN9VEBmdygyfJSfNlRwLL7cIvp5Y4LK6QeoDELETEME",

				/*
				[content] is required and can't be blank.
					It's the message posted by the webhook.

				[avatar_url] and [username] are optional.
					They're taken from your key.
					They override the webhook's name and avatar for the post.
				*/
				list(
					content = msg,
					avatar_url = key_info.IconURL(),
					username = key
				)
			)
client
	Southwest()
		if(mob.mining) return


		var/distance = rand(3,5)








		while(distance)
			sleep(3)

			distance--
	Northeast()
		if(mob.mining) return
		mob.dir = turn(mob.dir,90)
	Northwest()
		if(mob.mining) return
		mob.dir = turn(mob.dir,-90)
	Southeast()
	Center()
		if(mob.mining) return
		if(!mob.weapon)return 0
		if(mob.weapon)mob.weapon.fire()




mob
	var
		race
		hp
		maxhp


		strength
		attack
		defence
		coins
		move
		weight = 28
		qpoints
		naquadah
		attacked = 0
		kills = 0
		deaths = 0
		obj/items/weapon/weapon
		chat_color = "#FFFFFF"
		unlockedpegasus = 0

		respawntime = 100
		base_speed = 32



		//////VARIOUS/////

		card_bugged = 0
		safe = 0

	icon = 'Icons/player.dmi'
	icon_state="player"



	proc

		die(msg as text)
			if(safe)return
			src<<"<font color='red'> Alert: </font>You have died please wait 10 seconds before respawning"
			world<<output("<font color='black'><b> [src] has been killed by [msg]</b>","Server")
			//world<<"[src] has been killed by [msg]"
			src.hp=src.maxhp
			src.loc=null
			sleep(respawntime)
			if(src.race == "Tau'ri")
				src.loc=locate(67,35,5)
			else
				if(src.race == "Wraith")
					src.loc=locate(55,63,4)
					//src << "<font color='red'> Alert: </font>There is no Wraith Homeworld right now, So you've been plopped on a neutral world"
				else
					src << "<font color='red'> Alert: </font>We could not determine your Race, So you have been placed in a Neutral Location"
					src.loc=locate(39,36,1)

		//	src.loc=locate(respawnloc)
		//	src.loc=locate(60,53,2)
			//if(src.client)src.client.eye=src
			//src<<"Respawn time"
			src.attacked=0
			src.deaths += 1
	verb



		Say(msg as text)
			if(ckey in muted)return
			if(!msg||msg==""||msg==" ")return
			for(var/mob/M in view(10))
				if(ckey in debug)
					M << "<b><font face='Arial' color=[usr.chat_color] size='1'>(Say) [usr.name]</font> </b>>> <font face='Arial' color='white' size='1'> [msg]</font>"
				else
					M << "<font face='Arial' color=[usr.chat_color] size='1'> (Say) [usr.name]</font>>>> <font face='Arial' color='white' size='1'> [msg]</font>"
			say<<"[time2text(world.realtime)] - [usr.key]: [msg] "

		emote(msg as null|text)
			set name="Emote"
			set category = null
			if(!msg||msg==" "||msg=="  ")return
			if(ckey in muted)return
			if(length(msg)>=300)msg=copytext(msg,1,300)
			msg=dd_replacetext(msg,"\n","")
			msg=html_encode(msg)
			range(6) << "<font color='white' face='Arial' size='1'>*[src.name] [msg]*"
			universe<<"[time2text(world.realtime)] - *[usr.key]: [msg] *"


