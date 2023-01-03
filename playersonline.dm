world
	proc
		PlayersOnline()
			world<<output(null,"playersonline")
			world<<output("<center>There are currently <strong><font color=#78F3F9>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong></center>","playersonline")
			world.status = "<strong> [world.name] - <font color=#F5463E>[TauriOnline.len] Tau'ri & [WraithOnline.len] Wraith </font>Online.</strong> - [servername] [server_version] - [server_build] "
			sleep(100)
			PlayersOnline()
