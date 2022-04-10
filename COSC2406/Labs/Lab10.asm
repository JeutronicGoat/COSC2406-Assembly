TITLE	Lab9	(Lab9.asm)

;This program ...

INCLUDE Irvine32.inc

.data
	
	rectWidth			REAL4	?
	rectHeight			REAL4	?
	rectArea			REAL4	?
	rectPerim			REAL4	?
	WidthHieghtRatio	REAL4	?

	msg1 BYTE "Please enter the rectangle width: ", 0
	msg2 BYTE "Please enter the rectangle height: ", 0
	msg3 BYTE "The area of the rectangle is: ", 0
	msg4 BYTE "The perimeter of the rectangle is: ", 0
	msg5 BYTE "The ratio of width/height is: ", 0

.code
main PROC
	
	mov edx, OFFSET msg1				;
	call WriteString					;
	call ReadFloat						;

	fldz								;
	fcomip ST(0), ST(1)					;compare num 1 to 0
	jb next								;
	fchs								;

next:
	fstp rectWidth						;store width
	
	mov edx, OFFSET msg2				;
	call WriteString					;
	call ReadFloat						;

	fldz								;
	fcomp								;compare num 2 to 0
	fnstsw ax							;
	sahf								;
	jb next2						    ;
	fchs								;
next2:
	fst rectHeight						;

	call Area							;

	call Perim							;

	call Ratio							;

	call showFPUstack					;
	call CrLf							;

	exit
main ENDP

Area PROC
	
	fmul rectWidth						;w * h
	mov edx, OFFSET msg3				;
	call WriteString					;
	call WriteFloat						;
	call CrLf							;
	fstp rectArea						;

	ret
area ENDP

Perim PROC
	LOCAL factor : DWORD

	mov factor, 2						;
	
	fld   rectHeight					;h
	fimul factor						;h * 2
	fld   rectWidth						;w 
	fimul factor						;w * 2
	fadd								;h * 2 + w * 2
	mov edx, OFFSET msg4				;
	call WriteString					;
	call WriteFloat						;
	call CrLf							;
	fstp rectPerim						;

	ret
Perim ENDP

Ratio PROC
	
	fld	 rectWidth						;w
	fdiv rectHeight						;w/h
	mov edx, OFFSET msg5				;
	call WriteString					;
	call WriteFloat						;
	call CrLf							;
	fstp WidthHieghtRatio				;

	ret
Ratio ENDP
END main