#include <stdio.h>
#include <stddef.h>

void sys_exit(int code);
int sys_read(int fd, void *buffer, size_t size);
void sys_write(int fd, void *buffer, size_t size);
int sys_openf(char *filename);
int sys_closef(int fd);

int main(int argc, char *argv[]) {
    int fd = sys_openf("file.txt");
    char buffer[128];
    if (fd < 0) {
        sys_write(2, "Error opening file\n", 19);    // code 2 es error estandar
        sys_exit(1);
    }
    sys_write(fd, "Hello world desde file.txt\n", 27);   //Escribe la frase en el archivo
    
    sys_closef(fd);
    fd = sys_openf("file.txt");

    int bytes = sys_read(fd, buffer, sizeof(buffer));
    if(bytes>0){
        sys_write(1, buffer, bytes);     //code 1 es salida estandar
    }
    sys_closef(fd);
    sys_exit(0);
    return 0;
}