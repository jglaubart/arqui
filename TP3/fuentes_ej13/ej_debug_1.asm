; ej_debug_1.asm
;===============================================================================

GLOBAL main
EXTERN printf

section .rodata
fmtA db "argc: %d",10,  0
fmtB db "argv[%d] = %s", 10, 0

section .text
main:
    push    ebp
    mov     ebp, esp
; armado de stack frame

    push    dword[ebp+8]        ; valor del %d
    push    fmtA
    call    printf
    add     esp, 2*4

    mov     ecx, dword[ebp+8] ; cantidad de argumentos
    mov     ebx, 0   ; argv[ebx]
    mov     esi, [ebp+12]    ; argv  estamos pasando el arreglo
    cld     ; autoincremento de ESI

.loop:
     cmp     ebx, ecx ; NUEVO ---> comparo el índice con la cantidad de argumentos
     jge      .fin
    ;lodsd   ; eax = [ESI] y  ESI = ESI + 4   ----> NUEVO, LO SACO
     mov eax, [esi + ebx*4] ; eax = argv[ebx]  ----> NUEVO

      push    ecx  ; backup
    ;  push    eax  ; *argv ---> ESTABA MAL EL ORDEN
     
     push    eax ;arg 3
     push    ebx ;arg2
     push    fmtB ; orden de los args es al reves, se manda el formato y a partir de ahi los argumentos (arg1)
     call    printf
     add     esp, 4*3 ; borramos los datos usados de la pila

     pop     ecx ; recuperamos el valor de ecx

     inc ebx
     jmp    .loop


.fin:
    mov     esp,ebp
    pop     ebp  ; desarmado de stack frame
    mov eax, 0 ; valor de retorno de main
    ret
