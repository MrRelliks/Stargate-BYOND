/*
///////////////////////////////
		STUFF TO CREATE
///////////////////////////////
- ICONS -

Atlantis
	Doors
	Ancient Chair
	Screens / screencomputers
	Laptops

Wraith Turfs
	Doors
	Consols/Screens
	stasis turfs

Outfits
	Atlantis suits
	Wraith outfits

Nature turfs
	Cliffs
	water borders

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
											IMPORTANT TO READ !
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	The most of Turfs/icons is in code files : walls / floors / consols / pillarrocksturf ; Icons location set to Icons/BassIcons ; generated by autocoder.

	The coding files edit/add things for now : Objects.dm (added Stargate/Altantis and Wraith_Stronghold path / doors path )

	ALL ICONS DMI FILES, MUST BE REPLACED BY ALL NEWS IN THEIR RESPECTIVE FOLDERS. (Mostly the icons in the folder Icons/BassIcons)

	The files locations in the code are set with their full path (folders).

	I Recommend TO NOT MOVE THE FILES AND THEIR CODE CONTENTS, FROM THEIR NATIVE FILES AND FOLDERS

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

w

//Teleport Tiles for you.
turf
	TeleportTiles // defines the type of the tile

		SGC
			ToGateRoom

				Corridoor1
					layer = 100
					Entered(mob/M)
						if(!M.client)
							return
						else
							M.loc=locate(66,15,7)


		Atlantis// 																		atlantis gateroom stairs

			JumperArea_Conrolroom

				Gateroom_JumperArea
					Entered(mob/M)
						if(!M.client)
							return
						else
							M.loc=locate(14,37,5)

				JumperArea_Gateroom
					Entered(mob/M)
						if(!M.client)
							return
						else
							M.loc=locate(10,71,5)


			GateRoom_infirmary


				Left//rename this to describe where its going

					top
						Entered(mob/M)
							if(!M.client) // Check to make sure if not a client
								return
							else
								M.loc=locate(70,39,5) //change the location

					top_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(70,38,5)

					top_bottom
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(70,37,5)

					bottom_top
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(70,35,5)

					bottom_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(70,34,5)

					bottom_b
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(70,33,5)

				Right

					top
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(78,39,5)

					top_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(78,38,5)

					top_bottom
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(78,37,5)

					bottom_top
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(78,35,5)

					bottom_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(78,34,5)

					bottom_b
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(78,33,5)

			infirmary_GateRoom


				Left

					top
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(22,78,5)

					top_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(22,77,5)

					top_bottom
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(22,76,5)

					bottom_top
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(22,74,5)

					bottom_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(22,73,5)

					bottom_b
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(22,72,5)

				Right

					top
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(26,78,5)

					top_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(26,77,5)

					top_bottom
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(26,76,5)

					bottom_top
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(26,74,5)

					bottom_middle
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(26,73,5)

					bottom_b
						Entered(mob/M)
							if(!M.client)
								return
							else
								M.loc=locate(26,72,5)
/*
		Other_Planet
			One
				Entered(mob/M)
					if(!M.client)
						return
					else
						M.loc=locate(1,1,1)
			Two
				Entered(mob/M)
					if(!M.client)
						return
					else
						M.loc=locate(1,1,1)
*/