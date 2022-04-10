TITLE	Basic Multiplication	(Lab8P2.asm)

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
	
	mov esi, OFFSET num1						;#1
	mov edi, OFFSET num2						;#2
	mov ecx, 2									;type word
	call Prompt									;get info
	call MultiplySigned							;multiplySigned
	call Print									;Print
	call MultiplyUnsigned						;multiplyUnsigned
	call Print									;Print

;*******************************************************************************

	mov esi, OFFSET number1						;#1
	mov edi, OFFSET number2						;#2
	mov ecx, 4									;type word
	call Prompt									;get info
	call MultiplySigned							;multiplySigned
;	call Print									;Print

	exit
main ENDP

;******************************************************************************************
;esi OFFSET of #1
;edi OFFSET of #2
;ecx Type of variable Word = 2, Dword = 4
;******************************************************************************************
Prompt PROC
	
	cmp ecx, 2									;
	jne dwordSection							;


	mov edx, OFFSET msg1						;
	call WriteString							;gather #1
	call ReadInt								;
	mov DWORD PTR [esi], eax					;
	mov eax, 0									;

	mov edx, OFFSET msg2						;
	call WriteString							;gather #2
	call ReadInt								;
	mov DWORD PTR [edi], eax					;

	mov esi, OFFSET num1						;#1
	mov edi, OFFSET num2						;#2
	mov ecx, 2									;type Word


	jmp Done									;
dwordSection:
	cmp ecx, 4									;
	jne Done									;


	mov edx, OFFSET msg1						;
	call WriteString							;gather #1
	call ReadInt								;
	mov [esi], eax								;
	mov eax, 0									;

	mov edx, OFFSET msg2						;
	call WriteString							;gather #2
	call ReadInt								;
	mov [edi], eax								;

	mov esi, OFFSET number1						;#1
	mov edi, OFFSET number2						;#2
	mov ecx, 4									;type dWord


Done:

	ret
Prompt ENDP

;******************************************************************************************
;first num offset in esi
;second num offset in edi
;size of variable in ecx: WORD = 2, DWORD = 4
;******************************************************************************************
MultiplySigned PROC
	
	cmp ecx, 2									;
	jne dwordSection							;


	mov ax, [esi]								;
	mov bx, [edi]								;
	imul bx										;multiply

	SHL edx, 16									;
	xchg dx, ax									;
	mov eax, edx								;move answer to eax


	jmp Done									;
dwordSection:
	cmp ecx, 4									;
	jne Done									;


	mov eax, [esi]						    	;
	mov ebx, [edi]						    	;

	imul ebx									;multiply


Done:

	ret
MultiplySigned ENDP

;******************************************************************************************
;first num offset in esi
;second num offset in edi
;size of variable in ecx: WORD = 2, DWORD = 4
;******************************************************************************************
MultiplyUnsigned PROC
	
	cmp ecx, 2									;
	jne dwordSection							;


	mov ax, [esi]								;
	mov bx, [edi]								;
	mul bx										;multiply

	SHL edx, 16									;
	xchg dx, ax									;
	mov eax, edx								;move answer to eax


	jmp Done									;
dwordSection:
	cmp ecx, 4									;
	jne Done									;

	mov eax, [esi]						    	;
	mov ebx, [edi]						    	;

	mul ebx										;multiply

Done:


	ret
MultiplyUnsigned ENDP

;******************************************************************************************
;first num offset in esi
;second num offset in edi
;size of variable in ecx: WORD = 2, DWORD = 4
;******************************************************************************************
Print PROC
	
	cmp ecx, 2									;
	jne dwordSection							;

	mov edx, OFFSET answerMsg1					;
	call WriteString							;
	call WriteInt								;write singed int
	call CrLf									;

	mov edx, OFFSET answerMsg2					;
	call WriteString							;
	call WriteInt								;write singed int
	call CrLf									;

	jmp Done									;
dwordSection:
	cmp ecx, 4									;
	jne Done									;


	mov ebx, edx								;
	mov edx, OFFSET answerMsg1					;
	call WriteString							;
	mov edx, ebx								;

	mov ebx, eax								;Store bottom half
	mov eax, edx								;'FFFFFFFF' print top half
	call WriteHex								;
	mov ax, ':'									;'FFFFFFFF:'
	call WriteChar								;
	mov eax, ebx								;restore bottom half
	call WriteHex								;'FFFFFFFF:FFFFFFFF' print full answer
	call CrLf									;

	mov ebx, edx								;
	mov edx, OFFSET answerMsg2					;
	call WriteString							;
	mov edx, ebx								;

	mov ebx, eax								;Store bottom half
	mov eax, edx								;'FFFFFFFF' print top half
	call WriteHex								;
	mov ax, ':'									;'FFFFFFFF:'
	call WriteChar								;
	mov eax, ebx								;restore bottom half
	call WriteHex								;'FFFFFFFF:FFFFFFFF' print full answer
	call CrLf									;
	call CrLf									;


Done:


	ret
Print ENDP

END main