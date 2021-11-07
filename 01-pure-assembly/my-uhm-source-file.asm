
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CPSC 240, Professor P
;
; This folder is a demonstration of writing a program
;	in pure assembly language.
; It contains both a *.asm source file,
;	and a Makefile (so we can use GNU Make to build)
;
; You can use any editor of your choosing to view this file,
; 	but the indentation may only look correct if you set
;	your editor to use a tab size of 4, like me.
; Geany and other GUI editors make it easy to change this setting.
; If you want to edit your files in the console with the "nano" program,
;	here is some information on changing the tab size there as well:
; https://electrictoolbox.com/setting-tab-size-in-nano/


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


;
global _start
_start:
	
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

goodbye:
	
	; Use a system call
	; to exit gracefully
	mov rax, SYS_EXIT	; Load syscall code for 'return' into rax
	mov rdi, EXIT_SUCCESS	; Load our program's return code (0=Success) into rdi
	syscall




