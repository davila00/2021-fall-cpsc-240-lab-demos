


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Data Section
section		.data


SYS_WRITE					equ		1
FD_STDOUT					equ		1

ANNOUNCE_MOV_VALUE				db      "Printing [MY_INT] and r12 after moving by value:",13,10
ANNOUNCE_MOV_VALUE_LEN			equ     $-ANNOUNCE_MOV_VALUE

ANNOUNCE_GET_POINTER			db		"Printing r12 (which is a pointer to MY_INT), then printing dereferenced r12's pointer:",13,10
ANNOUNCE_GET_POINTER_LEN		equ		$-ANNOUNCE_GET_POINTER

ANNOUNCE_INC					db		"Increasing MY_INT with memory mode addressing (before then after):",13,10
ANNOUNCE_INC_LEN				equ		$-ANNOUNCE_INC

ANNOUNCE_BAD_ADD				db		"Adding 333333 to MY_INT first using a bad data type (byte), then using proper data type (qword):",13,10
ANNOUNCE_BAD_ADD_LEN			equ		$-ANNOUNCE_BAD_ADD

ANNOUNCE_ADDRESS_COMPUTE_1		db		"Using advanced address computation to come up with a pointer to the second integer in MY_INTS.",13,10
ANNOUNCE_ADDRESS_COMPUTE_1_LEN	equ		$-ANNOUNCE_ADDRESS_COMPUTE_1
ANNOUNCE_ADDRESS_COMPUTE_2		db		"1. MY_INTS pointer (which is also MY_INTS[0])",13,10,"2. MY_INTS[1] pointer",13,10,"3. Original value in MY_INTS[1].",13,10,"4. New value set to MY_INTS[1] using pointer.",13,10
ANNOUNCE_ADDRESS_COMPUTE_2_LEN	equ		$-ANNOUNCE_ADDRESS_COMPUTE_2

CRLF						db		13,10
CRLF_LEN					equ		$-CRLF


;; Important vars for this demo
MY_INT							dq		1234567
ARRAY_LEN						equ		100

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin bss section
section		.bss


; Allocate an array of integers (quadwords)
MY_INTS		resq	ARRAY_LEN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Text Section
section		.text


; Externals
extern libPuhfessorP_printSignedInteger64


; int main()
; 
; Internal usage:
;	nada
global main
main:
	
	;
	call getValue
	call crlf
	
	;
	call getPointer
	call crlf
	
	;
	call doInc
	call crlf
	
	;
	call badAdd
	call crlf
	
	;
	call advancedAddressComputation
	call crlf
	
	call crlf
	call crlf
	
	
main_done:
	
	; Epilogue
	
	
	; Return 0 to the OS
	mov rax, 0
	
	ret




;	Example: Moving by value
getValue:
	
	; Grab the value of the MY_INT integer into r12,
	; Then print both [MY_INT] and r12
	; Notice they're the same
	mov r12, [MY_INT]
	;
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, ANNOUNCE_MOV_VALUE
	mov rdx, ANNOUNCE_MOV_VALUE_LEN
	syscall
	;
	mov rdi, [MY_INT]
	call libPuhfessorP_printSignedInteger64
	call crlf
	;
	mov rdi, r12
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	ret


;	Example: Grabbing a pointer
getPointer:
	
	; Announce
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, ANNOUNCE_GET_POINTER
	mov rdx, ANNOUNCE_GET_POINTER_LEN
	syscall
	
	; Grab pointer to MY_INT
	mov r12, MY_INT
	
	; Print the pointer to MY_INT
	mov rdi, r12
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	; Now print a dereference of r12 (which is just going to be the MY_INT value)
	mov rdi, [r12]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	ret


; Increase the value of a number directly in memory
doInc:
	
	; Announce
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, ANNOUNCE_INC
	mov rdx, ANNOUNCE_INC_LEN
	syscall
	
	; Print original value
	mov rdi, [MY_INT]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	; Increase MY_INT directly in memory, and print
	inc qword [MY_INT]
	mov rdi, [MY_INT]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	ret

; Notice how the improper add only affects the first (lowest) byte (it wraps)
; Only the proper add works
badAdd:
	
	; Announce
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, ANNOUNCE_BAD_ADD
	mov rdx, ANNOUNCE_BAD_ADD_LEN
	syscall
	
	; Store original value
	mov r12, [MY_INT]
	
	; Add improperly (bad data type of byte)
	add byte [MY_INT], 333333
	; Print current value
	mov rdi, [MY_INT]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	; Restore value
	mov [MY_INT], r12
	
	; Add properly (good data type of qword)
	add qword [MY_INT], 333333
	
	; Print current value
	mov rdi, [MY_INT]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	ret


;
advancedAddressComputation:
	
	; Announce
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, ANNOUNCE_ADDRESS_COMPUTE_1
	mov rdx, ANNOUNCE_ADDRESS_COMPUTE_1_LEN
	syscall
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, ANNOUNCE_ADDRESS_COMPUTE_2
	mov rdx, ANNOUNCE_ADDRESS_COMPUTE_2_LEN
	syscall
	
	; Start by placing a dummy value into MY_INTS[1]
	mov qword [MY_INTS + 8], 5555
	
	; Grab MY_INTS (aka MY_INTS[0]) pointer and print
	mov r12, MY_INTS
	mov rdi, r12
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	; Grab MY_INTS[1] pointer and print
	lea r13, [MY_INTS + (1 * 8)]
	mov rdi, r13
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	; Print the value inside MY_INTS[1]
	; (before change)
	mov rdi, [MY_INTS + (1 * 8)]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	; Assign new value to MY_INTS[1] using r13 pointer
	mov qword [r13], 6666
	
	; Print value inside MY_INTS[1]
	; (after change)
	mov rdi, [MY_INTS + (1 * 8)]
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	ret


; Shortcut for a new line
crlf:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, CRLF
	mov rdx, CRLF_LEN
	syscall
	
	ret
	
	


