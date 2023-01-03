#define WINDOW_LAYER 1
#define TABLE_LAYER 2
#define CELL_LAYER 3
#define GFX_LAYER 4
#define TOOLTIP_LAYER 20
#define SCREEN_MAX_WIDTH 832		//adjust this to the size of your screen
#define SCREEN_MAX_HEIGHT 858		//adjust this to the size of your screen

#define CURSOR_ICONSET 'Cursors.dmi'
#define MENU_ICONSET 'Menu.dmi'
#define MENU_HEADER 'Menu 2.dmi'


Menu
	parent_type = /obj
	plane = 5
	screen_loc = "1, 1"
	appearance_flags = KEEP_TOGETHER

	var
		RefID

		ReferenceX = 0
		ReferenceY = 0

		Height = 0
		Width = 0

		isHeader = FALSE
		canClick = FALSE

		OnScreen = FALSE

		list
			Windows = list()

		Menu
			Parent

	proc
		Toggle(client/C)
			if(!OnScreen) C.screen += src
			else C.screen -=  src
			OnScreen = !OnScreen

		UpdatePosition(NewX, NewY)
			ReferenceX = (Width && Height) ? max(min(ReferenceX + NewX, SCREEN_MAX_WIDTH - Width), 1) : (ReferenceX + NewX)
			ReferenceY = (Width && Height) ? max(min(ReferenceY + NewY, SCREEN_MAX_HEIGHT - Height), 1) : (ReferenceY + NewY)
			screen_loc = "1:[ReferenceX], 1:[ReferenceY]"

		UpdatePlane(NewValue)
			plane = NewValue

	New(Tag, client/C, W, H)
		RefID = Tag
		C.Menus += Tag
		C.Menus[Tag] = src
		Width = W
		Height = H

	Window
		layer = WINDOW_LAYER
		OnScreen = TRUE
		var
			drawWindow = TRUE

			list
				Tables = list()

		Toggle()
			if(!OnScreen) Parent.vis_contents += src
			else Parent.vis_contents -=  src
			OnScreen = !OnScreen

		UpdatePosition(NewX, NewY)
			ReferenceX += NewX
			ReferenceY += NewY
			pixel_x = ReferenceX
			pixel_y = ReferenceY

		New(Tag, Menu/P, X, Y, Width, Height, IconSet = MENU_ICONSET, Header = FALSE)  //default IconSet can be changed to your liking.
			RefID = Tag
			Parent = P
			ReferenceX = X
			ReferenceY = Y
			isHeader = Header

			Parent.Windows += Tag
			Parent.Windows[Tag] = src
			Parent.vis_contents += src

			vis_contents.Add(\
				new/Menu/Window/Element(Tag, P, X    , Y    , Width, Height, IconSet, "  ", Header), \
				new/Menu/Window/Element(Tag, P, X - 30, Y + Height - 2, 32, 32, IconSet, "tl", Header), \
				new/Menu/Window/Element(Tag, P, X + 2    , Y + Height, Width - 4, 32, IconSet, "tm", Header), \
				new/Menu/Window/Element(Tag, P, X + Width - 2, Y + Height - 2, 32, 32, IconSet, "tr", Header), \
				new/Menu/Window/Element(Tag, P, X - 32, Y + 2, 32, Height - 4, IconSet, "cl", Header), \
				new/Menu/Window/Element(Tag, P, X + Width, Y + 2, 32, Height - 4, IconSet, "cr", Header), \
				new/Menu/Window/Element(Tag, P, X - 30, Y - 30, 32, 32, IconSet, "bl", Header), \
				new/Menu/Window/Element(Tag, P, X + 2, Y - 32, Width - 4, 32, IconSet, "bm", Header), \
				new/Menu/Window/Element(Tag, P, X + Width - 2, Y - 30, 32, 32, IconSet, "br", Header))

		Element
			New(Tag, Menu/P, X = 0, Y = 0, Width = 32, Height = 32, IconSet = MENU_ICONSET, IconState, Header = FALSE)
				icon = icon(IconSet, IconState)
				transform = matrix().Scale(Width/32, Height/32)

				RefID = Tag
				Parent = P
				ReferenceX = X + Width/2 - 16
				ReferenceY = Y + Height/2 - 16

				pixel_x = ReferenceX
				pixel_y = ReferenceY
				isHeader = Header

	Table
		layer = TABLE_LAYER
		OnScreen = TRUE
		var
			Rows = 1
			Columns = 1

			canScroll = FALSE
			Direction = NORTH|SOUTH

			list
				Icons = list()
				Cells = list()
				CellPositions = list()
				inView = list("ROWS" = list(), "COLUMNS" = list())

		Toggle()
			if(!OnScreen) Parent.vis_contents += src
			else Parent.vis_contents -= src
			OnScreen = !OnScreen

		UpdatePosition(NewX, NewY)
			ReferenceX += NewX
			ReferenceY += NewY
			pixel_x = ReferenceX
			pixel_y = ReferenceY

		New(Tag, Menu/P, X, Y, Row, Col, list/Widths, list/Heights)
			var/SetWidth, SetHeight

			RefID = Tag
			Parent = P
			ReferenceX = X
			ReferenceY = Y
			Rows = Row
			Columns = Col

			Parent:Tables += Tag
			Parent:Tables[Tag] = src
			Parent.vis_contents += src

			for(var/CellWidth in Widths) Width += CellWidth
			for(var/CellHeight in Heights) Height += CellHeight

			var/PlacementX = X
			for(var/CellX = 1 to Col)
				if(Widths.len == 1)
					SetWidth = round(Width / Col)
					PlacementX = X + SetWidth * (CellX - 1)
				else
					SetWidth = Widths[CellX]
					if(CellX != 1) PlacementX += Widths[CellX]

				var/PlacementY = Y
				for(var/CellY = 1 to Row)
					if(Heights.len == 1)
						SetHeight = round(Height / Row)
						PlacementY = Height + Y + SetHeight * CellY * -1
					else
						SetHeight = Heights[CellY]
						if(CellY != 1) PlacementY -= Heights[CellY]

					new/Menu/Table/Cell(src, PlacementX, PlacementY, SetWidth, SetHeight, CellX, CellY, canScroll)

		Cell
			layer = CELL_LAYER

			var
				PositionX
				PositionY

				Text

				list
					MergedWith = list()
					Commands = list()

				Menu/Tooltip
					Tooltip


			New(Menu/P, X, Y, W, H, PosX, PosY, Scroll)
				Parent = P
				ReferenceX = X
				ReferenceY = Y
				pixel_x = X
				pixel_y = Y
				Width = W
				Height = H
				maptext_width = W
				maptext_height = H
				PositionX = PosX
				PositionY = PosY
				canScroll = Scroll
				RefID = "[PosX], [PosY]"

				Parent:Cells += src
				Parent:CellPositions += RefID
				Parent:CellPositions[RefID] = src
				Parent.vis_contents += src

			GFX
				layer = GFX_LAYER

				New(Tag, Menu/P, icon/I, LocX, LocY)
					Parent = P
					RefID = Tag
					ReferenceX = LocX
					ReferenceY = LocY
					pixel_x = LocX
					pixel_y = LocY

					P:Icons += src

					if(Tag in list("INACTIVE_MOUSEOVER", "ACTIVE_MOUSEOVER", "BLANK_TOOLTIP")) I.Scale(Parent:Width, Parent:Height)

					icon = I
					Parent:Icons += Tag
					Parent:Icons[Tag] = src

					if(findtext(Tag, "SCROLL")) Parent.vis_contents += src								//because we manipulate the position of these when scrolling, we want the object to be added to vis_contents instead of overlays
					else if(!(Tag in list("ACTIVE_MOUSEOVER", "SELECTED"))) Parent.overlays += src		//we want this graphics object to graphically be part of the cell.


	Tooltip
		layer = TOOLTIP_LAYER
		mouse_opacity = 0

		ReferenceX = -32
		ReferenceY = -32

		UpdatePosition(NewX, NewY)
			screen_loc = "1:[(Width && ReferenceX + NewX + Width > SCREEN_MAX_WIDTH) ? (ReferenceX + NewX - Width) : (ReferenceX + NewX)], 1:[(Height && ReferenceY + NewY + Height > SCREEN_MAX_HEIGHT) ? (ReferenceY + NewY - Height) : (ReferenceY + NewY)]"

		New(P, W, H)
			RefID = "Tooltip"
			Width = W
			Height = H
			Parent = P
			Parent:Tooltip = src