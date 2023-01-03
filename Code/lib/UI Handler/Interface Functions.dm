icon
	proc
		_Scale(x, y)
			Scale(x, y)
			return src

client
	proc
		NewMenu(Tag, Width = 0, Height = 0)
			return new/Menu(Tag, src, Width, Height)

		SelectMenu(Tag)
			return Menus[Tag]

		//ease of use function
		SelectElement(Menu, Window, Table, Cell)
			if(Menu)
				if(Window)
					if(Table)
						if(Cell)
							return SelectMenu(Menu).SelectWindow(Window).SelectTable(Table).SelectCell(Cell)
						else
							return SelectMenu(Menu).SelectWindow(Window).SelectTable(Table)
					else
						return SelectMenu(Menu).SelectWindow(Window)
				else
					return SelectMenu(Menu)

		AdjustPlane(Menu)
			for(var/Increment = Menus.Find(Menu) to Menus.len)
				if(Increment == Menus.len || !Menus.Find(Menu)) break

				Menus.Swap(Increment, Increment + 1)

			for(var/RefID in Menus)
				SelectMenu(RefID).UpdatePlane(Menus.Find(RefID) + 3)

Menu
	proc
		NewWindow(Tag, LocX = 0, LocY = 0, Width = 32, Height = 32, IconSet = MENU_ICONSET, Header = FALSE)
			return new/Menu/Window(Tag, src, LocX, LocY, Width, Height, IconSet, Header)

		SelectWindow(Tag)
			return Windows[Tag]

		SelectWindowGroup(list/Tags)
			var/list/WindowGroup = new
			for(var/Window in Windows) if(Window in Tags) WindowGroup += Windows[Window]
			return WindowGroup

	Window
		proc
			NewTable(Tag, LocX = 0, LocY = 0, Rows, Columns, list/Widths, list/Heights)
				return new/Menu/Table(Tag, src, LocX, LocY, Rows, Columns, Widths, Heights)

			SelectTable(Tag)
				return Tables[Tag]

			SelectTableGroup(list/Tags)
				var/list/TableGroup = new
				for(var/Table in Tables) if(Table in Tags) TableGroup += Tables[Table]
				return TableGroup

	Table
		proc
			EnableScroll(ViewRow, ViewCol, Dir = NORTH|SOUTH)
				canScroll = !canScroll
				Direction = Dir
				if(ViewRow) for(var/R = 1 to Rows) if(inView["ROWS"].len < ViewRow) inView["ROWS"] += R
				if(ViewCol) for(var/R = 1 to Columns) if(inView["COLUMNS"].len < ViewCol) inView["COLUMNS"] += R

				if(ViewRow) for(var/R = 1 to Rows) if(!inView["ROWS"].Find(R)) HideRow(R)
				if(ViewCol) for(var/R = 1 to Columns) if(!inView["COLUMNS"].Find(R)) HideColumn(R)

			SelectCell(Tag)
				return CellPositions[Tag]

			SelectCellGroup(list/Start, list/End)
				var/list/CellGroup = list()
				for(var/X = Start[1] to End[1])
					for(var/Y = Start[2] to End[2])
						CellGroup += CellPositions["[X], [Y]"]

				return CellGroup

			NewIcons(list/IconList)
				for(var/Tag in IconList)
					new/Menu/Table/Cell/GFX(Tag, src, IconList[Tag][1], IconList[Tag].len>1 ? IconList[Tag][2]: 0, IconList[Tag].len>2 ? IconList[Tag][3]: 0)

			SelectIcon(Tag)
				return Icons[Tag]

			ChangeRowSize(AffectedRow, NewHeight)
				var/deltaHeight

				for(var/Menu/Table/Cell/Cell in SelectCellGroup(list(1, AffectedRow), list(Columns, AffectedRow)))
					if(!(Cell.Height - NewHeight)) return

					deltaHeight = Cell.Height - NewHeight
					Cell.Height = NewHeight
					Cell.maptext_height = NewHeight

				for(var/Menu/Table/Cell/Cell in SelectCellGroup(list(1, AffectedRow + 1), list(Columns, Rows)))
					Cell.UpdatePosition(0, deltaHeight)

				Height += deltaHeight

			ChangeColumnSize(AffectedColumn, NewWidth)
				var/deltaWidth

				for(var/Menu/Table/Cell/Cell in SelectCellGroup(list(AffectedColumn, 1), list(AffectedColumn, Rows)))
					if(!(Cell.Width - NewWidth)) return

					deltaWidth = Cell.Width - NewWidth
					Cell.Width = NewWidth
					Cell.maptext_width = NewWidth

				for(var/Menu/Table/Cell/Cell in SelectCellGroup(list(AffectedColumn + 1, 1), list(Columns, Rows)))
					Cell.UpdatePosition(deltaWidth, 0)

				Width += deltaWidth

			HideRow(AffectedRow)
				var/ReferenceSize

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionY == AffectedRow)
						ReferenceSize = Cell.Height
						if(inView["COLUMNS"].len && (Cell.PositionX in inView["COLUMNS"] && !Cell.OnScreen)) continue
						if(Cell.OnScreen) Cell.Toggle()

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionY < AffectedRow)
						Cell.UpdatePosition(0, -ReferenceSize)

				Height -= ReferenceSize

			HideColumn(AffectedColumn)
				var/ReferenceSize

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionX == AffectedColumn)
						ReferenceSize = Cell.Width
						if(inView["ROWS"].len && (Cell.PositionY in inView["ROWS"] && !Cell.OnScreen)) continue
						if(Cell.OnScreen) Cell.Toggle()

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionX > AffectedColumn)
						Cell.UpdatePosition(-ReferenceSize, 0)

				Width -= ReferenceSize

			ShowRow(AffectedRow)
				var/ReferenceSize

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionY == AffectedRow)
						ReferenceSize = Cell.Height
						if(inView["COLUMNS"].len && !(Cell.PositionX in inView["COLUMNS"])) continue
						if(!Cell.OnScreen) Cell.Toggle()

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionY < AffectedRow)
						Cell.UpdatePosition(0, ReferenceSize)

				Height += ReferenceSize

			ShowColumn(AffectedColumn)
				var/ReferenceSize

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionX == AffectedColumn)
						ReferenceSize = Cell.Width
						if(inView["ROWS"].len && !(Cell.PositionY in inView["ROWS"])) continue
						if(!Cell.OnScreen) Cell.Toggle()

				for(var/Menu/Table/Cell/Cell in Cells)
					if(Cell.PositionX > AffectedColumn)
						Cell.UpdatePosition(ReferenceSize, 0)

				Width += ReferenceSize

//			GetRowHeight(R)										//Test procs. Still determining if I want to go this route on getting size information.
//				return SelectCell("1, [R]").Height

//			GetColumnWidth(C)
//				return SelectCell("[C], 1").Width

		Cell
			proc
				MergeCell(list/CellList) //merge with cells in the list. Always start with a cell in the top left.
					for(var/Menu/Table/Cell/Cell in CellList)
						if(Cell.RefID == RefID) continue
						if(Cell.MergedWith.len) Cell.SplitCell()

						if(PositionX != Cell.PositionX && PositionY == Cell.PositionY)
							Width += Cell.Width
							maptext_width += Cell.maptext_width

						if(PositionX == Cell.PositionX && PositionY != Cell.PositionY)
							Height  += Cell.Height
							maptext_height += Cell.maptext_height
							ReferenceY -= Cell.Height

						if(Cell.OnScreen) Cell.Toggle()

						MergedWith += Cell.RefID

					UpdatePosition()

				SplitCell()
					for(var/Position in MergedWith)
						var/Menu/Table/Cell/UnmergeCell = Parent:CellPositions[Position]

						if(PositionX != UnmergeCell.PositionX && PositionY == UnmergeCell.PositionY)
							Width -= UnmergeCell.Width
							maptext_width -= UnmergeCell.maptext_width

						if(PositionX == UnmergeCell.PositionX && PositionY != UnmergeCell.PositionY)
							Height  -= UnmergeCell.Height
							maptext_height -= UnmergeCell.maptext_height
							ReferenceY += UnmergeCell.Height

						if(!UnmergeCell.OnScreen) UnmergeCell.Toggle()

						MergedWith -= Position

					UpdatePosition()

				ClearCell()
					maptext = null
					Text = null
					Commands = new/list()

					vis_contents = new/list()
					overlays = new/list()
					Icons = new/list()

					del Tooltip

					if(MergedWith.len) SplitCell()

				UpdateText(NewText, AutoText, Font = "Arial", Size = "10px", Align = "left", VAlign = "middle", Color = "#FFFFFF")
					maptext = "<span style='-dm-text-outline: 1px black; color: [Color]; font-size: [Size]; font-family: [Font]; vertical-align: [VAlign];'><b><font align=[Align]>[NewText]</font></b></span>"
					if(AutoText) Text = html_decode(AutoText)

				NewTooltip(Width, Height)
					return new/Menu/Tooltip(src, Width, Height)

				NewCommand(list/Proc)
					var/newName = "_[Commands.len+1]"
					Commands += newName
					Commands[newName] = Proc


			GFX
				proc
					ApplyFilter(filter)
						filters = filter

					Resize(NewWidth, NewHeight)
						icon = icon(icon)._Scale(NewWidth, NewHeight)