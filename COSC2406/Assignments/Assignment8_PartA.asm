TITLE	Jacob Culp Assignment8 Question1 Nov. 30th	(Assignment8_PartA.asm)

;This program gathers a string, starting index and ending index
;and returns a subtring

INCLUDE Irvine32.inc

.data
	
	msg1 BYTE "Enter a string: ", 0
	msg2 BYTE "Enter a start index: ", 0
	msg3 BYTE "Enter a end index: ", 0
	msg4 BYTE "Substring: ", 0

	MAX_STRING = 100

	string1  BYTE	MAX_STRING	DUP(?), 0
	string2  BYTE	MAX_STRING	DUP(?), 0
	startI	DWORD	?
	endI	DWORD	?

Str_substring PROTO,
	startIndex : DWORD,
	endIndex   : DWORD,
	sourceOFF  : PTR BYTE,
	targetOFF  : PTR BYTE

.code
main PROC
	
	mov edx, OFFSET msg1								;Get String
	call WriteString									;
	mov ecx, MAX_STRING									;100 characters max
	mov edx, OFFSET string1								;
	call ReadString										;

	mov edx, OFFSET msg2								;Get start index
	call WriteString									;
	call ReadDec										;
	mov startI, eax										;

	mov edx, OFFSET msg3								;Get end index
	call WriteString									;
	call ReadDec										;
	mov endI, eax										;

	mov edx, OFFSET msg4								;Get substring
	call WriteString									;
	invoke Str_substring, startI, endI,					;
		OFFSET string1, OFFSET string2					;

	mov al, '"'											;
	call WriteChar										;
	mov edx, OFFSET string2								;Return Substring
	call WriteString									;
	mov al, '"'											;
	call WriteChar										;
	call CrLf											;

	exit
main ENDP

;Gathers a substring
Str_substring PROC,
	startIndex : DWORD,
	endIndex   : DWORD,
	sourceOFF  : PTR BYTE,
	targetOFF  : PTR BYTE

	pushad
	pushfd

	mov eax, endI										;
	sub eax, startI										;
	jle	EmptyString										;if end <= start substring is empty

	mov ecx, (endI - startI)							;
	mov esi, sourceOFF									;
	add esi, startI										;
	mov edi, targetOFF									;

	CLD													;set direction ->
	rep movsb											;

EmptyString:

	popfd
	popad
	ret
Str_substring ENDP

END main