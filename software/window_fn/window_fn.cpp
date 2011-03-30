// window_lookup.cpp : Defines the entry point for the console application.
//


#include "targetver.h"

#include <stdio.h>
#include <tchar.h>
#include <math.h>


/********************************* CONFIG TUNABLES ******************************************/
/* The output format of the atan table, 4+4 (signed 2's complement) */
#define OUTPUT_FIXED_WORD_BITS		8
#define OUTPUT_FIXED_FRACTION_BITS	7
#define OUTPUT_FIXED_INTEGER_BITS	(OUTPUT_FIXED_WORD_BITS - OUTPUT_FIXED_FRACTION_BITS)

#define N_SAMPLES	2048
#define WINDOW_FUNCTION		WINDOW_FN_HAMMING
/********************************************************************************************/



enum {
	WINDOW_FN_RECTANGULAR,
	WINDOW_FN_HANN,
	WINDOW_FN_HAMMING,
	WINDOW_FN_BLACKMAN,
	WINDOW_FN_BLACKMAN_HARRIS_3,
	WINDOW_FN_BLACKMAN_HARRIS_4,
};

#define PI	3.14159265

#define WINDOW_HANN(N, n)												\
	(0.5 * (1 - cos((2.0*PI*n)/(N-1.0))))

#define WINDOW_HAMMING(N, n)											\
	(0.54 - 0.46 * cos((2.0*PI*n)/(N-1.0)))

#define WINDOW_BLACKMAN(N, n)											\
	(0.42 - 0.5*cos(2.0*PI*x/(N-1.0)) + 0.08*cos(4.0*PI*x/(N-1.0)))

#define WINDOW_BLACKMAN_HARRIS_3(N, n)									\
	(0.42323 - 0.49755*cos((2.0*PI*n)/(N-1.0)) +						\
	0.07922*cos((4.0*PI*n)/(N-1.0)))

#define WINDOW_BLACKMAN_HARRIS_4(N, n)									\
	(0.35875 - 0.48829*cos((2.0*PI*n)/(N-1.0)) +						\
	0.14128*cos((4.0*PI*n)/(N-1.0)) - 0.01168*cos((6.0*PI*n)/(N-1.0)))


//http://web.mit.edu/xiphmont/Public/windows.pdf
//http://www.katjaas.nl/FFTwindow/FFTwindow&filtering.html

void window(float *coeff, int window_fn, int N) {
	int n;

	for (n = 0; n < N; n++) {
		switch (window_fn) {
		case WINDOW_FN_HANN:
			coeff[n] = WINDOW_HANN(N, n);
			break;

		case WINDOW_FN_HAMMING:
			coeff[n] = WINDOW_HAMMING(N, n);
			break;

		case WINDOW_FN_BLACKMAN_HARRIS_3:
			coeff[n] = WINDOW_BLACKMAN_HARRIS_3(N, n);
			break;

		case WINDOW_FN_BLACKMAN_HARRIS_4:
			coeff[n] = WINDOW_BLACKMAN_HARRIS_4(N, n);
			break;

		case WINDOW_FN_RECTANGULAR:
		default:
			coeff[n] = 1.0;
		}
	}
}

int _tmain(int argc, _TCHAR* argv[])
{
	int i, j;
	float coeff[N_SAMPLES];
	unsigned long coeff_fixed;
	float dont_care;

	printf("; Memory file for window function ROM\n");
	printf("; addressed via [n] where n is the sample number.\n");
	printf("; Output is in 1QN fixed point signed two's complement\n");
	printf("; with %d bits fractional precision\n", OUTPUT_FIXED_FRACTION_BITS);
	printf("\n");
	printf("memory_initialization_radix=2;\n");
	printf("memory_initialization_vector= ");

	window(coeff, WINDOW_FUNCTION, N_SAMPLES);
	for (i = 0; i < N_SAMPLES; i++) {
		//printf("%lf", coeff[i]);

#if 1
		//coeff_fixed = modf(coeff[i], &dont_care);
		coeff_fixed = abs((long)(modf(coeff[i], &dont_care)/(1.0/powf(2.0, OUTPUT_FIXED_FRACTION_BITS))));
		coeff_fixed |= (abs((long)coeff[i]) << OUTPUT_FIXED_FRACTION_BITS);
#endif
		/* Now get the sign */
		if (coeff[i] < 0) {
			coeff_fixed = ~coeff_fixed;
			++coeff_fixed;
			coeff_fixed |= (1 << (OUTPUT_FIXED_WORD_BITS-1));
		}

		//printf("%d vs %f\n", theta_fixed, theta);
		for (j = OUTPUT_FIXED_WORD_BITS-1; j >= 0; j--) {
			if (coeff_fixed & (1 << j))
				putchar('1');
			else
				putchar('0');
		}

		if (i < N_SAMPLES-1)
			printf(", ");
	}

	printf(";\n");

	return 0;
}

