#include "stdio.h"
#include "string.h"

struct tree
{
    char *type;
    int age;
    float height;
};

void getValues(struct tree *t)
{
    printf("not needed");
}

int main()
{

    struct tree aTree;
    struct tree *pTree;
    struct tree *aForest;
    struct tree **aFewTrees;

    getValues(&aTree);
    pTree = NULL;
    pTree = (struct tree *)malloc(sizeof(struct tree *));
    if (pTree != NULL)
        getValues(pTree);

    aForest = NULL;
    aForest = (struct tree *)malloc(sizeof(struct tree) * 1000);
    if (aForest != NULL)
        getValues(aForest);

    aFewTrees = NULL;
    aFewTrees = (struct tree **)malloc(sizeof(struct tree *) * 10);
    if (aFewTrees != NULL)
        getValues(*aFewTrees);

    free(pTree);
    free(aForest);
    free(aFewTrees);
}