TITLE	Jacob Culp Assignment3 Question1	(Assignment3_PartA.asm)

;This program will ask for a DWORD copy it into another DWORD as BYTES and then print them out

INCLUDE Irvine32.inc

.data

	var1 DWORD ?
	var2 DWORD ?	

	msg1 BYTE "Please enter an integer value: ", 0

	msg2_1 BYTE "The HEX value of the first DWORD is: ", 0
	msg2_2 BYTE "The BINARY value of the first DWORD is: ", 0

	msg3_1 BYTE "The HEX value of the second DWORD is: ", 0
	msg3_2 BYTE "The BINARY value of the second DWORD is: ", 0

.code
main PROC

	mov edx, OFFSET msg1						;
	call WriteString							;Ask For Number
	call ReadInt								;
	mov var1, eax								;put number in var1


	mov al, BYTE PTR [var1]						;
	mov BYTE PTR [var2], al						;Copy First BYTE

	mov al, BYTE PTR [var1 + 1]					;
	mov BYTE PTR [var2 + 1], al					;Copy Second BYTE

	mov al, BYTE PTR [var1 + 2]					;
	mov BYTE PTR [var2 + 2], al					;Copy Third BYTE

	mov al, BYTE PTR [var1 + 3]					;
	mov BYTE PTR [var2 + 3], al					;Copy Fourth BYTE


	mov edx, OFFSET msg2_1						;
	call WriteString							;
	mov eax, var1								;
	call WriteHex								;Print first DWORD in HEX
	call CrLf									;

	mov edx, OFFSET msg2_2						;
	call WriteString							;
	call WriteBin								;Print first DWORD in BINARY
	call CrLf									;


	mov edx, OFFSET msg3_1						;
	call WriteString							;
	mov eax, var2								;
	call WriteHex								;Print second DWORD in HEX
	call CrLf									;

	mov edx, OFFSET msg3_2						;
	call WriteString							;
	call WriteBin								;Print second DWORD in BINARY
	call CrLf									;

	
	exit
main ENDP
END main