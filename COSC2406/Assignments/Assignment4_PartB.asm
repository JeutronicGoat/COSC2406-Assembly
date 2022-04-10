TITLE	Jacob Culp Assignment4 Question2 Oct. 27th	(Assignment4_PartB.asm)

;This program creates a better random number generator

INCLUDE Irvine32.inc

.data
	
	msgLow	BYTE "Please enter a low number: ", 0
	msgHigh	BYTE "Please enter a high number: ", 0
	msg		BYTE "The Random number is: ", 0

.code
main PROC
	
	mov ecx, 5										;loop 5 times

L1:
	mov edx, OFFSET msgLow							;
	call WriteString								;ask for low
	call ReadInt									;gather low
	mov ebx, eax									;store low in ebx

	mov edx, OFFSET msgHigh							;
	call WriteString								;ask for high
	call ReadInt									;gather high

	call RandomNum									;generate random #

	mov edx, OFFSET msg								;
	call WriteString								;
	call WriteInt									;print #
	call CrLf										;
	call CrLf										;

	Loop L1

	exit
main ENDP

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