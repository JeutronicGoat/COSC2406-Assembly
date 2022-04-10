TITLE   Fibonacci Version 2 - Using Register Parameters  (FibVer2.asm)
; This is a recursive version of Fibonacci
; using registers for parameter passing

INCLUDE Irvine32.INC

.data

msg1a	BYTE	"Calculating fib(", 0
msg1b	BYTE	") - please wait...", 0dh, 0ah, 0
msg2a	BYTE	"Fib(", 0
msg2b	BYTE	") = ", 0
		
n		DWORD	40

.code

main PROC
	mov	edx, OFFSET msg1a
	call WriteString

	mov eax, n
	call WriteDec
	mov edx, OFFSET msg1b
	call WriteString

	push n
	call Fib

	mov edx, OFFSET msg2a
	call WriteString
	mov ebx, n
	xchg eax, ebx
	call WriteDec
	mov edx, OFFSET msg2b
	call WriteString
	xchg eax, ebx
	call WriteDec
	call Crlf

	ret
main ENDP

;****************************************************************
Fib PROC,
	num : DWORD
	LOCAL temp: DWORD

; Receives: N on the stack
; Internally, ebx used to hold an interim value
; Returns: EAX is Fib(n-1)+Fib(n-2), Fib(0) = 0, Fib(1) = 1
;****************************************************************
	;ENTER 4, 0					;ENTER
	
	;push ebp					;ENTER
	;mov ebp, esp				;does this code
	;sub esp, 4					;

	;push ebx
	mov eax, num				;[ebp + 8]			; move n into eax

	cmp eax, 0					; base case: n=0, jmp to end and return 0
	je fibEnd			
	cmp eax, 1					; base case: n=1, jmp to end and return 1
	je fibEnd

	dec DWORD PTR num			;[ebp + 8]				; n-1
	push DWORD PTR num			;[ebp + 8]	; save current eax = n-1
	call Fib					; calculate Fib(n-1)

	xchg eax, temp				;[ebp - 4]			; use ebx to hold Fib(n-1)

	dec DWORD PTR num			;[ebp + 8]				; n-2
	push DWORD PTR num			;[ebp + 8]
	call Fib					; calculate Fib(n-2)

	add eax, temp				;[ebp - 4]			; add Fib(n-1) to Fib(n-2)

fibEnd:


	;mov esp, ebp				;LEAVE 
	;pop ebp					;does this code

	;LEAVE						;LEAVE
	ret	;4						; return answer in eax
fib ENDP

END main