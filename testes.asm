section .data
    valores dd 10, 20, 30, 40, 50
    msg db "Media = ", 0

section .bss
    out resb 12

section .text
    global _start

_start:
    mov ecx, 5
    xor ebx, ebx
    xor esi, esi

soma_loop:
    mov eax, [valores + esi*4]
    add ebx, eax
    inc esi
    loop soma_loop

    mov eax, ebx
    mov ecx, 5
    xor edx, edx
    div ecx

    mov edi, out + 11
    mov byte [edi], 0xA
    dec edi

convert_loop:
    xor edx, edx
    mov ebx, 10
    div ebx
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz convert_loop

    inc edi

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 8
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, out + 12 - edi
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
