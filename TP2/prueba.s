extern print_string
extern exit
extern int_to_string

section .data
    msg db "Cantidad de argumentos:  ", 0
    msg_argumento db "Argumento ", 0
    msg_puntos db ": ", 0
    intro db 10, 0


section .bss
    buffer resb 16       ; Espacio para la cadena convertida

section .text
    global _start

_start:
    push ebp
    mov ebp, esp

    mov ecx, 10
loop:
    cmp ecx, 0
    je end
    push ecx

    push buffer
    push ecx
    call int_to_string
    add esp, 8

    push buffer
    call print_string
    add esp, 4

    pop ecx
    dec ecx
    jmp loop

end:
    mov esp, ebp
    pop ebp
    call exit