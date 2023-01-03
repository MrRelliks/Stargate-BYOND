/*

                                                           Stargate BYOND V2.0 Shop System, Coded by Stargate_Offic 29.10.2020


*/
mob
	proc
		CreateAlert(WDIS)
			if(!src.client)
				return
			else
				winset(src, "wintut", "is-visible=true")
				src << output(WDIS, "outputtut")

mob/proc
	ShowShop()
		if(!src.client)
			return
		else
			winset(src, "shop", "is-visible=true")


	//	winset(src, "shop.shopname" =
	HideShop()
		if(!src.client)
			return
		else
			winset(src, "shop", "is-visible=false")

mob
	verb
		HideShoppp()
			usr.HideShop()

mob
	var
		mob/shopkeeper/shopkeeper
		description = ""
		npc = 0
	//	equipped = 0
	//	hud = 1
	//	money = 9000

obj
	var
		strengthadd
		description = ""

client/Topic(href,href_list[])
	var/item_type = href_list["type"]
	if(item_type)
		var/obj/i = new item_type()
		if(usr.naquadah >= i.price)
			usr.CreateAlert("Pleasure doing business with you, [usr.name] !<br><br> your [i.name] has been placed in your inventory,")
			if(i.price <= 0)
				usr << "This one is on me ... Nothing was taken from your balance"
			else
				usr << "[i.price] has been deducted from your balance."
			usr.naquadah -= i.price
			i.Move(usr)
		//	usr.shopkeeper:Shopkeeper2()
		else
			usr << "Sorry you dont have enough naquadah"
		//	usr.shopkeeper:Shopkeeper2()




mob
	icon = 'Icons/Non-Playerables.dmi'
	shopkeeper
		MingingGuy
			name = "Digger"
			description = "Mining Supplies for all your diggin' needs!"
			icon_state = "PickAxe"
			npc = 1
			New()

				src.contents +=  list(new /obj/items/PickAxe,new /obj/items/ore/Copper)
			DblClick()
				if (src in range(1))
					usr.ShowShop()
					src.Shopkeeper2()
			var/html
			proc
				Shopkeeper2()
					src.ShowShop()
					//usr << "Running proc"
					html = {"
						<style>
							body{
								background:#2C3F5E
								color: #fff
							}
							</style>
						<b><font color = "white">Welcome to [src.name]'s shop!</font></b>
						<p><font color = "white">[src.description]</font></p>
						<table style="width: 400px; border: none"  cellpadding="10">
						<tbody>
						<Caption><font color = "white">Items</font></Caption>
						"}
					for(var/obj/items/A in src.contents)
						html += {"
						<tr>

						<td align = "center"><font color = "white">[A.name]</font></td>
						<td align = "center"><font color = "white"> Price : [A.price] Naquada </font></td>
						<td align = "center"><font color = "white"><a href='?src=\ref[usr];type=[A.type];action=buy'>Buy</a></font></td></tbody>
						</tr>
						"}
					usr << browse(html, "window=shop.shopweb;can-scroll:none;can_minimize=0;can_resize=0;size=500x340")


mob
	icon = 'Icons/Non-Playerables.dmi'
	shopkeeper
		WeaponsSupplier
			name = "BangBang"
			icon_state = "jaffa"
			npc = 1
			description = "Arming you to the teeth, go and make us proud!"
			New()

				src.contents +=  list(new /obj/items/weapon/mp5,new /obj/items/weapon/p90)
			DblClick()
				if (src in range(1))
					usr.ShowShop()
					src.WeaponsShop()
			var/html

			proc
				WeaponsShop()
					src.ShowShop()
					//usr << "Running proc"
					html = {"
						<style>
							body{
								background:#2C3F5E
								color: #fff
							}
							</style>
						<b><font color = "white">Welcome to [src.name]'s shop!</font></b>
						<p><font color = "white">[src.description]</font></p>
						<table style="width: 400px; border: none"  cellpadding="10">
						<tbody>
						<Caption><font color = "white">Items</font></Caption>
						"}
					for(var/obj/items/A in src.contents)
						html += {"
						<tr>

						<td align = "center"><font color = "white">[A.name]</font></td>
						<td align = "center"><font color = "white"> Price : [A.price] Naquada </font></td>
						<td align = "center"><font color = "white"><a href='?src=\ref[usr];type=[A.type];action=buy'>Buy</a></font></td></tbody>
						</tr>
						"}
					usr << browse(html, "window=shop.shopweb;can-scroll:none;can_minimize=0;can_resize=0;size=500x340")

		WeaponsSupplierwraith
			name = "Kel'Shak"
			icon = 'Icons/Non-Playerables.dmi'
			icon_state = "wraith_weapons"
			npc = 1
			description = "Arming you to the teeth, go and make us proud!"
			New()

				src.contents +=  list(new /obj/items/weapon/Wrifle,new /obj/items/weapon/wstunner)
			DblClick()
				if (src in range(1))
					usr.ShowShop()
					src.WeaponsShopwraith()
			var/html

			proc
				WeaponsShopwraith()
					src.ShowShop()
					//usr << "Running proc"
					html = {"
						<style>
							body{
								background:#2C3F5E
								color: #fff
							}
							</style>
						<b><font color = "white">Welcome to [src.name]'s shop!</font></b>
						<p><font color = "white">[src.description]</font></p>
						<table style="width: 400px; border: none"  cellpadding="10">
						<tbody>
						<Caption><font color = "white">Items</font></Caption>
						"}
					for(var/obj/items/A in src.contents)
						html += {"
						<tr>

						<td align = "center"><font color = "white">[A.name]</font></td>
						<td align = "center"><font color = "white"> Price : [A.price] Naquada </font></td>
						<td align = "center"><font color = "white"><a href='?src=\ref[usr];type=[A.type];action=buy'>Buy</a></font></td></tbody>
						</tr>
						"}
					usr << browse(html, "window=shop.shopweb;can-scroll:none;can_minimize=0;can_resize=0;size=500x340")
