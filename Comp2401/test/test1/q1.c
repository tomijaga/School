#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    unsigned char number;

    printf("Enter Binary number:\n");
    scanf("%hhd", &number);

    printf("%d", number);
    return (0);
}