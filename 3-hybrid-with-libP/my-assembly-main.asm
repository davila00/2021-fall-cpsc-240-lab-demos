
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


;;;;;
; File descriptors
FD_STDIN			equ		0
FD_STDOUT			equ		1
FD_STDERR			equ		2


;;;;;
; Strings
HELLO_MESSAGE		db		"Hello, my name is Archibald Northbottom !!",13,10
HELLO_MESSAGE_LEN	equ		$-HELLO_MESSAGE


;;;;;
; Hold inputted integers
MY_INT			dq		0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the text section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.text


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; My External symbols
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_inputSignedInteger64
extern hybrid_cool


;
global main
main:
	
	nop
	nop
	nop
	
	; some other stuff
	nop
	nop
	nop

hello:
	
	;;;;;;;;;;;;;;;;;;;;
	; Print out our hello message with a system call
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, HELLO_MESSAGE		; Provide the memory location to start reading our characters to print
	mov rdx, HELLO_MESSAGE_LEN	; Provide the number of characters print
	syscall

call_hybrid:
	
	call hybrid_cool

;;;;;;;;;;
;	TODO: add some fun calls to libPuhfessorP here, so the class can see it working
;	Probably want to make a CRLF convenience function to format, and also show the power of assembly functions
new_stuff:

	; Practice printing an integer with libP
	; The parameter passing conventions are in the book section 12.8.1
	; Expected parameters for all libP functions are found FUNCTIONS.md, in the libP deploy repo
	mov rdi, 785323
	call libPuhfessorP_printSignedInteger64

	mov rdi, -12762
	call libPuhfessorP_printSignedInteger64
	
	; Practive receiving an integer
	call libPuhfessorP_inputSignedInteger64
	;inc rax			; Increase the value returned by 1
	mov [MY_INT], rax		; Kinda like saying MY_INT = rax
	mov rdi, [MY_INT]
	call libPuhfessorP_printSignedInteger64

;	Return to the caller
goodbye:
	
	; It is a convention for return values to show up in rax
	mov rax, EXIT_SUCCESS
	ret





