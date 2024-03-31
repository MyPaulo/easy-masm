; Include necessary libraries
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

TITLE Ass4.asm 
; Name: 
; Date: 
; ID: 
; Description: 

.data
    ; Declare buffers and prompts
    hexBuff BYTE 20 dup(?),0
    decBuff BYTE 11 dup(?),0
    promptdo DB "What do you want to do, Lovely? ",0
    promptValue DB "Enter a 32 bit decimal number to convert to hex: ",0
    promptHex DB "Enter a hexadecimal string to convert to binary: ",0
    promptBye DB "Thank you, Sweetey Honey Bun",0
    promptLost DB "Get Lost, you Sweetey Honey Bun",0
    promptEAX BYTE "Binary content of EAX: ", 0
    promptEBX BYTE "Hex content of EBX: ", 0

.code

; Procedure to convert hexadecimal input to binary

HexInput PROC
    ; Prompt for hexadecimal input
    mov EDX, OFFSET promptHex
    call WriteString
    ; Read hexadecimal input into buffer
    mov EDX, OFFSET hexBuff
    mov ECX, SIZEOF hexBuff
    call ReadString
    xor EAX, EAX

    begin:
        ; Convert hexadecimal to binary
        mov BL, [EDX]
        cmp BL, 'h'
        je endLetter
        cmp BL, 'A'
        jb digit
        sub BL, 37h
        shl EAX, 4
        OR AL, BL
        inc EDX
        jmp begin
        
        digit:
            sub BL, 30h
            shl EAX, 4
            OR AL, BL
            inc EDX
            jmp begin

        endLetter:
        ; Output binary result
        call CRLF
        mov EDX, OFFSET promptEAX
        call WriteString
        call WriteBin
        call CRLF
        ret
HexInput ENDP

; Procedure to convert decimal input to hexadecimal
HexOutput PROC
    mov ECX, 8
    mov ESI, OFFSET decBuff
    begin:
        ; Convert decimal to hexadecimal
        rol EBX, 4
        mov DL, BL
        and DL, 0Fh
        cmp DL, 0Ah
        jb belowTen
        add DL, 37h
        jmp next
    belowTen:
        add DL, 30h
    next:
        mov [ESI], DL
        inc ESI
    loop begin
    mov BYTE PTR[ESI], 68h
    mov EDX, OFFSET decBuff
    ; Output hexadecimal result
    call WriteString
    ret
HexOutput ENDP

; Main procedure
main PROC
     call Clrscr
    ; Prompt for operation choice
    lea EDX, promptdo
    call WriteString
    Call ReadChar
    Call WriteChar
    Call CRLF
    ; Branch based on operation choice
    cmp AL, 'W'
    je decHex
    cmp AL, 'w'
    je decHex
    cmp AL, 'R'
    je hexBin
    cmp AL, 'r'
    je hexBin
    jmp Exit1
decHex:
    ; Decimal to hexadecimal conversion
    mov EAX,0
    LEA EDX, promptValue
    call WriteString
    call ReadDec
    mov EBX, EAX
    Call CRLF
    mov EDX, OFFSET promptEBX
    call WriteString
    call HexOutput
    Call CRLF
    jmp bye
hexBin:
    ; Hexadecimal to binary conversion
    call HexInput
    jmp bye
    jmp exitP
Exit1:
    ; Exit message for invalid operation choice
    Call CRLF
    mov EDX, OFFSET promptLost
    call WriteString
    call CRLF
    jmp exitP
Bye:
    ; Exit message for successful operation
    call CRLF
    mov EDX, 0
    mov EDX, OFFSET promptBye
    call WriteString
    call CRLF
exitP:
    call CRLF
    ; Exit program
    exit
main ENDP
END main



























