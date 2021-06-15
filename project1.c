#include <stdio.h>
#include <stdlib.h>
#include <time.h>  

int generate_random (int n);
int compare (int x, int y);

int main()
{
    char run = 'Y';
    
    while (run == 'Y')
    {
        srand (time(NULL));
        int random = generate_random(100); //Assuming that we don't have to ask for the input.
        
        while (1)
        {
            printf("Input a number: ");
            int n;
            scanf ("%d",&n);
    
            int result = compare(n,random);
            
            if (result == 1)
                printf("%i is bigger than the number.\n", n);
            else if (result == -1)
                printf("%i is smaller than the number.\n", n);
            else if (result == 0)
            {
                printf("You found the number! Play again? (Y/N)");
                scanf(" %c", &run);
                break;
            } 
        }
    }

    return 0;
}

int generate_random (int n)
{
    int x = n + 1;

    int random = rand() % x;
    return random; 
}

int compare (int x, int y)
{
    if (x < y)
        return -1;
    else if (x == y)
        return 0;
    else
        return 1;
}