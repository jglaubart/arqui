global puts

section .data
    intro db 10
section .text

puts:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 8]    ;string
    xor edx, edx

.find_length:
    cmp byte [ecx + edx], 0 
    je .write
    inc edx
    jmp .find_length

.write:
    mov eax, 4
    mov ebx, 1
    int 80h

    mov ecx, intro
    mov edx, 1
    mov eax, 4
    mov ebx, 1
    int 80h

    leave
    ret