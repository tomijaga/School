
typedef struct
{
    int data;
} InfoType;

typedef struct Node
{
    InfoType *data;
    struct Node *next;
    struct Node *prev;
} DoubleNode;

int insertAtHead(DoubleNode **headA, DoubleNode **tailA, DoubleNode **headB, DoubleNode **tailB)
{

    DoubleNode *temp = (DoubleNode *)malloc(sizeof(DoubleNode));

    if (temp == NULL)
    {
        printf("Error allocating space");
        exit(0);
    }

    temp = *headA;

    head = *headB;

    tailB.next = temp;
}