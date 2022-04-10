TITLE	Get Loopy	(GetLoopy.asm)

;This program multiplies 2 numbers

INCLUDE Irvine32.inc

.data

	msg1 BYTE "Please enter a number: ", 0
	msg2 BYTE "x * n = ", 0

	varX DWORD ?
	varN DWORD ?

.code
main PROC
	
	mov edx, OFFSET msg1
	call WriteString					;ask for x
	call ReadInt
	mov varX, eax						;varX = x

	call WriteString					;ask for N
	call ReadInt
	mov varN, eax						;varN = N

	mov eax, 0							;reset eax to 0

	mov ecx, varN						;not needed but to better understand

L1:
	
	add eax, varX
	loop L1

	mov edx, OFFSET msg2
	call WriteString					;x * n = eax
	call WriteInt
	call CrLf


	exit
main ENDP
END main