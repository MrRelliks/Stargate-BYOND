world/version = 116

/*
**	RealBigNum V116
**		by Asielen 2012
**
**	December 31, 2012 – Release V113–116
**		Added:
**			Decimal and Thousands divider options for readability of output
**				They are on by default but can be turned off
**			Bignum can be created through scientific notation
**				(e.g. you can enter 10.2e5 as text and it will create the number 1,020,000)
**				Sigfigs and scientific notation output are coming at some point
**		Fixed:
**			Multiply link was not working on the demo, fixed that
**			Cleaned up the output for the demo, so it makes more sense for testers
**
**	July 24, 2012 - Release V110
**		Added:
**			RealBigNum Basics to make jumping into using bignums easier (see reference for details)
**		Fixed:
**			bn_Primary.dm
**				-bigAdd() was passing bignums to _bigAdd() instead of lists
**				-bigDivide() was not handling signs properly
**				-bigSubtract() was not handling signs properly
**
**	March 10, 2012 - First Release V100
*/
