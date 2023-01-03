/*
// This library provides two methods for getting an abbreviated number back.
// Proc_GetCustomAbbreviatedNumber() provides options for overriding basic style settings.
// Proc_GetAbbreviatedNumberWithStyle() provides options for overriding the entire style.
// Proc_CovertToAbbreviatedForm() is where the magic happens.
*/
proc
{
	//
	// Provides options to override specific properties of the style string.
	// See Proc_GetAbbreviatedNumberWithStyle() if you want more control over the style
	//
	Proc_GetCustomAbbreviatedNumber(var/numberAsString, var/precisionCount = 5, var/fontFamily as text, var/fontSize as text, var/fontStyle as text, var/fontWeight as text, var/fontColor as text, var/spaceAmount = 1)
	{
		// Defaults
		var/_fontFamily = "Impact"
		var/_fontSize = "28pt"
		var/_fontStyle = "Italic"
		var/_fontWeight = "500"
		var/_fontColor = "White"
		var/_spaceAmount = 1

		if (fontFamily == "")
		{
			_fontFamily = fontFamily
		}
		if (fontSize == "")
		{
			_fontSize = fontSize
		}
		if (fontStyle == "")
		{
			_fontStyle = fontStyle
		}
		if (fontWeight == "")
		{
			_fontWeight = fontWeight
		}
		if (fontColor == "")
		{
			_fontColor = fontColor
		}
		if (spaceAmount != 1)
		{
			_spaceAmount = spaceAmount
		}

		var/styleStart = "<font style=\"font-family: [_fontFamily]; font-size:[_fontSize];font-style:[_fontStyle];font-weight:[_fontWeight];color:[_fontColor]\">"
		var/tinySpace = "<font size=[_spaceAmount]>   </font>"
		var/abbsStyleEnd = "</font>"

		return Proc_CovertToAbbreviatedForm(numberAsString, precisionCount, styleStart, tinySpace, abbsStyleEnd)
	}

	//
	// Provides options to override the entire style string.
	//
	Proc_GetAbbreviatedNumberWithStyle(var/numberAsString as text, var/precisionCount = 5, var/styleStart as text, var/styleClose as text, var/spaceAmount as num)
	{
		var/_styleStart = "<font style=\"font-family: Impact; font-size:28pt;font-style:italic;font-weight:500;color:white\">"
		var/_styleClose = "</font>"
		var/tinySpace = "<font size=[spaceAmount]>   </font>"

		// Does user want to override any of the default default styles?
		if (styleStart != "")
		{
			_styleStart = styleStart
		}

		if (styleClose != "")
		{
			_styleClose = styleClose
		}

		return Proc_CovertToAbbreviatedForm(numberAsString, precisionCount, _styleStart, tinySpace, _styleClose)
	}

	//
	// Heart of the library. Handles the conversion.
	// Converts the number string into an abbreviated form.
	//
	Proc_CovertToAbbreviatedForm(var/numberAsString as text, var/precisionCount = 4, var/styleStart as text, var/tinySpace as text, var/styleEnd as text)
	{
		var/list/listOfAbbs = list("K", "M", "B", "t", "q", "Q", "s", "S", "o", "n", "d", "U", "D", "T", "Qt", "Qd", "Sd", "St", "O", "N", "v", "c");

		// Convert the length into large number support
		var/bignum/_sNumberCharacterLength = new(length(numberAsString))

		// If the number is less than 1000 (4 characters)
		// just return it. No need to abbreviate.
		if (bNum(_sNumberCharacterLength) <= 3)
		{
			return numberAsString
		}

		// Take 12341241234 and divide it into 3. A remainder of 3 tells us there is one
		// digit to the left of the decimal, while a remainder of 6 tells us there is two and
		// no remainder tells us there are 3 digits to the left of the decimal.
		var/dividedLength = bNum(_sNumberCharacterLength) / 3

		if (dividedLength > length(listOfAbbs))
		{
			return text2num(numberAsString)
		}

		// Example: 16/3 = 5.3. We could get values like 5.6 or 5 (whole numbers) but always .3, .6 or whole number.
		var/dividedLengthAsString = num2text(dividedLength)

		var/firstDigitAfterDecimal = "";

		// Can we find a decimal in the string?
		if (findtext(dividedLengthAsString, "."))
		{
			// We have a decimal so split the string on it


			// Get the first digit after the decimal. Again, always a 3 or 6.
			firstDigitAfterDecimal = copytext(splitString[2], 1, 2)
		}

		var/my_string
		var/decimal = ""

		// Are we adding a decmial?
		if (precisionCount > 0)
		{
			decimal = "."
		}

		// Determines if the number starts with X, XX or XXX (100's, 10's 1's)
		if (firstDigitAfterDecimal == "3")
		{
			// Only one digit to left of first comma
			my_string = copytext(numberAsString, 1, 2)
			my_string += "[decimal][copytext(numberAsString, 2, 2 + precisionCount)][styleStart][tinySpace][listOfAbbs[dividedLength]][styleEnd]"
		}
		else if (firstDigitAfterDecimal == "6")
		{
			// Two digits to left of first comma
			my_string = copytext(numberAsString, 1, 3)
			my_string += "[decimal][copytext(numberAsString, 3, 3 + precisionCount)][styleStart][tinySpace][listOfAbbs[dividedLength]][styleEnd]"
		}
		else
		{
			// Three digits to left of first comma
			my_string = copytext(numberAsString, 1, 4)
			my_string += "[decimal][copytext(numberAsString, 4, 4 + precisionCount)][styleStart][tinySpace][listOfAbbs[dividedLength-1]][styleEnd]"
		}

		return my_string
	}
}