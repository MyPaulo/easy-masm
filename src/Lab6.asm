
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib



TITLE Program reverse name         

; This program reverses a string.



.data
prompt BYTE "Enter your last name in lowercase ",0
myName BYTE 50 DUP(0)
nameSize DWORD ?

.code
main PROC

	mov  edx,OFFSET prompt	
	call WriteString
	mov edx, OFFSET myName
	mov ecx, (SIZEOF myName) - 1
	call ReadString	
	mov nameSize, eax
	
	; Push the name on the stack.
	mov ecx,nameSize
	mov esi,0
	L1:	movzx eax,myName[esi]	; get character
		push eax	; push on stack
		inc esi
		Loop L1

	; Pop the name from the stack, in reverse,
	; convert to uppercase and store in the myName array.
		mov ecx,nameSize
		mov esi,0

	L2:	pop eax	; get character
		sub al, 20h
		mov myName[esi],al	; store in string
		inc esi
		Loop L2

	; Display the name.
		mov edx,OFFSET myName
		call Writestring
		call Crlf
		call DumpRegs
	exit
main ENDP
END main