#include "stdio.h"
#include "string.h"

int main()
{

    char *names[8] = {"Andy", "Bob", "Chantalle", "Darla", "Erika", "Fred", "Gordon", "Heather"};
    char shortNames[8][4];
    char list[100];

    // INSERT MISSING CODE HERE //

    for (size_t i = 0; i < 8; i++)
    {
        for (size_t j = 0; j < 4; j++)
        {
            if (j < 3)
            {
                shortNames[i][j] = *(names[i] + j);
            }
            else
            {
                shortNames[i][j] = '\0';
            }
        }
    }

    int size = 0;
    for (size_t i = 0; i < 8; i++)
    {

        strcpy(&list[size], names[i]);
        size += strlen(names[i]);
        if (i != 7)
        {
            strcpy(&list[size], ",");
            size += 1;
        }
    }

    for (int i = 0; i < 8; i++)
        printf("%s ", shortNames[i]);
    printf("\n%s\n", list);
}