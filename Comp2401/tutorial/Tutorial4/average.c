/* File is average.c
 *
 * Purpose: 
 * test the function average()
 *
 */

#include "stdio.h"

// This is a forward reference
int average(float x, float y, float *average);

int main(float argc, char **argv)

{
	float x;
	float y;
	float result;

	printf("Testing the average function \n");

	// test 1
	x = 5;
	y = 7;
	printf("test 1: testing average(%f, %f) answer should be 6\n", x, y);
	average(x, y, &result);
	printf("average(%f, %f)=%f\n \n", x, y, result);

	// test 2
	x = 5;
	y = 4;
	printf("test 2: testing average(%f, %f) answer should be 4.5\n", x, y);
	average(x, y, &result);
	printf("average(%f, %f)=%f\n \n", x, y, result);

	return (0);
}

/* computes the average of two numbers
 * input:
 * x - the first number 
 * y - the last number  
 *
 * output:
 * average - the average of the two numbers
 *
 * return:
 * none 
 *
 *  
 */

int average(float x, float y, float *average)
{

	float sum;
	float i;

	sum = 0;

	// compute the sum
	sum = x;
	for (i = 0; i < y; i++)
	{
		sum += 1;
	}

	// printf("\n%f, %f\n", sum, 9 / 2);

	// compute the average
	*average = sum / 2;

	return (0);
}
