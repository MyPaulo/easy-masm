; Include necessary libraries
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

TITLE Ass4.asm 
; Name: Paul Osuji, Temirlan Rashid,
; Date: 
; ID: 110157511
; Description: 

.data
    ; Declare buffers and prompts
    hexBuff BYTE 20 dup(?),0
    decBuff BYTE 20 dup(?),0  ; Increase the buffer size to accommodate larger decimal inputs
    promptdo DB "What do you want to do, Lovely? ",0
    promptValue DB "Enter a 64 bit decimal number to convert to hex: ",0  ; Update the prompt message
    promptHex DB "Enter a hexadecimal string to convert to binary: ",0
    promptBye DB "Thank you, Sweetey Honey Bun",0
    promptLost DB "Get Lost, you Sweetey Honey Bun",0
    promptEAX BYTE "Binary content of EAX: ", 0

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
    mov ECX, 16  ; Set the loop counter for 16 digits (64 bits / 4 bits per digit)
    mov ESI, OFFSET decBuff
    begin:
        ; Convert decimal to hexadecimal
        rol rbx, 4  ; Use RBX instead of EBX for 64-bit operations
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
    mov RAX,0  ; Use RAX instead of EAX for 64-bit operations
    LEA EDX, promptValue
    call WriteString
    call ReadDec  ; Update to ReadDec64 to handle 64-bit inputs
    mov RBX, RAX  ; Use RBX instead of EBX for 64-bit operations
    call HexOutput
    jmp bye
hexBin:
    ; Hexadecimal to binary conversion
    call HexInput
    jmp bye
    jmp exitP
Exit1:
    ; Exit message for invalid operation choice
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
