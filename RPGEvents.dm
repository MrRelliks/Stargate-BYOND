atom
	movable
		var //These variables can be edited in map.dmm to make interacting with each atom give a unique experience. The event var must be defined to cause an event.
			event = ""								//A text string for the type of event to occur when this atom's Event() proc is triggered.
			event_relay = FALSE						//Whether to relay the event to
			event_ShowText = ""						//Text to be shown when the player interacts with this atom.
			event_window_color = "black"			//Color to be used for the window. Must match one of the available icon states in HUD_windows.dmi.
			event_window_screenloc = "1:16,1:24"	//screen_loc to be used for the window.
			event_window_height = 0					//height to be used for the window.
		proc
			FindMovableAtom(var/d=dir)
				var/atom/movable/M = null
				switch(d)
					if(NORTH) M = locate() in obounds(src, src.bound_width*0.5, src.bound_height*1.5, 1-src.bound_width, 1-src.bound_height)
					if(EAST)  M = locate() in obounds(src, src.bound_width*1.5, src.bound_height*0.5, 1-src.bound_width, 1-src.bound_height)
					if(SOUTH) M = locate() in obounds(src, src.bound_width*0.5, -src.bound_height*0.5, 1-src.bound_width, 1-src.bound_height)
					if(WEST)  M = locate() in obounds(src, -src.bound_width*0.5, src.bound_height*0.5, 1-src.bound_width, 1-src.bound_height)
				return M
			Event(var/mob/M)	//By default does nothing. You can define this for any movable atom (mob or obj) to make it's Event do the desired action.
				if(M)
					switch(event)
						if("ShowText") ShowText(event_ShowText, M)
						else if(event_relay)
							var/atom/movable/E = FindMovableAtom(M.dir)
							if(E) E.Event(M)
			ShowText(var/show_text="", var/mob/M)
				if(show_text && M && M.client)
					var/atom/movable/hud/window/W = new(M.client, event_window_screenloc, icon_state=event_window_color, height=event_window_height) //Create the window.
					W.DrawText(show_text) //Make the window do something; in this case, we make the window draw text.

mob
	verb
		Interact(var/atom/movable/M = null)
			set hidden = 1
			if(!M)
				if(client)
					if(client.move_focus) client.move_focus.Select(src)
					else M = FindMovableAtom(dir)
				else M = FindMovableAtom(dir)
			if(M)
				M.Event(src)	//src triggers M's Event() proc.