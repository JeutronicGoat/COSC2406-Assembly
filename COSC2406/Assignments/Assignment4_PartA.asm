TITLE	Jacob Culp Assignment4 Question1 Oct. 28th	(Assignment4_PartA.asm)

;This program read data from a file and print the hidden message

INCLUDE Irvine32.inc

.data
	
	msg BYTE "Please enter the file name: ", 0 

	letters BYTE 26 DUP(?)
	index	BYTE 27 DUP(?)

	fileName BYTE 50 DUP(?)
	fileHandle DWORD ?

.code
main PROC
	
	mov edx, OFFSET msg								;
	call WriteString								;ask for file name

	mov edx, OFFSET fileName						;
	mov ecx, LengthOF fileName						;max size of input
	call ReadString									;gather file name

	call OpenInputFile								;Open file
	mov fileHandle, eax								;save fileHandle

	mov edx, OFFSET letters							;start of letterArray
	mov ecx, 26										;read the first 26 bytes
	call ReadFromFile								;read from file to letterArray

	mov eax, fileHandle								;ensuring fileHandle is in eax

	mov edx, OFFSET index							;start of the index array
	mov ecx, 27										;read the next 27 bytes
	call ReadFromFile								;read from file to index array

	mov edx, OFFSET letters							;start of letters array
	mov ecx, 26										;loop 26 times
	movzx esi, [index + 26]							;beginning position

L1:
	
	mov al, [letters + esi]							;al = char at letters(esi)
	call WriteChar									;print char
	movzx esi, BYTE PTR [index + esi]				;find next position

	Loop L1

	call CrLf
	call CloseFile									;close file

	exit
main ENDP
END main