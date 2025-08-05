#include <stdio.h>
#include <string.h>

extern int imprime_pantalla(char *encabezado, int tam_enc, char *pie, int tam_pie);
extern char buffer_prueba[480];

int main() {
    char encabezado[] = "Este es el título";
    char pie[] = "Fin de mensaje";

    int r = imprime_pantalla(encabezado, strlen(encabezado), pie, strlen(pie));
    printf("Resultado: %d\n", r);

    printf("Fila 6 (última fila):\n");
    for (int i = 0; i < 480; i++) {
        if (buffer_prueba[i] != 0){
            if(i==400) puts("");
            putchar(buffer_prueba[i]);
        }
        else if(i%80 == 0 && i!=0){
            puts("");
        } else{
            putchar('.');
        }
    }
    putchar('\n');

    return 0;
}
