/*

                                                           Stargate BYOND V2.0 Bank System, Coded by Stargate_Offic 02.11.2020


*/

mob/proc
	ShowBank()
		if(!src.client)
			return
		else
			winset(src, "bank", "is-visible=true")


	//	winset(src, "shop.shopname" =
	HideBank()
		winset(src, "bank", "is-visible=false")
mob
	verb
		HideBankkkkkk()
			usr.HideBank()
mob
	var
		list/locker_contents[0] //items in locker
mob
	Entered(Item/A)						//	If an item or anything else sucessfully enters the mob's contents
		..()							//	Checks to see if there's anything else to be called (in case).
		if(istype(A))
			var/Item/X=locate(A.type) in usr.contents2-A	//Checks if there's an item with the same type already.
			if(X)						//	If there's an item that exists with the same path
				A.amount+=X.amount		//	Adds the amount of the item found
				del X					//	Deletes that item found.
		Inventory()						//	Calls the Inventory() prcoedure.

	Exited()
		..()
		Inventory()

	proc/Inventory()
		if(!src.client)return
		var/i=1
		winset(src,"bank.bangrid",{"cells="1x[locker_contents.len+1]""})	//	Sets column = 2, row = contents.len+1
		src<<output("<b>Items</b>","bank.bangrid:1,1")				//	Displays "Items" in the current cell, which is column 1, row 1
		//src<<output("<b>Amount</b>","bank.bangrid:2,1")				//	Displays "Amount" in column 2, row 2
		for(var/obj/I in locker_contents)
			src<<output(I,"bank.bangrid:1,[++i]")								//	Searches through the contents list
			//src<<output(I,"bank.bangrid:1")					//	Outputs to the cell: column=1, row = ++i (++i means (i+1) returned immediately. i++ means (i+1) but first returns the value of i).; this Sets the item (I) in to the current cell
		//	src<<output(I.amount,"bank.bangrid:2,[i]")				//	Displays the amount the item (I) has in to the cell: column=2, row = i (i is already now i+1 from the previous output())

	verb/Clear_Text()										//	To clear the chat part.
		src<<output(null,"output")

	//	And here is where we define the default for Bumped().. Note it is under /atom not /atom/movable. /atom children are /area, /turf and /movable [hence atom/movable]. The bumped() object does not necessarily have to be just an /obj or /mob right?

Item									//	A datum named Item for items (obviously).
	parent_type = /obj					//	/Item's parent (which can be checked via atom.parent_type) is now set to /obj, meaning that /Item contains all traits of /obj which contains it from /atom/movable which contains it from /atom (modified along the way of course).
	density = 1
	var
		amount						//	Makes the item dense (unable to walk through)
	Bumped(mob/M)						//	If something Bump()s into it, this is called.
		if(!ismob(M)) return 0			//	If M (the argument sent) is not a mob, the rest is stopped from happening
		if(!M.client) return 0			//	If M is not a client (human player), the rest of the procedure does not happen.
		Pickup_proc(M)					//	Calls the procedure Pickup_proc.

	verb/Pickup()						//	All /Item have this verb.
		set src in oview(1)				//	Makes the verb available if the user if within 1 tile from the source.
		set category = "Items"			//	The verb's category is set as Items
		Pickup_proc(usr)				//	You know what this does.

	verb/Drop()							//	All /Item have this verb as well.
		set src in usr					//	Verb is available if the item is in the contents.
		set category = "Items"			//	The verb's category is set as Items
		var/amt=max(0,min(99,input("How many [name] do you wish to drop? Maximum amount: [min(99,amount)]","Item drop",1) as num|null))
		if(!(src in usr)||!amt) return 0		//	Safety checking if the item is actually in the usr's contents.
		var/turf/XX = get_step(usr,turn(usr.dir,180))
		if(!XX)XX=usr.loc
		if(amt>=amount).=Move(XX)	//	Tries to moves the item to one step behind the user.
		else
			var/Item/X = type
			X = new X(XX)
			X.amount = amt
			amount-=amt
			.=1
			usr.Inventory()
		usr << "[(.)?"\green":"\red"] You[(.)?"":" did not"] drop [amt] [src.name]\s."	//	Checks if the item was dropped sucessfully. (x)?y:z is a mini-if() statement: if(x){ y } else { z }

	proc/Pickup_proc(mob/M)				//	Reason why I defined this instead of just having the verb is so I can pick up /Item's by bumping into them. Sure I could call the verb through Bumped() but than the usr would be someone else.
		if(!(M in oview(1,src))) return	//	Checks if M is within 1 tile. If it isn't, the procedure stops.
		.=Move(M)	//	Tries to moves the item to one step behind the user.
		M << "[(.)?"\green":"\red"] You[(.)?"":" did not"] pick up [src.name]."	//	Checks if the item was picked up sucessfully. (x)?y:z is a mini-if() statement: if(x){ y } else { z }


	New()
		..()
		mouse_drag_pointer = icon(src.icon, src.icon_state)  //  Makes the drag icon the item itself - useless really since MosueDrop() is not used
mob
	var
		bank_wealth
	//	weight = 32


mob/
	var/list/contents2

	verb
		DepositItem758365437286348()
			for(var/mob/Bank/B in view(3))
				B.Deposit_item1208()
		WithdrawItem6543875643895743()
			for(var/mob/Bank/B in view(3))
				B.Withdraw_item1208()
	Bank
		icon='Icons/SGC.dmi'
		icon_state="Bank"
		DblClick()
			usr.ShowBank()
			usr.Inventory()
			/*var/Banking = input("What do you want to do?")in list("Withdraw Item","Deposit Item","Cancel")
			switch(Banking)
				if("Withdraw Item")
					for(var/mob/Bank/B in view(3))
						B.Withdraw_item1208()
				if("Deposit Item")
					for(var/mob/Bank/B in view(3))
						B.Deposit_item1208()

				if("Cancel")
					return*/

		proc
			Deposit_item1208()
			//	set category="Bank"
				set src in oview(3)
				var/O=input(usr,"What do you want to Deposit?","Choose:") in usr.contents+"Nevermind"

				input(usr,"How many would you like to deposit?")
				if(O=="Nevermind")
					//usr <<"Ok"
					return
				else
					if(locate(O) in usr.contents)
						usr.contents-=O
						usr.locker_contents+=O
						usr << "You Deposit [O]"
						usr.Inventory()
								//Deposit_item1208()
					else
						usr<<"Item is not in your inventory!"
			Withdraw_item1208()
				set src in oview(3)
				//set category="Bank"
				var/O=input(usr,"What do you want to Withdraw?","Choose:") in usr.locker_contents+"Nevermind"
				if(O=="Nevermind")
				//	usr <<"Ok"
					return
				else
					if(locate(O) in usr.locker_contents)
						usr.locker_contents-=O
						usr.contents+=O
						usr.Inventory()
						usr << "You withdraw [O]"
						//Withdraw_item1208()
					else
						usr<<"Item is not in bank!"

