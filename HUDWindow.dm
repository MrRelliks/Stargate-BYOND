/*
	HUD Windows
	A BYOND Library
	By Tyruswoo "Woo"
	24 Aug. 2017

	Heads-up displays (HUDs) are very useful for making your game more immersive, since everything is handled within the main screen.
	This library aims to make it easy to create HUD windows that can display text, images, selectable options, and more.
*/

atom/movable
	hud //We define hud as a new movable atom type, at the same level as a mob or obj.
		var
			client/client = null				//Keep track of which client is viewing this hud element.
		window
			var
				letter_wait = 0.9
							//Amount of time (in ticks) to wait before printing the next letter. 0 for instantaneous.
				window_icon = 'HUD_windows.dmi'	//Default icon for windows, when none is specified in the window's new proc.
				window_icon_state = "black"		//Default icon state for windows, when none is specified in the window's new proc.
				font = "Monospace"				//Font to use. A monspace font is highly recommended.
				text_color = null
				//Any hexidecimal or other supported color name. If not specified, will use the text color in HUD_windows.dmi.
				letter_width = 10				//The number of pixels wide for each letter.
				letter_height = 16				//The number of pixels tall for each letter.
				letter_padding_below = 3		//The amount of space below the main text line, for hanging letters (y, j, etc) to be separate from the lower window border.
				letter_padding_above = 5		//The amount of space above the main text line, separating it from the upper border of the window.
				width = 0						//Keep track of this window's dimensions.
				height = 0
				busy = FALSE					//Keep track of whether this window is busy or not.
				rush = FALSE					//If window is busy, and player presses a Select key, then make the window rush to completion.
				input_needed = FALSE			//Keep track of whether player input is needed to continue with the window's action.
				input_received = FALSE			//Keep track of whether player input has been received.
			New(client/c=null, var/screen_loc="1,1", var/width=0, var/height=0, var/icon=null, var/icon_state=null, var/text_color=null)
				..()
				if(c)
					client = c
					client.move_focus = src
					SetIcon(icon, icon_state)
					SetTextColor(text_color)	//Requires that the icon and icon_state already be set.
					src.screen_loc = screen_loc	//screen_loc helps determine the width, so must be set before calling the SetWidth proc that immediately follows.
					SetWidth(client, width)
					SetHeight(client, height)
					src.icon = DrawBackground()

					overlays += list(DrawEdge(NORTH), DrawEdge(EAST), DrawEdge(SOUTH), DrawEdge(WEST))
					overlays += list(DrawCorner(NORTHEAST), DrawCorner(NORTHWEST), DrawCorner(SOUTHEAST), DrawCorner(SOUTHWEST))
					client.screen += src
			proc
				SetIcon(var/window_icon=null, var/window_icon_state=null)
					if(window_icon) src.window_icon = window_icon					//If an icon was defined in the proc call, then use it.
					if(!src.window_icon) src.window_icon = 'HUD_windows.dmi'		//If no icon in proc call or defined as in the code, then use library's default.
					if(window_icon_state) src.window_icon_state = window_icon_state	//If an icon_state was defined in the proc call, then use it.
					if(!src.window_icon_state) src.window_icon_state = "black"		//If no icon_state in proc call or defined in the code, then use library's default.
				SetTextColor(var/text_color=null)
					if(text_color) src.text_color = text_color						//If a text color was defined in the proc call, then use it.
					if(!src.text_color)
						var/icon/I = new(window_icon, window_icon_state)
						src.text_color = I.GetPixel(32,32)

					if(!src.text_color) src.text_color = "#FEFEFE"
				SetWidth(client/c, var/window_width=0)
					width = window_width
					if(!width)
						width = c.ViewWidth()-(screen_x()-1)*world.icon_size*2-screen_x("offset")*2
					return width
				SetHeight(client/c, var/window_height=0)
					height = window_height
					if(!height)
						height = c.ViewHeight()/4
						height = height - height%letter_height
					return height
				DrawBackground()
					var/icon/I = new(window_icon, window_icon_state)
					I.Crop(1,17,16,32) //The window's background color.
					I.Scale(width,height)

					return I
				DrawCorner(var/d=null)
					var/icon/I = new(window_icon, window_icon_state)
					I.Crop(1,1,16,16) //The window's corner appearance.
					switch(d)
						if(NORTHEAST)
							I.Turn(180)
							I.Crop(1,1,width,height)
							I.Shift(NORTH,height-16)
							I.Shift(EAST,width-16)
						if(NORTHWEST)
							I.Flip(NORTH)
							I.Crop(1,1,16,height)
							I.Shift(NORTH,height-16)
						if(SOUTHEAST)
							I.Flip(EAST)
							I.Crop(1,1,width,16)
							I.Shift(EAST,width-16)
					return I
				DrawEdge(var/d=null)
					var/icon/I = new(window_icon, window_icon_state)
					I.Crop(17,1,32,16) //By default, matches the southern edge.
					switch(d)
						if(NORTH)
							I.Flip(NORTH)
							I.Scale(width,16)
							I.Crop(1,1,width,height)
							I.Shift(NORTH,height-16)
						if(EAST)
							I.Turn(-90)
							I.Scale(16,height)
							I.Crop(1,1,width,height)
							I.Shift(EAST,width-16)
						if(SOUTH)
							I.Scale(width,16)
						if(WEST)
							I.Turn(90)
							I.Scale(16,height)
					return I
				DrawText(var/draw_text=null)
					busy = TRUE
					var
						row_max = (height-32)/letter_height
						screen_x = screen_x()
						screen_y = screen_y()
						screen_x_offset = screen_x("offset")
						screen_y_offset = screen_y("offset")
					while(draw_text)
						var/text_y = height-16-letter_height+letter_padding_above
						for(var/row=1, row<=row_max, row++)
							var/atom/movable/hud/text/T = new(src, "[screen_x]:[screen_x_offset+16],[screen_y]:[screen_y_offset+text_y]")

							draw_text = T.Draw(draw_text)
							text_y -= letter_height
						if(draw_text)
							WaitForInput()
							for(var/atom/movable/hud/text/T in src)
								del T
						rush = FALSE
					busy = FALSE
					WaitForInput()
				screen_x(var/offset="") //If offset="offset", then return the offset value.
					var
						screen_x = 1
						screen_x_offset = 0
					if(screen_loc)
						screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
						if(findtext(screen_x,":"))
							screen_x_offset = text2num(copytext(screen_x, findtext(screen_x,":")+1))
							screen_x = text2num(copytext(screen_x, 1, findtext(screen_x,":")))
						else screen_x = text2num(screen_x)
					if(offset=="offset") return screen_x_offset
					else return screen_x
				screen_y(var/offset="") //If offset="offset", then return the offset value.
					var
						screen_y = 1
						screen_y_offset = 0
					if(screen_loc)
						screen_y = copytext(screen_loc, findtext(screen_loc, ",")+1)
						if(findtext(screen_y,":"))
							screen_y_offset = text2num(copytext(screen_y, findtext(screen_y,":")+1))
							screen_y = text2num(copytext(screen_y, 1, findtext(screen_y,":")))
						else screen_y = text2num(screen_y)
					if(offset=="offset") return screen_y_offset
					else return screen_y
				Select()
					if(busy)
						if(input_needed) input_received = TRUE
						else rush = TRUE
					else del src
				WaitForInput()
					input_needed = TRUE
					var/icon/I = new(window_icon, window_icon_state)
					I.Crop(17,17,32,24)
					I.Crop(1,1,width,16)
					I.Shift(EAST, width/2-7)
					I.Shift(NORTH, 2)
					var
						wait_count = 0
						blink_time = 12
					while(!input_received)
						sleep(1)
						if(wait_count%blink_time == 0) overlays += I
						else if(wait_count%blink_time >= blink_time/2) overlays -= I
						wait_count += 1
					overlays -= I
					input_needed = FALSE
					input_received = FALSE

atom/movable
	hud
		text //This heads-up display atom is used inside windows to display text.
			icon = null
			var
				atom/movable/hud/window/window = null	//Keep track of which window is associated with this text.
			New(var/atom/movable/hud/window/loc=null, var/screen_loc="1,1", var/client/c=loc.client)
				Move(loc)
				if(loc)
					window = loc
					maptext_width = window.width-32-((window.width-32)%window.letter_width)
					maptext_height = window.letter_height + window.letter_padding_below
					maptext_y -= window.letter_padding_below
				if(c)
					client = c
					src.screen_loc = screen_loc
					client.screen += src
			proc
				Draw(var/draw_text=null) //Draw this text onto its line of the window.
					var
						list/words = splittext(draw_text," ")
						letter_max = maptext_width / window.letter_width
						letter_count = 0
					maptext_width += window.letter_width
					if(!words) return FALSE
					for(var/word in words)
						if(!letter_count) //For first letter, do nothing.
						else if(letter_count + length(word) >= letter_max) return jointext(words," ") //If not enough room on the text line for this word, then exit loop.
						else
							letter_count += 1
							maptext += "<FONT FACE=[window.font] COLOR=[window.text_color]><BIG><B> </B></BIG></FONT>"
							if(window && !window.rush) sleep(window.letter_wait)
						for(var/i=1, i<=length(word), i++)
							letter_count += 1
							maptext += "<FONT FACE=[window.font] COLOR=[window.text_color]><BIG><B>[copytext(word, i, i+1)]</B></BIG></FONT>"
							if(window && !window.rush) sleep(window.letter_wait)
						words.Cut(1,2)
					return jointext(words," ")

client
	var
		atom/movable/hud/window/move_focus = null	//Keep track of which HUD window this player is focused on.
	North()		if(!move_focus) ..()	//Player can only use keys to move when not focused on a HUD window.
	East()		if(!move_focus) ..()
	South()		if(!move_focus) ..()
	West()		if(!move_focus) ..()
	Northeast()	if(!move_focus) ..()
	Northwest()	if(!move_focus) ..()
	Southeast()	if(!move_focus) ..()
	Southwest()	if(!move_focus) ..()
	proc
		ViewWidth() //returns this client's view width, in pixels.
			if(isnum(view)) return (view * 2 + 1) * world.icon_size
			else return text2num(copytext(view, 1, findtext(view, "x"))) * world.icon_size
		ViewHeight() //returns this client's view height, in pixels.
			if(isnum(view)) return (view * 2 + 1) * world.icon_size
			else return text2num(copytext(view, findtext(view, "x")+1)) * world.icon_size