global _start
extern main

section .text

_start:
    mov eax, 0x4    ;Hacemos un print para chequear que estamos en este codigo.
    mov ecx, msg
    mov edx, len
    mov ebx, 1
    int 80h

    push dword [esp+4]   ;Pusheamos el arreglo de argumentos
    push dword [esp]    ;Pusheemos la cantidad de argumentos

    call main

    mov ebx, eax    ;Le paso lo que retorna main al exit
    mov eax, 1      ;Syscall de exit
    int 80h

section .data
    msg db "Starting main from asm", 10, 0
    len equ $-msg