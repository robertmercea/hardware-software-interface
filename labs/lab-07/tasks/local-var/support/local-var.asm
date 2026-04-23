%include "printf64.asm"

%define ARRAY_1_LEN 5
%define ARRAY_2_LEN 7
%define ARRAY_OUTPUT_LEN 12

section .data

array_1 dd 27, 46, 55, 83, 84
array_2 dd 1, 4, 21, 26, 59, 92, 105
array_output times 12 dd 0

; === THE STACK ===
; --- rbp
;
; (ARRAY_OUTPUT_LEN - 1) * unalloc_mem
; r11 (12th unalloc mem) - array_output
;
; (ARRAY_1_LEN - 1) elems
; r9 (ARRAY_1_LENth elem) - array_1
;
; (ARRAY_2_LEN - 1) elems
; r10 (ARRAY_2_LENth elem) - array_2 -- rsp

section .text

extern printf
global main
main:
    push rbp
    mov rbp, rsp

    mov rax, 0 ; counter used for array_1
    mov rbx, 0 ; counter used for array_2
    mov rcx, 0 ; counter used for the output array

		xor r9, r9   ; array_1 ptr
		xor r10, r10 ; array_2 ptr
		xor r11, r11 ; output  ptr

		; allocate space for output array
		sub rsp, 48 ; ARRAY_OUTPUT_LEN * sizeof(dword) == 12 * 4
		mov r11, rsp

		; move the first array onto the stack, in reverse order
		mov rcx, ARRAY_1_LEN
move_one_onto_stack:
		sub rsp, 4
		mov rax, [array_1 + rcx * 4 - 4]
		mov [rsp], rax
		loop move_one_onto_stack

		; save the addr
		mov r9, rsp
		
		; move the second array onto the stack, in reverse order
		mov rcx, ARRAY_2_LEN
move_two_onto_stack:
		sub rsp, 4
		mov rax, [array_2 + rcx * 4 - 4]
		mov [rsp], rax
		loop move_two_onto_stack
		
		; save the addr
		mov r10, rsp

		; iterator initialization (again)
    mov rax, 0 ; counter used for array_1
    mov rbx, 0 ; counter used for array_2
    mov rcx, 0 ; counter used for the output array
		
merge_arrays:
    mov edx, [r9 + 4 * rax]
    cmp edx, [r10 + 4 * rbx]
    jg array_2_lower
array_1_lower:
    mov [r11 + 4 * rcx], edx
    inc rax
    inc rcx
    jmp verify_array_end
array_2_lower:
    mov edx, [r10 + 4 * rbx]
    mov [r11 + 4 * rcx], edx
    inc rcx
    inc rbx

verify_array_end:
    cmp rax, ARRAY_1_LEN
    jge copy_array_2
    cmp rbx, ARRAY_2_LEN
    jge copy_array_1
    jmp merge_arrays

copy_array_1:
    mov edx, [r9 + 4 * rax]
    mov [r11 + 4 * rcx], edx
    inc rcx
    inc rax
    cmp rax, ARRAY_1_LEN
    jb copy_array_1
    jmp print_array
copy_array_2:
    mov edx, [r10 + 4 * rbx]
    mov [r11 + 4 * rcx], edx
    inc rcx
    inc rbx
    cmp rbx, ARRAY_2_LEN
    jb copy_array_2

print_array:
    PRINTF64 `Array merged:\n\x0`
    mov rcx, 0
print:
    mov eax, [r11 + 4 * rcx]
    PRINTF64 `%d \x0`, rax
    inc rcx
    cmp rcx, ARRAY_OUTPUT_LEN
    jb print

    PRINTF64 `\n\x0`
    xor rax, rax

    mov rsp, rbp
    pop rbp
    ret
