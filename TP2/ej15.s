section .text
    global _start
    extern exit
    extern int_to_string
    extern print_string

section .bss
    buffer resb 256
section .data
    period dd 1, 0
    intro db 10, 0
_start:       ; Suspender la ejecución por n segundos  ---> hice un contador porque pinto
    mov esi, 1
    mov edi, 3    
.loop:
    cmp esi, edi 
    jg .end

    mov eax, 162
    mov ebx, period
    int 0x80

    push buffer
    push esi
    call int_to_string
    push buffer
    call print_string

    push intro
    call print_string

    inc esi
    jmp .loop

.end:
    call exit       ; Llamar a la función exit

