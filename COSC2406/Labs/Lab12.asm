TITLE	Lab 12	(Lab12.asm)

;This program messes with strings

INCLUDE Irvine32.inc

.data
	
	targetStr	BYTE "Hello Cruel World!", 20 DUP(0)
	sourceStr	BYTE "Hello cruel World!", 0


	
Str_concat PROTO,
	targetOFF : DWORD,
	sourceOFF : DWORD

Str_concat2 PROTO,
	targetOFF : DWORD,
	sourceOFF : DWORD,
	lengthOfTarget : DWORD

Str_Remove PROTO,
	 stringOFF : DWORD,
	 n : DWORD

.code
main PROC
	




;	invoke Str_concat, OFFSET targetStr, OFFSET sourceStr		;
;	mov edx, OFFSET targetStr									;
;	call WriteString											;
;	call CrLf													;

;	invoke Str_concat2, OFFSET targetStr, OFFSET sourceStr,		;
;		LENGTHOF targetStr										;
;	mov edx, OFFSET targetStr									;
;	call WriteString											;
;	call CrLf													;

	invoke Str_Remove, OFFSET [targetStr + 3], 4				;
	mov edx, OFFSET targetStr									;
	call WriteString											;
	call CrLf													;


	exit
main ENDP

;****************************************************************************

Str_concat PROC,
	targetOFF : DWORD,
	sourceOFF : DWORD

	
	mov edi, targetOFF							;edi = start of target
	invoke Str_Length, targetOFF				;
	mov ecx, eax								;edi = end of target
	mov al, 0									;
	CLD											;set direction ->
	repne scasb									;rep while not null terminated
	
	invoke Str_Length, sourceOFF				;find length of source string
	mov ecx, eax								;ecx = length of 

	mov esi, sourceOFF							;esi = start of source

	rep movsb									;concat strings

	ret
Str_concat ENDP

;****************************************************************************

Str_concat2 PROC,
	targetOFF : DWORD,
	sourceOFF : DWORD,
	lengthOfTarget : DWORD

	
	mov edi, targetOFF							;edi = start of target
	invoke Str_Length, targetOFF				;
	add edi, eax								;edi = end of target

	sub lengthOfTarget, eax						;
	dec lengthOfTarget							;space left in target not including the final 0

	invoke Str_Length, sourceOFF				;find length of source string

	cmp lengthOfTarget, eax						;
	jl targetLess								;
	mov ecx, eax								;
	jmp Done									;
targetLess:
	mov ecx, lengthOfTarget						;
Done:

	mov esi, sourceOFF							;esi = start of source

	rep movsb									;concat strings

	ret
Str_concat2 ENDP

;****************************************************************************

Str_Remove PROC,
	 stringOFF : DWORD,
	 n : DWORD

	 invoke Str_Length, stringOFF			;
	 mov ecx, eax							;

	 mov edi, stringOFF						;
	 mov esi, StringOFF						;
	 add esi, n								;
	 
	 CLD									;set direction ->
	 rep movsb								;

	ret
Str_Remove ENDP

;****************************************************************************

END main