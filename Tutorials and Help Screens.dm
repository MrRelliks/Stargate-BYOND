
/*

Dialogue System


*/

var/list/Dialogue = list(
/////Welcome screen that will appear to anyone that first logs in to the game.
///// Hopefully I can add in a fully fledged tutorial and integrate this with the Questing System
	"Welcome To Stargate BYOND" = list(
		"INTRO_1" = list(
			"Conditions" = list(),
			"Options" = list("  Yes" = "Tutorial_1", "  No" = "End"),
			"Body" = "HELPER: Welcome to Stargate BYOND, I am The HELPER, would you like a little tutorial on how to get started? "),

		"Tutorial_1" = list(
			"Conditions" = list(),
			"Options" = list("  Mining" = "MiningTut", "  Smithing" = "SmithingTut" , "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: Great, in this tutorial we will teach you the basics of the game, but please note that the game is still in development and it is important you check back here to see if anything new has been added."),

		"MiningTut" = list(
			"Conditions" = list(),
			"Options" = list("  Start Again" = "INTRO_1", "  Smithing" = "SmithingTut" , "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: The Mining Skill is a very important part of the game, training it to higher levels will not only unlock higher tier ores to acquire but it will enable you to craft items and generate naquada faster."),

		"SmithingTut" = list(
			"Conditions" = list(),
			"Options" = list("  Start Again" = "INTRO_1", "  Mining" = "MiningTut" , "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: The Smithing Skill is a very important part of the game, training it to higher levels will help you to craft higher tier items which can be used on your adventures in game.")
		)

//	)


	,"WelcomeWraith" = list(
		"INTRO_1" = list(
			"Conditions" = list(),
			"Options" = list("  Yes" = "Tutorial_1", "  No" = "End"),
			"Body" = "Would you like to see my shop?"),

		"Tutorial_1" = list(
			"Conditions" = list(),
			"Options" = list("  Next..." = "Tutorial_2", "  Thanks, Bye!" = "End"),
			"Body" = "Okay great, here you go ..."),


		"Tutorial_2" = list(
			"Conditions" = list(),
			"Options" = list("  Start Again" = "INTRO_1", "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: Tutorial Page 2")
		)


	)


