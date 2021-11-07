;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Data Section
section		.data

SYS_WRITE					equ		1
FD_STDOUT					equ		1

VARIABLE_FOR_CRASHER		dq		0.0

VARIABLE_ONE				dq		1		; Integer
VARIABLE_TWO				dq		2		; Integer
VARIABLE_THREE				dq		3.1		; Float64
VARIABLE_FOUR				dq		4.5		; Float64

MSG_AFTER_CALL_VALUE		db		"Printing variable's one and two after calling by value:",13,10
MSG_AFTER_CALL_VALUE_LEN	equ		$-MSG_AFTER_CALL_VALUE
;
MSG_AFTER_CALL_POINTERS		db		"Printing variable's one and two after calling using pointers:",13,10
MSG_AFTER_CALL_POINTERS_LEN	equ		$-MSG_AFTER_CALL_POINTERS

CRLF						db		13,10
CRLF_LEN					equ		$-CRLF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Text Section
section		.text


; Externals
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_printFloat64
extern my_c_function_by_value
extern my_c_function_with_pointers
extern my_c_function_with_floats


; main()
global main
main:
	
	; Try to crash the program
	; Disabled for now
	;call forceCrashViaStackAlignmentIssues
	
	; Call my_c_function_by_value with some values
	mov rdi, [VARIABLE_ONE]
	mov rsi, [VARIABLE_TWO]
	call my_c_function_by_value
	call crlf
	; Announce we're going to print the variables again
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, MSG_AFTER_CALL_VALUE
	mov rdx, MSG_AFTER_CALL_VALUE_LEN
	syscall
	; Actually print the variables again
	mov rdi, [VARIABLE_ONE]
	call libPuhfessorP_printSignedInteger64
	call crlf
	mov rdi, [VARIABLE_TWO]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	call crlf
	
	; NOW, let's call a C function that takes pointers to integers
	; We can't "call by reference", because C functions can't take references
	mov rdi, VARIABLE_ONE
	mov rsi, VARIABLE_TWO
	call my_c_function_with_pointers
	; Let's first do a strange thing, where we surround some functions calls with a push/pop pair,
	;	so we can preserve the return value of my_c_function_with_pointers (rax)
	;	without having to use it yet.
	;	(because we're totally out of registers, and I don't feel like making a global for whatever reason)
	push rax		; Normally we might want to double check that our stack is aligned.
					; Since libPuhfessorP_printSignedInteger64 is a function call with unknown code inside
					; (unknown code could call C functions that require 16 byte stack alignment).
					; Luckily, libPuhfessorP_printSignedInteger64 doesn't call C functions, so we don't
					;	have to worry here.
	;
	call crlf
	; Announce we're going to print the variables again
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, MSG_AFTER_CALL_POINTERS
	mov rdx, MSG_AFTER_CALL_POINTERS_LEN
	syscall
	; Actually print the variables again
	mov rdi, [VARIABLE_ONE]
	call libPuhfessorP_printSignedInteger64
	call crlf
	mov rdi, [VARIABLE_TWO]
	call libPuhfessorP_printSignedInteger64
	call crlf
	;
	pop rax
	mov rdi, rax
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	call crlf
	
	;
	call cWithIntegersAndFloats
	call crlf
	
	;
	mov rax, 0
	ret
	

cWithIntegersAndFloats:
	
	; Now let's call a function with mixed datatype arguments!
	; my_c_function_with_floats(long int a, long int b, double c, double d)
	mov rdi, [VARIABLE_ONE]			; 1st integer argument
	mov rsi, [VARIABLE_TWO]			; 2nd integer argument
	movsd xmm0, [VARIABLE_THREE]	; 1st 64-bit float argument
	movsd xmm1, [VARIABLE_FOUR]		; 2nd 64-bit float arguments
	call my_c_function_with_floats
	
	call crlf
	
	ret


; Some libP functions rely on C library functions
; C library functions often assume your stack is aligned to 16 Bytes (evenly divisible by 16 Bytes),
;	for performance and optimization stuffs.
; When you push a single 64-bit register, you're pushing 8 bytes
; So if you experience mysterious crashes while interacting with libP or C library functions,
;	you may want to add an extra push/pop pair, to see if alignment issues are causing your crash.
; Try commenting out one of the push/pop pairs and see if you can get the program to crash!
; (also uncomment the call to this function above)
forceCrashViaStackAlignmentIssues:
	
	push r14
	push r14
	
	; First argument to libPuhfessorP_printFloat64 should be the float you wish to print
	movsd xmm0, [VARIABLE_FOR_CRASHER]
	call libPuhfessorP_printFloat64
	
	pop r14
	pop r14
	
	ret


; Shortcut for a new line
crlf:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, CRLF
	mov rdx, CRLF_LEN
	syscall
	
	ret





