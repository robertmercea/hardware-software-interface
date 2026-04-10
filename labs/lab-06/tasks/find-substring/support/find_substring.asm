; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

section .data
source_text: db "baaanaaanaaaa", 0 ; DO NOT MODIFY THIS LINE EXCEPT FOR THE STRING IN QUOTES
substring: db "aa", 0 ; DO NOT MODIFY THIS LINE EXCEPT FOR THE STRING IN QUOTES

print_format: db "Substring found at index: %d", 10, 0

section .text
extern printf
global main
main:
	push rbp
	mov rbp, rsp

	mov rax, 0 ; ptr in source_text
	mov rbx, 0 ; ptr in substring
	jmp search

; while (source_text[i] != 0) {
; 	if (substring[j] == 0) {
; 		printf("%d", i);
; 		j = 0;
; 	}
;
; 	if (source_text[i] == substring[j]) {
; 		j++;
; 	} else {
; 		j = 0;
;			i--;
; 	}
;
; 	i++;
; }
found:
	; display the current index
	; rcx = rax - rbx = source[i] - len(substr)
	mov rcx, rax
	sub rcx, rbx
	PRINTF64 `Substring found at index: %d\n\x0`, rcx
	sub rax, rbx

reset:
	; substring_index = 0
	; source_text_index++
	xor rbx, rbx
	inc rax
	jmp search_cond

search:
	mov cl, byte [source_text + rax]
	cmp cl, byte [substring + rbx]
	jnz reset

	inc rax
	inc rbx

search_cond:
	cmp byte [substring + rbx], 0
	je found

	cmp byte [source_text + rax], 0
	jne search

end:
    leave
    ret
