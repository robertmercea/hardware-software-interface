; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; Print all three values (int_x, char_y, string_s) from sample_obj.
    ; Hint: use "lea reg, [base + offset]" to save the result of
    ; "base + offset" into register "reg".
		mov eax, [sample_obj + int_x]
		PRINTF64 `int_x: %d\n\x0`, rax

		xor rax, rax
		mov al, byte [sample_obj + char_y]
		PRINTF64 `char_y: %c\n\x0`, rax

		xor rax, rax
		lea rax, sample_obj + string_s
		PRINTF64 `string_s: %s\n\x0`, rax


    ; write the equivalent of "sample_obj->int_x = new_int".
		mov eax, dword [new_int]
		mov dword [sample_obj + int_x], eax

    ; write the equivalent of "sample_obj->char_y = new_char".
		mov al, byte [new_char]
		mov [sample_obj + char_y], al

    ; write the equivalent of "strcpy(sample_obj->string_s, new_string)".
		mov rcx, 14
copy:
		mov al, byte [new_string + rcx - 1]
		mov byte [sample_obj + string_s + rcx - 1], al
		loop copy

    ; print all three values again to validate the results of the
    ; three set operations above.
		mov eax, [sample_obj + int_x]
		PRINTF64 `int_x: %d\n\x0`, rax

		xor rax, rax
		mov al, byte [sample_obj + char_y]
		PRINTF64 `char_y: %c\n\x0`, rax

		xor rax, rax
		lea rax, sample_obj + string_s
		PRINTF64 `string_s: %s\n\x0`, rax

    xor rax, rax
    leave
    ret
