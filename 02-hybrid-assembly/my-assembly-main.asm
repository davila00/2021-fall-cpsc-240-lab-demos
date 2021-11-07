
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
HELLO_MESSAGE		db		"Hello, my name is Gibsin Montgomery-Gibson !!",13,10
HELLO_MESSAGE_LEN	equ		$-HELLO_MESSAGE


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the text section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.text


;;;
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

;call_hybrid:
	
	call hybrid_cool

goodbye:
	
	mov rax, EXIT_SUCCESS
	ret



