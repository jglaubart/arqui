section .bss
    Buff resb 1          ; reservar 1 byte para leer un carácter

section .text
    global _start

_start:
Read:
    mov eax, 3           ; syscall número 3 = sys_read
    mov ebx, 0           ; archivo 0 = stdin
    mov ecx, Buff        ; dirección del buffer
    mov edx, 1           ; leer 1 byte
    int 0x80             ; llamada al sistema

    cmp eax, 0           ; ¿EOF?
    je Exit              ; si sí, salir

    cmp byte [Buff], 61h ; ¿es menor a 'a'?
    jb Write
    cmp byte [Buff], 7Ah ; ¿es mayor a 'z'?
    ja Write

    sub byte [Buff], 20h ; convertir minúscula a mayúscula

Write:
    mov eax, 4           ; syscall número 4 = sys_write
    mov ebx, 1           ; archivo 1 = stdout
    mov ecx, Buff        ; dirección del buffer
    mov edx, 1           ; escribir 1 byte
    int 0x80             ; llamada al sistema

    jmp Read             ; volver a leer otro carácter

Exit:
    mov eax, 1           ; syscall número 1 = sys_exit
    mov ebx, 0           ; código de salida
    int 0x80
