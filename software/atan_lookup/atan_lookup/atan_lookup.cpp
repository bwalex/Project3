// atan_lookup.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <math.h>

/* We use 1QN format (one bit to the left of the radix point, signed 2's complement) */
#define FIXED_WORD_BITS		5
#define FIXED_FRACTION_BITS	4
#define MASK_FOR_FRACTION_BITS	0xF

/* The output format of the atan table, 4+4 (signed 2's complement) */
#define OUTPUT_FIXED_WORD_BITS		8
#define OUTPUT_FIXED_FRACTION_BITS	4
#define OUTPUT_FIXED_INTEGER_BITS	(OUTPUT_FIXED_WORD_BITS - OUTPUT_FIXED_FRACTION_BITS)

int _tmain(int argc, _TCHAR* argv[])
{
	float a, b, theta, dont_care;
	unsigned long i, max, theta_fixed;
	int j, sign_a, sign_b, bits_a, bits_b;

	max = (unsigned long)powf(2.0, (float)2.0*FIXED_WORD_BITS);

	printf("; Memory file for atan2(y,x) LUT\n");
	printf("; addressed via [y][x] where both y and x are in 5-bit 1QN format\n");
	printf("; Output is in 4+4 fixed point signed two's complement\n");
	printf("\n");
	printf("memory_initialization_radix=2;\n");
	printf("memory_initialization_vector= ");
	for (i = 0; i < max; i++)
	{
		bits_b = (i & MASK_FOR_FRACTION_BITS);
		bits_a = ((i >> FIXED_WORD_BITS) & MASK_FOR_FRACTION_BITS);
		sign_b = (i & (1 << FIXED_FRACTION_BITS));
		sign_a = ((i >> FIXED_WORD_BITS) & (1 << FIXED_FRACTION_BITS));

		if (sign_b) {
			--bits_b;
			bits_b = ((~bits_b) & MASK_FOR_FRACTION_BITS);
			/* Kludge, since 0b100... == -2^N-1 */
			if (bits_b == 0)
				b = -1.0;
			else
				b = (float)(-1.0/powf(2.0, FIXED_FRACTION_BITS) * bits_b);
		} else {
			b = (float)(1.0/powf(2.0, FIXED_FRACTION_BITS) * bits_b);
		}

		if (sign_a) {
			--bits_a;
			bits_a = ((~bits_a) & MASK_FOR_FRACTION_BITS);
			/* Kludge, since 0b100... == -2^N-1 */
			if (bits_a == 0)
				a = -1.0;
			else
				a = (float)(-1.0/powf(2.0, FIXED_FRACTION_BITS) * bits_a);
		} else {
			a = (float)(1.0/powf(2.0, FIXED_FRACTION_BITS) * bits_a);
		}
		theta = atan2f(a, b);

		/* Check if we have enough integer bits. One integer bit is for the sign */
		if (abs((long)theta) >= (long)powf(2.0, OUTPUT_FIXED_INTEGER_BITS-1)) {
			printf("Error! Not enough integer precision bits!!!\n");
			return -1;
		}

		theta_fixed = abs((long)(modf(theta, &dont_care)/(1.0/powf(2.0, OUTPUT_FIXED_FRACTION_BITS))));
		theta_fixed |= (abs((long)theta) << OUTPUT_FIXED_FRACTION_BITS);

		/* Now get the sign */
		if (theta < 0) {
			theta_fixed = ~theta_fixed;
			++theta_fixed;
			theta_fixed |= (1 << (OUTPUT_FIXED_WORD_BITS-1));
		}

		//printf("%d vs %f\n", theta_fixed, theta);
		for (j = OUTPUT_FIXED_WORD_BITS-1; j >= 0; j--) {
			if (theta_fixed & (1 << j))
				putchar('1');
			else
				putchar('0');
		}
		
		if (i < max-1)
			printf(", ");

#if 0
		/* now we need to convert theta to fixed point */
		printf("a = %.4f     b = %.4f     theta = %.2f\n", a, b, theta);
#endif
	}

	printf(";\n");
	return 0;
}

