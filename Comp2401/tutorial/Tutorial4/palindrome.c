#include <stdio.h>
#include <string.h>

// This is a forward reference
int palindrome(char *s);

int main()
{

  char word[30];

  printf("Enter a word or \"q\" to stop: ");
  scanf("%s", word);

  while (strcmp(word, "q") != 0)
  {
    palindrome(word);
    printf("Enter a word or \"q\" to stop: ");
    scanf("%s", word);
  };

  return 0;
}

int palindrome(char *s)
{
  // add code to test for palindrome and print a message
  unsigned long i = 0;
  unsigned long n = strlen(s) - 1;

  while (i < n)
  {

    char start = *(s + i);
    char end = *(s + n);

    if (start != end)
    {
      return printf("\"%s\" is not a palindrome\n\n", s);
    }

    printf("\t start %c == %c end\n", start, end);

    ++i;
    --n;
  }

  return printf("\"%s\" is a palindrome\n\n", s);
}
