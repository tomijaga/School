#include "mystr.h"

int myStrCmp(char *str1, char *str2){
    int len1 = strlen(str1);
    int len2 = strlen(str2);
    int length  = len1 < len2? len1: len2;
    return cmpEachChar(str1, str2, 0, length);
}

int cmpEachChar(char *str1, char *str2, int i, int terminate){
    if(i<terminate){
        if(str1[i]!=str2[i]){
        return str1[i]<str2[i]? -1: 1;

    }
        return cmpEachChar(str1, str2, ++i, terminate);
    } else {
        return 0;
    }  
}