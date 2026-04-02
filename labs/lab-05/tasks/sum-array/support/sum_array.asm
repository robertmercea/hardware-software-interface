; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

%define ARRAY_SIZE    10

section .data
    byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1392, 12544, 7992, 6992, 7202, 27187, 28789, 17897, 12988, 17992
    qword_array dq 1392849893, 1254400000, 8799230000, 8799279000, 7202277000, 9718720000, 2878929200, 1789789200, 1298800000, 8799201000
    big_qword_array dq 9223372036854775800, 8223372036854775800, 7223372036854775800

section .text
extern printf
global main
main:
    push rbp
    mov rbp, rsp

    ; Byte array sum
    mov rcx, ARRAY_SIZE     ; Use rcx as loop counter
    xor rax, rax            ; Use rax to store the sum
    xor rdx, rdx            ; Store current value in dl; zero entire rdx

add_byte_array_element:
    mov dl, byte [byte_array + rcx - 1]
    add rax, rdx
    loop add_byte_array_element

    PRINTF64 `Byte array sum: %u\n\x0`, rax

    ; TODO Compute sum for elements in word_array
		xor rax, rax
		mov rcx, ARRAY_SIZE
sum_word:
		mov dx, [word_array + rcx * 2 - 2]
		add rax, rdx
		loop sum_word

		PRINTF64 `Word array sum: %u\n\x0`, rax

		xor rax, rax
		mov rcx, ARRAY_SIZE
sum_dword:
		mov edx, [dword_array + rcx * 4 - 4]
		add rax, rdx
		loop sum_dword

		PRINTF64 `Dword array sum: %u\n\x0`, rax

		xor rax, rax
		mov rcx, ARRAY_SIZE
sum_qword:
		mov rdx, [qword_array + rcx * 8 - 8]
		add rax, rdx
		loop sum_qword

		PRINTF64 `Qword array sum: %llu\n\x0`, rax

    ; TODO Compute sum for elements in big_qword_array
		xor rax, rax
		xor rbx, rbx

		mov rdx, [big_qword_array]
		add rax, rdx
		jnc next1
		inc rbx

next1:
		mov rdx, [big_qword_array + 8]
		add rax, rdx
		jnc next2
		inc rbx

next2:
		mov rdx, [big_qword_array + 16]
		add rax, rdx
		jnc finish
		inc rbx

finish:
    PRINTF64 `128-bit addition example: 0x%lx%016lx\n\x0`, rbx, rax

    leave
    ret
