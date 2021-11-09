

; The point of this demo is to demonstrate Command Line Argument parsing!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin data section
section		.data


SYS_WRITE						equ     1

FD_STDOUT						equ     1


;
WELCOME_MSG						db		"Hello and welcome to command line argument parsing, brought to you by Pelican Steve!",0
ARG_COUNT_MSG_1					db		"This program has received ",0
ARG_COUNT_MSG_2					db		" arguments from the command line:",0
ARG_PREFIX_MSG_1				db		"ARG #",0
ARG_PREFIX_MSG_2				db		" : ",0

;
CRLF							db		13,10
CRLF_LEN						equ		$-CRLF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin text section
section		.text


; Externals
extern libPuhfessorP_printSignedInteger64


; int main(int argc, char * argv[])
; r12: Count of incoming arguments
; r13: Base pointer of incoming argument string array
; r14: Index of current incoming argument string
global main
main:
	
	; Prologue
	push r12
	push r13
	push r14
	
	; Grab incoming arguments
	mov r12, rdi		; int argc
	mov r13, rsi		; char * argv[]
	
	; Say hello
	mov rdi, WELCOME_MSG
	call printNullTerminatedString
	
	call crlf
	call crlf
	
	; Print the number of arguments
	mov rdi, ARG_COUNT_MSG_1
	call printNullTerminatedString
	
	; This is the important part ==> r12 was main's rdi aka argc
	mov rdi, r12
	call libPuhfessorP_printSignedInteger64
	
	; Print the number of arguments
	mov rdi, ARG_COUNT_MSG_2
	call printNullTerminatedString
	
	call crlf
	call crlf
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; BEGIN                                                          ;;;
	;;; Loop through each incoming command line argument, and print it ;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
main_printArguments_init:
	
	; Start our index at the 0 argument (program name)
	mov r14, 0
	
main_printArguments_loopTop:
	
	; Exit if we're beyond the last argument
	cmp r14, r12
	jge main_printArguments_done
	
	; Print current argument
	mov rdi, ARG_PREFIX_MSG_1
	call printNullTerminatedString
	;
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	;
	mov rdi, ARG_PREFIX_MSG_2
	call printNullTerminatedString
	;
	; Remember that r13 is a "pointer to the first pointer" (from char * argv[])
	mov rdi, [r13 + (r14 * 8)]	; Use MOV not LEA here because we're trying to get a pointer by dereferencing the original pointer lel
	call printNullTerminatedString
	call crlf
	
	; Increment index and continue looping
	inc r14
	jmp main_printArguments_loopTop
	
main_printArguments_done:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; END                                                            ;;;
	;;; Loop through each incoming command line argument, and print it ;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;
	call crlf
	call crlf
	
main_done:
	
	; Epilogue
	pop r14
	pop r13
	pop r12
	
	; Return
	mov rax, 0
	ret



;	printNullTerminatedString(char * theString)
;	r12: Running pointer
printNullTerminatedString:
	
	; Prologue
	push r12
	
	; Grab pointer
	mov r12, rdi
	
printNullTerminatedString_loopTop:
	
	; Grab next byte and possibly exit if we found our null terminator
	mov r10b, byte [r12]
	cmp r10b, 0
	je printNullTerminatedString_done
	
	; Print this next character
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, r12
	mov rdx, 1
	syscall
	
	; Increment and continue looping
	inc r12
	jmp printNullTerminatedString_loopTop
	
	
printNullTerminatedString_done:
	
	; Epilogue
	pop r12
	
	ret



;	Print CRLF
crlf:
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, CRLF
	mov rdx, CRLF_LEN
	syscall
	
	ret



