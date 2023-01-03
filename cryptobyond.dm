var/cryptlib = "plugins/cryptobyond.dll"
var/cryptlib_file = 'plugins/cryptobyond.dll'

world
	New()
		if(!fexists("plugins/cryptobyond.dll")){fcopy(cryptlib_file,cryptlib)}
		..()

proc
	SHA1(string)return call(cryptlib,"SHA1")(string)
	SHA224(string)return call(cryptlib,"SHA224")(string)
	SHA256(string)return call(cryptlib,"SHA256")(string)
	SHA384(string)return call(cryptlib,"SHA384")(string)
	SHA512(string)return call(cryptlib,"SHA512")(string)



//DEMO

mob
	var
		password
		prime = 40903
		salt = 40811613
		tries = 0
	proc
		TryAgain()
			usr << "Please Log in."
			var/enterpass = input("Enter Your Password") as text
			var/sha512 = SHA512(enterpass)
			var/addsalt = sha512 + prime. + salt
			if(addsalt == usr.password)
				usr << "Logged in."
			else
				usr << "Incorrect Password, Try again."
		PasswordLogin()
			if(src.password == null)
				var/newpass = input("Enter a secure password") as text
				usr.password = newpass
			else
				var/enterpass = input("Enter Your Password") as text
				var/sha512 = SHA512(enterpass)
				var/addsalt = sha512 + prime. + salt
				if(addsalt == usr.password)
					usr << "Logged in."

				else
					usr << "Incorrect Password, Try again."
					usr.TryAgain()
					usr.tries += 1
