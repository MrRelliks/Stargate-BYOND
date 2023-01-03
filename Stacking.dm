mob/var/tmp/list/stack_selected[0]

stat
	parent_type=/obj
	stack
		var
			typ
			//price
		New(nam,typ,i,ic,is,mob/owner)
			name=nam
			src.typ=typ
			suffix=i
			icon = ic
			icon_state = is
			var/obj/items/D = new typ
			price = D.price
			del(D)
			if(name in owner.stack_selected)
				overlays += icon('Stack.dmi',"openstacked")
			else
				overlays += icon('Stack.dmi',"stacked")
		Click()
			if(name in usr.stack_selected)
				overlays = list()
				overlays += icon('Stack.dmi',"stacked")
				usr.stack_selected-=name
			else
				overlays = list()
				overlays += icon('Stack.dmi',"openstacked")
				usr.stack_selected+=name


		DblClick()

			var/r = 0
			for(var/mob/shopkeeper/A in range(1))
				if(A in range(1))
					r=1
				else
					r = 0
			var/list/doable = list("Drop All","Cancel")
			if(r)
				doable += "Sell"

			var/choice = input("what would you like to do with, [name]?")in doable
			switch(choice)
				if("Drop All")
					for(var/obj/D in usr.contents)
						if(istype(D,src.typ))
							D.loc = usr.loc
				if("Sell")
					var/WorkOutPrice = src.price/4
					//WorkOutPrice = WorkOutPrice*3
				//	WorkOutPrice = round(WorkOutPrice,1)
					switch(alert(usr,"Sell [src] for [WorkOutPrice] Naquadah (each)?","Sell Items","Yes","No"))
						if("Yes")
							for(var/obj/D in usr.contents)
								if(istype(D,src.typ))

									usr.naquadah += WorkOutPrice
									del D
				else
					return
