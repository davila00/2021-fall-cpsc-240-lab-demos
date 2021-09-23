

;;
;; Reference: Book Section 12.11: Stack-Based Local Variables


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Data Section
section		.data

SYS_WRITE					equ		1
FD_STDOUT					equ		1

LOCAL_VARIABLE_COUNT		equ		500

CRLF						db		13,10
CRLF_LEN					equ		$-CRLF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	Text Section
section		.text


; Externals
extern libPuhfessorP_printSignedInteger64


;;;;;;;;;;
; int main()
;
; Internal register usage:
;	r10: Temp calculations stuff
;	r12: Pointer to the beginning of our array
;	r13: Current number to write
;	r14: Current index
;	r15: Running pointer
;	rbx: Stopping point for the running pointer (pointer to the last integer)
global main
main:
	
	; Prologue
	push rbp
	push rbx
	push r12
	push r13
	push r14
	push r15
	
	mov rbp, rsp		; Move the stack pointer into the base pointer
						; The base pointer will serve as a bookmark to where our stack started
	;
	mov r10, LOCAL_VARIABLE_COUNT		; Start with r10 = n_integers
	imul r10, 8							; Now r10 = (n_integers * 8), or the number of bytes we need for our integers
	sub rsp, r10						; Allocate our integers on the stack by basically just moving the stack pointer
										; (yes, this means we now have LOCAL_VARIABLE_COUNT integers of junk)
	mov r12, rsp						; Keep a pointeer to the first integer we've created
	
main_fillLoop_init:
	
	; Now let's fill the array with values starting with 5 and increasing by 2
	; This is where we initialize our loop
	mov r13, 5		; Start number at 5
	mov r14, 0		; Start our offset/index at 0

main_fillLoop_top:
	
	; Are we done looping?
	cmp r14, LOCAL_VARIABLE_COUNT
	jge main_fillLoop_done
	
	; Fill in the next number
	mov [r12 + (r14 * 8)], r13		; Compute address of integer (left), and give it the value of r13
									; my_integers[r14] = r13
	
	; Increment stuff
	inc r14				; Increase the index
	add r13, 2			; Increase the value we're writing
	
	; Jump back to the top of the loop
	jmp main_fillLoop_top
	
main_fillLoop_done:

main_printLoop:
	
	; INITIALIZE OUR PRINT LOOP
	; Now let's print our integers, one-by-one, to make sure we wrote them correctly
	; Instead of computing the address of each integer in our mov instruction,
	;	let's just use a running pointer that knows when to stop
	mov r15, r12										; Start the running pointer at the beginning of our array
	lea rbx, [r12 + (LOCAL_VARIABLE_COUNT * 8) - 1]		; Calculate the address of the LAST integer (inclusive because of the -1)
														; Note: We use "lea" to move a computed address into rbx rather than the value at that address

main_printLoop_top:
	
	; Are we done?
	cmp r15, rbx			; Compare our running pointer to the last integer's pointer
	jg main_printLoop_done	; We're finished when our running pointer is greater than the last integer's pointer
	
	; Ask libP to print for us!
	mov rdi, [r15]			; Use our running pointer to grab the value of the integer we're currently pointing at
	call libPuhfessorP_printSignedInteger64
	call crlf
	
	; Increment our running pointer, and continue looping
	add r15, 8
	jmp main_printLoop_top
	
main_printLoop_done:
	
main_done:
	
	; Epilogue
	mov rsp, rbp
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	
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

















