


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Data Section
section		.data


SYS_WRITE					equ		1
FD_STDOUT					equ		1

CRLF						db		13,10
CRLF_LEN					equ		$-CRLF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin bss section
section		.bss


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
	
	push r12
	push r12
	push r12
	push r12
	push r12
	push r12
	push r12
	push r12
	push r12
	push r12
	
	;
	call crlf
	call crlf
	
	pop r12
	pop r12
	pop r12
	pop r12
	pop r12
	pop r12
	pop r12
	pop r12
	pop r12
	pop r12
		
main_done:
	
	; Epilogue
	
	
	; Return 0 to the OS
	mov rax, 0
	
	ret




; Shortcut for a new line
crlf:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, CRLF
	mov rdx, CRLF_LEN
	syscall
	
	ret
	
	


