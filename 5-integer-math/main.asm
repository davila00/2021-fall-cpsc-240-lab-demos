
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CPSC 240, Professor P
;
; TODO: Notes


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the data section
section	.data


;;;;;
; System calls
SYS_WRITE			equ		1
SYS_EXIT			equ		60


;;;;;
; Exit Codes
EXIT_SUCCESS			equ		0
EXIT_FUN_TEST			equ		214


;;;;;
; File descriptors
FD_STDIN			equ		0
FD_STDOUT			equ		1
FD_STDERR			equ		2


;;;;;
; Strings
HELLO_MESSAGE		db		"Hello, my name is Carnegie Mondover !!"
HELLO_MESSAGE_LEN	equ		$-HELLO_MESSAGE

MSG_QUOTIENT		db		"The quotient is: "
MSG_QUOTIENT_LEN	equ		$-MSG_QUOTIENT

MSG_REMAINDER		db		"The remainder is: "
MSG_REMAINDER_LEN	equ		$-MSG_REMAINDER

CRLF				db		13,10
CRLF_LEN			equ		$-CRLF

; User input stuff
USER_RADIUS			dq		0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the text section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.text


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; My External symbols
extern libPuhfessorP_printSignedInteger64

;
global main
main:
	
	;;;;;;;;;;;;;;;;;;;;
	; Print out our hello message with a system call
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, HELLO_MESSAGE		; Provide the memory location to start reading our characters to print
	mov rdx, HELLO_MESSAGE_LEN	; Provide the number of characters print
	syscall

	call crlf


;
multiplyTest:
	
	;;;;;
	; Test out the new multiplication instruction
	mov r12, 2897				; r12 = 2897
	imul r12, 126				; r12 = r12 * 126
	
	; Print the result with libP
	; Answer should be 365022
	mov rdi, r12
	call libPuhfessorP_printSignedInteger64
	call crlf


divisionTest:
	
	; Let's try to divide 1765482 by 182
	; The quotient should end up being 9700
	; The remainder should end up being 82
	
	; Reference the book, page 100 to perform the division
	; (looking in the qAns2 area)
	; Also note the nice table on page 96
	
	mov rax, 1765482			; Start by loading the numerator (top part) into rax
	cqo							; Convert rax to rdx:rax (as needed for idiv)
	
	mov r10, 182				; Load 182 into temp register r10 because we cannot divide by an immediate (must be register or memory)
	idiv r10					; Divide rdx:rax by 182, which is now inside temp register r10
								; Quotient will be in rax
								; Remainder will be in rdx
	
	mov r12, rax				; Quickly save quotient and remainder in our chosen registers
	mov r13, rdx
	
	; Print the quotient
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, MSG_QUOTIENT
	mov rdx, MSG_QUOTIENT_LEN
	syscall
	;
	mov rdi, r12								; Ask libP to print the actual integer
	call libPuhfessorP_printSignedInteger64
	call crlf									; Line feed
	
	; Print the remainder
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, MSG_REMAINDER
	mov rdx, MSG_REMAINDER_LEN
	syscall
	;
	mov rdi, r13								; Ask libP to print the actual integer
	call libPuhfessorP_printSignedInteger64
	call crlf									; Line feed
	
	call crlf

;	Return to the caller
goodbye:
	
	; It is a convention for return values to show up in rax
	mov rax, EXIT_SUCCESS
	ret


crlf:
	
	;
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, CRLF				; Provide the memory location to start reading our characters to print
	mov rdx, CRLF_LEN			; Provide the number of characters print
	syscall
	
	ret






