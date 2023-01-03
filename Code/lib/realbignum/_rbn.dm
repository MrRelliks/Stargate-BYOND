#define POSITIVE 1
#define NEGATIVE 0

//@ Error Messages
#define DV0 "ERROR DIVIDE BY 0"			//@ Tried to divide by 0
#define UNK "ERROR UNKNOWN"				//@ Unknown error, or answer is unknown
#define IMG "ERROR IMAGINARY ANSWER"	//@ Tried to take the root of a negative number
#define OVR "ERROR OVERFLOW"

world/loop_checks=0	//Be carful with this off. If we leave it on BYOND may not allow some of
					// the longer computations



var/MAXFLOAT = 12 	//To limit results, prevents problems where you could have infinite digits

	/*@
	** Changes the standard float
	** -This proc limits the MAXFLOAT value to between 0 and 500. You can have more decimals
	**   and if you feel the need you can increase the number but it will hinder performance
	** -It is important to have a max float value because some calculations could end up with
	**   infinite digits otherwise
	*/
proc
	bn_setFloat(var/float=12)
		MAXFLOAT = max(min(float,500),0)




var/DECPOINT = "."	//The divider between the decimal part and integer part
var/INTSEP = null	//The divider betwen thousands
var/DECSEP = null	//The divider for grouping decimal places (this is different than the decimal point) – not currently implemented

	/*@
	** Changes the separators for displaying numbers
	** -IMPORTANT NOTE: It is HIGHLY RECOMENDED that you use this to set their values
	** 		rather than setting them directly. If you set them directly and you set two
	**		of the separators to the same thing, it may cause problems when parsing numbers.
	*/
proc
	bn_setSeparators(var/dpoint=DECPOINT,var/isep=INTSEP,var/dsep=DECSEP)
		dpoint = copytext(dpoint,1,2) //@ Only use one character
		isep = copytext(isep,1,2)
		dsep = copytext(dsep,1,2)
		if(dpoint==isep||dpoint==dsep)
			//CRASH("SEPARATORS CANNOT BE THE SAME")
			world << "SEPARATORS CANNOT BE THE SAME, SETTING TO LAST VALUES"
			return
		DECPOINT = dpoint
		INTSEP = isep
		DECSEP = dsep

