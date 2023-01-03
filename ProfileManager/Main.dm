
profile
	var/nickname
	var/biogender
	var/bio
	var/job
	var/profilepic
	var/key

	New(mob/mob)

		key = mob.key

client
	proc
		ViewProfile(profile/profile)
			var/profilehtml = profile_css






mob
	proc
		ProfileLink(text)

			return "<a href=?action=ViewProfile;ckey=[ckey]>[text]</a>"






client
	Topic(href, list/params, datum/hsrc)
		if(params["action"] == "ViewProfile")
			var/profile/profile = Profiles.Get(params["ckey"])
			if(profile)
				ViewProfile(profile)
			else
				return //Do something here

var/profile_manager/Profiles = new

profile_manager
	proc/Path(ckey)
		return "data/profile/[ckey].sav" // example

	proc/Save(mob/mob)
		new/savefile(mob.ckey)["profile"] << new/profile(mob)

	proc/Load(ckey)
		var/profile/loaded = null
		if(fexists(Path(ckey)))
			new/savefile(Path(ckey))["profile"] >> loaded
		return loaded

	proc/Get(ckey)
		return Find(ckey) || Load(ckey)

	proc/Find(ckey)
		for(var/client/client)
			if(client.ckey == ckey)
				return new/profile(client.mob)
		return null