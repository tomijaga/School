#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "display.h"

#define MAX_MESSAGE_SIZE 100

char getBit(unsigned char byte, int n);
void setBit(unsigned char *byte, int n);
void removeBit(unsigned char *byte, int n);

int main()
{
    //characters
    unsigned char characters[28][8] = {
        {0b00010000, 0b00101000, 68, 68, 124, 68, 68, 238},                                                                 //A
        {0b11111000, 0b01000100, 0b01001000, 0b01111100, 0b01000010, 0b01000010, 0b01000010, 0b11111100},   //B
        {0b00111010, 0b01000110, 0b10000010, 0b10000000, 0b10000000, 0b10000010, 0b01000110, 0b00111010},   //C
        {0b11111000, 0b01000100, 0b01000010, 0b01000010, 0b01000010, 0b01000010, 0b01000100, 0b11111000},   //D
        {0b11111110, 0b01000010, 0b01000000, 0b01111000, 0b01000000, 0b01000000, 0b01000010, 0b11111110},   //E
        {0b11111110, 0b01000010, 0b01000010, 0b01001000, 0b01111000, 0b01001000, 0b01000000, 0b11100000},   //F
        {0b00111110, 0b01000010, 0b10000000, 0b10011110, 0b10010010, 0b10000010, 0b01000010, 0b00111100},   //G
        {0b11101110, 0b01000100, 0b01000100, 0b01111100, 0b01000100, 0b01000100, 0b01000100, 0b11101110},   //H
        {0b11111110, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b11111110},   //I
        {0b00111110, 0b00001000, 0b00001000, 0b00001000, 0b11001000, 0b10001000, 0b10001000, 0b01110000},   //J
        {0b11101110, 0b01000100, 0b01001000, 0b01110000, 0b01001000, 0b01000100, 0b01000100, 0b11101110},   //K
        {0b11100000, 0b01000000, 0b01000000, 0b01000000, 0b01000000, 0b01000000, 0b01000010, 0b11111110},   //L
        {0b11000110, 0b01101100, 0b01010100, 0b01010100, 0b01000100, 0b01000100, 0b01000100, 0b11101110},   //M
        {0b11001110, 0b01100100, 0b01010100, 0b01010100, 0b01001100, 0b01000100, 0b01000100, 0b11101110},   //N
        {0b00111000, 0b01000100, 0b10000010, 0b10000010, 0b10000010, 0b10000010, 0b01000100, 0b00111000},   //O
        {0b11111100, 0b01000010, 0b01000010, 0b01111100, 0b01000000, 0b01000000, 0b01000000, 0b11100000},   //P
        {0b01111100, 0b10000010, 0b10000010, 0b10000010, 0b10000010, 0b10010010, 0b01111100, 0b00010000},   //Q
        {0b11111100, 0b01000010, 0b01000010, 0b01111100, 0b01010000, 0b01001000, 0b01000100, 0b11101110},   //R
        {0b01111010, 0b10000110, 0b10000010, 0b01111000, 0b00000100, 0b10000010, 0b11000010, 0b10111100},   //S
        {0b11111110, 0b10010010, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00111000},   //T
        {0b11101110, 0b01000100, 0b01000100, 0b01000100, 0b01000100, 0b01000100, 0b01000100, 0b00111000},   //U
        {0b11101110, 0b01000100, 0b01000100, 0b01000100, 0b01000100, 0b01000100, 0b00101000, 0b00010000},   //V
        {0b11101110, 0b01000100, 0b01000100, 0b01000100, 0b01010100, 0b01010100, 0b01010100, 0b00101000},   //W
        {0b11101110, 0b01000100, 0b00101000, 0b00010000, 0b00010000, 0b00101000, 0b01000100, 0b11101110},   //X
        {0b11101110, 0b01000100, 0b01000100, 0b00101000, 0b00010000, 0b00010000, 0b00010000, 0b00111000},   //Y
        {0b11111110, 0b10000010, 0b00000100, 0b00011000, 0b00100000, 0b01000000, 0b10000010, 0b11111110},   //Z
        {0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b11000000, 0b11000000},   //.
        {0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},   //[space]
        
    };

    int orientation=-1;
    
    unsigned char errorChecker = 0;
    printf("Choose Your Orientation:\n");


    while(orientation < 0 ){

    if(errorChecker >=1){
    printf("\nPls Choose A Valid Orientation From Below:\n");
    }

    printf("\t1.  Horizontal\n");
    printf("\t2.  Vertical\n");

    
    if(!scanf("%d  *[^\n]", &orientation) || errorChecker++ >= 2){
    printf("\nProgram was Terminated due to invalid input\n");
            break;
     }
    }

    if(orientation)--orientation;

    printf("Enter Message To Display:\n");
    char message[MAX_MESSAGE_SIZE]="";
    fflush(stdout);
    fgets(message, MAX_MESSAGE_SIZE, stdin);

    int messageLength = strlen(message)-1;

    //change small letters to CAPITAL letters
    for(int i = 0; i < messageLength; ++i){
        char Char = message[i];
        if(Char <= 122 && Char >= 97){
            message[i] = Char - 32;
        }
    }


    if(orientation == HORIZONTAL || orientation == VERTICAL){
    initializeWindow(orientation, MAX_CHARACTERS);
    unsigned char bytes[900];
    unsigned int bytesIndex = 0;

    for (int i = 0; i < messageLength; ++i)
    {
        char Char = message[i];
        unsigned char *letter;

        if(Char <= 90 && Char >= 65){
            letter = characters[Char - 65];
        }else if(Char == 46){
            letter = characters[26];
        }else{
            letter = characters[27];

        }

        if(orientation == VERTICAL){
        for(int  j =0; j < VERTICAL_CELLS_PER_CHAR; ++j){
                bytes[bytesIndex++] = letter[j];
        }
                bytes[bytesIndex++] = 0;

        }else {
            for(int  col = HORIZONTAL_CELLS_PER_CHAR - 1; col >= 0; --col){
                unsigned char newChar = 0;
                for(int  row = HORIZONTAL_CELLS_PER_CHAR - 1; row >= 0 ; --row){
                    
                    if(getBit(letter[row], col)){
                        printf("\nset bit to 1\n");
                        setBit(&newChar, row);
                        printf("\t newChar = %d, row %d\n", newChar, row);

                    }else{
                        printf("set bit to 0\n");
                        removeBit(&newChar, row);
                        printf("\t newChar = %d, row %d\n", newChar, row);

                    }
                }
                    printf("newChar = %d, col %d\n", newChar, col);

                    bytes[bytesIndex++] = newChar;
                
            }
        }

    }

printf("\n %d", bytesIndex);

    displaySign(bytes, bytesIndex);
    closeWindow();
    }

    return (0);
}

char getBit(unsigned char byte, int n)
{
    return (byte & (1 << n)) >> n;
}

void setBit(unsigned char *byte, int n){
    printf("\t oldBit = %d", *byte);

    *byte = *byte | (1 << n);

    printf("\t newBit = %d\n", *byte);
}

void removeBit(unsigned char *byte, int n){
    *byte = *byte & ~ (1<<n);
}