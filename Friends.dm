mob/var
	list/friends = list("No Friends")
	gm = 0

world
	mob = /mob/characters

mob/characters/verb/AddFriend(var/mob/M in oview(6))
	set name = "Add a Friend"
	set category = "Friends"
	if(alert(M,"[usr] wishes to add you, accept?!","Add-a-Friend","Yes","No")=="No")
		alert("[M] said no.")
		return
	if(M.gm)
		usr << "Cannot befriend a Game Moderator."
	else
		if(usr.friends[M.ckey]==M.name)
			usr << "<b>You already have [M] in your list."
		else
			usr.friends[M.ckey]=M.name
			usr << "You add [M.name]!"
			if(alert(M,"Add [usr]?","Add-a-Friend","Yes","No")=="Yes")
				M.friends[usr.ckey]=usr.name
mob/characters/verb/checkfriends()
	set category ="Friends"
	set name = "Check a Friend"
	if(length(usr.friends) < 2)
		alert("You have no friends in your list.")
		return
	var/p = 0
	var/check =input("Friends in your list- Function by: Kimaru Kiko","Check Friend's status")in usr.friends
	usr << "[check]"
	if(check == "None/Cancel") return
	for(var/mob/characters/M in world)
		if(check == "[M.name]")
			p+= 1 // Player found!"
	if(p == 1)
		usr << "[check] is online!"
	else
		usr << "[check] is offline!"
	var/Browse
	var/savefile/F = new()
	var/txtfile = file("playerinfo/[check].txt")
	F.ImportText("/",txtfile)
	F[check] >> Browse
	src<<browse(Browse)

mob/characters/verb/RemoveFriend(var/X in src.friends|null)
	set category = "Friends"
	set name = "Remove Friend"
	if(X)
		src.friends.Remove(X,null)
mob/characters/verb/FriendMessage(msg as text)
	set category = "Friends"
	usr << "<b><font color = green>[usr] {Friends Message}: [msg]</font></b>"
	for(var/mob/characters/M in world)
		if(usr.friends.Find("[M.name]"))
			M << "<b><font color = green>[usr] {Friends Message}: [msg]</font></b>"
mob/characters/verb/CheckInfo()
	set category = "Friends"
	set name = "Check your info"
	var/Browse
	var/savefile/F = new()
	var/txtfile = file("playerinfo/[usr.name].txt")
	F.ImportText("/",txtfile)
	F[usr.name] >> Browse
	src<<browse(Browse)
mob/characters/verb/EditInfo()
	set category="Friends"
	usr.char_form.DisplayForm()

mob
	var
		Form/info/char_form = new()
		tmp
			error_text = ""

		pointsmax = 5

Form/info
	form_reusable = 0
	form_window = "window=info;titlebar=0;can_close=0;can_minimize=0;size=600x400"
	var
		name2
		age
		location = "EU Central"
		Info = "Input Info Here"
		Info_interface = TEXTAREA
		Info_size = "20x5"
		gender
		gender_1 = "Male"
		gender_2 = "Female"
		AIM = "N/A"
		Discord = "Username#0000"
		YIM = "N/A"
		email = "N/A"
		HC = "Red"
		HC_values = list("Black","Red","White","Blue","Aqua","Teal","Pink","Purple","Tan","Navy","Orange","Gray","Green")
		IC = "White"
		IC_values = list("Black","Red","White","Blue","Aqua","Teal","Pink","Purple","Tan","Navy","Orange","Gray","Green")
		BGC = "Black"
		BGC_values= list("Red","White","Black","Blue","Aqua","Teal","Pink","Purple","Tan","Navy","Orange","Gray","Green")
	Initialize()
		if (!name2)	 name2 = usr.name
		if (!gender) gender = "Male"
		if (!age) age = "Unknown"
	HtmlLayout()

		var/page = {"<STYLE>BODY{background: black; color: white}</STYLE>
		<center><h1>Information Edit</h1></center>
		<font color=red><b>[usr.error_text]</b></font><br>
		<table width="100%">
		  <tr><td><b>Name:</b></td><td>[name2]</td></tr>
		  <tr><td>&nbsp;</td><td>&nbsp</td></tr>
		  <tr><td>&nbsp;</td><td>&nbsp</td></tr>
		  <tr><td><b>Age</b></td><td>[age]</td></tr>
		  <tr><td><b>Location</b></td><td>[location]</td></tr>
		  <tr><td>&nbsp;</td><td>&nbsp</td></tr>
		  <tr><td><b>Gender:</b></td>
		      <td>
		      [gender_1] Male<br>
		      [gender_2] Female
		      </td>
		  <tr><td><b>Info</b></td><td>[Info]</td></tr>
		  <tr><td><b>AIM</b></td><td><b>Discord</b></td></tr>
		  <tr><td width="25%"><b>[AIM]</b></td><td width="25%"><b>[Discord]</b></td></tr>
		  <tr><td><b>YIM</b></td><td><b>E-Mail</b></td></tr>
		  <tr><td width="25%"><b>[YIM]</b></td><td width="25%"><b>[email]</b></td></tr>
		  <tr><td><h1>HTML Edit</h1></td></tr>
		  <tr><td>Header Color</td><td>Subheader Color</td><td>Background Color</td></tr>
		  <tr><td><b>[HC]</b></td><td><b>[IC]</b></td><td><b>[BGC]</b></td></tr>
		  <tr><td>&nbsp;</td><td>[submit]</td></tr>
		</table>
		"}
		return page
	ProcessForm()
		usr << browse(null, "window=info")
		var/Browse = {"<html><body bgcolor=[BGC]><alignment = "Center"><font size = 5><b><font color = [HC]>[name2]'s Info:</font><alignment = "Left">
	<font color = [IC]><br></b><font size = 2>
	Age:[age]
	Sex:[gender]
	Location:[location]<br><br>
	Information:<br>[copytext(Info,1,201)]<br>
	<font size = 5><font color = [HC]>Contact Information:<br><font size = 2><font color = [IC]>
	AIM:[AIM]<br>
	MSN:[Discord]<br>
	Yahoo:[YIM]<br>
	E-Mail:[email]
	"}
		spawn() infosave(usr,Browse)

proc/infosave(mob/M,Browse as text)
	var/savefile/F = new()
	var/txtfile = file("playerinfo/[M.name].txt")
	F["[M.name]"] << Browse

	fdel(txtfile)
	F.ExportText("/",txtfile)
