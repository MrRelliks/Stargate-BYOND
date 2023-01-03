#define DEBUG




client
	Topic(href,href_list[])
		if(href=="Close")
			usr << browse(null,"window=who")
			usr << browse(null,"window=popup")
		else
			..()



mob/verb/openscores()
	set hidden = 1
	src.ShowScores()
	src<<link("byond://?score=ranks_mine")
client/verb/miningscores()
	set hidden=1
	src<<link("byond://?score=ranks_mine")

client/verb/smithingscores()
	set hidden=1
	src<<link("byond://?score=ranks_smith")



client/Topic(href,href_list[],hsrc)
	if(href_list["score"])
		var/html=Main+console_css
		html+="</center></div>"
		html+={"<center><div id="content_container">"}
		switch(href_list["score"])

			if("ranks_mine")
				html+={"<div class="content">
<h1>Highscores : Mining</h1>"}
				var/list/levels=new()
				var/savefile/F=new("SaveFile/mining.sav")
				F[("stuff")]>>(levels)
				if(!levels)html+={"<div class="content">Nothing To Display Here</div><div id="clear"></div></div>"}
				else
					for(var/number in 1 to levels.len)
						var{character=(levels[(number)]);Rank_Entry/player=(levels[(character)])}
						html+={"<b>Rank (#[(number)])</b> User : <font face="arial" coloor="red">[(player.Name)]</font> | Mining Lvl : <b><i>[num2text(round(player.M_Level),100)]</i></b> |<br>"}
				html+={"</div>
 <div id="clear"></div>
    </div>
</div>"}
			if("ranks_smith")
				html+={"<div class="content">
<h1>Highscores : Smithing</h1>"}
				var/list/levels=new()
				var/savefile/F=new("SaveFile/Smithing.sav")
				F[("stuff")]>>(levels)
				if(!levels)html+={"<div class="content">Nothing To Display Here</div><div id="clear"></div></div>"}
				else
					for(var/number in 1 to levels.len)
						var{character=(levels[(number)]);Rank_Entry/player=(levels[(character)])}
						html+={"<b>Rank (#[(number)])</b> User : <font face="arial" coloor="red">[(player.Name)]</font> | Smithing Lvl : <b><i>[num2text(round(player.S_Level),100)]</i></b> |<br>"}
				html+={"</div>
 <div id="clear"></div>
    </div>
</div>"}
		src << browse(html, "window=Scores.Scoreboard;can-scroll:none;can_minimize=0;can_resize=0;size=500x340")
		return 0
	return ..()