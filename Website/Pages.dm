




client
	Topic(href,href_list[])
		if(href=="Close")
			usr << browse(null,"window=who")
			usr << browse(null,"window=popup")
		else
			..()

client/verb/sgf()
	set hidden=1
	src<<link("byond://?sgo=archive")

client/verb/sgfonline()
	set hidden=1
	src<<link("byond://?sgo=online")
client/verb/sgfTutorial()
	set hidden=1
	src<<link("byond://?sgo=Tutorial")

client/verb/sgfrules()
	set hidden=1
	src<<link("byond://?sgo=rules")

client/verb/sgfgates()
	set hidden=1
	src<<link("byond://?sgo=gateaddress")





client/Topic(href,href_list[],hsrc)
	if(href_list["sgo"])
		var/html=Main+console_css
		html+="</center></div>"
		html+={"<center><div id="content_container">"}
		switch(href_list["sgo"])
			if("archive")
				html+={"<div class="content">
				[Updates]
				</div>
				"}


			if("hyperdrive")
				html+={"<div class="content">
				<ul><h1>Hyperspace Coordinates</h1>
				<ul>
				<li>Coming Soon</li>

				"}
			if("rules")
				html+={"
<div class="content">
	[gamerules]


</div>"}

			if("player")
				html+={"<div ><center><h1>Stargate BYOND</h1>Health [usr.hp] / [usr.maxhp] </center><br><style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-0lax{text-align:center;vertical-align:top}
</style><table class="tg">
  <tr>
    <th class="tg-0lax"><span style="font-weight:bold">Player Name</span></th>
    <th class="tg-0lax"><b><font size = 5; color = "orange">[usr.name]</font></b></th>
    <th class="tg-0lax"><span style="font-weight:bold">Race</span></th>
    <th class="tg-0lax"><b><font size = 5>[usr.race]</font></b></th>
  </tr>
  <tr>
    <th class="tg-0lax"><span style="font-weight:bold">Health</span></th>
    <th class="tg-0lax"><b><font size = 5; color = "orange">[usr.hp]/[usr.maxhp]</font></b></th>
    <th class="tg-0lax"><span style="font-weight:bold">Naquada</span></th>
    <th class="tg-0lax"><b><font size = 5>[usr.naquadah]</font></b></th>
  </tr>
  <tr>
    <td class="tg-0lax"><span style="font-weight:bold">Skill name</span></td>
    <td class="tg-0lax"><span style="font-weight:bold">Level</span></td>
    <td class="tg-0lax"><span style="font-weight:bold">Total XP</span></td>
    <td class="tg-0lax"><span style="font-weight:bold">XP Til Next Level</span></td>
  </tr>
  <tr>
    <td class="tg-0lax">Mining</td>
    <td class="tg-0lax">[usr.MiningLevel]</td>
    <td class="tg-0lax">[usr.MiningEXP]</td>
    <td class="tg-0lax">[round((usr.MiningEXP/usr.MiningMaxEXP)*100,1)]%</td>
  </tr>

</table>
</div>"}
			if("Tutorial")
				html+={"<div> <p>Welcome to Stargate BYOND, [usr.name] in this tutorial we will teach you the basics of the game, but please note that the game is still in development and it is important you check back here to see if anything new has been added.</p>
<p><strong>Mining</strong></p>
<p>The Mining Skill is a very important part of the game, training it to higher levels will not only unlock higher tier ores to acquire but it will enable you to craft items and generate naquada faster.</p></div>"}



			if("online")
				html+={"<div class="content">
 <h1>Online List</h1>"}
				for(var/mob/M in world)if(M.client)
					if(M.ckey in debug)
						if(M.AFK == 1)
							html+={"(Away) --- <b> (Staff)</b>(Key : [M.key]), User : [M.name] [M.Rank] of the [M.race] | <i>[M.status]</i> |<br>"}
						else
							html+={"<b>Staff : </b>(Key : [M.key]), User : [M.name] [M.Rank] of the [M.race] | <i>[M.status]</i> |<br>"}
					else
						if(M.AFK == 1)
							html+={"(Away) --- (Key : [M.key]), User : [M.name] [M.Rank] of the [M.race] | <i>[M.status]</i> |<br>"}
						else

							html+={"(Key : [M.key]), User : [M.name] [M.Rank] of the [M.race] | <i>[M.status]</i> |<br>"}
						html+={"</div>
						"}


			if("gateaddress1")
				html+={"<div class="content">
<h1>Stargate Address</h1>
						<p>The Following Stargates are listed below</p>
					</div>
				"}
				for(var/obj/Stargate/G in world)
					if(G._iris != 3)
						var/list/symbols = dd_text2list(G.address," ")
						var/allow = 1
						if(G.private)
							allow = 0
						else
							for(var/X in symbols)
								if(text2num(X) <1 || text2num(X) > 38)
									allow = 0
						if(allow)
							html+={"<div class="content">"}
							html+="<center><b><h1>[G.name]</h1> "
							for(var/X in symbols)
							///	html +="<img src=https://php-network.000webhostapp.com/stargateimages/symbols_[X].png"
						//	html +="Press the numbered symbols on the DHD to dial the address."
							html +="<br><center><b>[G.address] [G.galaxy]"
							html+="</div>"
			if("gateaddress")
				html+={"<br>"}
				html+={"<center><div class="header">"}
				html+={"<table width="100%" border="0"><tr>
		<td width="35%">Planet Name</td>

		<td width="40%">Address</td>
		</tr></tr></table></div>"}
				html+={"<br>"}
				for(var/obj/Pegasus_Gates/D in world)
					if(!D.private)
						html+={"<center><div class="header">"}
						html+={"<table width="100%" border="0">
								<tr>"}
						if(D.name != "Staff Homeworld")
							var/list/symbols = dd_text2list(D.address," ")
							html+={"<td width="35%"><b>[D.name]</b>"}
							if(D.iris)
								html += {" {[D.iris==2?"Sheild":"Iris"]}</td>"}
							//html+={"<td width="25%">[D.address]</td>"}
							html +={"<td width="40%">"}
							for(var/X in symbols)
								html +="<img src=http://139.162.251.170/images/Symbols_[X].png>"
							html +="</td>"

						html +="</td>"
						html +="</tr>"
						html +={"</table></div>"}
						html+= "<br>"
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
		src << browse(html, "window=website.SGOweb;can-scroll:none;can_minimize=0;can_resize=0;size=500x340")
		return 0
	return ..()