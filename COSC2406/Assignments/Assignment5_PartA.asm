TITLE	Jacob Culp COSC2407 Nov.7th Assignment5 Question1	(Assignment5_PartA.asm)

;This program will count the amount of letters and digits in a textfile

INCLUDE Irvine32.inc

.data
	
	letters BYTE 26 DUP(?)
	digits	BYTE 10 DUP(?)

	charBuffer BYTE 100 DUP(?)

	msg		BYTE "Please enter the file name: ", 0
	errorMsg BYTE "Error: File did not open properly", 0
	countMsg1 BYTE "Count of '", 0
	countMsg2 BYTE "' = ", 0

	fileName BYTE 50 DUP(?)
	fileHandle DWORD ?

	temp BYTE ?

.code
main PROC
	
	mov edx, OFFSET msg								;
	call WriteString								;
	mov edx, OFFSET fileName						;
	mov ecx, LengthOF fileName						;max size of input
	call ReadString									;gather file name

	call OpenInputFile								;Open file
	cmp eax, INVALID_HANDLE_VALUE					;Check to see if file opened correctly
	je error
	mov fileHandle, eax								;save fileHandle

readAgain:
	
	mov eax, fileHandle								;read 100 bytes from file
	mov edx, OFFSET charBuffer						;into char buffer
	mov ecx, SIZEOF charBuffer						;
	call ReadFromFile								;

	cmp eax, 0										;
	je done											;
	mov ecx, eax									;# of char read
	call processBuffer								;

	jmp readAgain									;

done:

	call print										;print

	exit

error:
	mov edx, OFFSET errorMsg						;"ERROR: File did not open properly"
	call WriteString								;End Program
	call CrLf										;
	exit
main ENDP

;****************************************************************************************************
;uses esi for digit/letter index
;uses al to display digits
;uses edx to display message
;uses ecx
;****************************************************************************************************
print PROC
	push esi
	push eax
	push edx
	push ecx

	mov eax, 0										;zero out eax
	add al, '0'										;start of digits
	mov esi, 0										;start of digits array
	mov ecx, 10										;loop 10 times for digits

L1:

	mov edx, OFFSET countMsg1						;count of '
	call WriteString								;								
	call writechar									;count of 'current char
	mov edx, OFFSET countMsg2						;count of count of 'current char' = 
	call WriteString								;
	push eax										;store al
	mov eax, 0										;
	mov al, [digits + esi]							;
	call writedec									;
	pop eax											;restore al
	call CrLf										;

	inc al											;next char
	add esi, 1

	Loop L1

	mov eax, 0										;zero out eax
	add al, 'A'										;start of letters
	mov esi, 0										;start of letters array
	mov ecx, 26										;loop 26 times for letters

L2:

	mov edx, OFFSET countMsg1						;count of '
	call WriteString								;								
	call writechar									;count of 'current char
	mov edx, OFFSET countMsg2						;count of count of 'current char' = 
	call WriteString								;
	push eax										;store al
	mov eax, 0										;
	mov al, [letters + esi]							;
	call writedec									;
	pop eax											;restore al
	call CrLf										;

	inc al											;next char
	add esi, 1

	Loop L2


	pop ecx
	pop edx
	pop eax
	pop esi
	ret
print ENDP


;****************************************************************************************************
;uses ecx for # of bytes to process
;uses esi as index of charBuffer
;uses edi for index of digits or letters
;al hold the char
;****************************************************************************************************
processBuffer PROC USES ecx eax esi edi
	
	mov esi, OFFSET charBuffer						;

L1:
	
	mov al, [esi]									;next char

	call isDigit									;
	jnz toLetter									;
	sub al, '0'										;
	mov temp, al									;
	mov edi, DWORD PTR temp							;inc digit counter
	inc Digits[edi]									;


toLetter:

	call isLetter									;
	jnz invalidChar									;
	AND al, 11011111b								;letter to uppercase
	sub al, 'A'										;
	mov temp, al									;
	mov edi, DWORD PTR temp							;inc letter counter
	inc letters[edi]								;

invalidChar:
	
	inc esi											;index += 1
	Loop L1


	ret
processBuffer ENDP

;****************************************************************************************************
;preserves ax
;uses al for char
;returns ZF = 1 if it is a letter otherwise ZF = 0
;****************************************************************************************************
isLetter PROC
	push ax											;preserve al register

	cmp al, 'A'										;if((char >= 'A' && char <= 'Z'))
	jb nextCondition								;
	cmp al, 'Z'										;
	jb isALetter									;

nextCondition:	
	cmp al, 'z'										;if((char >= 'A' && char <= 'Z') || (char >= 'a' && char <= 'z'))
	ja notLetter									;
	cmp al, 'a'										;
	jb notLetter									;
	
isALetter:

	test ax, 0										;if it is a letter set ZF = 1
	
notLetter:
	
	pop ax											;restore al 
	ret
isLetter ENDP

END main