;main.asm
GLOBAL main
EXTERN printf

section .rodata
fmt db "Cantidad de argumentos: %d", 10, 0
section .text
main:
push ebp ;Armado de stack frame
mov ebp, esp ;
mov eax, dword [ebp+8]
dec eax
push eax
push fmt
call printf
add esp, 2*4
mov eax, 0
mov esp, ebp ;Desarmado de stack frame
pop ebp ;
ret