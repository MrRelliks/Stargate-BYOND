/**************************************************************************************/
bignum
	var
		list/digits		//@ The number itself (stored backwards and with no sign or decimal point)
		sign = TRUE 	//@ TRUE = positive, FALSE = negative
		decimal = 0		//@ The number of decimal places
		sigfigs = 0		//@ The number of significant digits
		ERROR = ""		//@ Used to display errors if found


	//@ New automatically calls make()
	New(var/value)
		make(value)

	/*@
	** Make a new bignum from text/num/bignum
	*/
	proc/make(var/value)
		if(istext(value)) makeFromText(value)
		else if(bn_isbignum(value)) makeFromBignum(value)
		else if(bn_islist(value)) makeFromList(value)
		else makeFromNum(value)

	/*@
	** Make a new bignum from text
	*/
	proc/makeFromText(var/str)
		if(!str) str = "0"
		if(copytext(str,1,2) == "-")
			sign = NEGATIVE
			str = copytext(str,2)

		var/dec = 0
		var/sci = findtext(str,"e")
		if(sci)	//If the number is in scientific notiaton
			dec = text2num(copytext(str,sci+1,0))
			str = copytext(str,1,sci)

		str = bn_onlyNum(str)						//@ Strips out weird characters

		if(str == "0") sign = POSITIVE				//@ 0 is positive even if it has a 0 sign in front of it

		decimal = findtext(str,DECPOINT) 				//@ Find the length of the integer part
		if(decimal)
			digits = new(length(str)) //initialize this here because we need the length of digits to fidng the dec place
			decimal = length(str) - decimal			//@ Set it to the length of the decimal part
			str = removeDecimal(str)	//@ If there is a decimal, remove it from the number

		digits = bn_text2list(str)
		if(sci&&dec)
			shiftDigitsDec(dec)
			trimZeros()

	/*@
	** Make a new bignum from num. {This is not a good method because it limits precision.}
	*/
	proc/makeFromNum(var/num)
		if(!isnum(num)||!num) num = 0
		if(num > 999999) 						//@ If the number is larger 1million or larger, Byond uses scientific notiation,
			return makeFromText(num2text(num,8))	//@ so pass it to text processing (largest num is 16777216)
		if(num<0) sign = NEGATIVE 				//@ Get the sign
		if(num) makeFromText("[abs(num)]")		//@ Call from_text
		else digits = list(0)					//@ Not nessesary but cuts some of the overhead of making the num
												//@ -can use make(0) for a quick clearing of the number

	/*@
	** Not really a viable way to make a bignum since it can only be a positive integer
	**  Really, lists should only be used to create bignums from within procs like multiply()
	*/
	proc/makeFromList(var/list/num)
		src.digits = num

	/*@
	** Make a new bignum from a bignum
	** -makes the src a copy of bn
	*/
	proc/makeFromBignum(var/bignum/bn)
		src.digits = bn.digits.Copy()
		src.sign = bn.sign
		src.decimal = bn.decimal
		src.sigfigs = bn.sigfigs

	/*@
	** Make a copy of a bignum
	** -returns a bignum which is a copy of the src
	*/
	proc/copyBignum()
		var/bignum/ret = new()
		ret.digits = digits.Copy()
		ret.sign = sign
		ret.decimal = decimal
		ret.sigfigs = sigfigs
		return ret

/**************************************************************************************/