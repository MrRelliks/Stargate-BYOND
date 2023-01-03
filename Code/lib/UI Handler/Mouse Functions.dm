var/global/regex/ParsePosition = regex("^(?:(?!\[0-9]+:)(\\w+):)?(\\d+)(?::(\\d+))?,(\\d+)(?::(\\d+))?$")

client
	var
		tmp
			MouseOffsetX = 0
			MouseOffsetY = 0
			MouseDragX = 0
			MouseDragY = 0

			Menu/FocusedMenu
		list
			Menus = list()

	proc
		GrabMouseOffset(params)
			if(ParsePosition.Find(params2list(params)["screen-loc"]))
				MouseOffsetX = text2num(ParsePosition.group[2]) * 32 + text2num(ParsePosition.group[3])
				MouseOffsetY = text2num(ParsePosition.group[4]) * 32 + text2num(ParsePosition.group[5])

		GrabMouseDrag(params)
			if(ParsePosition.Find(params2list(params)["screen-loc"]))
				MouseDragX = text2num(ParsePosition.group[2]) * 32 + text2num(ParsePosition.group[3])
				MouseDragY = text2num(ParsePosition.group[4]) * 32 + text2num(ParsePosition.group[5])

		MouseDeltaY()
			return MouseDragY - MouseOffsetY

		MouseDeltaX()
			return MouseDragX - MouseOffsetX

		ResetMouse()
			MouseDragX = 0
			MouseDragY = 0
			MouseOffsetX = 0
			MouseOffsetY = 0
			FocusedMenu = null


atom
	MouseMove(location, control, params)
		..()

Menu
	proc
		GrabMouse(client/C, params)
			C.GrabMouseOffset(params)

			C.FocusedMenu = Parent
			C.AdjustPlane(Parent.RefID)

		ReleaseMouse(client/C)
			if(!C.MouseDragX && !C.MouseDragY || C.FocusedMenu)
				C.ResetMouse()

		UpdateDragPosition(client/C, params)
			if(C.FocusedMenu && isHeader)
				C.GrabMouseDrag(params)

				C.FocusedMenu.UpdatePosition(C.MouseDeltaX(), C.MouseDeltaY())

				C.MouseOffsetX = C.MouseDragX
				C.MouseOffsetY = C.MouseDragY

	Window
		Click()
			..()
			usr.client.AdjustPlane(Parent.RefID)

		MouseDown(location, control, params)
			..()
			GrabMouse(usr.client, params)

		MouseUp(location, control, params)
			..()
			ReleaseMouse(usr.client)

		MouseDrag(over_object, src_location, over_location, src_control, over_control, params)
			..()
			UpdateDragPosition(usr.client, params)

	Table
		proc
			Scrolling(delta_x, delta_y)
				if(canScroll)
					if(delta_y > 0)
						if(inView["ROWS"][1] == 1) return FALSE

						ShowRow(inView["ROWS"][1] - 1)
						HideRow(inView["ROWS"][inView["ROWS"].len])

						inView["ROWS"].Cut(inView["ROWS"].len, inView["ROWS"].len + 1)
						inView["ROWS"].Insert(1, inView["ROWS"][1] - 1)

					if(delta_y < 0)
						if(inView["ROWS"][inView["ROWS"].len] == Rows) return FALSE

						ShowRow(inView["ROWS"][inView["ROWS"].len] + 1)
						HideRow(inView["ROWS"][1])

						inView["ROWS"].Cut(1, 2)
						inView["ROWS"].Insert(inView["ROWS"].len + 1, inView["ROWS"][inView["ROWS"].len] + 1)

					if(delta_x < 0)
						if(inView["COLUMNS"][1] == 1) return FALSE

						ShowColumn(inView["COLUMNS"][1] - 1)
						HideColumn(inView["COLUMNS"][inView["COLUMNS"].len])

						inView["COLUMNS"].Cut(inView["COLUMNS"].len, inView["COLUMNS"].len + 1)
						inView["COLUMNS"].Insert(1, inView["COLUMNS"][1] - 1)

					if(delta_x > 0)
						if(inView["COLUMNS"][inView["COLUMNS"].len] == Columns) return FALSE

						ShowColumn(inView["COLUMNS"][inView["COLUMNS"].len] + 1)
						HideColumn(inView["COLUMNS"][1])

						inView["COLUMNS"].Cut(1, 2)
						inView["COLUMNS"].Insert(inView["COLUMNS"].len + 1, inView["COLUMNS"][inView["COLUMNS"].len] + 1)

					return TRUE

			UpdateScrollWheel(delta_x, delta_y)
				if(!Scrolling(delta_x, delta_y)) return

				if(delta_x > 0) Icons["SCROLL_POS_X"].UpdatePosition(DragScrollPosition("COLUMNS"), 0)
				if(delta_x < 0) Icons["SCROLL_POS_X"].UpdatePosition(-DragScrollPosition("COLUMNS"), 0)
				if(delta_y > 0) Icons["SCROLL_POS_Y"].UpdatePosition(0, DragScrollPosition("ROWS"))
				if(delta_y < 0) Icons["SCROLL_POS_Y"].UpdatePosition(0, -DragScrollPosition("ROWS"))

				Icons["SCROLL_POS_Y"].pixel_y = min(max(Icons["SCROLL_POS_Y"].pixel_y, Icons["SCROLL_DOWN"].pixel_y + Icons["SCROLL_DOWN"].Height), Icons["SCROLL_UP"].pixel_y - Icons["SCROLL_UP"].Height)
				Icons["SCROLL_POS_X"].pixel_x = min(max(Icons["SCROLL_POS_X"].pixel_x, Icons["SCROLL_LEFT"].pixel_x + Icons["SCROLL_LEFT"].Width), Icons["SCROLL_RIGHT"].pixel_x - Icons["SCROLL_RIGHT"].Width)

			UpdateScrollDrag(delta_x, delta_y)
				if(!Scrolling(delta_x, delta_y)) return

				if(delta_x > 0) Icons["SCROLL_POS_X"].ReferenceX += DragScrollPosition("COLUMNS")
				if(delta_x < 0) Icons["SCROLL_POS_X"].ReferenceX -= DragScrollPosition("COLUMNS")
				if(delta_y > 0) Icons["SCROLL_POS_Y"].ReferenceY += DragScrollPosition("ROWS")
				if(delta_y < 0) Icons["SCROLL_POS_Y"].ReferenceY -= DragScrollPosition("ROWS")

			DragScrollPosition(Axis)
				switch(Axis)
					if("COLUMNS") return (Icons["SCROLL_BAR_X"].Width - Icons["SCROLL_POS_X"].Width) / (Columns - inView[Axis].len)
					if("ROWS") return (Icons["SCROLL_BAR_Y"].Height - Icons["SCROLL_POS_Y"].Height) / (Rows - inView[Axis].len)


		Cell
			proc
				UpdateTooltipPosition(params)
					if(Tooltip)
						if(ParsePosition.Find(params2list(params)["screen-loc"]))
							Tooltip.UpdatePosition(text2num(ParsePosition.group[2]) * 32 + text2num(ParsePosition.group[3]), text2num(ParsePosition.group[4]) * 32 + text2num(ParsePosition.group[5]))

			Click()
				..()

				var/client/C = usr.client
				C.AdjustPlane(Parent.Parent.Parent.RefID)

				if(Commands.len)
					for(var/r in Commands)
						call(Commands[r]["SRC"], Commands[r]["PROC"])(Commands[r]["ARG1"], Commands[r]["ARG2"],Commands[r]["ARG3"], Commands[r]["ARG4"])

			MouseEntered(location, control, params)
				..()

				if("ACTIVE_MOUSEOVER" in Icons)
					overlays -= Icons["INACTIVE_MOUSEOVER"]
					overlays += Icons["ACTIVE_MOUSEOVER"]

				if(Tooltip)
					UpdateTooltipPosition(params)
					Tooltip.Toggle(usr.client)

			MouseExited(location, control, params)
				..()

				if("INACTIVE_MOUSEOVER" in Icons)
					overlays -= Icons["ACTIVE_MOUSEOVER"]
					overlays += Icons["INACTIVE_MOUSEOVER"]

				if(Tooltip)
					UpdateTooltipPosition(params)
					Tooltip.Toggle(usr.client)

			MouseMove(location, control, params)
				..()
				UpdateTooltipPosition(params)

			MouseWheel(delta_x, delta_y, location, contol, params)
				..()
				Parent:UpdateScrollWheel(delta_x, delta_y)

			GFX
				Click()
					..()

					switch(RefID)
						if("SCROLL_UP") Parent:UpdateScrollWheel(null, 1)
						if("SCROLL_DOWN") Parent:UpdateScrollWheel(null, -1)
						if("SCROLL_RIGHT") Parent:UpdateScrollWheel(1, null)
						if("SCROLL_LEFT") Parent:UpdateScrollWheel(-1, null)

				MouseDown(location, control, params)
					..()
					GrabMouse(usr.client, params)
					if(findtext(RefID, "SCROLL_POS")) usr.client.FocusedMenu = src

				MouseUp(location, control, params)
					..()
					ReleaseMouse(usr.client, params)

				MouseDrag(over_object, src_location, over_location, src_control, over_control, params)
					..()

					var/client/C = usr.client
					if(C.FocusedMenu)
						C.GrabMouseDrag(params)

						switch(C.FocusedMenu:RefID)
							if("SCROLL_POS_Y")
								Parent:Icons["SCROLL_POS_Y"].pixel_y = min(max(Parent:Icons["SCROLL_POS_Y"].pixel_y + C.MouseDeltaY(), Parent:Icons["SCROLL_DOWN"].pixel_y + Parent:Icons["SCROLL_DOWN"].Height), Parent:Icons["SCROLL_UP"].pixel_y - Parent:Icons["SCROLL_UP"].Height + 1)
								while(abs(Parent:Icons["SCROLL_POS_Y"].pixel_y - Parent:Icons["SCROLL_POS_Y"].ReferenceY) >= Parent:DragScrollPosition("ROWS")) Parent:UpdateScrollDrag(0, C.MouseDeltaY())

							if("SCROLL_POS_X")
								Parent:Icons["SCROLL_POS_X"].pixel_x = min(max(Parent:Icons["SCROLL_POS_X"].pixel_x + C.MouseDeltaX(), Parent:Icons["SCROLL_LEFT"].pixel_x + Parent:Icons["SCROLL_LEFT"].Width - 1), Parent:Icons["SCROLL_RIGHT"].pixel_x - Parent:Icons["SCROLL_RIGHT"].Width)
								while(abs(Parent:Icons["SCROLL_POS_X"].pixel_x - Parent:Icons["SCROLL_POS_X"].ReferenceX) >= Parent:DragScrollPosition("COLUMNS")) Parent:UpdateScrollDrag(C.MouseDeltaX(), 0)

						C.MouseOffsetX = C.MouseDragX
						C.MouseOffsetY = C.MouseDragY