%include "printf64.asm"

%define NUM 5

section .text

extern printf
global main
main:
    mov rbp, rsp

    ; replaced every "push" instruction by an equivalent sequence of commands
		; (using direct addressing of memory)
    mov rcx, NUM
push_nums:
		sub rsp, 8
    mov [rsp], rcx
    loop push_nums

		sub rsp, 8
		mov [rsp], 0

		sub rsp, 8
    mov rax, "handsome"
		mov [rsp], rax

		sub rsp, 8
    mov rax, "is very "
		mov [rsp], rax

		sub rsp, 8
    mov rax, "Anthony "
		mov [rsp], rax

    lea rsi, [rsp]
    PRINTF64 `%s\n\x0`, rsi

    ; printing the stack in "address: value" format in the range of [RSP:RBP]
		mov rcx, rbp ; this feels wrong :D
print_addr:
		mov rax, [rcx]
		PRINTF64 `0x%x: 0x%x\n\x0`, rcx, rax

		sub rcx, 8
		cmp rcx, rsp
		jae print_addr

    ; print the string
		mov rcx, rsp
		xor rax, rax
print_str:
		mov al, byte [rcx]
		PRINTF64 `%c\x0`, rax

		add rcx, 1
		cmp al, 0
		ja print_str

		PRINTF64 `\n\x0`
		
    ; print the array on the stack, element by element.
		mov rdx, rbp
		sub rdx, 40 ; 4 ints
		mov rcx, NUM
print_arr:
		mov rax, [rdx]
		PRINTF64 `%d \x0`, rax
		
		add rdx, 8
		loop print_arr


    ; restore the previous value of the rbp (Base Pointer)
    mov rsp, rbp

    ; exit without errors
    xor rax, rax
    ret
