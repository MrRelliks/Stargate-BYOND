client/script={"
macro
	Tab return ".center"



"}

var/list/playerlist=list()

world
	proc
		AutoRestart()
			sleep(432000) //Sleep for 12 hours
			for(var/mob/M in world)

				world << "<font color=\"#FF9B00\"><strong>Attention<strong>: Server restart in 30 seconds ... logging you out to prevent Save File corruption.</font>"
				M.Write()
				sleep(10)
				del(M)
				sleep(10)
				world << "Restarting now ..."
				world.Reboot()




client
	command_text="Universe-> \""

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



