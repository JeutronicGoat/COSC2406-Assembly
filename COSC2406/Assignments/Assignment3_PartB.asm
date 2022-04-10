TITLE	Jacob Culp Assignment3 Question2	(Assignment3_PartB.asm)

;This program will have a word array and copy it into a dword array then print the dword array

INCLUDE Irvine32.inc

.data

	NUM EQU 10

	wordArray  WORD  NUM DUP(?)
	dwordArray DWORD NUM DUP(?)

	msg BYTE "Plese enter a singed integer: ", 0

.code
main PROC

	mov eax, 0							;Zero out eax
	mov ecx, NUM						;ecx = 10
	mov edx, OFFSET msg					;
	mov esi, OFFSET wordArray			;Start of wordArray

L1:	
	
	call WriteString					;
	call ReadInt						;Get signed Number

	mov [esi], ax						;Put value in array
	add esi, 2							;Next position

	Loop L1


	mov ecx, NUM						;ecx = 10
	mov esi, OFFSET wordArray			;Start of wordArray
	mov edi, OFFSET dwordArray			;Start of dwordArray

L2:

	mov ax, [esi]
	mov [edi], eax

	add esi, 2
	add edi, 4

	Loop L2


	mov ecx, NUM						;ecx = 10
	mov esi, OFFSET dwordArray			;Start of dwordArray

L3:

	mov eax, [esi]						;
	call WriteInt						;Write number

	mov al, " "							;
	call WriteChar						;Make Space
	add esi, 4							;Next Posion

	Loop L3
	

	exit
main ENDP
END main