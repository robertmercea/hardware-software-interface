; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

section .data
    myString: db "Hello, World!", 0
		byeString: db "Goodbye, World!", 0
    N: dq 6                         ; N = 6

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rcx, QWORD [N]              ; rcx will store the value of N
    PRINTF64 `%d\n\x0`, rcx         ; DO NOT REMOVE/MODIFY THIS LINE

    mov rax, 2
    mov r8, 1
    cmp rax, r8
		mov rcx, [N]
    jg print                        ; TODO1: rax > r8?
    xor rax, rax

    leave
    ret

print:
    PRINTF64 `%s\n\x0`, myString

		dec rcx
		cmp rcx, 0
		jg print
                                    ; TODO2.2: print "Hello, World!" N times
                                    ; TODO2.1: print "Goodbye, World!"
    xor rax, rax

    PRINTF64 `%s\n\x0`, byeString
    leave
    ret
