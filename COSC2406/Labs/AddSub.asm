TITLE Add and Subtract			(AddSub.asm)

;This program adds and subtracts 32-bit intergers.

INCLUDE Irvine32.inc

.code
main PROC

		mov		eax, 20200h					;EAX = 20200h
		call	WriteDec
		call	CrLf
		sub		eax, 20200h					;EAX = 10100h
		call	WriteHex
		call	CrLf
		add		eax, 20200h					;EAX = 40500h
		call	WriteBin
		call	CrLf
		call	DumpRegs
		call	WriteInt
		call	CrLf

		exit

main ENDP
END main