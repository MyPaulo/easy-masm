INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


TITLE test.asm 

; Program Description: This program adds and substracts 32 bit registers
; Author: 
; Creation Date: 
; Revisions: 
; Date: 

.data
	; data or variable declarations go here
    myArray WORD 10h,22AAH,35,01111011b,40h
	myArraySize DWORD ?
	myByte1 BYTE 'a';
	myByte2 BYTE ?
	myArray2 SDWORD 10 DUP(-76);
    

.code
main PROC

	mov EAX, SIZEOF myArray;
	call WriteDec
	call CRLF
	mov EAX, LENGTHOF myArray;
	call WriteHex
	mov AL, myByte1
	sub AL,20h
	;call WriteChar
	;call CRLF
	;call WriteHex
	mov myByte2,AL

    call DumpRegs
	exit

main ENDP
	; insert additional procedure here
END main