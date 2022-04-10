TITLE Rotate Examples          (RotateThis.asm)
; This program (when completed) will demonstrate the shift and rotate operations


INCLUDE Irvine32.inc

.data
	
	msg BYTE "Enter a number to rotate: ", 0


.code
main PROC

;******************************************************  collect a number from the user

	mov edx, OFFSET msg
	call WriteString
	call ReadInt



;******************************************************  demonstrate SHL ax, 2
	push eax						; save user value on stack

	mov ebx, 2						;print 2 bytes
	mov bh, 0						;BH - 0 = SHL
	mov ecx, 2						;ecx shows shift is 2 
	call BinaryPrintRotateInfo		;print initial values 

	SHL ax, 2						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value


;******************************************************  demonstrate SHR AL, 4
	push eax						; save user value on stack

	mov ebx, 1						;print 1 bytes
	mov bh, 1						;BH - 1 = SHR
	mov ecx, 4						;ecx shows shift is 4 
	call BinaryPrintRotateInfo		;print initial values 

	SHR al, 4						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value
;******************************************************  demonstrate SAL AX, 2
	push eax						; save user value on stack

	mov ebx, 2						;print 2 bytes
	mov bh, 2						;BH - 2 = SAL
	mov ecx, 2						;ecx shows shift is 2 
	call BinaryPrintRotateInfo		;print initial values 

	SAL ax, 2						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value
;******************************************************  demonstrate SAR AL, 4
	push eax						; save user value on stack

	mov ebx, 1						;print 1 bytes
	mov bh, 3						;BH - 3 = SAR
	mov ecx, 4						;ecx shows shift is 4 
	call BinaryPrintRotateInfo		;print initial values 

	SAR al, 4						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value
;******************************************************  demonstrate ROL EAX, 10
	push eax						; save user value on stack

	mov ebx, 4						;print 4 bytes
	mov bh, 4						;BH - 4 = ROL
	mov ecx, 10						;ecx shows shift is 10 
	call BinaryPrintRotateInfo		;print initial values 

	ROL eax, 10						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value
;******************************************************  demonstrate ROR AX, 14
	push eax						; save user value on stack

	mov ebx, 2						;print 2 bytes
	mov bh, 5						;BH - 5 = ROR
	mov ecx, 14						;ecx shows shift is 14 
	call BinaryPrintRotateInfo		;print initial values 

	ROR ax, 14						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value
;******************************************************  demonstrate RCL EAX, 10
	push eax						; save user value on stack

	mov ebx, 4						;print 4 bytes
	mov bh, 6						;BH - 6 = RCL
	mov ecx, 10						;ecx shows shift is 10 
	call BinaryPrintRotateInfo		;print initial values 

	RCL eax, 10						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value
;******************************************************  demonstrate RCR AX, 14
	push eax						; save user value on stack

	mov ebx, 2						;print 2 bytes
	mov bh, 7						;BH - 7 = RCR
	mov ecx, 14						;ecx shows shift is 14 
	call BinaryPrintRotateInfo		;print initial values 

	RCR ax, 14						;perform actual operation

	call SetBHToCarry				;set BH to carry

	call BinaryPrintWithCarry		;print results

	pop eax							;restore original user value
 			
	exit
main ENDP


;******************************************************************
SetBHToCarry PROC 
; RECEIVES:  carry flag set or not set
; RETURNS:   bh = 0 if no carry and 1 if carry set
; Preserves all registers except ebx
;******************************************************************
	
	jc Done
	mov bh, 0
	ret
Done:
	mov bh, 1
	ret
SetBHToCarry ENDP 


;******************************************************************
BinaryPrintRotateInfo PROC USES eax ebx ecx edx
; RECEIVES: eax = unrotated binary number to print
;           bh  = rotate type
;		{0=SHL, 1=SHR, 2=SAL, 3=SAR, 4=ROL, 5=ROR, 6=RCL, 7=RCR}
;           bl  = number of bytes to print from eax
;			ecx = number of bits to shift
; RETURNS:  nothing
; Preserves everything
;******************************************************************
.data
	bpriMsg1	BYTE	"Unrotated value: ",0
	bpriMsg2	BYTE	"     SHL by ", 0
	bpriMsg3	BYTE	"     SHR by ", 0
	bpriMsg4	BYTE	"     SAL by ", 0
	bpriMsg5	BYTE	"     SAR by ", 0
	bpriMsg6	BYTE	"     ROL by ", 0
	bpriMsg7	BYTE	"     ROR by ", 0
	bpriMsg8	BYTE	"     RCL by ", 0
	bpriMsg9	BYTE	"     RCR by ", 0

.code   
	mov edx, OFFSET bpriMsg1
	call WriteString
	
	push ebx
	mov bh, 0
	call WriteBinB
	pop ebx
	
	mov edx, OFFSET bpriMsg2
	cmp bh, 0
	je bpriPrint
	mov edx, OFFSET bpriMsg3
	cmp bh, 1
	je bpriPrint
	mov edx, OFFSET bpriMsg4
	cmp bh, 2
	je bpriPrint
	mov edx, OFFSET bpriMsg5
	cmp bh, 3
	je bpriPrint
	mov edx, OFFSET bpriMsg6
	cmp bh, 4
	je bpriPrint
	mov edx, OFFSET bpriMsg7
	cmp bh, 5
	je bpriPrint
	mov edx, OFFSET bpriMsg8
	cmp bh, 6
	je bpriPrint
	mov edx, OFFSET bpriMsg9
bpriPrint:
	call WriteString	
	
	mov eax, ecx
	call WriteDec
	call Crlf

	ret
BinaryPrintRotateInfo ENDP



;******************************************************************
BinaryPrintWithCarry PROC USES eax ebx edx
; RECEIVES: eax = rotated binary number to print
;           bh  = 1 if rotate into carry, 0 = no rotate into carry
;           bl  = number of bytes to print from eax
; RETURNS:  nothing
; Preserves everything
;******************************************************************
.data
	bpwcMsg1	BYTE	"Rotated value:   ",0
	bpwcMsg2	BYTE	"     Carry is ON", 0dh, 0ah, 0
	bpwcMsg3	BYTE	"     Carry is OFF", 0dh, 0ah, 0
.code   
	mov edx, OFFSET bpwcMsg1
	call WriteString
	
	push ebx
	mov bh, 0
	call WriteBinB
	pop ebx
	
	mov edx, OFFSET bpwcMsg3
	cmp bh, 0
	je bpwcSkip1
	mov edx, OFFSET bpwcMsg2
bpwcSkip1:
	call WriteString	
	call Crlf
	ret
BinaryPrintWithCarry ENDP

END main