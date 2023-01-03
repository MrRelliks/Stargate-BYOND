turf/goauld/candle
	icon = 'Icons/Goauld.dmi'
	CandleBottom
		icon_state = "candlebottom"
		density = 1
	CandleTop
		icon_state = "candletop"
		density = 1
		New()
			..()




//Floor

turf/goauld/Floor
	icon = 'Icons/Goauld.dmi'
	Floor
		icon_state = "Floor"

//Goauld Walls

turf/goauld/Wall
	icon = 'Icons/Goauld.dmi'
	Wall
		icon_state = "GoauldWall1"
		density = 1
	Wall2
		icon_state = "GoauldWall2"
		density = 1
	Wall3
		icon_state = "GoauldWall3"
		density = 1

	WallThing
		icon_state = "WallThing"
		density = 1
	WallThingTop
		icon_state = "WallThingTop"
		density = 1

///Goauld Doorway
turf/goauld/Doorway
	icon = 'Icons/Goauld.dmi'
	BottomLeft
		icon_state = "goaulddoorbottomleft"
		layer = 99
		density = 1
	BottomRight
		icon_state = "goaulddoorbottomright"
		layer = 99
		density = 1
	MiddleLeft
		icon_state = "goaulddoormiddleleft"
		layer = 99
		density = 1
	Top
		icon_state = "goaulddoortopmiddle"
		layer = 99
	Middle
		icon_state = "goaulddoormiddle"
		layer = 99
	MiddleRight
		icon_state = "goaulddoormiddleright"
		layer = 99
		density = 1