bignum
/**************************************************************************************/
/*
** These are in-place procs, i.e. they don't return a new value they modify the src
*/

	/*@
	** Shift number by d places
	**  equivalent to adding zeros to a number, no change in decimal
	*/
	proc/shiftDigits(var/d)
		if(!d) return
		for(var/i=abs(d),i>0,i--)
			if(d<0) digits.Add(0)
			else
				digits.Insert(1,0)
				decimal++

	/*@
	** Shift number by d places while retaining decimal position
	**  equivalent to multiplying by 10^d (d can be positive or negative)
	*/
	proc/shiftDigitsDec(var/d)
		if(!d) return
		for(var/i=abs(d),i>0,i--)
			if(d<0)
				digits.Add(0)
				decimal++
			else digits.Insert(1,0)




