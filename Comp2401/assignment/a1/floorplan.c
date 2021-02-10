#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_NUM 255
typedef struct
{
    char position[2];
    char size;
} PartyType;

typedef struct
{
    u_char totalParties;
    u_char width;
    u_char length;
    u_char seatedParties;

    u_char floorPlanColumn;

    char partiesSize[MAX_NUM];
    PartyType parties[MAX_NUM];
    char *floorPlan[MAX_NUM][MAX_NUM];

} Restaurant;

void initRestaurant(Restaurant *restaurant);
void initRestaurantWithArgV(Restaurant *restaurant, char *width, char *length, char *totalParties);
void generateRandomParties(Restaurant *restaurant);
void setParties(Restaurant *restaurant);
void initFloorPlan(Restaurant *restaurant);
void seatParty(Restaurant *restaurant, u_char size, u_char sizeIndex);
void getAPartySize(Restaurant *restaurant, char *partySize, char *partIndex, u_char limit);
void updateFloorPlan(Restaurant *restaurant);
void printFloorPlan(Restaurant *restaurant);
void printUnaivailableMessage(char size);
void printGreyRow(Restaurant *restaurant);
void setFloorPlanColumn(Restaurant *restaurant, u_char column, char *val);

// void initParty(unsigned *parties[], PartyType *party, char column, char row, char size);

int main(int argc, char *argv[])
{
    srand(time(NULL));

    Restaurant theKeg;
    if (argv[1] && argv[2] && argv[1])
    {
        initRestaurantWithArgV(&theKeg, argv[1], argv[2], argv[3]);
    }
    else
    {
        initRestaurant(&theKeg);
    }

    printFloorPlan(&theKeg);

    return (0);
}

void initRestaurant(Restaurant *restaurant)
{

    u_char width;
    u_char length;
    u_char totalParties;

    system("clear");
    printf("How wide (in feet) is the restaurant floor?   ");
    scanf("%hhd", &width);
    restaurant->width = width - 2;

    printf("How long (in feet) is the restaurant floor?   ");
    scanf("%hhd", &length);
    restaurant->length = length - 2;

    printf("How many seatings would you like to simulate? ");
    scanf("%hhd", &(restaurant->totalParties));

    restaurant->seatedParties = 0;
    restaurant->floorPlanColumn = 0;

    initFloorPlan(restaurant);
    generateRandomParties(restaurant);
}

void initRestaurantWithArgV(Restaurant *restaurant, char *width, char *length, char *totalParties)
{
    system("clear");
    sscanf(width, "%hhd", &(restaurant->width));
    restaurant->width -= 2;

    sscanf(length, "%hhd", &(restaurant->length));
    restaurant->length -= 2;

    sscanf(totalParties, "%hhd", &(restaurant->totalParties));

    restaurant->seatedParties = 0;
    restaurant->floorPlanColumn = 0;

    printf("\nHow wide (in feet) is the restaurant floor?   %d\n", restaurant->width + 2);
    printf("How long (in feet) is the restaurant floor?   %d\n", restaurant->length + 2);
    printf("How many seatings would you like to simulate? %d\n", restaurant->totalParties);

    initFloorPlan(restaurant);
    generateRandomParties(restaurant);
}

void initFloorPlan(Restaurant *restaurant)
{
    u_char width = restaurant->width;
    u_char length = restaurant->length;

    // printf("width: %d \n", restaurant->width);
    // printf("length: %d \n", restaurant->length);

    for (
        u_char column = 0;
        column + 3 <= width;
        column = column + 3)
    {
        // printf("column: %d \n", restaurant->floorPlanColumn);

        setFloorPlanColumn(restaurant, restaurant->floorPlanColumn++, "...");
    }

    if (width % 3 != 0)
    {
        // printf("column: %d \n", restaurant->floorPlanColumn);

        switch (width % 3)
        {
        case 1:
            setFloorPlanColumn(restaurant, restaurant->floorPlanColumn++, ".");
            break;

        case 2:
            setFloorPlanColumn(restaurant, restaurant->floorPlanColumn++, "..");
            break;
        }
    }
}

void setFloorPlanColumn(Restaurant *restaurant, u_char column, char *val)
{
    for (u_char row = 0; row < restaurant->length; ++row)
    {
        // printf("\trow: %d, %s\n", row, val);
        restaurant->floorPlan[column][row] = val;
    }
    // printf("\n");
}

void generateRandomParties(Restaurant *restaurant)
{
    u_char randomSizes[11] = {1, 2, 2, 3, 3, 4, 4, 5, 6, 8, 12};
    u_char total = restaurant->totalParties;

    printf("\nParties: \n");
    for (u_char i = 0; i < total; ++i)
    {
        int r = rand() % 11;
        restaurant->partiesSize[i] = randomSizes[r];
        printf("[%d]\t", restaurant->partiesSize[i]);
    }
    printf("\n\n");

    for (u_char i = 0; i < total; ++i)
    {
        setParties(restaurant);
    }
}

void setParties(Restaurant *restaurant)
{
    u_char totalSeated = restaurant->seatedParties;

    u_char lastColumn = 0;
    u_char lastRow = 0;
    u_char lastSize = 0;

    u_char nextColumn = 0;
    u_char nextRow = 0;

    if (totalSeated > 0)
    {
        lastColumn = restaurant->parties[totalSeated - 1].position[0];
        lastRow = restaurant->parties[totalSeated - 1].position[1];
        lastSize = restaurant->parties[totalSeated - 1].size;

        nextColumn = lastColumn;
        nextRow = lastRow + 3 + lastSize;
    }

    u_char spaceLeft = restaurant->length - nextRow;
    char partySize = -1;
    char partyIndex = -1;

    if (nextColumn < (restaurant->width / 3))
    {
        if (spaceLeft <= 0)
        {
            nextColumn = nextColumn + 2;
            nextRow = 0;

            if (nextColumn < (restaurant->width / 3))
            {
                getAPartySize(restaurant, &partySize, &partyIndex, restaurant->length);
            }
        }
        else
        {
            getAPartySize(restaurant, &partySize, &partyIndex, spaceLeft);

            if (partySize == -1)
            {
                nextColumn = nextColumn + 2;
                nextRow = 0;
                if (nextColumn < (restaurant->width / 3))
                {
                    getAPartySize(restaurant, &partySize, &partyIndex, restaurant->length);
                }
            }
        }
    }

    if (partySize != -1)
    {
        seatParty(restaurant, partySize, partyIndex);
    }
}

void seatParty(Restaurant *restaurant, u_char size, u_char sizeIndex)
{
    PartyType party;
    party.size = size;

    u_char totalSeated = restaurant->seatedParties;
    // printf("seated Parties:%d\n", totalSeated);

    u_char lastColumn = 0;
    u_char lastRow = 0;
    u_char lastSize = 0;

    u_char nextColumn = 0;
    u_char nextRow = 0;

    if (totalSeated > 0)
    {
        lastColumn = restaurant->parties[totalSeated - 1].position[0];
        lastRow = restaurant->parties[totalSeated - 1].position[1];
        lastSize = restaurant->parties[totalSeated - 1].size;

        nextColumn = lastColumn;
        nextRow = lastRow + 3 + lastSize;
    }

    char spaceLeft = restaurant->length - nextRow;
    // printf("\tspace left: %d\n", spaceLeft);

    if (spaceLeft <= 0 || size > spaceLeft)
    {
        nextColumn = nextColumn + 2;
        nextRow = 0;
    }

    if (nextColumn < (restaurant->width / 3))
    {
        party.position[0] = nextColumn;
        party.position[1] = nextRow;

        restaurant->parties[restaurant->seatedParties++] = party;
        restaurant->partiesSize[sizeIndex] = -1;
    }
}

void getAPartySize(Restaurant *restaurant, char *partySize, char *partIndex, u_char limit)
{
    u_char i = 0;
    *partySize = -1;

    while (i < restaurant->totalParties)
    {
        char size = restaurant->partiesSize[i];
        // printf("size: %d\n", size);

        if (limit >= size && size > 0)
        {

            *partySize = size;
            *partIndex = i;
        }
        ++i;
    }
}

void updateFloorPlan(Restaurant *restaurant)
{
    u_char *seating = "CTC";

    for (u_char i = 0; i < restaurant->seatedParties; i++)
    {
        u_char column = restaurant->parties[i].position[0];
        u_char row = restaurant->parties[i].position[1];
        u_char size = restaurant->parties[i].size;

        // printf("\nParty %d:", i);
        // printf("\n\tcolumn: %d", column);
        // printf("\n\trow: %d", row);
        // printf("\n\tsize: %d\n", size);

        if (column < restaurant->floorPlanColumn)
        {
            u_char mapped = 0;
            while (mapped < size)
            {
                restaurant->floorPlan[column][row + mapped++] = seating;
            }
        }
    }
}

void printFloorPlan(Restaurant *restaurant)
{
    updateFloorPlan(restaurant);

    printGreyRow(restaurant);
    for (u_char row = 0; row < restaurant->length; row++)
    {
        printf(".");
        for (u_char column = 0; column < restaurant->floorPlanColumn; ++column)
        {
            printf("%s", restaurant->floorPlan[column][row]);
        }

        printf(".\n");
    }
    printGreyRow(restaurant);

    printf("\n");

    for (size_t i = 0; i < restaurant->totalParties; i++)
    {
        char size = restaurant->partiesSize[i];
        if (size != -1)
        {
            printUnaivailableMessage(size);
        }
    }
}

/*
@params

*/
void printGreyRow(Restaurant *restaurant)
{
    for (u_char i = 0; i < restaurant->width + 2; i++)
    {
        printf(".");
    }
    printf("\n");
}

void printUnaivailableMessage(char size)
{
    printf("*** Table for %d was not available ***\n", size);
}