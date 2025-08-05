#include <stdio.h>

// code:
// EAX = 0: Información del fabricante del procesador.
// EAX = 1: Información sobre el procesador (familia, modelo, etc.).
// EAX = 4: Información sobre las cachés del procesador.
#define FABRICANTE 0
#define PROCESADOR 1
#define CAHCES 4

void get_cpuid(int code, unsigned int *buffer);


int main(int argc, char *argv[]) {
    
    unsigned int buffer[13];
    int code = FABRICANTE;

    get_cpuid(0, buffer);

    buffer[12] = '\n';

    printf("CPUID: %s\n", buffer);
    return 0;
}