


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Data Section
section				.data

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Text Section
section				.text


; STRANGE: Program has mysterious problems in GDB, until I added a single push/pop pair
; - GDB would get stuck on the same line (cmp) no matter how many times I issued "continue"
; - Often segfaulted by the end
; You may wish to play with an extra push/pop if you experience mysterious problems, too
; (and that it may be related to stack alignment ... or not)

; Main function
global main
main:
	
	push r12
	
	; Init loop
	mov r12, 0
	
main_loopTop:
	
	cmp r12, 3
	je main_loopDone
	
	inc r12
	jmp main_loopTop

main_loopDone:
	
	pop r12
	
	; Return
	mov rax, 0
	ret



