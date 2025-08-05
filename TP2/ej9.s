extern print_string
extern exit
extern int_to_string

section .data
    msg db "Se pasaron ", 0
    msg_2 db " parametros a este programa", 10, 0


section .bss
    output resb 256       ; Espacio para la cadena convertida

section .text
    global _start

_start:
    push ebp
    mov ebp, esp

    push msg
    call print_string
    add esp, 4          ;Limpiar parametro del stack

    mov eax, [esp+4] ;cargo argc en eax
    dec eax ; porque el nombre del programa cuenta como argumento sino
    
    push output
    push eax
    call int_to_string
    add esp, 8          ;Limpiar ambos parametros

    push output
    call print_string
    add esp, 4

    push msg_2
    call print_string
    add esp, 4

    call exit