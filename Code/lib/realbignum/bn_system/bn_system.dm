/**************************************************************************************/
bignum

	/*@
	** Returns the length of the integer part, also known as where the decimal is, if there is one
	*/
	proc/intLength()
		if(!digits) return 0
		return digits.len - decimal

	/*@
	** Returns length of the decimal part
	*/
	proc/decLength()
		return decimal

	/*@
	** Return the total number of digits
	** -as a num
	*/
	proc/digitsLength()
		return digits.len

	/*@ Switched dec and int commands copy statements
	** Return the int part
	** -as a list
	*/
	proc/intPart()
		return digits.Copy(decimal+1)

	/*@
	** Return the dec part
	** -as a list
	*/
	proc/decPart()
		if(!decimal) return list()
		return digits.Copy(1,decimal+1)

	/*@
	** Clean up the number
	** Remove leading 0s and trailing 0s (after decimal)
	*/
	proc/trimZeros()
		while(digits.len>decimal) 			//@ Remove leading 0s
			if(digits[digits.len]) break	//@ If it hits a non-zero number
			digits.Cut(digits.len)
		while(decimal) 					//@ Remove trailing 0s after decimal
			if(digits[1]) break			//@ If it hits a non-zero number
			digits.Cut(1,2)
			decimal--

		if(digits==list(0)) sign = POSITIVE //@ If num = 0 set sign to +


	/*@
	** Returns 1 if the number has a value
	** -0 if it doesn't
	*/
	proc/isNotZero()
		trimZeros()
		if(!digitsLength()||(digitsLength()<2&&digits[1]==0)) return 0
		else return 1

/**************************************************************************************/

/**************************************************************************************/
/*
** General purpose procs - Not defined under the bignum datum
*/

	/*@
	** Converts a list to a string of the elements of the list
	** -eg {6,5,4,3,2,1} » 123456
	*/
proc/bn_list2text(var/list/l,var/sep)
	if(!istype(l)) return
	for(var/i=l.len,i>0,i--)
		. += "[l[i]][sep ? sep : ""]"
	return .

	/*@
	** Converst text to a list
	** -eg 123456 » {6,5,4,3,2,1}
	*/
proc/bn_text2list(var/str)
	var/list/l = new()
	for(var/i=length(str),i>0,i--)
		if(text2num(bn_getChar(str,i)) in list(0,1,2,3,4,5,6,7,8,9))
			l.Add(text2num(bn_getChar(str,i)))
	return l

	/*@
	** Get the character in positon i
	** -Tested to be faster than: copytext(str,i,i+1) by about 40%
	*/
proc/bn_getChar(var/str,var/i)
	return ascii2text(text2ascii(str,i))

	/*@
	** Checks to see if bn is a bignum
	** -returns 1 if it is, 0 if it isn't
	*/
proc/bn_isbignum(var/bn)
	return istype(bn,/bignum)

	/*@
	** Returns a BigNum = 0
	*/
proc/bn_nullbignum()
	var/bignum/n = new(0)
	return n

	/*@
	** Checks to see if l is a list
	** -returns 1 if it is, 0 if it isn't
	*/
proc/bn_islist(list/l)
	return istype(l)

	/*@
	** Strips out everything in the inputed text
	** -except a decimal place and numbers
	*/
proc/bn_onlyNum(var/str)
	var{c;d}	//c is the current character and d is a check to see if there has been a decimal or not
	var/dpASCII = text2ascii(DECPOINT)	//Gets the Ascii equivalent of the current Decimal point
	for(var/i=length(str),i>0,i--)
		c = text2ascii(str,i)
		if(c==dpASCII&&!d) d=1
		else if(c>57||c<48) str = copytext(str,1,i)+copytext(str,i+1,0)
	return str

/**************************************************************************************/