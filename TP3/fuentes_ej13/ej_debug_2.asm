; ej_debug_2.asm
;===============================================================================

GLOBAL main
EXTERN puts, sprintf
section .rodata
     fmt db "%d",0
     number dd 1234567890
     
section .bss
     buffer resb 40

section .text
main:
     push dword [number] ;;arg3, argumento para fmt
     push fmt     ;arg2, fmt
     push buffer  ;arg1, buffer
     
     call sprintf
     add esp, 12

     push buffer
     call puts
     add esp, 4

     xor eax, eax
     ret
