extern print_string
extern int_to_string
extern exit
section .data
    msg_padre db "Soy el padre", 10, 0
    msg_hijo  db "Soy el hijo", 10, 0
    error_msg db "Error en fork", 10, 0

section .bss
    buffer resb 256
section .text
    global _start

_start:
    ; Llamar a fork()
    mov eax, 2          ; syscall fork (número 2 en Linux)
    int 0x80            ; Interrupción del kernel

    cmp eax, 0
    jl .error            ; Si eax < 0, hubo un error en fork()
    je .hijo             ; Si eax == 0, estamos en el hijo

    ; Código del padre
    push msg_padre
    call print_string
    jmp .salir

.hijo:
    ; Código del hijo
    push msg_hijo
    call print_string
    jmp .salir

.error:
    ; Imprimir mensaje de error
    push error_msg
    call print_string
    add esp, 4

.salir:
    call exit
