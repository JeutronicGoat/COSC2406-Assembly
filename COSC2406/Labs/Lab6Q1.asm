TITLE	Lab6Q1	(Lab6.asm)

;This program copies java code

INCLUDE Irvine32.inc

.data

	msg BYTE "Enter the n value for the sum(n) or negative to terminate: ", 0 

	ans1 BYTE "sum(", 0
	ans2 BYTE ") = ", 0

	endMsg BYTE "Good Bye!", 0

.code
main PROC
	

Do:
	mov edx, OFFSET msg						;
	call WriteString						;
	call ReadInt							;Get number

	mov ebx, eax							;ebx = num

	cmp eax, 0								;
	jnge D1									;if ecx >= 0 
		
	call Recursion1

	mov edx, OFFSET ans1					;
	call WriteString						;"sum("

	xchg eax, ebx							;
	call WriteInt							;print num
	xchg eax, ebx							;

	mov edx, OFFSET ans2					;
	call WriteString						;") = "
	call WriteInt							;print answer

	call CrLf								;

	jmp Do									;Loop
D1:											;else

	mov edx, OFFSET endMsg					;
	call WriteString						;GOODBYE msg
	call CrLf								;

	exit
main ENDP

;**************************************************************************************

Recursion1 PROC								;recursion method

	push ebx								;Store ebx


	cmp eax, 1								;
	jng Done								;if eax > 1
	
	mov ebx, eax
	dec eax
	call Recursion1
	add eax, ebx;

	Done:									;else

	pop ebx									;restore ebx

	ret										;return
Recursion1 ENDP

END main