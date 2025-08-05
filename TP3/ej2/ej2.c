#include <stdio.h>
int main(int argc, char *argv[]) {
printf("Cantidad de argumentos %d\n", argc-1);
for(int i=1; i<argc; i++){
    printf("Argumento %d: %s\n", i, argv[i]);
}
return 0;
}