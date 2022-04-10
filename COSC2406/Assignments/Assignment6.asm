TITLE	Jacob Culp Assignment6 Question1 Nov. 14th	(Assignment6.asm)

;This program will ask the user what option they would like to select
;and execute the operation that was selected

INCLUDE Irvine32.inc

.data
	
	menu BYTE "Please select one of the following:",10,13,
			  "1 - Populate the array with random numbers",10,13,
			  "2 - Multiply the array with a user provided multiplier",10,13,
			  "3 - Divide the array with a user provided divisor",10,13,
			  "4 - Print the array",10,13,
			  "0 - Exit ", 0
	
	popMsg BYTE "The array has been populated!", 0
	mulVal BYTE "Enter the value the array will be multiplied by: ", 0
	mulMsg BYTE "The array has been multiplied!", 0
	DivVal BYTE	"Enter the value the array will be divided by: ", 0
	DivMsg BYTE "The array has been divided!", 0
	errorMsg BYTE "Invalid Number Entered!!!", 0
	continueMsg BYTE "Please press ENTER to continue...", 0

	numArray SWORD 10 DUP(-100)
	temp DWORD ?

	PrintArray PROTO,
		arrayOff: DWORD,
		count	: DWORD

.code
main PROC
	call RANDOMIZE

L1:	
	mov edx, OFFSET menu						;
	call WriteString							;Display menu
	call CrLf									;
	call ReadInt								;Collect answer

	cmp eax, 0									;
	je Done										;Exit if 0

;************************************************************************************
	cmp eax, 1									;
	jne Op2Check								;Call PopulateRandomNum if 1

	push OFFSET numArray						;pass the array & Length of array
	push LENGTHOF numArray						;
	Call PopulateRandomNum						;
	mov edx, OFFSET popMsg						;
	call WriteString							;
	call CrLf									;

	mov edx, OFFSET continueMsg					;
	call WriteString							;
	call ReadDec								;
	call ClrScr									;
	jmp L1										;

;************************************************************************************
Op2Check:
	cmp eax, 2									;
	jne Op3Check								;Call MulArray if 2
	mov edx, OFFSET mulVal						;
	call WriteString							;
	call ReadInt								;

	push eax									;eax = multiplier value. pass eax
	push OFFSET numArray						;
	push Length numArray						;pass the array & Length of array
	Call MulArray								;
	mov edx, OFFSET mulMsg						;
	call WriteString							;
	call CrLf									;

	mov edx, OFFSET continueMsg					;
	call WriteString							;
	call ReadDec								;
	call ClrScr									;
	jmp L1										;

;************************************************************************************
Op3Check:
	cmp eax, 3									;
	jne Op4Check								;Call DivArray if 3
	mov edx, OFFSET DivVal						;
	call WriteString							;
	call ReadInt								;
	mov temp, eax								;Store value

	mov esi, 0									;
	mov ecx, LENGTHOF numArray					;
L2:
	push eax									;eax = divider value. pass eax
	movsx ebx, [numArray + esi]					;
	push ebx									;pass value at array index												
	Call DivNum									;
	mov numArray[esi], ax						;
	mov eax, temp								;restore eax
	add esi, 2									;
	LOOP L2										;

	mov edx, OFFSET DivMsg						;
	call WriteString							;
	call CrLf									;

	mov edx, OFFSET continueMsg					;
	call WriteString							;
	call ReadDec								;
	call ClrScr									;
	jmp L1										;

;************************************************************************************
Op4Check:
	cmp eax, 4												;
	jne Error												;Call PrintArray if 4
	invoke PrintArray, 	OFFSET numArray, LENGTHOF numArray	;		
	call CrLf												;

	mov edx, OFFSET continueMsg								;
	call WriteString										;
	call ReadDec											;
	call ClrScr												;
	jmp L1													;

;************************************************************************************
Error:
	mov edx, OFFSET errorMsg					;
	call WriteString							;Invalid # was entered
	call CrLf									;

	mov edx, OFFSET continueMsg					;
	call WriteString							;
	call ReadDec								;
	call ClrScr									;
	jmp L1										;

;************************************************************************************

Done:

	exit
main ENDP
	
;************************************************************************************
;Populates the passed array withe values between -1500 and +2500
;************************************************************************************
PopulateRandomNum PROC
	ENTER 8, 0
	pushfd	
	push esi
	push ecx
	push eax


	mov esi, [ebp + 12]							;
	mov ecx, [ebp + 8]							;
	
L1:
	mov eax, -1500								;
	mov ebx, 2500								;generate num -1500 - +2500
	call RandomNum								;
	mov [esi], eax								;insert at index
	add esi, 2									;index++
	LOOP L1										;

	pop eax
	pop ecx
	pop esi
	popfd
	LEAVE
	ret 8
PopulateRandomNum ENDP
;************************************************************************************


;************************************************************************************
;multiplies all values in the passed array by the passed value
;************************************************************************************
MulArray PROC,
	count	: DWORD,
	array	: DWORD,
	mulValue: WORD
	pushfd
	push esi
	push eax		

	mov esi, array								;
L1:
	cmp count, 0								;
	je Done										;

	mov ax, [esi]								;take value at index
	imul ax, mulValue							;multiply by value
	mov [esi], ax								;put value in at index
	add esi, 2									;inc index

	dec count									;
	jmp L1										;
Done:

	pop eax
	pop esi
	popfd
	ret
MulArray ENDP
;************************************************************************************

;************************************************************************************
;Divides a passed value by another passed value
;returns in answer eax
;************************************************************************************
DivNum PROC
	ENTER 8,0
	pushfd
	push ebx

	mov ax, [ebp + 8]							;[ebp + 8] = array num
	CWD											;
	mov bx, WORD PTR [ebp + 12]					;[ebp + 12] = divnum
	idiv bx										;
	
	pop ebx
	popfd
	LEAVE
	ret 8
DivNum ENDP
;************************************************************************************


;************************************************************************************
;Prints the passed array
;************************************************************************************
PrintArray PROC,
	arrayOff: DWORD,
	count	: DWORD
	push eax
	push edx
	push esi
	pushfd

	mov esi, arrayOff
	mov al, '['								;
	call WriteChar							;
	dec count								;array length - 1
L1:
	cmp count, 0							;
	je Done									;

	movsx eax, WORD PTR [esi]				;
	call WriteInt							;print array
	mov al, ','								;
	call WriteChar							;
	mov al, ' '								;
	call WriteChar							;
	add esi, 2								;

	dec count								;
	jmp L1									;
Done:
	movsx eax, WORD PTR [esi]				;
	call WriteInt							;Last number
	mov al, ']'								;
	call WriteChar							;
	
	popfd
	pop esi
	pop edx
	pop eax
	ret 
PrintArray ENDP
;************************************************************************************


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