section .text

global to_upper

; void to_upper(char *str)
to_upper:
    push rbp
    mov rbp, rsp

    ; save the used registers and align the stack, if needed
    sub rsp, 8
    push rcx
    push rax

    ; convert the string to uppercase
    xor rcx, rcx
convert_str:
    mov al, byte [rdi + rcx]
    cmp al, 'a'
    jb convert_cond

    sub al, 0x20
    mov byte [rdi + rcx], al

convert_cond:
    inc rcx
    cmp byte [rdi + rcx], 0
    jnz convert_str

    ; restore the used registers and the stack pointer, if altered
    pop rax
    pop rcx
    add rsp, 8

    leave
    ret
