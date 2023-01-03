obj/HUD
	FadeIn
		layer=9001
		icon='Icons/FadeIn.dmi'
		screen_loc="SOUTHWEST to NORTHEAST"//extends from the very bottom left corner of your screen, to the top right
	FadeOut
		layer=9001
		icon='Icons/FadeOut.dmi'
		screen_loc="SOUTHWEST to NORTHEAST"


mob/proc/UnFadeScreen() // This will be used to do a Fade-Out
	var/obj/HUD/FadeOut/f = new //creates HUD
	if(client)
		client.screen+=f // adds hud to screen
		sleep(20) //wait 2 seconds
		client.screen-=f // removes hud from screen
	.=..()

mob/proc/FadeScreen() //This is used for a Fade-In
	var/obj/HUD/FadeIn/f = new //creates HUD
	if(client)
		client.screen+=f // adds hud to screen
		sleep(20) //wait 2 seconds
		client.screen-=f // removes hud from screen
	.=..()

