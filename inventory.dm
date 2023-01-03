mob
	proc
		updateInventory()
			spawn(2)
				var/i=1
				winset(src,"Inventory.inventory",{"cells="2x[src.contents.len]""})
				for(var/obj/a in src.contents)
					src<<output(a,"Inventory.inventory:1,[i]")
					src<<output(a.suffix,"Inventory.inventory:2,[i]")
					i++
					src << output(null,"Inventory.inventorylabel")
					src << output("Inventory ([src.contents.len] / 28)","Inventory.inventorylabel")
				src.updateInventory()

