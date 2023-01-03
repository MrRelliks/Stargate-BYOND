
//Dialogue structured in a database format. Would like to explore exporting to a SQL database using queries to reference data.

var/list/Dialogue = list(
	"Welcome To Stargate BYOND" = list(
		"INTRO_1" = list(
			"Conditions" = list(),
			"Options" = list("  Yes" = "Tutorial_1", "  No" = "End"),
			"Body" = "HELPER: Welcome to Stargate BYOND, I am The HELPER, would you like a little tutorial on how to get started? "),

		"Tutorial_1" = list(
			"Conditions" = list(),
			"Options" = list("  Next..." = "Tutorial_2", "  Lets Poo On Each Other" = "PooPoo" , "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: Great, Lets get Started. "),

		"Tutorial_2" = list(
			"Conditions" = list(),
			"Options" = list("  Start Again" = "INTRO_1", "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: Tutorial Page 2"),

		"PooPoo" = list(
			"Conditions" = list(),
			"Options" = list("  Start Again" = "INTRO_1", "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: Tutorial Page 2")
		)

//	)


	,"WelcomeWraith" = list(
		"INTRO_1" = list(
			"Conditions" = list(),
			"Options" = list("  Yes" = "Tutorial_1", "  No" = "End"),
			"Body" = "HELPER: Jaffa Tutorial "),

		"Tutorial_1" = list(
			"Conditions" = list(),
			"Options" = list("  Next..." = "Tutorial_2", "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: Great, a Tutorial will be added here in future ..."),

		"Tutorial_2" = list(
			"Conditions" = list(),
			"Options" = list("  Start Again" = "INTRO_1", "  Thanks, Bye!" = "End"),
			"Body" = "HELPER: Tutorial Page 2")
		)


	)


