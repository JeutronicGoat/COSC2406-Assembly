TITLE	Jacob Culp Assignment3 Question3	(Assignment3_PartC.asm)

;This program ...

INCLUDE Irvine32.inc

.data

	msg1 BYTE "Please enter a unsigned value for P: ", 0
	msg2 BYTE "Please enter signed value for Q: ", 0
	msg3 BYTE "Please enter unsigned value for R: ", 0
	msg4 BYTE "Please enter signed value for S: ", 0
	msg5 BYTE "Please enter unsigned value for T: ", 0

	P DWORD  ?
	Q SDWORD ?
	R DWORD  ?
	S SDWORD ?
	T DWORD  ?

.code
main PROC
	
	mov edx, OFFSET msg1						;
	call WriteString							;Ask For #
	call ReadDec								;
	mov P, eax									;Store # in P

	mov edx, OFFSET msg2						;
	call WriteString							;Ask For #
	call ReadInt								;
	mov Q, eax									;Store # in Q

	mov edx, OFFSET msg3						;
	call WriteString							;Ask For #
	call ReadDec								;
	mov R, eax									;Store # in R

	mov edx, OFFSET msg4						;
	call WriteString							;Ask For #
	call ReadInt								;
	mov S, eax									;Store # in S

	mov edx, OFFSET msg5						;
	call WriteString							;Ask For #
	call ReadDec								;
	mov T, eax									;Store # in T

;***************************************************************************

	mov eax, T									;T
	add eax, eax								;2T
	add eax, eax								;eax = 4T

	mov edx, Q									;Q
	add edx, Q									;2Q
	add edx, Q									;edx = 3Q

	mov ebx, P									;
	sub ebx, edx								;ebx = (P - 3Q)

	add eax, ebx								;eax = 4T + (P - 3Q)

	mov edx, R									;R
	add edx, R									;edx = 2R

	mov ebx, S									;
	add ebx, edx								;ebx = (S + 2R)

	sub eax, ebx								;eax = 4T + (P - 3Q) - (S + 2R)

;**********************************************************************************

.data

	msg6 BYTE "4T + (P - 3Q) - (S + 2R) = ", 0


.code

	mov edx, OFFSET msg6						;
	call WriteString							;
	call WriteInt								;Write: 4T + (P - 3Q) - (S + 2R) = 'Answer'


	exit
main ENDP
END main