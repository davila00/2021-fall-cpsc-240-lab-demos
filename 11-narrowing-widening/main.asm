

;;
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Data Section
section		.data

SYS_WRITE					equ		1
FD_STDOUT					equ		1

CRLF						db		13,10
CRLF_LEN					equ		$-CRLF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	BSS Section
section		.bss

MY_BYTE						resb	1
MY_WORD						resw	1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Text Section
section		.text


; Externals
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_printFloat64


; int main()
; 
; Internal usage:
;	nada
global main
main:
	
	;;;;;;;;;;;;;;;;;
	;;; Narrowing ;;;
	;;;;;;;;;;;;;;;;;
	
	; Move 50 into rax. Access via al works because it fits into a single byte
	mov rax, 50
	mov byte [MY_BYTE], al
	nop
	
	; Move 200 into rax. Access via al shouldn't work because 200 is beyond the range an 8-bit signed integer
	mov rax, 200
	mov [MY_BYTE], al
	mov [MY_WORD], ax
	nop
	
	; Negative numbers will also work IF THEY FIT in the destination size
	mov rax, -10
	mov byte [MY_BYTE], al
	nop
	
	;;;;;;;;;;;;;;;;
	;;; Widening ;;;
	;;;;;;;;;;;;;;;;
	
	; Start by setting MY_BYTE to -11
	mov [MY_BYTE], byte -11
	
	; Move MY_BYTE (8-bits) into r10 (64-bits)
	; This will NOT WORK, because we're not using a proper widening instruction
	; (this will move junk data into r10)
	mov r10, [MY_BYTE]
	nop
	
	; Move MY_BYTE (8-bits) into r10 (64-bits)
	; This will work because we're using the proper widening instruction
	movsx r10, byte [MY_BYTE]
	nop
	
	;
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	
	
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
	
	


