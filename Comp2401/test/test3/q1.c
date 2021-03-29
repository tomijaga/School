#include <string.h>
#include <stdio.h>
#include <signal.h>
#include <ctype.h>
#include <limits.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

int main()
{
    int result;
    for (int i = 0; i < 10; i++)
    {
        int result = fork();
        usleep(1000000);
        srand(time(NULL));
        if (result == 0)
        {
            int num = rand() % 10;
            printf("child %d is ok\n", i);

            if (num == i)
            {
                printf("%d == %d\n", num, i);
                printf("Killing the program\n");
                kill(getppid(), SIGKILL);
            }
            break;
        }

        if (i == 9)
        {
            printf("Ended Naturally");
        }
    }
}