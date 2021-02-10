
#include <stdio.h>
#include <stdlib.h>

char getBit(unsigned char c, int n);
char compareBit(unsigned char n1, unsigned char b1, unsigned char n2, unsigned char b2);
char areBitsReversed(unsigned char n1, unsigned char n2);

int main(int argc, char *argv[])
{
    unsigned char decimal1 = 58; // 00111010
    unsigned char decimal2 = 98; // 01011100
    if (areBitsReversed(decimal1, decimal2))
        printf("Yes\n");
    else
        printf("No\n");

    return (0);
}

char areBitsReversed(unsigned char n1, unsigned char n2)
{

    for (char i = 0; i < 8; ++i)
    {
        if (!compareBit(n1, i, n2, i))
        {
            return 0;
        }
    }

    return 1;
}

char compareBit(unsigned char n1, unsigned char b1, unsigned char n2, unsigned char b2)
{
    if (getBit(n1, b1) == getBit(n2, b2))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

char getBit(unsigned char c, int n)
{
    return (c & (1 << n)) >> n;
}