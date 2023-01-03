/* - Start here if you want to take advantage of bignums without diving into the depths
Please consult the reference for more info
*/


//The four primary functions - run through bn_primary.dm
proc
	bAdd(var/bignum/a,var/b,var/f)
		/*
		 *  Adds two values together by first converting
		 *	 them to bignums
		 *	Returns a 3rd value as a bignum
		 */
		if(!bn_isbignum(a)) a = new(a)
		return a.bigAdd(b,f)

	bSubtract(var/bignum/a,var/b,var/f)
		/*
		 *  Subtracts two values from each other by first
		 *	 converting them to bignums
		 *	Returns a 3rd value as a bignum
		 */
		if(!bn_isbignum(a)) a = new(a)
		return a.bigSubtract(b,f)

	bMultiply(var/bignum/a,var/b,var/f)
		/*
		 *  Multiples two values by each other by first
		 *	 converting them to bignums
		 *	Returns a 3rd value as a bignum
		 */
		if(!bn_isbignum(a)) a = new(a)
		return a.bigMultiply(b,f)

	bDivide(var/bignum/a,var/b,var/f)
		/*
		 *  Divides a by b by first converting them into bignums
		 *	Returns a 3rd value as a bignum
		 */
		if(!bn_isbignum(a)) a = new(a)
		return a.bigDivide(b,f)



//Secondary Functions - run through bn_secondary.dm
proc
	/*
	These three procs provide basic comparisons
	-They return 1 if true and 0 if false
	Ex: a = 25 b = 67
		bGreater(a,b) = 0
		bLess(a,b) = 1
		bEqual(a,b) = 0
	-Based on bigCompare()
	*/
	bGreater(var/bignum/a,var/b)
		if(!bn_isbignum(a)) a = new(a)
		return a.bigCompare(b)<0

	bLess(var/bignum/a,var/b)
		if(!bn_isbignum(a)) a = new(a)
		return a.bigCompare(b)>0

	bEqual(var/bignum/a,var/b)
		if(!bn_isbignum(a)) a = new(a)
		return a.bigCompare(b)==0

	bAbs(var/bignum/a)
		/*
		 *	Returns the absolute value of a num
		 */
		if(!bn_isbignum(a)) a = new(a)
		a.sign = POSITIVE
		return a

	bRound(var/bignum/a,var/n)
		/*
		 *	Rounds a to n decimal places
		 *	-a can be any number in any form
		 *  -n must be an integer
		 *		Negative n for rounding to decimal points: -1 = .1;  -3 = .001
		 *		Positive n will round to powers of 10: 1 = 1; 3 = 100
		 */
		if(!bn_isbignum(a)) a = new(a)
		return a.bigRound(n)


//Display Functions - run through dn_display.dm
proc
	bString(var/bignum/a,var/intSep=INTSEP,var/decSep=DECSEP)
		/*
		*	Returns a string representation of a num
		*/
		if(!bn_isbignum(a)) a = new(a)
		return a.toString(,intSep,decSep)

	bNum(var/bignum/a)
		/*
		*	Returns a num representation of a num
		*		{this is inhibited by the max length of numbers in BYOND (the whole reason for this library...)}
		*/
		if(!bn_isbignum(a)) a = new(a)
		return a.toNum()