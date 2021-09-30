


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Data Section
section				.data

SYS_WRITE			equ		1
FD_STDOUT			equ		1

BUFFER_SIZE			equ		8192

SOME_NUMBER			dq		19872

PROMPT_MSG			db		"Please enter some text and hit enter: "
PROMPT_MSG_LEN		equ		$-PROMPT_MSG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; BSS Section
section				.bss


BUFFER				resb	BUFFER_SIZE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Text Section
section				.text


; Externals
extern libPuhfessorP_inputLine


; Main function
global main
main:
	
	push r12
	
	; Load r11 with the address of SOME_NUMBER, so we can debug-inspect it
	mov r11, SOME_NUMBER
	nop
	
	; Read a line of input with libP
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, PROMPT_MSG
	mov rdx, PROMPT_MSG_LEN
	syscall
	;
	mov rdi, BUFFER
	mov rsi, BUFFER_SIZE
	call libPuhfessorP_inputLine
	
	; Init loop to point to the beginning of our buffer
	mov r12, BUFFER
	nop
	
main_loopTop:
	
	; Have we hit a null-terminator?
	cmp [r12], byte 0
	je main_loopDone
	
	; Increase and keep looping
	inc r12
	jmp main_loopTop

main_loopDone:
	
	pop r12
	
	; Return
	mov rax, 0
	ret




