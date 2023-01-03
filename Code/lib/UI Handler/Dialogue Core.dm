Menu/Table/Cell		//Datum referenced in Aiota.GUIHandler. Let's create a custom proc for scrolling text.
	proc
		ScrollText(client/C) //Only to be called when new scrolling text needs to be displayed.
			var/Formatting = FALSE  //Turn off any skips as this is the start of new scrolling text.
			var/Char = ""
			C.ClickSkip = FALSE

			for(var/Position = 1 to length(Text)) //We're going to parse the cell's text to check for HTML.
				Char = "[Char][copytext(Text, Position, Position+1)]"
				if(copytext(Text, Position, Position+1) == "<") Formatting = TRUE  //We want to skip everything between "<" and ">" incl.
				else if(copytext(Text, Position, Position+1) == ">") Formatting = FALSE

				if(Formatting) continue

				UpdateText("[maptext][Char]", Size = "10px", VAlign = "top", Align = "left") //Updating the maptext 1 character at a time.
				Char = ""
				if(!Formatting && !C.ClickSkip) sleep(TICK * 2) //If both skips are false, we want to delay the loop by 2 ticks.

client
	Click()
		if(!ClickSkip) ClickSkip = TRUE
		..()

	proc
		ConditionCheck(list/Conditions) //We'll create a new client proc to check the dialog conditions. Since this will involve UI, we will define the check under the client and reference it's mob's variables.
			var/PassTally = 0, CondTotal = 0	//Define a check tally of the conditions.  These are just simple pass/fail checks.

			//If you're using a different container for the player mob, un-comment the below line and make the necessary changes.
			//var/mob/Player/P = mob

			for(var/Condition in Conditions)	//Loops through the different conditions
				if(length(Conditions[Condition]))
					CondTotal += Conditions[Condition].len	//If there are multiple criteria under the same condition, add them to the total.
				else CondTotal++ //otherwise add one

				switch(Condition) //We'll demo two conditions based on level, but you can add as many as you want
					if("Over Level") if(mob.Level >= Conditions[Condition]) PassTally++
					if("Under Level") if(mob.Level < Conditions[Condition]) PassTally++

			if(PassTally == CondTotal) return TRUE
			else return FALSE

		CreateDialog(Parent, Child)  //Parent will be the main dialogue tree and Child will be the different chains in the tree.
			DialogBox()

			if(!Child) //If there is no Child defined, we will determine a valid intro child.
				for(var/Tag in Dialogue[Parent])
					if(findtext(Tag, "INTRO"))	//Only look at childs that contain INTRO
						if(!ConditionCheck(Dialogue[Parent][Tag]["Conditions"])) continue //If the condition on the child fails, continue to the next one.
						else
							Child = Tag
							break

			if(!Child || Child == "End")
				if(SelectMenu("Dialogue").OnScreen) SelectMenu("Dialogue").Toggle(src)  //If the text box is on screen, toggle it off
				return //If there is still no child after the previous check OR the child equals "End", stop the proc.

			if(!SelectMenu("Dialogue").OnScreen) SelectMenu("Dialogue").Toggle(src)  //If the text box is off screen, toggle if on

			var/Menu/Table/Table = SelectElement("Dialogue", "Window", "Text") //We will continue using the table element, so it gets its own var.

			for(var/Menu/Table/Cell/C in Table.SelectCellGroup(list(1, 1), list(1, 5))) C.ClearCell()

			Table.SelectCell("1, 1").UpdateText(AutoText = Dialogue[Parent][Child]["Body"])  //Set the auto text of the scroll
			Table.SelectCell("1, 1").ScrollText(src) //Start the scroll loop

			for(var/r in Dialogue[Parent][Child]["Options"])
				var/Position = Dialogue[Parent][Child]["Options"].Find(r) //Determine the position of the option then offset by one

				//Apply cell formatting below.
				Table.SelectCell("1, [1 + Position]").UpdateText(r, Size = "8px")
				Table.SelectCell("1, [1 + Position]").NewIcons(list("INACTIVE_MOUSEOVER" = list(icon('Cursors.dmi', "Blank")), "ACTIVE_MOUSEOVER" = list(icon('Cursors.dmi', "Cursor"))))
				Table.SelectCell("1, [1 + Position]").NewCommand(list("SRC" = src, PROC = "CreateDialog", "ARG1" = Parent, "ARG2" = Dialogue[Parent][Child]["Options"][r]))

		DialogBox()
			if("Dialogue" in Menus)
				return

			NewMenu("Dialogue").NewWindow("Window", 150, 36, 320, 150, Header = TRUE).NewTable("Text", 158, 114, 5, 1, list(304), list(62, 20, 20, 20, 20))