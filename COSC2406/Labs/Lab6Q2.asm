TITLE	Lab6Q1	(Lab6.asm)

;This program is a modified fib sequence
;
;
;
;
;NOT COMPLETE
;
;
;
;
INCLUDE Irvine32.inc

.data
	
	msg BYTE "Please enter a number n or a negative to terminate: ", 0

	byeMsg BYTE "Good Bye!", 0

.code
main PROC
	
	mov edx, OFFSET msg					;
	call WriteString					;
	call ReadInt						;get n
	mov ebx, eax						;ebx = n

	cmp eax, 0							;
	jnge Done							;if ecx >= 0

	call Fib
	call CrLf							;

Done:

	mov edx, OFFSET byeMsg				;
	call WriteString					;GOODBYE
	call CrLf							;

	exit
main ENDP

Fib PROC				;uses ebx returns into eax
	push ebx			;Store ebx







	pop ebx				;restore ebx
	ret					;return
Fib ENDP

END main