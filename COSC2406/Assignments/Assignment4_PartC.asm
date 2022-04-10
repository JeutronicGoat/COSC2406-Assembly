TITLE	Jacob Culp Assignment4 Question3 Oct. 27th	(Assignment4_PartC.asm)

;This program will flash a char a user inputs 500 times in random postions of the console and
;with random colours for the char and background.

INCLUDE Irvine32.inc

.data
	
	choiceMsg BYTE "(Black = 0), (Blue = 1), (Green = 2), (Cyan = 3), (Red = 4), (Magenta = 5), ",10,13,
	"(Brown = 6), (LightGray = 7), (Gray = 8), (LightBlue = 9), (LightGreen = 10),",10,13, 
	"(LightCyan = 11), (LightRed = 12), (LightMagenta = 13), (Yellow = 14),",10,13, "(White = 15)",10,13, 0

	msg		  BYTE "Please enter a character: ", 0
	msg1	  BYTE "Please enter a first forground colour: ", 0
	msg2	  BYTE "Please enter a first background colour: ", 0

	char BYTE ?

	temp DWORD ?

	tempBackGround DWORD ?

.code
main PROC

	mov edx, OFFSET choiceMsg					;
	call WriteString							;Colours
	call CrLf									;

	mov edx, OFFSET msg							;
	call WriteString							;ask for char
	call ReadChar								;
	mov char, al								;
	call WriteChar								;show what char was typed in
	call CrLf									;

	mov edx, OFFSET msg2						;
	call WriteString							;ask for first background colour
	call ReadInt								;
	mov tempBackGround, eax						;store it

	mov edx, OFFSET msg1						;
	call WriteString							;ask for first forground colour
	call ReadInt								;

	mov edx, tempBackGround						;restore forground
	add edx, edx								;edx * 2
	add edx, edx								;edx * 4
	add edx, edx								;edx * 8
	add edx, edx								;edx * 16
	add eax, edx								;eax + edx * 16		SetTextColor is now ready for use
	
	call ClrScr									;Clear screen

	call SetTextColor							;
	mov al, char								;
	call WriteChar								;write char

;******************************************************************************************************************
									
	mov ebx, 0									;the low for all ranges used are 0
	mov ecx, 499								;loop 499 times after the first

L1:

	mov eax, 200								;
	call Delay									;wait 1/5s

	mov eax, 20									;
	call randomNum								;generate random num between eax(high) and ebx(low) for rows(Y)
	mov dh, al									;

	mov eax, 40									;
	call randomNum								;generate random num between eax(high) and ebx(low) for cols(X)
	mov BYTE PTR temp, al						;
	mov dl, BYTE PTR temp						;

	call goToXY									;new position

	mov eax, 15									;
	call randomNum								;Get random background colour
	mov edx, eax								;store it
	add edx, edx								;edx * 2
	add edx, edx								;edx * 4
	add edx, edx								;edx * 8
	add edx, edx								;edx * 16

	mov eax, 15									;
	call randomNum								;Get random forground colour
	
	add eax, edx								;eax + edx * 16

	call SetTextColor							;

	mov al, char								;
	call WriteChar								;write char

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