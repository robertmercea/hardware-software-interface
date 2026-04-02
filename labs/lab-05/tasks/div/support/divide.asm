; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

; https://en.wikibooks.org/wiki/X86_Assembly/Arithmetic

section .data
    dividend1 db 91
    divisor1 db 27

    dividend2 dd 67254
    divisor2 dw 1349

    dividend3 dq 69094148
    divisor3 dq 12345678

    dividend4 dq 0x00000000FFFFFFFF, 0x0000000000000000
    divisor4 dq 0x0000000000010000

section .text
extern printf
global main
main:
    push rbp
    mov rbp, rsp

    xor rax, rax

    mov al, byte [dividend1]
    mov bl, byte [divisor1]
    div bl

    xor rbx, rbx
    mov bl, al
    PRINTF64 `Quotient: %hhu\n\x0`, rbx

    xor rbx, rbx
    mov bl, ah
    PRINTF64 `Remainder: %hhu\n\x0`, rbx

		; Quotient and remained for dividend2 / divisor2
		xor rdx, rdx
		xor rbx, rbx
		mov bx, word [divisor2]
		mov eax, [dividend2]
		mov dx, ax
		shr eax, 16
		xchg dx, ax
		mov eax, [dividend2]
		div bx

		mov bx, ax
		PRINTF64 `Quotient: %hu\n\x0`, rbx

		mov bx, dx
		PRINTF64 `Remained: %hu\n\x0`, rbx


    ; TODO: Calculate quotient and remainder for dividend3 / divisor3.

		; xor rbx, rbx
		; mov rax, qword [dividend3]
		; mov ebx, dword [divisor3]
		; div ebx
		; PRINTF64 `Quotient: %hhu\n\x0`, rax
		; PRINTF64 `Remained: %hhu\n\x0`, rdx


    ; TODO: Calculate quotient and remainder for dividend4 / divisor4.

    leave
    ret
