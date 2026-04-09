; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

extern printf

section .bss
	; the structure for a student
	struc student_t
		name:   resb	10	; char[10] - student name
		id_course:	resq	1	; integer - the id of the course where a student is assigned
		check:	resd	1	; "bool" - check if the student is assigned to any course
	endstruc

    ; the structure for a course
	struc course_t
		id:	resq	1	; id = index in courses (the list of courses)
		name_course:   resb	15	; char[10] - the name of the course
	endstruc

section .data
    unassigned:		db "Student unassigned :(", 0
	v_students_count:    dq 5
    v_courses_count:    dq 3

    students:
		istruc student_t
			at name,	db "Vlad", 0
			at id_course,		dq 0
			at check,	dd 1
		iend

		istruc student_t
			at name,	db "Andrew", 0
			at id_course,		dq 1
			at check,	dd 1
		iend

		istruc student_t
			at name,	db "Kim", 0
			at id_course,		dq 1
			at check,	dd 1
		iend

		istruc student_t
			at name,	db "George", 0
			at id_course,		dq 2
			at check,	dd 1
		iend

		istruc student_t
			at name,	db "Kate", 0
			at id_course,		dq 0
			at check,	dd 0
		iend

    courses:
		istruc course_t
			at id,	dq 0
			at name_course,	db "Assembly", 0
		iend

		istruc course_t
			at id,	dq 1
			at name_course,	db "Linear Algebra", 0
		iend

		istruc course_t
			at id,   dq 2
			at name_course,	db "Physics", 0
		iend

section .text
global main

main:
	push rbp
	mov rbp, rsp
	PRINTF64 `The students list is:\n\x0`
	; Print the list of students and the courses where they are assigned

	mov rax, qword [v_students_count] ; student iterator
	mov r10, students
	mov r11, courses

start_search:
	mov rcx, qword [v_courses_count]  ; init course iterator

	; getting the course id - verbose version
	; mov rbx, qword [r10 + student_t_size * rax - student_t_size + id_course] ; get current course id
	mov r9, rax
	dec r9
	mul r9, student_t_size
	mov rbx, qword [r10 + r9 + id_course]

find_course:
	cmp rax, 0
	je end

	; getting the current_course_id - verbose version
	; cmp qword [r11 + course_t_size * rcx - course_t_size + id], rbx ; check if current_course_id == target_course_id

	mov r9, rcx
	dec r9
	mul r9, course_t_size
	cmp qword [r11 + r9 + id], rbx

	je found
	loop find_course

	; course not found

	; getting name of course - verbose version
	; lea r8, r11 + course_t_size * rcx - course_t_size + name_course ; get name of course

	mov r9, rcx
	dec r9
	mul r9, course_t_size
	add r9, r11
	lea r8, r9 + name_course

	; aaaaaaaaaaaaaa

	lea r9, unassigned
	PRINTF64 `%s ---- %s\n\x0`, r9, r8 																	; display both
	dec rax
	loop find_course


found:
	lea r8, r11 + course_t_size * rcx - course_t_size + name_course ; get name of course
	lea r9, r10 + student_t_size * rax - student_t_size + name     ; get name of student
	PRINTF64 `%s ---- %s\n\x0`, r9, r8 																	; display both
	dec rax

	jmp start_search

end:
  leave
  ret
