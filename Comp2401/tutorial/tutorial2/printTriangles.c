/* File is printTriangles.c

Purpose: file is for tutorial 2 to explore recursion


Revision:
a. Initial code - Doron Nussbaum 14/9/2018
b. Revision to remove unused prototypes and change return types

*/

/************************************************************************/

// INCLUDE FILES

#include "stdio.h"
#include "stdlib.h"


/************************************************************************/
// FUNCTION PROTOTYPES

void printTriangleRecursive(unsigned int numRows);
void printTriangleRecursiveUpsidedown(unsigned int numRows);
void printTriangleRecursiveCountStars(unsigned int numRows, int *numStars);
void printTriangleRecursiveDown(unsigned int numRows, unsigned int count);
void printandRecursiveCountStars(unsigned int numRows, unsigned int count, int *numStars);
/************************************************************************/


int main()
{

  unsigned int numRows=7;
	int numStars;
  int j;

	printf("printing a triangle with %d rows \n",numRows);
	printTriangleRecursive(numRows);
 
	printf("\nprinting a triangle upside down with %d rows \n\n",numRows);
	printTriangleRecursiveUpsidedown(numRows);

	printf("\nprinting a triangle with %d rows and counting the number of stars\n\n",numRows);
	printf("the number of printf * should be %d \n", (1+numRows)*numRows/2);
	printTriangleRecursiveCountStars(numRows, &numStars);
	printf("\nthe number of * returned by the function is %d\n\n",numStars);

	return(0);
}


/***********************************************************************************/
/* Purpose: prints a triangle DownWards '*'

input:
numRows - the number of rows that the triangle should have
count - number of rows already printed

output:
none

return:

*/


void printTriangleRecursive(unsigned int numRows)
{
	printTriangleRecursiveDown(numRows, 0);

    return;
}

void printTriangleRecursiveDown(unsigned int numRows, unsigned int count){
for (size_t i = 0; i < count; i++)
{
	printf("*");
	
}
printf("\n");


if(count<numRows){

printTriangleRecursiveDown(numRows, count+1);

}

return;
}


/***********************************************************************************/
/* Purpose: prints a triangle using '*' and computes how many '*' were printed

input:
numRows - the number of rows that the triangle should have

output:
numStars - the number of stars that were printed

return:
*/


void printTriangleRecursiveCountStars(unsigned int numRows, int *numStars)
{
 *numStars=0;
printandRecursiveCountStars(numRows, 0, numStars);

    return;
}


/***********************************************************************************/
/* Purpose: prints a triangle using '*' and computes how many '*' were printed

input:
numRows - the number of rows that the triangle should have

output:
numStars - the number of stars that were printed

return:
*/


void printandRecursiveCountStars(unsigned int numRows, unsigned int count, int *numStars)
{

for (size_t i = 0; i < count; i++)
{
	printf("*");
	*numStars = *numStars+1;
	
}
printf("\n");


if(count<numRows){

printandRecursiveCountStars(numRows, count+1, numStars);

}

return;
}



/***********************************************************************************/
/* Purpose: prints a triangle using '*' with the base as the first row

input:
numRows - the number of rows that the triangle should have

output:
none

return:

*/


void printTriangleRecursiveUpsidedown(unsigned int numRows)
{


if(numRows == 0){
		return;
	}

for (size_t i = 0; i < numRows; i++)
{
	printf("*");
	
}
printf("\n");

printTriangleRecursiveUpsidedown(numRows-1);
  
	return;
}

