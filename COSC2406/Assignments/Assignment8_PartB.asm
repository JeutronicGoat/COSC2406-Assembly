TITLE	Jacob Culp Assignment8 Question2 Nov. 30th	(Assignment8_PartB.asm)

;This program will create and maniplulate a 2D array

INCLUDE Irvine32.inc

.data
	
	NUM_ROWS = 10
	NUM_COLS = 5

	array	SWORD	(NUM_ROWS * NUM_COLS) DUP(15)

	msg1	BYTE	"Enter a column to total: ", 0
	msg2	BYTE	"The sum of the column is: ", 0

SumColumnOfArray PROTO,
	arrayOFF : DWORD,
	numOfRows: DWORD,
	numOfCols: DWORD,
	colNum	 : DWORD

.code
main PROC

	call Randomize								;

	call PopulateArray							;
	
	mov eax, NUM_ROWS							;
	push eax									;
	mov eax, NUM_COLS							;
	push eax									;
	push DWORD PTR OFFSET array					;
	call PrintArray								;

	mov edx, OFFSET msg1						;
	call WriteString							;
	call ReadDec								;

	invoke SumColumnOfArray, OFFSET array,		;
		NUM_ROWS, NUM_COLS, eax					;

	mov edx, OFFSET msg2						;
	call WriteString							;
	call WriteInt								;
	call CrLf									;

	exit
main ENDP

;***************************************************************
;USES esi, ecx, ebx, eax, edi
;***************************************************************
PopulateArray PROC
	pushad
	pushfd

	mov esi, 0									;
	mov ecx, NUM_ROWS							;loop for rows

L1:

	push ecx									;loop for columns
	mov edi, 0									;
	mov ecx, NUM_COLS							;

L2:

	mov ebx, -100								;
	mov eax, 100								;
	call RandomNum								;random num -100 - 100
	mov array[esi + edi], ax					;

	add edi, TYPE array							;next num in column
	loop L2										;
	add esi, edi								;next row
	pop ecx										;
	loop L1										;

	popfd
	popad
	ret
PopulateArray ENDP

.data
	msg BYTE ", ", 0
.code
;***************************************************************
;[ebp + 16] = num of rows
;[ebp + 12] = num of cols
;[ebp + 8] = OFFSET of array
;USES eax, esi, ecx, edi
;***************************************************************
PrintArray PROC
	ENTER 0,0
	pushad
	pushfd

	mov eax, [ebp + 16]							;
	mov esi, [ebp + 8]							;
	mov ecx, eax								;rows loop

L1:

	push ecx									;
	mov edi, 0									;
	mov al, '|'									;
	call WriteChar								;"| "
	mov al, ' '									;
	call WriteChar								;
	mov eax, [ebp + 12]							;
	mov ecx, eax								;cols loop
	dec ecx										;

L2:
;***************************************************************
	movsx eax, SWORD PTR [esi + edi]			;
	call WriteInt								;
	mov edx, OFFSET msg							;
	call WriteString							;"#, "
	add edi, TYPE SWORD							;next num in column
	loop L2										;

	movsx eax, SWORD PTR [esi + edi]			;Last num in col
	call WriteInt								;
	mov al, ' '									;
	call WriteChar								;
	add edi, TYPE WORD							;
;***************************************************************

	mov al, '|'									;
	call WriteChar								;| ... |
	call CrLf									;
	add esi, edi								;next row
	pop ecx										; 
	loop L1										;
	call CrLf									;

	popfd
	popad
	LEAVE
	ret
PrintArray ENDP

;***************************************************************
;returns sum of column in eax
;USES 
;***************************************************************
SumColumnOfArray PROC USES esi edi ecx ebx,
	arrayOFF : DWORD,
	numOfRows: DWORD,
	numOfCols: DWORD,
	colNum	 : DWORD
	LOCAL lengthOfRow : DWORD
	
	pushfd

	mov eax, 0
	mov esi, arrayOFF							;starting row
	mov edi, 0									;
	mov ecx, colNum 							;
	dec ecx										;
L3:
	add edi, TYPE array							;starting col
	Loop L3										;

	mov ecx, numOfRows							;

L1:
	movsx ebx, WORD PTR [esi + edi]				;
	add eax, ebx								;

	push ecx									;
	mov ecx, numOfCols							;
L2:
	add edi, TYPE array							;next row
	Loop L2										;
	pop ecx										;

	loop L1										;
	call WriteInt

	popfd
	ret
SumColumnOfArray ENDP
;***************************************************************

;***************************************************************************
	Title Better Random Number Generator
;This procedure uses eax, ebx.
;This procedure will take a low and a high (ebx = low, eax = high).
;It will switch eax and ebx if low > high.
;Then will generate a number between the low and high. (returns in eax)
;***************************************************************************
;public static int randomNum(int low, int high) {
;		
;		if(low > high) {
;			int temp = low;
;			low = high;
;			high = temp;
;		}
;		
;		return (int)(Math.random() * (high - low + 1)) + low;
;}
;***************************************************************************
RandomNum PROC
	push ebx
	
	cmp eax, ebx							;
	jge Done								;if High > low jump else
	
	xchg eax, ebx							;high = low, low = high

Done:
	
	sub eax, ebx							;(high - low)
	call RandomRange						;(Math.random() * (high - low))
	inc eax									;(Math.random() * (high - low + 1))
	add eax, ebx							;(Math.random() * (high - low + 1)) + low

	pop ebx
	ret
RandomNum ENDP
;***************************************************************************
END main