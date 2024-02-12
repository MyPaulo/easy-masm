TITLE Convert Big Endian to Little Endian

; Name: 
; Date: 
; ID: 
; Description: This program takes a big endian number as input and converts it 
;to little endian format. It then displays the values of both formats on the console

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	; data declarations go here
	bigEndian BYTE 12h, 34h, 0ABh, 0CDh ; read as 12, 34, AB, CD (in hex values)
	littleEndian DWORD ?

	bigE byte "bigEndian = ",0
    littE byte "littleEndian = ",0

	spacer BYTE "h, ",0

.code
main PROC	
	; Write "bigEndian = " to the console
	mov edx, OFFSET bigE
	call WriteString

	mov AL, bigEndian
	mov ebx,1
	call WriteHexB 
	mov edx, offset spacer
	call WriteString
	mov BYTE PTR littleEndian[3],AL

	mov AL, bigEndian[1]
	;mov ebx,1
	call WriteHexB 
	call WriteString
	mov BYTE PTR littleEndian[2],AL

	mov AL, bigEndian[2]
	;mov ebx,1
	call WriteHexB 
	call WriteString
	mov BYTE PTR littleEndian[1],AL

	mov AL, bigEndian[3]
	;mov ebx,1
	call WriteHexB 
	call WriteString
	mov BYTE PTR littleEndian[0],AL
	; removing the last comma and space(,)
    mov al, 8 ; move the ascii value for backspace(8) to al
    call WriteChar ; move the cursor back two position
    call WriteChar ; move the cursor back two position
    mov al, 32     ; move the ascii value for space(32) into al
    call WriteChar ; overwrite the , with backspace
    
	call CRLF

    mov EDX, offset littE
    call WriteString
    mov EAX, littleEndian
	;call DumpRegs
    call WriteHex
	mov al, 'h'
	call WriteChar

	exit
	

main ENDP
END main
