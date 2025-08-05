global _start
global sys_exit
global sys_read
global sys_write
global sys_openf
global sys_closef
EXTERN main
section .text

; _start:
;     push ebp
;     mov ebp, esp

;     push dword [esp+4]   ;Pusheamos el arreglo de argumentos
;     push dword [esp]    ;Pusheemos la cantidad de argumentos
    
;     call main

;     mov ebx, eax    ;Le paso lo que retorna main al exit
;     mov eax, 1      ;Syscall de exit
;     int 80h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; void sys_exit(int code)
sys_exit:
    mov eax, 1
    mov ebx, [esp+4]   ;primer argumento, se le pasa el codigo de salida
    int 80h
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; int sys_read(int fd, void *buffer, int size)
sys_read:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx

    mov eax, 3
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]    ;buffer
    mov edx, [ebp+16]    ;size
    int 80h

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ;En eax ya queda guardado el descriptor de archivo.
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; void sys_write(int fd, void *buffer, int size)
sys_write:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx

    mov eax, 4          ;Número de llamada al sistema para 'write'
    mov ebx, [ebp+8]    ;Descriptor de archivo
    mov ecx, [ebp+12]   ;Puntero al buffer
    mov edx, [ebp+16]   ;Tamaño de escritura
    int 80h            

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; int sys_openf(char *filename)
sys_openf:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push edx

    mov eax, 5          ;Número de llamada al sistema para 'open'
    mov ebx, [ebp + 8]  ;Puntero al nombre del archivo
    mov ecx, 2          ;Modo de apertura (read and write)
    int 80h             

    pop edx
    pop ecx
    pop ebx

    mov esp, ebp
    pop ebp
    ;En eax ya queda guardado el descriptor de archivo.
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; int sys_closef(int fd)
sys_closef:
    push ebp
    mov ebp, esp
    push ebx
    
    mov eax, 6
    mov ebx, [ebp + 8]
    int 80h
    
    pop ebx
    mov esp, ebp
    pop ebp 
    ret
