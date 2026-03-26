; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

section .data
    N: dq 7          ; N-th fibonacci number to calculate

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rcx, QWORD [N]       ; we want to find the N-th fibonacci number; N = RCX = 7
    PRINTF64 `%d\n\x0`, rcx  ; DO NOT REMOVE/MODIFY THIS LINE

		mov rax, 0
		mov rbx, 1

fib:
		dec rcx
		cmp rcx, 0
		jz print
		add rax, rbx
		xchg rax, rbx
		jmp fib
		
print:
		PRINTF64 `%d\n\x0`, rbx
    xor rax, rax

    leave
    ret
