#include <stdio.h>

int checkLong(char * str, char len);

int main(){
    extern char msg[];
    extern char len;
    int ans = checkLong(msg, len);

    if(ans == 0){
        printf("Coinciden los resultados!\n");
    } else {
        printf("No coinciden los resultados. La diferencia es de %d.\n", ans);
    }

    ans = checkLong(msg, 8);
    if(ans == 0){
        printf("Coinciden los resultados!\n");
    } else {
        printf("No coinciden los resultados. La diferencia es de %d.\n", ans);
    }
}