TITLE	Jacob Culp Assignment3 Question5	(Assignment3_PartE.asm)

;This program Will Calculate a modified Fibinacci Sequence of 30 numbers

INCLUDE Irvine32.inc

.data

	fibArray DWORD 30 DUP(?)

.code
main PROC
	
	mov esi, OFFSET fibArray						;Start of fibArray
	mov eax, 1										;
	mov [esi], eax									;F(0) = 1
	add esi, TYPE fibArray							;Next Position
	mov eax, 3										;
	mov [esi], eax									;F(1) = 3
	add esi, TYPE fibArray							;Next Position
	mov eax, 2										;
	mov [esi], eax									;F(2) = 2
	add esi, TYPE fibArray							;Next Position
	mov eax, 5										;
	mov [esi], eax									;F(3) = 5
	add esi, TYPE fibArray							;Next Position

	mov ecx, 26										;Loop 25 because formula only affect F at > 4

L1:
	
	mov eax, [esi - (1 * TYPE fibArray)]			;eax = value of position - 1	F(n-1)
	mov ebx, [esi - (4 * TYPE fibArray)]			;ebx = value of position - 4	F(n-4)

	add ebx, ebx									;2 * F(n-4)
	add eax, ebx									;F(n-1) + 2 * F(n-4)

	mov [esi], eax									;Store eax into fibArray
	add esi, TYPE fibArray							;Next Position

	Loop L1

;************************************************************************************************

.data

	msg BYTE ", ", 0

.code

	mov edx, OFFSET msg
	mov ecx, 29										;Loop 29 times, Manually print 
													;the lst number with no comma
	mov esi, OFFSET fibArray
	
L2:

	mov eax, [esi]									;
	call WriteDec									;
	call WriteString								;Write: "#, "

	add esi, TYPE fibArray							;Next Position

	Loop L2

	mov eax, [esi]									;
	call WriteDec									;Write Last Number

	call CrLf

	exit
main ENDP
END main