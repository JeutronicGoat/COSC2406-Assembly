TITLE	Jacob Culp Assignment7 Question2 Nov. 22nd	(Assignment7_PartB.asm)

;This program recieves a single-precision floating-point binary value
;And displays it in the format of (sign 1. significand x 2^exponent)

INCLUDE Irvine32.inc
	
.data
	
	msg  BYTE "Please enter a float value: ", 0
	msg2 BYTE "The real number in binary is: ", 0

	finMsg1 BYTE "1.", 0
	finMsg2 BYTE " x 2^", 0

	inputVal REAL4 ?


	DisplayFloat PROTO,
		value : REAL4

.code
main PROC

	mov edx, OFFSET msg							;
	call WriteString							;
	call ReadFloat								;
	fstp inputVal								;
	
	mov edx, OFFSET msg2						;
	call WriteString							;
	
	invoke DisplayFloat, inputVal				;

	call CrLf									;
	call showFPUstack							;

	exit
main ENDP

DisplayFloat PROC,
	value : REAL4
	LOCAL significand : REAL4
	LOCAL exponent : DWORD
	pushfd
	push eax
	push edx
	push ecx


	fld value									;
	fxtract										;ST(0) = significand, ST(1) = exponent
	fstp significand							;
	mov eax, significand						;
	SHL eax, 1									;SIGN
	push eax									;
	jc isNeg									;if first bit = 1 print '-'
	mov al, '+'									;if first bit = 0 print '+'
	jmp Done									;
isNeg:
	mov al, '-'									;
Done:
	call WriteChar								;
	pop eax										;
	SHL eax, 8									;Remove exponent
	
	mov edx, OFFSET finMsg1						;1.
	call WriteString							;

	mov ecx, 23									;
L1:
	push eax									;

	AND eax, 80000000h							;test 1st bit 
	cmp eax, 80000000h							;if set print 1 
	je bitSet									;if not print 0
	mov al, '0'									;
	jmp notSet									;
bitSet:
	mov al, '1'									;
notSet:
	call WriteChar								;

	pop eax										;
	SHL eax, 1									;next bit
	Loop L1										;

	mov edx, OFFSET finMsg2						;
	call WriteString							;
	fistp exponent								;Exponent
	mov eax, exponent							;
	Call WriteInt								;


	pop ecx
	pop edx
	pop eax
	popfd
	ret
DisplayFloat ENDP

END main