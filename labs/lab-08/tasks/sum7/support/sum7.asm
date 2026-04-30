section .text

global sum7

sum7:
    push rbp
    mov rbp, rsp

    ; save the used registers and align the stack, if needed
    push r10

    ; implement the sum7 function

    mov rax, rdi
    add rax, rsi
    add rax, rdx
    add rax, rcx
    add rax, r8
    add rax, r9
    add rax, [rbp + 16]

    ; restore the used registers and the stack pointer, if altered
    pop r10

    leave
    ret
