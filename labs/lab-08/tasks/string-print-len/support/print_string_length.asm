section .data
    print_format db "String length is %d", 10, 0

section .text

extern printf
global print_string_length

print_string_length:
    push rbp
    mov rbp, rsp

    ; save the used registers and align the stack, if needed
    sub rsp, 8
    push rbx

    ; print the string length
    ; printf(rdi, rsi) = printf(format, value)
    mov rbx, rdi ; the length of the string (passed as param)
    mov rdi, print_format ; format
    mov rsi, rbx ; string length (value)
    call printf

    ; restore the used registers and the stack pointer, if altered
    pop rbx
    add rsp, 8

    leave
    ret
