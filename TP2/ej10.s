extern print_string
extern exit
extern int_to_string

section .data
    msg db "Cantidad de argumentos: ", 0
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

    push msg
    call print_string
    
    mov edi, [ebp+4] ;cargo argc en edi
    dec edi ; porque el nombre del programa cuenta como argumento sino
    
    push buffer
    push edi
    call int_to_string
    push buffer
    call print_string

    push intro
    call print_string

    ; Comienzo con los argumentos
    mov edi, [ebp+4] ;cargo argc en edi, salteo la dir de retorno
    dec edi ; porque el nombre del programa cuenta como argumento sino
    mov esi, 1 ;contador de argumentos

loop:
    cmp edi, esi
    jl end

    push msg_argumento
    call print_string

    push buffer
    push esi
    call int_to_string
    push buffer
    call print_string

    push msg_puntos
    call print_string 

    mov eax, [ebp+8+4*esi]
    push eax
    call print_string

    push intro
    call print_string

    inc esi
  
    jmp loop

end:
    mov esp, ebp
    pop ebp
    call exit



