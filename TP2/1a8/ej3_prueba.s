EXTERN int_to_string
EXTERN print_string
EXTERN exit

section .data
    input dd 12345; Cadena de entrada terminada en 0
    msg db "Resultado: ", 0    ; Mensaje para mostrar el resultado

section .bss
    output resb 256

section .text
    global _start

_start:
    ; Llamar a la función para convertir a mayúsculas
    mov eax, [input]    ; Dirección de la cadena de entrada
    mov edi, output   ; Dirección de la cadena de salida
    call int_to_string

    ; Mostrar el mensaje "Resultado: "
    mov esi, msg
    call print_string

    ; Mostrar la cadena convertida
    mov esi, output
    call print_string

    ; Salir del programa
    call exit