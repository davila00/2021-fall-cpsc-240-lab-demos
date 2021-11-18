
;;;;;;;;;;;;;;;;;;
;;;;; Data Section
section .data


; Exit codes
EXIT_SUCCESS					equ		0


; Syscall codes
SYS_READ						equ     0
SYS_WRITE						equ     1
SYS_OPEN						equ		2
SYS_CLOSE						equ		3
SYS_CREATE						equ		85


; File status flags
FILE_READ_ONLY					equ		0
FILE_WRITE_ONLY					equ		1
FILE_READ_WRITE					equ		2


; File permissions
FILE_PERMISSIONS_DEFAULT		equ		00755q		; u = rwx, g = rx, o = rx
FILE_PERMISSIONS_SLIGHTLY_SECURE	equ		00750q		; u = rwx, g = rx, o = [nothing]
FILE_PERMISSIONS_VERY_SECURE	equ		00700q		; u = rwx, g = [nothing], o = [nothing]


; File descriptors
FD_STDOUT						equ     1


; File names
INFILE_NAME_GOOD				db		"infile.txt",0
INFILE_NAME_BAD					db		"does-not-exist.txt",0
OUTFILE_NAME					db		"out-file.txt",0


; Messages
MSG_ANNOUNCE_INFILE_1			db		"Now opening+reading infile ",34,0
MSG_ANNOUNCE_INFILE_2			db		34," and printing to console.",0

MSG_ANNOUNCE_OUTFILE_1			db		"Now opening+writing outfile ",34,0
MSG_ANNOUNCE_OUTFILE_2			db		34,0
MSG_OUTFILE_WRITE_SUCCESS_1		db		"Successsfully wrote ",0
MSG_OUTFILE_WRITE_SUCCESS_2		db		" bytes.",0
MSG_OUTFILE_WRITE_FAIL			db		"Failed to write to the outfile!",0
OUTFILE_WRITE_CONTENTS			db		"Well, hello there!"
OUTFILE_WRITE_CONTENTS_LEN		equ		$-OUTFILE_WRITE_CONTENTS

MSG_OPENFILE_SUCCESS			db		"File opened successfully.",0
MSG_OPENFILE_ERROR				db		"There was an error opening that file!",0

; Special strings
CRLF							db		13,10,0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; BSS Section (uninitialized data)
section .bss

TEMP_CHAR						resb	1


;;;;;;;;;;;;;;;;;;
;;;;; Text Section
section .text

;;; Externs
extern libPuhfessorP_printSignedInteger64


;;;
global main
main:
	
	; Prologue
	call crlf
	call crlf
	call crlf
	
	; Test out opening a bad file name
	mov rdi, INFILE_NAME_BAD
	call readInfile
	call crlf
	call crlf
	
	mov rdi, INFILE_NAME_GOOD
	call readInfile
	call crlf
	call crlf
	
	mov rdi, OUTFILE_NAME
	call writeOutfile
	call crlf
	
	call crlf
	
main_done:
	
	; Epilogue
	
	; Return value
	mov rax, EXIT_SUCCESS
	
	ret



; Read the infile and print to the screen
; Incoming arguments:
;	rsi: File name
; Internal usage:
;	r10: Temp character
;	r12: Incoming file name
;	r13: Opened file descriptor (handle)
readInfile:
	
	; Prologue
	push r12
	push r13
	
	; Grab the file name
	mov r12, rdi
	
	;	Announce the infile
	mov rdi, MSG_ANNOUNCE_INFILE_1
	call print
	mov rdi, r12
	call print
	mov rdi, MSG_ANNOUNCE_INFILE_2
	call print
	call crlf
	
	; Open the file
	mov rax, SYS_OPEN
	mov rdi, r12
	mov rsi, FILE_READ_ONLY
	syscall
	
	; Save and check result
	mov r13, rax
	cmp r13, 0
	jl  readInfile_error
	jmp readInfile_success

readInfile_error:
	
	mov rdi, MSG_OPENFILE_ERROR
	call print
	jmp readInfile_done
	
readInfile_success:
	
	mov rdi, MSG_OPENFILE_SUCCESS
	call print
	call crlf
	jmp readInfile_opened

readInfile_opened:
	
readInfile_readLoopTop:
	
	; Read one more character
	mov rax, SYS_READ
	mov rdi, r13
	mov rsi, TEMP_CHAR
	mov rdx, 1
	syscall
	
	; Check the result. We're done when we see a negative value
	cmp rax, 0
	jle readInfile_close
	
	; Print this character to the console
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, TEMP_CHAR
	mov rdx, 1
	syscall
	
	; Continue looping
	jmp readInfile_readLoopTop
	
readInfile_close:
	
	call crlf
	
	; Close the file handle to our infile
	mov rax, SYS_CLOSE
	mov rdi, r13
	syscall
	
readInfile_done:
	
	; Epilogue
	pop r13
	pop r12
	
	ret




; Incoming arguments:
;	rdi: File name
; Internal usage:
;	r12: File name
;	r13: File handle
;	r14: Number of bytes written
writeOutfile:
	
	; Prologue
	push r12
	push r13
	push r14
	
	; Save incoming arguments
	mov r12, rdi
	
	; Announce what we're doing
	mov rdi, MSG_ANNOUNCE_OUTFILE_1
	call print
	mov rdi, r12
	call print
	mov rdi, MSG_ANNOUNCE_OUTFILE_2
	call print
	call crlf
	
writeOutfile_openCreate:
	
	; Open the outfile (create if it doesn't exist)
	mov rax, SYS_CREATE
	mov rdi, r12
	mov rsi, FILE_PERMISSIONS_DEFAULT
	;mov rsi, FILE_PERMISSIONS_VERY_SECURE
	syscall
	mov r13, rax
	
	; Did the file open successfully?
	cmp r13, 0
	jg writeOutfile_openSuccess
	jmp writeOutfile_openFail

writeOutfile_openSuccess:
	
	mov rdi, MSG_OPENFILE_SUCCESS
	call print
	call crlf
	
	jmp writeOutfile_write
	
writeOutfile_openFail:
	
	mov rdi, MSG_OPENFILE_ERROR
	call print
	call crlf
	
	jmp writeOutfile_done

writeOutfile_write:
	
	; Do the writing
	mov rax, SYS_WRITE
	mov rdi, r13
	mov rsi, OUTFILE_WRITE_CONTENTS
	mov rdx, OUTFILE_WRITE_CONTENTS_LEN
	syscall
	
	; Check the count written
	mov r14, rax
	cmp r14, 0
	jg writeOutfile_write_success
	jmp writeOutfile_write_fail

writeOutfile_write_success:
	
	; Just print that we were successful
	mov rdi, MSG_OUTFILE_WRITE_SUCCESS_1
	call print
	;
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	;
	mov rdi, MSG_OUTFILE_WRITE_SUCCESS_2
	call print
	call crlf
	
	jmp writeOutfile_close
	
writeOutfile_write_fail:
	
	mov rdi, MSG_OUTFILE_WRITE_FAIL
	call print
	call crlf
	
	jmp writeOutfile_close
	
writeOutfile_close:
	
	; Close the file handle to our infile
	mov rax, SYS_CLOSE
	mov rdi, r13
	syscall
	
writeOutfile_done:
	
	; Epilogue
	pop r14
	pop r13
	pop r12
	
	ret





;	printNullTerminatedString(char * theString)
;	r12: Running pointer
print:
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


crlf:
	
	mov rdi, CRLF
	call print
	
	ret














