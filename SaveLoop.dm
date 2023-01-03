world/New()
	..()
	spawn(40)
	loop_save()

obj/dontsave
	layer=1000

staff/verb
	saveall()
		set category = "Staff"
		set name = "Save everyone"
		world.loop_save(1)

world/proc
	loop_save(loop=0)
		for(var/mob/M in world)
			if(M.client)
			//	world<<output("\[[time2text(world.realtime,"hh:mm:ss")]\]<font color='white'><b> World Is Saving.</b>","Server")
				M.Write()
					//dont_get_stuck(M)
				//rc_update_person(M)
				//saveSecurity()
			//	world<<output("\[[time2text(world.realtime,"hh:mm:ss")]\]<font color='white'><b> World Save Complete.</b>","Server")
				//world<<output("[time2text(world.realtime)]<b>World Save Complete</b>","Server")
	//	world<<"Please Wait ... World Is Saving"
		//world<<output( {"Done."},{"Player"})
		sleep(30)
		if(!loop)
			loop_save()

//winset(src, "mainwindow.MapOutput", "left=mappane;")