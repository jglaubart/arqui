EXTERN print_string
EXTERN to_uppercase
EXTERN exit

section .data
    input db "h4ppy c0d1ng", 10, 0 ; Cadena de entrada terminada en 0
    msg db "Resultado: ", 0    ; Mensaje para mostrar el resultado
section .bss
    output resb 256            ; Espacio para la cadena convertida a mayúsculas (256 bytes)

section .text
    global _start

_start:
    ; Llamar a la función para convertir a mayúsculas
    mov esi, input    ; Dirección de la cadena de entrada
    mov edi, output   ; Dirección de la cadena de salida
    call to_uppercase

    ; Mostrar el mensaje "Resultado: "
    mov esi, msg
    call print_string

    ; Mostrar la cadena convertida
    mov esi, output
    call print_string

    ; Salir del programa
    call exit
