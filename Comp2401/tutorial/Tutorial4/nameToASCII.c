#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[])
{

    for (int i = 1; i < argc; ++i)
    {
        printf("%d. %s ==> ", i, argv[i]);

        for (unsigned long j = 0; j < strlen(argv[i]); ++j)
        {

            printf("%d  ", *(argv[i] + j));
        }

        printf("\n\n");
    }

    return (0);
}