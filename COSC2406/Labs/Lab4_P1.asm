TITLE	Loops	(Loops.asm)

;This program copies java code

INCLUDE Irvine32.inc

.data

	msg1 BYTE "Please enter a number: ", 0
	msg2 BYTE "a + b = ", 0
	msg3 BYTE "a - b = ", 0

	varA DWORD ?
	varB DWORD ?

.code
main PROC

	mov edx, OFFSET msg1							
	call WriteString								;ask for number
	call ReadInt
	mov varA, eax									;varA = a

	call WriteString								;ask for number
	call ReadInt
	mov varB, eax									;varB = b
	
	mov eax, varA									;eax = a
	add eax, varB									;eax = a + b

	mov edx, OFFSET msg2							;write a + b = eax
	call WriteString
	call WriteInt
	call CrLf

	mov eax, varA									;eax = a
	sub eax, varB									;eax = a - b

	mov edx, OFFSET msg3							;write a - b = eax
	call WriteString
	call WriteInt
	call CrLf

	exit	
main ENDP
END main