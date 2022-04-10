TITLE	Jacob Culp COSC2407 Nov.7th Assignment5 Question2	(Assignment5_PartB.asm)	

;This program determines if a given number is a power of 2 using only shifts and rotations

INCLUDE Irvine32.inc

.data
	
	msg		  BYTE "Please enter a number: ", 0
	pwrMsg	  BYTE "This number is a power of two.", 0
	notPwrMsg BYTE "This number is not a power of two.", 0 

.code
main PROC
	
	mov edx, OFFSET msg								;
	call WriteString								;
	call ReadDec									;

	call pwrCheck									;
	jnz notPwr										;not a power of 2
	mov edx, OFFSET PwrMsg							;is a power of 2
	call WriteString								;
	call CrLf										;

	exit

notPwr:
	mov edx, OFFSET notPwrMsg						;
	call WriteString								;
	call CrLf										;
	exit
main ENDP

;*************************************************************************
;uses al to check value, ecx for loop, and ebx for count
;checks each bit increases count everytime there is a set bit
;at the end if the # of set bits != 1 then is is not a power of 2
;*************************************************************************
pwrCheck PROC Uses eax ecx ebx

	mov ebx, 0										;zero out ebx
	mov ecx, 8										;check all 8 bits in the byte

L1:
	
	push ax											;store al
	AND al, 00000001b								;isolate last bit
	cmp al, 00000001b								;
	jne notSetBit									;if bit is not set jump
	inc ebx											;count++

notSetBit:
	pop ax											;restore al
	SHR al, 1										;get next bit

	Loop L1

	cmp ebx, 1										;set zero flag if 1 bit is set
	ret
pwrCheck ENDP

END main