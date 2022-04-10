TITLE	Basic Multiplication	(Lab8.asm)

;This program multiplies

INCLUDE Irvine32.inc

.data
	
	msg1 BYTE "Please enter a number: ", 0
	msg2 BYTE "Please enter another number: ", 0

	answerMsg1 BYTE "Signed: ", 0
	answerMsg2 BYTE "Unsigned: ", 0


	num1 WORD ?
	num2 WORD ?

	number1 DWORD ?
	number2 DWORD ?

.code
main PROC
	
	mov edx, OFFSET msg1						;
	call WriteString							;gather #1
	call ReadInt								;
	mov DWORD PTR num1, eax						;
	mov eax, 0									;

	mov edx, OFFSET msg2						;
	call WriteString							;gather #2
	call ReadInt								;
	mov DWORD PTR num2, eax						;

	mov ax, num1								;
	mov bx, num2								;
	imul bx										;multiply

	SHL edx, 16									;
	xchg dx, ax									;
	mov eax, edx								;move answer to eax

	mov edx, OFFSET answerMsg1					;
	call WriteString							;
	call WriteInt								;write singed int
	call CrLf									;

	mov ax, num1								;
	mov bx, num2								;
	mul bx										;multiply

	SHL edx, 16									;
	xchg dx, ax									;
	mov eax, edx								;move answer to eax

	mov edx, OFFSET answerMsg2					;
	call WriteString							;
	call WriteDec								;write singed int
	call CrLf									;
	call CrLf									;

;*******************************************************************************

	mov edx, OFFSET msg1						;
	call WriteString							;gather #1
	call ReadInt								;
	mov number1, eax							;
	mov eax, 0									;

	mov edx, OFFSET msg2						;
	call WriteString							;gather #2
	call ReadInt								;
	mov number2, eax							;

	mov eax, number1							;
	mov ebx, number2							;
	mov edx, OFFSET answerMsg1					;
	call WriteString							;

	imul ebx									;multiply
	mov ebx, eax								;Store bottom half
	mov eax, edx								;'FFFFFFFF' print top half
	call WriteHex								;
	mov ax, ':'									;'FFFFFFFF:'
	call WriteChar								;
	mov eax, ebx								;restore bottom half
	call WriteHex								;'FFFFFFFF:FFFFFFFF' print full answer
	call CrLf									;

	mov eax, number1							;
	mov ebx, number2							;
	mov edx, OFFSET answerMsg2					;
	call WriteString							;

	mul ebx										;multiply
	mov ebx, eax								;Store bottom half
	mov eax, edx								;'FFFFFFFF' print top half
	call WriteHex								;
	mov ax, ':'									;'FFFFFFFF:'
	call WriteChar								;
	mov eax, ebx								;restore bottom half
	call WriteHex								;'FFFFFFFF:FFFFFFFF' print full answer
	call CrLf									;
	call CrLf									;

	exit
main ENDP
END main