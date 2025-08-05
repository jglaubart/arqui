#include <stdio.h>

extern int cuentaMayores(int *vec, int len, int umbral);

int main(void){
    int arr[] = {4, 5, 6, 7, 5, 9, -1, -4, 8};
    int *vec  = arr;
    int len = 9;
    int umbral = 5;
    int ans = cuentaMayores(arr, len, umbral);  //4
    printf("En el vector hay %d elementos mayores al umbral (%d)\n", ans, umbral);
    return 0;
}   