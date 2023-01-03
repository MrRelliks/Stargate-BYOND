obj
	var
		attackbonus = 1
		strengthbonus = 1
		defencebonus = 1

	items
		var
			tmp/mob/owner
			worn = 0
			nomove
			power=0
			amountinbank = 0
		MouseEntered(location, control, params)
			..()
			usr.ShowToolTip(src.name,src.desc)
		MouseExited()
			usr.CloseToolTip()
		verb
			SellAll()
				set name = "Sell All"
				for(var/mob/shopkeeper/A in range(1))
					if(A in range(1))
						set hidden = 0
						var/WorkOutPrice = src.price/4
						//WorkOutPrice = WorkOutPrice*3
					//	WorkOutPrice = round(WorkOutPrice,1)
						switch(alert(usr,"Sell [src] for [WorkOutPrice] Naquadah (each)?","Sell Items","Yes","No"))
							if("Yes")
								for(var/obj/D in usr.contents)
									if(istype(D,src.type))
										while(D in usr.contents)

											usr.naquadah += WorkOutPrice
											del D
					else
						usr << "You need to go to a shopkeepers to sell this!"
			Sell()
				set name = "Sell One"
				for(var/mob/shopkeeper/A in range(1))
					if(A in range(1))
						set hidden = 0
						var/WorkOutPrice = src.price/4
					//WorkOutPrice = WorkOutPrice*3
				//	WorkOutPrice = round(WorkOutPrice,1)
						switch(alert(usr,"Sell [src] for [WorkOutPrice] Naquadah (each)?","Sell Items","Yes","No"))
							if("Yes")

								usr.naquadah += WorkOutPrice
							//	usr.CreateAlert("Pleasure doing business with you!")
								del src
					else

						usr << "You need to go to a shopkeepers to sell this!"




		DblClick()
			if(src in usr.contents)
				Move(usr.loc)
			else
				if(usr.contents.len <= usr.weight)
					src.loc = usr.contents
					usr.contents+= src

				else
					usr << "You do not have the inventory space to pick that up."
					return





		PickAxe
			icon = 'Code/Skills/Pickaxe.dmi'
			name = "Pickaxe"
			desc = "You can use this to hit things..."
