client
	var
		tmp
			ClickSkip = 0 //This is to make sure the client is able to skip scrolling text by clicking anywhere on the screen.
			hasDialogue = FALSE //Stop certain actions if the player is in dialogue.

mob
	var
		Level = 1 //Let's add a mob variable to test our dialogue conditions



var
	const
		TICK = 10/60 //Global tick

mob
	verb
		Dialog()
		//	set name = "Test Dialog"
		//	set category = "Commands"
			set hidden = 1
			client.CreateDialog("Welcome To Stargate BYOND")

