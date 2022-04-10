INCLUDE Irvine32.inc

.data

	radius	REAL4	?
	circ	REAL4  ?
	two	DWORD	2

	prompt	BYTE	"Please enter a radius (0 to exit): ", 0
	msg		BYTE	"Circumference of the circle is ", 0

	noNeg	BYTE	"No negative radius values allowed!", 0
	bye		BYTE	"I'm outta here!!!!", 0
.code
main PROC
	FINIT

L1:
	mov edx, OFFSET prompt
	call WriteString
	call ReadFloat
	
	fldz					;compare float to zero
	FCOMP					; older FCOM instruction
	FNSTSW AX
	SAHF
	je goodbye				;jmp if equal to goodbye
	
	fldz					;compare float to zero
	fcomip ST(0), ST(1)		; uses the new FCOMI instruction
	jnb calc					; jump if positive to calc stuff

	mov edx, OFFSET noNeg
	call WriteString
	call Crlf
	ffree ST(0)
	jmp L1
calc:						; calc stuff starting point
	fst radius
	mov edx, OFFSET msg
	call WriteString
	fsqrt

	fldPI
	fmul
	fimul two

	call WriteFloat
	call CrLf
	ffree st(0)
	;fstp circ

	jmp L1

goodbye:
	ffree ST(0)
	mov edx, OFFSET bye
	call WriteString
	call CrLf

	call showFPUStack

	exit
main ENDP

END main

