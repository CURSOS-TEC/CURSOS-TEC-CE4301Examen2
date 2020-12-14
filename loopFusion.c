#include <stdio.h>
#include <stdlib.h>
int main(int argc, char const *argv[])
{

    /* Este ews un código que ejemplifica un uso de arreglos multidimensionales */
    int *array1 = (int *)malloc(2000*sizeof(int));
    int *array2 = (int *)malloc(sizeof(int));
    for (int i = 0; i < 2000; i++){
        array1[i] = array1[i] + 3;
    }
    for (int i = 0; i < 2000; i++){
        array1[i] = array1[i] + 4;
    }
    printf("Fusionloop");
    return 0;
}
