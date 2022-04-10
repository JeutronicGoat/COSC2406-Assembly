TITLE	Jacob Culp Assignment7 Question1 Nov. 22nd	(Assignment7_PartA.asm)

;This program finds the area and volume of a rhombicosidodecahedron
;And the volume and area of its circumsphere and midshpere

INCLUDE Irvine32.inc

.data
	
	msg			 BYTE	"Please enter an edge length (0 = exit): ", 0
	goodByeMsg	 BYTE	"GoodBye!!!", 0
	errorMsg	 BYTE	"The value entered is invalid!!!", 0
	romAreaMsg   BYTE	"The surface area of the Rhombicosidodecahedron          = ", 0
	romVolumeMsg BYTE   "The volume of the Rhombicosidodecahedron                = ", 0
	circumRadius BYTE	"The circumsphere radius for this Rhombicosidodecahedron = ", 0
	midRadius	 BYTE	"The midsphere radius for this Rhombicosidodecahedron    = ", 0
	circumVolume BYTE	"The volume of the circumsphere                          = ", 0
	midVolume	 BYTE	"The volume of the midsphere                             = ", 0

	edgeValue	 REAL4	?
	circumRadVal REAL4  ?
	midRadVal	 REAL4  ?
	temp		 REAL4  ?
	intValues	 DWORD  5, 3, 10, 25, 30, 1, 60, 29, 11, 4, 2

.code
main PROC
	
L1:
	mov edx, OFFSET msg								;
	call WriteString								;
	call ReadFloat									;
	fst  edgeValue									;
	call CrLf										;

	fldz											;compare float to zero
	fcomip ST(0), ST(1)								;
	je exitLoop										;value = 0 = exit
	jb validValue									;value < 0 = invalid value

;********************************************************************************

	mov edx, OFFSET errorMsg						;Negaitve value was entered
	call WriteString								;
	call CrLf										;
	call CrLf										;
	ffree ST(0)										;
	jmp L1											;

;********************************************************************************
;[intValues]		= 5
;[intValues + 4]	= 3
;[intValues + 8]	= 10
;[intValues + 12]	= 25
;[intValues + 16]	= 30
;[intValues + 20]	= 1
;[intValues + 24]	= 60
;[intValues + 28]	= 29
;[intValues + 32]	= 11
;[intValues + 36]	= 4
;[intValues + 40]	= 2
;********************************************************************************

validValue:
	
	fmul  ST(0), ST(0)								;e^2
	fild  [intValues]								;5
	fsqrt											;sqrt(5)
	fimul [intValues + 8]							;10 * sqrt(5)
	fiadd [intValues + 12]							;25 + 10*sqrt(5)
	fsqrt											;sqrt(25 + 10*sqrt(5))
	fimul [intValues + 4]							;3 * sqrt(25 + 10*sqrt(5))
	fild  [intValues + 4]							;3
	fsqrt											;sqrt(3)
	fimul [intValues]								;5 * sqrt(3)
	fstp  temp										;
	fadd  temp										;(5 * sqrt(3)) + (3 * sqrt(25 + 10*sqrt(5)))
	fiadd [intValues + 16]							;(5 * sqrt(3)) + (3 * sqrt(25 + 10*sqrt(5))) + 30
	fstp  temp										;
	fmul  temp										;((5 * sqrt(3)) + (3 * sqrt(25 + 10*sqrt(5))) + 30) * e^2

	mov edx, OFFSET romAreaMsg						;
	call WriteString								;
	call WriteFloat									;
	call CrLf										;
	ffree ST(0)										;
	
;********************************************************************************

	fld   edgeValue									;
	fmul  edgeValue									;e^2
	fmul  edgeValue									;e^3
	fild  [intValues]								;5
	fsqrt											;sqrt(5)
	fimul [intValues + 28]							;29*sqrt(5)
	fiadd [intValues + 24]							;60+29*sqrt(5)
	fild  [intValues + 20]							;1
	fidiv [intValues + 4]							;1/3
	fstp  temp										;
	fmul  temp										;1/3 * (60+29*sqrt(5))
	fstp  temp										;
	fmul  temp										;(1/3 * (60+29*sqrt(5))) * e^3

	mov edx, OFFSET romVolumeMsg					;
	call WriteString								;
	call WriteFloat									;
	call CrLf										;
	ffree ST(0)										;

;********************************************************************************
	
	fld   edgeValue									;e
	fild  [intValues + 20]							;1
	fidiv [intValues + 40]							;1/2
	fstp  temp										;
	fmul  temp										;1/2 * e
	fild  [intValues]								;5
	fsqrt											;sqrt(5)
	fimul [intValues + 36]							;4*sqrt(5)
	fiadd [intValues + 32]							;11 + 4*sqrt(5)
	fsqrt											;sqrt(11 + 4*sqrt(5))
	fstp  temp										;
	fmul  temp										;1/2 * e * sqrt(11 + 4*sqrt(5))
	fst   circumRadVal								;Store value for volume later

	mov edx, OFFSET circumRadius					;
	call WriteString								;
	call WriteFloat									;
	call CrLf										;
	ffree ST(0)										;

;********************************************************************************
	
	fld   edgeValue									;e
	fild  [intValues + 20]							;1
	fidiv [intValues + 40]							;1/2
	fstp  temp										;
	fmul  temp										;1/2 * e
	fild  [intValues]								;5
	fsqrt											;sqrt(5)
	fimul [intValues + 36]							;4*sqrt(5)
	fiadd [intValues + 8]							;10 + 4*sqrt(5)
	fsqrt											;sqrt(10 + 4*sqrt(5))
	fstp  temp										;
	fmul  temp										;1/2 * e * sqrt(10 + 4*sqrt(5))
	fst   midRadVal									;Store value for volume later

	mov edx, OFFSET midRadius						;
	call WriteString								;
	call WriteFloat									;
	call CrLf										;
	ffree ST(0)										;

;********************************************************************************
	
	fld   circumRadVal								;Get r
	fmul  circumRadVal								;r^2
	fmul  circumRadVal								;r^3
	fldPI											;PI
	fstp  temp										;
	fmul  temp										;PI * r^3
	fild  [intValues + 36]							;4
	fidiv [intValues + 4]							;4/3
	fstp  temp										;
	fmul  temp										;4/3 * PI * r^3

	mov edx, OFFSET circumVolume					;
	call WriteString								;
	call WriteFloat									;
	call CrLf										;
	ffree ST(0)										;

;********************************************************************************
	
	fld   midRadVal									;Get r
	fmul  midRadVal									;r^2
	fmul  midRadVal									;r^3
	fldPI											;PI
	fstp  temp										;
	fmul  temp										;PI * r^3
	fild  [intValues + 36]							;4
	fidiv [intValues + 4]							;4/3
	fstp  temp										;
	fmul  temp										;4/3 * PI * r^3

	mov edx, OFFSET midVolume						;
	call WriteString								;
	call WriteFloat									;
	call CrLf										;
	ffree ST(0)										;

	call CrLf										;
	jmp L1											;

;********************************************************************************

exitLoop:
	mov edx, OFFSET goodByeMsg						;exit program
	call WriteString								;
	call CrLf										;
	ffree ST(0)										;
	call showFPUstack								;
	
	exit
main ENDP
END main