; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

section .bss
    array3: resw 10

section .data
    array1: db 27, 35, 46, 14, 17, 29, 37, 104, 135, 124
    array2: db 15, 38, 44, 20, 17, 33, 78, 143, 132, 16

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; Traversing array1 and array2 and putting the result in array3
		mov rcx, 10
sum:
		xor rax, rax
		mov al, [array1 + rcx - 1]
		mov bl, [array2 + rcx - 1]
		mul bl
		; product is now in ax
		mov [array3 + rcx * 2 - 2], ax
		loop sum

    PRINTF64 `The array that results from the product of the corresponding elements in array1 and array2 is:\n\x0`


    ; Traversing array3 and displaying its elements
		xor rcx, rcx
display:
		xor rax, rax
		mov ax, [array3 + rcx * 2]
		PRINTF64 `%d \x0`, rax
		inc rcx
		
display_cond:
		cmp rcx, 10
		jb display

    PRINTF64 `\n\x0`
    leave
    ret
