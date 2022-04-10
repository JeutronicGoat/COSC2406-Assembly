TITLE	Lab 11	(Lab11.asm)

;This program deals with 2d arrays

INCLUDE Irvine32.inc

.data
	
	NUM_ROWS = 5
	NUM_COLS = 5

	array	SWORD NUM_ROWS * NUM_COLS DUP(?)

popRandom PROTO,
	arrayOFF : DWORD,
	numOfRows : DWORD,
	numOfCols : DWORD

totalRows PROTO,
	numOfRows : DWORD,
	numOfCols : DWORD

.code
main PROC
	
	call Randomize										;

	invoke popRandom, OFFSET array, NUM_ROWS, NUM_COLS	;

	invoke totalRows, NUM_ROWS, NUM_COLS	;


	exit
main ENDP

popRandom PROC,
	arrayOFF : DWORD,
	numOfRows : DWORD,
	numOfCols : DWORD
	
	mov esi, arrayOFF					;
	mov ecx, numOfRows					;

L1:
	push ecx							;
	mov edi, 0							;
	mov ecx, numOfCols					;

L2:
	mov eax, 200 - -100 + 1				;
	call RandomRange					;
	add eax, -100						;
	mov [esi + edi], ax					;

	add edi, TYPE WORD					;
	loop L2								;

	add esi, edi						;
	pop ecx								;
	loop L1								;

	ret
popRandom ENDP

;*************************************************************
.data
	msg BYTE " + ", 0
	msg2 BYTE " = ", 0
.code
totalRows PROC,
	numOfRows : DWORD,
	numOfCols : DWORD
	LOCAL total : DWORD
	
	mov esi, 0							;
	mov ecx, numOfRows					;
L1:
	push ecx							;
	mov total, 0						;
	mov edi, 0							;
	mov ecx, numOfCols					;
	dec ecx								;

L2:
	mov eax, 0							;
	movsx eax, array[esi+edi]			;
	add total, eax						;
	call WriteInt						;display #

	mov edx, OFFSET msg					;
	call WriteString					;

	add edi, TYPE WORD					;
	loop L2								;

	mov eax, 0							;
	movsx eax, array[esi+edi]			;
	add total, eax						;
	call WriteInt						;

	mov edx, OFFSET msg2				;
	call WriteString					;

	mov eax, total						;display last #
	call WriteInt						;
	
	call CrLf							;

	add esi, edi						;
	pop ecx								;
	loop L1								;
	call CrLf							;

	ret
totalRows ENDP

END main