; SPDX-License-Identifier: BSD-3-Clause


; Fill buffer with data and print it. Buffer is 64 bytes long and
; is stored on the stack.

extern printf
extern puts

section .data
    buffer_intro_message: db "buffer is:", 0
    byte_format: db " %02X", 0
    null_string: db 0
    var_message_and_format: db "var is 0x%08X", 13, 10, 0

section .text

global main

main:
    push rbp
    mov rbp, rsp

    ; Make room for local variabile (64-bit, 8 bytes).
    ; Variable address is at rbp - 8.
    sub rsp, 8

    ; Make room for buffer (64 bytes).
    ; Buffer address is at rbp - 72.
    sub rsp, 64

    sub rsp, 8             ; align stack

    ; Initialize local variable.
    mov dword [rbp - 8], 0xCAFEBABE

    ; Fill data in buffer: buffer[i] = i + 1
    ; Use rbx as buffer base address, rcx as index and dl as value.
    ; dl needs to be rcx + 1.
    ; Buffer length is 64 bytes.
    lea rbx, [rbp - 72]
    xor rcx, rcx
fill_byte:
    mov dl, cl
    inc dl
    mov byte [rbx + rcx], dl
    inc rcx
    cmp rcx, 64
    jl fill_byte

    ; Since rcx is at index 64, basically one index out of the bounds of the
    ; array, it currently points to the value of our local variable:
    ; "DEADBEEF", therefore we can overwrite it
    mov dword [rbx + rcx], 0xDEADBEEF

    ; Text before printing buffer.
    mov rdi, buffer_intro_message
    xor eax, eax
    call printf

    xor rcx, rcx
print_byte:
    xor eax, eax
    lea rbx, [rbp - 72]
    mov al, byte[rbx + rcx]
    push rcx               ; save rcx
    sub rsp, 8             ; align stack

    movzx esi, al          ; 2nd arg: char (printable)
    mov edx, esi           ; 3rd arg: hex value
    mov rdi, byte_format   ; 1st arg: format string
    xor eax, eax
    call printf

    add rsp, 8             ; align stack
    pop rcx                ; restore rcx
    inc rcx

    ; TODO 1: Print the next 4 bytes
    ; TODO 2: After printing the local variable,
    ; print the next 8 bytes (What contain the next 8 bytes?)

    ; student's note: the values printed are the stack alignment (zeroed out by the OS) and the rip value
    cmp ecx, 76 ; 76 = 64 + 4 + 8
    jl print_byte

    ; Print new line. C equivalent instruction is puts("").
    mov rdi, null_string
    call puts

    ; Print local variable.
    mov esi, [rbp - 8]                ; value
    mov rdi, var_message_and_format   ; format
    xor eax, eax
    call printf

    leave
    ret
