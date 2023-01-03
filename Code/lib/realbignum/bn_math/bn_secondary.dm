/**************************************************************************************/
bignum
	/*@ Just modified the last secion with the for loop
	** Compare <src> to a value
	**  return:
	** 		-1 if src > value
	**		+1 if src < value
	**		0  if src = value
	*/
	proc/bigCompare(var/value,var/s = 1)
		//1 if sign matters, 0 if not
		//Most of the time you want 1

		var/bignum/n1 = new(src)
		var/bignum/n2 = new(value)

		if(!s) {n1.sign = POSITIVE;n2.sign = POSITIVE}	//This is only for dividing

		n1.trimZeros()
		n2.trimZeros()
		//@ if <n1> is positive and <n2> is negative: src>that
		if(n1.sign && !n2.sign) return -1

		//@ if <n1> is negative and <n2> is positive: src<that
		if(!n1.sign && n2.sign) return 1

		var/decimalDiff = (n1.decimal - n2.decimal) 				//@ See add for explaination
		if(decimalDiff<0) n1.shiftDigits(abs(decimalDiff))		//@ Easier to compare if decimal places are equal
		else if(decimalDiff>0) n2.shiftDigits(abs(decimalDiff))

		//@ Compare the int parts of each number, assuming signs are the same
		if(n1.intLength() < n2.intLength())
			return src.sign ? 1 : -1
		if(n1.intLength() > n2.intLength())
			return src.sign ? -1 : 1

		return _bigCompare(n1.digits,n2.digits,n1.sign) //@ Else no difference

	proc/_bigCompare(var/list/n1,var/list/n2,var/sign=POSITIVE)
		//@ compare method; assumes they are the same length at this point
		for(var/i = n1.len, i>0, i--)						//@ Starting with the highest position
			if(n1[i]>n2[i])	return !src.sign ? 1 : -1		//@ In this case, it will stop right
			if(n2[i]>n1[i])	return !src.sign ? -1 : 1		//@  after the decimal point
		return 0

/**************************************************************************************/
bignum
	/*@
	** Take src and round it to n
	**  n is a num not a bignum in this case
	**  Negative for rounding to decimal points: -1 = .1;  -3 = .001
	** 	Positive will round to powers of 10: 1 = 1; 3 = 100
	*/
	proc/bigRound(var/n)
		if(!n) 	n = 1
		var/bignum/result = new(src)
		n += result.decimal + (n<0 ? 1 : 0) //@ To adjust for the format of BigNum, (the +1 is because lists start at 1 not 0)

		if(n<=1) return src //@ no need to round
		if(n > result.digits.len)  return bn_nullbignum() //@ eg trying to round 156 to the nearest 1000: return 0

		_bigRound(result.digits,n)

			//@ Instead of shortening the number, change the unneeded digits to 0s
			//   the trimZeros function will take care of shorenting while still
			//   preserving decimals
		for(var/i = 1,i<n,i++) result.digits[i] = 0
		result.trimZeros(0)

		return result

		// Checks to see if you need to round
		//  if n > 5 round up
	proc/_bigRound(var/list/r,var/pos)
		if(r[pos-1]>=5)
			r = _carry(r,pos)

		// Adds 1 to the selected position and if that makes it greater than 9, continue down the line adding one
	proc/_carry(var/list/r,var/pos)
		var/i = pos
		for(i, i <= r.len, i++)
			r[i] = (r[i]+1) % 10
			if(r[i]) break
		if(i>r.len) r.Add(1)

/**************************************************************************************/

	/* @Simple Factorials
	 * Takes a num and returns a bignum = to n!
	 */
proc/bn_bigFactorial(var/n)
	var/bignum/result = new(1)
	var/perc = round(n/7.5)		//To prevent hangups
	for(var/i=n,i>1,i--)

		if(n>=500) //To prevent hangups
			if(!(i % perc))
				world << "[round(1 - (i / n),0.01)*100]%"
				sleep(0.5)

		result = result.bigMultiply(i)
	return result






