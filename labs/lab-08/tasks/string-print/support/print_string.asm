section .text

extern puts
global print_string

print_string:
    push rbp
    mov rbp, rsp

    ; save the used registers and align the stack, if needed
    ; (no need to save anything)

    ; print the string
    ; (rdi is already in place, so no need to change anything)
    call puts

    ; restore the used registers and the stack pointer, if altered
    ; (again, nothing changed, nothing neede to change)

    leave
    ret
