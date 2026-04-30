section .data
  dst_buf times 64 db 0 ; char dst_buf[64] = {0}

section .text
extern printf
extern puts
global print_reverse_string

; void reverse_string(char *src, size_t len, char *dst)
reverse_string:
    push rbp
    mov rbp, rsp

    mov rax, rdi            ; get the address of the string
    mov rcx, rsi            ; get the length of the string
                            ; the address of the buffer to store the reversed string is already in rdx

    test rcx, rcx           ; check if length is zero
    jz done                 ; if zero, skip to null termination

    add rax, rcx            ; point to one past the last character
    dec rax                 ; point to the last character

copy_loop:
    mov bl, [rax]           ; get a byte from the source
    mov [rdx], bl           ; store it in the destination
    dec rax                 ; move to previous character in source
    inc rdx                 ; move to next character in destination
    dec rcx                 ; decrease counter
    jnz copy_loop           ; if counter not zero, continue loop

done:
    mov byte [rdx], 0       ; null-terminate the destination string

    leave
    ret

; print_reverse_string(char *str, size_t len)
print_reverse_string:
    push rbp
    mov rbp, rsp

    ; save the used registers and align the stack, if needed
    sub rsp, 8 ; aligning the stack to 16 as we have pushed rbp

    ; call the reverse_string() function and print the reversed string

    ; rdi and rsi are already "in position" - no need to alter them
    ; gotta add rdx for the buffer
    mov rdx, dst_buf
    call reverse_string

    mov rdi, dst_buf ; this is the only argument requred for puts()
    call puts

    ; restore the used registers and the stack pointer, if altered
    add rsp, 8

    leave
    ret
