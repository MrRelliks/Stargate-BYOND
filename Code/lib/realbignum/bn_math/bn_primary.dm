proc

	/*gD = get Digit
	** either returns the requested digit from a list or if it is out of the index, returns 0
	*/
	bn_gD(var/list/l,var/i)
		if(i>l.len) return 0
		return l[i]

	/*
	** Generalized version of shiftDigit for lists
	*/
	bn_shiftList(var/list/l,var/d)
		if(!d) return l
		for(var/i=abs(d),i>0,i--)
			if(d>0) l.Insert(1,0)
			else l.Add(0)



/**************************************************************************************/
bignum
		/*@
		 *  Adds the BigNum src to BigNum n2
		 *	 Returns a 3rd value
		 */
	proc/bigAdd(var/bignum/n2,var/FLOAT = MAXFLOAT)
		if(!bn_isbignum(n2)) n2 = new(n2)
		var/bignum/n1 = new(src)
		var/bignum/result = new()
		if(!n1.isNotZero()) return n2
		if(!n2.isNotZero()) return n1

		var/decimalDiff = (n1.decimal - n2.decimal)
		if(decimalDiff<0) n1.shiftDigits(abs(decimalDiff))
		else if(decimalDiff>0) n2.shiftDigits(abs(decimalDiff))

		if(n1.sign == n2.sign)
			result.sign = n1.sign
			_bigAdd(n1.digits,n2.digits,result.digits)

		else
			if(n1.sign == NEGATIVE)			//@ -2 + 3 = 3 - 2
				n1.sign = POSITIVE
				_bigSubtract(n2.digits,n1.digits,result.digits)
				n1.sign = NEGATIVE
			else							//@ 2 + -3 = 2 - 3
				n2.sign = POSITIVE
				_bigSubtract(n1.digits,n2.digits,result.digits)
				n2.sign = NEGATIVE

		result.decimal = max(n1.decimal,n2.decimal)

		result.trimZeros()
		if(MAXFLOAT) result = result.bigRound(-MAXFLOAT)

		return result


	proc/_bigAdd(var/list/n1,var/list/n2,var/list/r)
		r.len = max(n1.len,n2.len)+1
		var{a;carry=0}										//@ n1 = 1234; n2 = 5678
		for(var/i=1,i<=r.len,i++)							//@ Go through each place starting with last digit of each number
			a = carry + bn_gD(n1,i) + bn_gD(n2,i)					//@  add those numbers together eg. (n1[1]»4)+(n2[1]»8)+carry = 12»a
			r[i]=a%10
			carry = round(a/10)								//@ If a>10 carry the extra digit

/**************************************************************************************/
bignum
		/*@
		 *  Subtracts the BigNum n2 from BigNum src
		 *	 Returns a 3rd value
		 */
	proc/bigSubtract(var/bignum/n2,var/FLOAT = MAXFLOAT)
		var/bignum/n1 = new(src)
		if(!bn_isbignum(n2)) n2 = new(n2)
		var/bignum/result=new()

		var/decimalDiff = (n1.decimal - n2.decimal)
		if(decimalDiff<0) n1.shiftDigits(abs(decimalDiff))
		else if(decimalDiff>0) n2.shiftDigits(abs(decimalDiff))

		result.decimal = n1.decimal

		if(n1.sign^n2.sign)					//@ If either number is negative but not both
			n2.sign = !n2.sign								// 	e.g. -3 - 2 = -(2+3)
			_bigAdd(n1.digits,n2.digits,result.digits)		//  e.g. 3 - -2 = 3+2
			n2.sign = !n2.sign
			result.sign = n1.sign

		else if(n1.bigCompare(n2)==1) // if <n2> is bigger than <n1>
			result.sign = NEGATIVE
			if(!(n1.sign|n2.sign)) _bigSubtract(n1.digits,n2.digits,result.digits)
			else _bigSubtract(n2.digits,n1.digits,result.digits)

		else
			if(!(n1.sign|n2.sign)) _bigSubtract(n2.digits,n1.digits,result.digits)
			else _bigSubtract(n1.digits,n2.digits,result.digits)


		result.trimZeros()
		if(FLOAT) result = result.bigRound(-FLOAT)
		return result

	proc/_bigSubtract(var/list/n1,var/list/n2,var/list/r)
		r.len = max(n1.len,n2.len)
		//@ subtraction method
		var{a;borrow=0}								// n1 = 2345; n2 = 1234
		for(var/i=1, i<=r.len, i++)					// Go through each digit starting with the final position
			a = bn_gD(n1,i)-borrow-bn_gD(n2,i)			//  subtract the digits with any borrow eg. (n1[1]»a»5)-borrow-(n2[1]»b»4)= 1»c
			if(bn_gD(n1,i)>0) borrow = 0					// if n1[i] is larger than zero, clear borrow
			if(a<0) {a+=10;borrow=1}				// if a is less than 0, you need to borrow, so add 10 to a
			r[i]=a%10								// set_digit(i) to the whole part of c%10

/**************************************************************************************/
bignum
		/*@
		 *  Multiplies the BigNum src by BigNum n2
		 *	 Returns a 3rd value
		 */
	proc/bigMultiply(var/bignum/n2,var/FLOAT = MAXFLOAT)
		if(!bn_isbignum(n2)) n2 = new(n2)
		var/bignum/result=new()

		_bigMultiply(src.digits,n2.digits,result.digits)

		result.sign = !(src.sign ^ n2.sign)
		result.decimal = src.decimal + n2.decimal

		result.trimZeros()
		if(FLOAT) result = result.bigRound(-FLOAT)

		return result

	proc/_bigMultiply(var/list/n1,var/list/n2,var/list/r)
		var/list/row = n1.Copy()						//@the current row, initially equal to <src>
		for(var/i=1, i<=n2.len, i++)
			for(var/j=1,j<=n2[i],j++)
				_bigAdd(r,row,r)
			bn_shiftList(row,1)

/**************************************************************************************/
bignum
	/*@
	** Divide src by n2
	**  return a third bignum
	*/

	proc/bigDivide(var/bignum/n2,var/FLOAT = MAXFLOAT)

		var/bignum/n1 = new(src)
		if(!bn_isbignum(n2)) n2 = new(n2)	//If you try to divide by something other than a BigNum, it will try to turn it into one
		var/bignum/result=new(0)

		//@ Check for divide by 0 error
		if(!n2.isNotZero())
			result.ERROR = DV0
			return result

		//@ Get rid of the decimals
		var/decimalDifference = max(n1.decimal,n2.decimal)

		if(decimalDifference)
			n1.shiftDigitsDec(decimalDifference)	//Since we are shifting both numbers by the same ammount each time,
			n2.shiftDigitsDec(decimalDifference)	// it will not change the result
		n1.trimZeros()
		n2.trimZeros()

		//@find the dign
		result.sign = !(n1.sign ^ n2.sign)

		_bigDivide(n1,n2,result,FLOAT)

		//@ add back one if there will be a decimal in the new num
		result.trimZeros()

		return result

	proc/_bigDivide(var/bignum/n1,var/bignum/n2,var/bignum/r,var/FLT)
		var/bignum/row = new(0) //@ inititate row
		var/i = n1.digitsLength()
		do
			if(i<1)
				r.decimal++
				row.digits.Insert(1,0)
			else
				row.digits.Insert(1,n1.digits[i])
			r.digits.Insert(1,0)
			while(row.bigCompare(n2,0) < 1) //row >= n2
				r.digits[1]+=1
				_bigSubtract(row.digits,n2.digits,row.digits)
			i--
		while(r.decimal<abs(FLT)||(row.isNotZero()&&i>0)) //You have to have some limit or the function could continue forever
