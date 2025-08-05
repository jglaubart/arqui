global main
extern printf
extern get_humedad

section .data
    arreglo dd 10, 20, 30, 40, 50
    len dd ($-arreglo)/4
    filename db "/sys/bus/iio/in_voltage0_raw", 0
    timespec dd 1,0   ;1 sec , 0 nanosec
    aparece db "Humedad: %d, aparece en el arreglo", 10, 0
    no_aparece db "Humedad: %d, NO aparece en el arreglo", 10, 0

section .text
main:
    push ebp
    mov ebp, esp
.humedad:
    mov eax, 16
    push filename
    push eax
    call get_humedad
    add esp, 2*4
    ; humedad devuelta en eax
.ajuste:
    mov ecx, 7
    xor edx, edx
    div ecx
    ;humedad ajustada en eax
.recorrer_vec:
    mov ebx, arreglo
    mov esi, len 
    xor edi, edi
.loop_vec:
    cmp edi, esi
    je .no_aparece   ;llego hasta el final y no lo encontro
    cmp eax, dword [ebx + edi*4]
    je .aparece
    inc edi 
    jmp .loop_vec
.no_aparece:
    push eax
    push no_aparece
    call printf
    add esp, 2*4
    jmp .wait
.aparece:
    push eax
    push aparece
    call printf
    add esp, 2*4
.wait:
    mov eax, 162
    mov ebx, timespec
    mov ecx, 0
    int 80h
    jmp .humedad
    
