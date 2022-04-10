TITLE	Sum Accumulations	(SumAccumulations.asm)

;This program uses procedures

INCLUDE Irvine32.inc

.data

	array1 WORD 10h, 20h, 30h, 40h, 50h, 60h, 70h, 80h, 90h, 0A0h	
	array2 WORD 10 DUP(?) 

.code
main PROC
	
	mov esi, OFFSET		array1
	mov edi, OFFSET		array2
	mov ebx, TYPE		array1
	mov ecx, LENGTHOF	array1

	call printArray
	call calcRunningTotal

	mov esi, edi

	call printArray


	exit
main ENDP


.data
	msg BYTE "h, ", 0

.code
printArray PROC USES ecx esi				;Print Array

	sub ecx, 1

	mov al, '['								; [
	call Writechar 

L1:
	mov ax, [esi]
	call WriteHexB							; #,
	
	mov edx, OFFSET msg
	call WriteString

	add esi, ebx
	Loop L1

	mov ax, [esi]
	call WriteHexB

	mov al, 'h'								
	call Writechar
	mov al, ']'								; ]
	call Writechar 

	call CrLf

ret
printArray ENDP


calcRunningTotal PROC USES ecx esi edi			;Calculate Running Total

	mov eax, 0								;zero out

L1:

	add ax, [esi]
	mov [edi], ax

	add esi, ebx
	add edi, ebx

	Loop L1


ret
calcRunningTotal ENDP

END main