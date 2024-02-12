INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

TITLE

; Name: 
; Date: 
; ID: 
; Description: This program reads a value for the variable littleEndian and then uses a sequence of 
;mov instructions to fill the array bigEndian with the bytes of littleEndian in reverse order

.data
    
	; data declarations go here
    bigEndian BYTE ?, ?, ?, ?
    littleEndian DWORD 12345678h
    prompt BYTE "Enter a hexadecimal number for littleEndian = ",0
    promptBig BYTE "bigEndian = ",0
    promptLittle BYTE "LittleEndian = ",0
    prompth BYTE "h, ",0
.code
main PROC

	; code goes here
    ; Display prompt and read littleEndian as a hexadecimal number
    mov edx, offset prompt
    call WriteString
    call ReadHex ;read a hexadecimal value for littleEndian
    mov littleEndian, eax

    ;fill bigEndian with the bytes of littleEndian in reverse order
    mov edx, offset promptBig
    call WriteString
    movzx eax, BYTE PTR littleEndian[3] ; accessing the most significant byte of little endian
    mov bigEndian[0], al  ; mov the byte into the arrayindex of bigEndian 
    mov ebx,1; telling writeHexB we want to print 1 byte from EAX(AL) 
    call WriteHexB; // display the value 
    mov edx, offset prompth ; only need to do this once because writestring wont change content of EDX
    call WriteString

    movzx eax, BYTE PTR littleEndian[2] ; accessing the 2nd most significant byte of little endian
    mov bigEndian[1], al  ; mov the byte into the arrayindex of bigEndian 
    call WriteHexB; // display the value 
    call WriteString

    movzx eax, BYTE PTR littleEndian[1] ; accessing the 3rd most significant byte of little endian
    mov bigEndian[2], al  ; mov the byte into the arrayindex of bigEndian 
    call WriteHexB; // display the value 
    call WriteString

    movzx eax, BYTE PTR littleEndian[0] ; accessing the 3rd most significant byte of little endian
    mov bigEndian[3], al  ; mov the byte into the arrayindex of bigEndian 
    call WriteHexB; // display the value 
    call WriteString
    ; removing the last comma and space(,)
    mov al, 8 ; move the ascii value for backspace(8) to al
    call WriteChar ; move the cursor back two position
    call WriteChar ; move the cursor back two position
    mov al, 32     ; move the ascii value for space(32) into al
    call WriteChar ; overwrite the , with backspace
    call CRLF
    mov edx, offset promptLittle
    call writestring

    ; print the value of littleEndian
    mov eax, littleEndian
    call writeHex
    
    
    ;FEDCBA98h
    call CRLF
    call CRLF
	;call DumpRegs ; displays registers in console
	exit

main ENDP
END main