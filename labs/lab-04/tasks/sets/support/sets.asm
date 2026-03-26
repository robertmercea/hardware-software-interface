; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"
; 139 - 128 = 11 - 8 = 3
; 169 - 128 = 41 - 32 = 9 - 8 = 1
section .data
    FIRST_SET: dq 139   ; The first set - contains  10001011 = 128 + 8 + 2 + 1
    SECOND_SET: dq 169  ; The second set - contains 10101001 = 128 + 32 + 8 + 1

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    ; The two sets can be found in the FIRST_SET and SECOND_SET variables
    mov rax, QWORD [FIRST_SET]
    mov rbx, QWORD [SECOND_SET]
    PRINTF64 `%u\n\x0`, rax ; print the first set
    PRINTF64 `%u\n\x0`, rbx ; print the second set

    ; TODO1: reunion of the two sets
		mov rcx, rax
		or rcx, rbx
    PRINTF64 `%u\n\x0`, rcx


    ; TODO2: adding an element to a set
		or rcx, 16
		or rcx, 32
    PRINTF64 `%u\n\x0`, rcx


    ; TODO3: intersection of the two sets
		and rcx, rbx
    PRINTF64 `%u\n\x0`, rcx

    ; TODO4: the complement of a set
		mov rdx, rcx ; rcx = set A
		not rdx      ; make complement
    PRINTF64 `%u\n\x0`, rdx ; print complement


    ; TODO5: removal of an element from a set
		mov rdx, 16
		not rdx
		and rcx, rdx
    PRINTF64 `%u\n\x0`, rcx

		; 10001011 = A
		; 10101001 = B
		; 00000010 = A \ B = A xor B and A ?
		; A xor B = 00100010
		; (A xor B) and A = 00000010
    ; TODO6: difference of two sets
		xor rcx, rbx
		and rcx, rax
    PRINTF64 `%u\n\x0`, rcx


    xor rax, rax

    leave
    ret
