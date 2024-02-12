TITLE  Calculate Z=(A-B)-(C-D) in Assembly

; Name: 
; Date: 
; ID: 
; Description: This program takes two input values C and D from the user and calculates Z=(A-B)-(C-D)
; using the predefined values of A and B. It then displays the values of A, B, C, D, and Z in decimal, binary, 
;and hexadecimal formats   

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	; data declarations go here
    valA SDWORD -543210 ;declared signed 32 bit value assigned to A
    valB SWORD -3210 ; declared signed 32 bit value assigned to A

    valC SDWORD ? ; to be assigned later;
    valD SBYTE  ? ; 8 bit 
    valZ SDWORD ?;

    promptC BYTE "What is the value of C: ",0
    promptConfirmC BYTE "The value of C: ",0
    promptD BYTE "What is the value of D: ",0
    promptConfirmD BYTE "The value of D: ",0

    promptDisplay BYTE "Z=(A-B)-(C-D)",0

    promptSpacing BYTE "   :   ",0

.code
main PROC

	; code goes here
    mov EDX, offset promptC
    call WriteString ;output the value using this function;
    call ReadInt
    mov valC, EAX
    mov EDX, offset promptConfirmC
    call WriteString
    call WriteInt

    call CRLF

    mov EDX, offset promptD
    call WriteString ;output the value using this function;
    call ReadInt
    mov valD, AL
    mov EDX, offset promptConfirmD
    call WriteString
    call WriteInt
    call CRLF
    
    ;mathematical expression
    
    mov EAX, valA 
    movsx EDX, valB ; move Sword into SDword EDX
    sub EAX,EDX ; subtract A - B 

    mov EBX, valC
    movsx EDX, valD ; move SBYTE into SDword EDX
    sub EBX, EDX  ; subtract C- D

    sub EAX,EBX ; final subtraction (A-B)-(C-D)

    mov valZ,EAX ; move the final value into Z



    mov EDX, offset promptDisplay
    call WriteString

    call CRLF
    mov EAX, valA
    call WriteInt
    mov EDX,offset promptSpacing
    call WriteString
    movsx EAX, valB
    call WriteInt
    mov EDX,offset promptSpacing
    call WriteString

    mov EAX, valC
    call WriteInt
    mov EDX,offset promptSpacing
    call WriteString
    movsx EAX, valD
    call WriteInt
    call CRLF
    call CRLF

    mov EAX, valZ
    call WriteBin
    call CRLF
    call WriteInt
    call CRLF
    call WriteHex
    call CRLF

    
	;call DumpRegs ; displays registers in console
	exit

main ENDP
END main
