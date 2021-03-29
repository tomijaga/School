

struct listItem
{
    char *name;
    unsigned char age;
    struct listItem *next;
} Person

    void
    cutOffByAge(Person **people, unsigned char cutoffAge)
{
    Person *list = (Person *)malloc(sizeof(Person));

    for (size_t i = 0; i < 10; i++)
    {

        list = people[i];

        while (list != NULL)
        {
            if (list->next != NULL)
            {
                if (list->next.age > cutoffAge)
                {
                    list->next = NULL;
                    freeList(list);
                }
            }
        }

        if (people[i].age > cutoffAge)
        {
            temp = people[i];
            peaple[i] == NULL;
        }
    }
}

void freeList(*list)
{
    Person *temp = (Person *)malloc(sizeof(Person));
    while (list != NULL)
    {
        temp = list->next;
        free(list);
        list = temp;
    }
    free(temp);
}

int main(int argc, char const *argv[])
{
    /* code */
    return 0;
}
