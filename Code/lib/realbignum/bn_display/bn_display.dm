/**************************************************************************************/
/*
** Procs that have to do with outputting a text string value of a BigNum
*/
bignum
	/*@
	** Output the number as a text string
	*/
	proc/toString(var/abs=0) //@ argument = 1 for absolute value
		if(ERROR) return ERROR
		var/str = bn_list2text(digits)

		if(decimal)
			str = insertDecimal(str)
			if(decimal==length(digits)+1) str="0[str]"			//@ Makes decimals easier to read i.e. add the 0 to 0.2

		if(INTSEP||DECSEP) str = insertSeperators(str)

		if(!sign&&!abs) str = "-[str]"
		return str

	/*@
	** Output the number as a num
	** {this is inhibited by the max length of numbers in BYOND (the whole reason for this library...)}
	*/
	proc/toNum()
		return text2num(toString())

	/*@
	** Debug Output
	**  -A simple debug message that shows all the values of the number
	*/
	proc/debug()
		return "[sign ? "+" : "-"]<[bn_list2text(digits)]>/<[decimal]><[digitsLength()]> \n--{[toString()]}[ERROR?"\n #[ERROR]#":""]"

	/*@
	** Returns the position of the decimal point in relation to a text string
	** -the position after the point
	*/
	proc/getDecimalPosition()
		return intLength()+1

	/*@
	** Inserts a decimal into a text string
	** -used for bignum output
	*/
	proc/insertDecimal(var/str)
		return copytext(str,1,getDecimalPosition())+DECPOINT+ copytext(str,getDecimalPosition())

	/*@
	** inserts the Seperators to make printed numbers easier to read
	*/
	proc/insertSeperators(var/str)
		var/i
		if(INTSEP && intLength()>3)						//If there is an integer separator and the number needs one
			for(i = intLength()-2,i>1,i-=3)
				str = copytext(str,1,i)+INTSEP+copytext(str,i)
		if(DECSEP && decLength()>3)
			i = findtext(str,DECPOINT)+3
			for(i,i<length(str),i+=4)
				str = copytext(str,1,i)+DECSEP+copytext(str,i)
		return str

	/*@
	** Removes a decimal from a text string
	** -used to convert text to bignum
	** -assumes the decimal has been found first
	*/
	proc/removeDecimal(var/str)
		if(!decimal||decimal<0||decimal>length(str)) return str
		return copytext(str,1,getDecimalPosition()-1)+copytext(str,getDecimalPosition())
/**************************************************************************************/

