TITLE	Jacob Culp Assignment3 Question4	(Assignment3_PartD.asm)

;This program creates a DWORD array of length 10 and moves all values forward one position
;all values are user supplied

INCLUDE Irvine32.inc

.data

	dwordArray DWORD 10 DUP(?)
	
	msg BYTE "Please enter an integer value: ", 0

.code
main PROC
	
	mov ecx, LENGTHOF dwordArray				;ecx = 10
	mov esi, OFFSET   dwordArray				;Start of dwordArray
	mov edx, OFFSET   msg						;

L1:

	call WriteString							;
	call ReadInt								;Collect Number

	mov [esi], eax								;Store Number 
	add esi, TYPE dwordArray					;Next Position

	Loop L1

;**************************************************************************************

	sub esi, TYPE dwordArray					;esi = Position 10 of 10
	mov ebx, [esi]								;ebx = Position 10 value
	mov ecx, LENGTHOF dwordArray - 1			;Loop 9 times, manually change position 1 to 10

L2:

	mov edx, [esi - TYPE dwordArray]			;
	mov [esi], edx								;Position = Previous Position
	sub esi, TYPE dwordArray					;esi - 4

	Loop L2

	mov [esi], ebx								;Value 10 put in position 1

;**************************************************************************************

.data

	msg2 BYTE ", ", 0

.code

	mov esi, OFFSET dwordArray					;
	mov edx, OFFSET msg2						;
	mov ecx, LENGTHOF dwordArray - 1			;ecx = 9, manually do the first/last brackets

	mov al, "["									;
	call WriteChar								;

L3:

	mov eax, [esi]								;Get Number 
	call WriteInt								;Print Number
	call WriteString							;Space and Comma

	add esi, TYPE dwordArray					;Next Position

	Loop L3

	mov eax, [esi]								;Get Number 
	call WriteInt								;Print Number

	mov al, "]"									;
	call WriteChar								;

	exit
main ENDP
END main