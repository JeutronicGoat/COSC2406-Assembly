TITLE	Subtract Two Numbers	(SubTwoNums.asm)

;This program collects two numbers and subtracts the second from the first 

INCLUDE Irvine32.inc

.data
	prompt	BYTE	"Please enter a number: ", 0
	msg	    BYTE	"The answer of 3 * NUM2 + 20 - 2 * NUM1 is ", 0

	val1	Dword	20

.code
main PROC
		
		;Data
		mov		edx, OFFSET prompt			;Ask the question				val1 = ebx		val2 = ecx
		call	WriteString
		call	ReadInt						;collect first num
		mov		ebx, eax					;store first num in ebx
		call	WriteString					;Ask again
		call	ReadInt						;collect second num
		mov		ecx, eax					;store second num in ecx

		;Math 
		mov		ecx, eax					;both ecx = eax = val1
		add     ecx, ecx					;ecx * 2
		add		ecx, eax					;ecx += eax
		add		ecx, val1					;ecx += 20			We now have 3 * NUM2 + 20
		add		ebx, ebx					;ebx * 2			We now have 2 * NUM1
		sub		ecx, ebx					;ecx -= ebx			We now have 3 * NUM2 + 20 - 2 * NUM1

		mov		edx, OFFSET msg				;print opening text
		call	WriteString
		xchg	eax, ecx					;put answer in eax
		call	WriteInt					;print answer
		call	CrLf

		exit
main ENDP
END main