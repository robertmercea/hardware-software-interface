%include "printf64.asm"

section .text

extern printf
global main
main:
    push rbp
    mov rbp, rsp

    ; numbers are placed in these two registers
    mov rax, 1
    mov rbx, 4

		push rax
		push rbx

		cmp rax, rbx
		jb pop_once
		pop rax
	
pop_once:
		pop rax


    PRINTF64 `Max value is: %ld\n\x0`, rax ; print maximum value

    mov rsp, rbp
    pop rbp
    ret
