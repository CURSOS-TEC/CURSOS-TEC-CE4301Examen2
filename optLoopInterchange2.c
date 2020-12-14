#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
    int size = atoi(argv[1]);
    int **a = (int **)malloc(size * sizeof(int *));
    int **b = (int **)malloc(size * sizeof(int *));
    int **c = (int **)malloc(size * sizeof(int *));
    for (int i = 0; i < size; i++){
        a[i] = (int *)malloc(size * sizeof(int));
        b[i] = (int *)malloc(size * sizeof(int));
        c[i] = (int *)malloc(size * sizeof(int));
    }
    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            a[i][j] = 3;
            b[i][j] = 4;
            c[i][j] = 5;
        }
    }
    int i, j, k;
   
     for(i=0; i<size; i++) {
        for(k=0; k<size; k++) {
            for(j=0; j<size; j++) {
                c[i][j] = a[i][k] * b[k][j] + c[i][j];
            }
        }
    }
    return 0;
}