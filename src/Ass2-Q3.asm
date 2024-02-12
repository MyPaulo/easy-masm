INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    buff BYTE 129 DUP(0)  ; Array for 128 characters + null terminator
    promptAsk BYTE "Enter a string of at most 128 characters: ", 0
    upperCaseCount DWORD 0
    totalCount DWORD 0
    promptDisplay BYTE "Here it is, with all lowercases and uppercases flipped, and in reverse order:", 0
    promptUpper BYTE "There are ", 0
    promptUpper1 BYTE " upper-case letters after conversion ", 0
    promptTotal BYTE "There are ", 0
    promptTotal1 BYTE " characters in the string ", 0

.code
main PROC
    ; Print the prompt
    mov EDX, offset promptAsk
    call WriteString
    ; Read the string from the user
    mov EDX, offset buff
    mov ECX, sizeof buff - 1  ; Include null terminator
    call ReadString
    mov totalCount, EAX  ; Store count
    ; Process the string: convert lower-case to upper-case and vice versa, and count the number of upper-case letters
    mov ECX, offset buff
proLoop:
    mov AL, [ECX]
    cmp AL, 0
    je endProLoop  ; If we've reached the end of the string, jump to endProLoop
    cmp AL, 'a'
    jl checkUpper  ; If the character is not a lower-case letter, jump to checkUpper
    cmp AL, 'z'
    jg checkUpper  ; If the character is not a lower-case letter, jump to checkUpper
    sub AL, 32  ; Convert to upper case
    inc upperCaseCount  ; Increment the count of upper-case letters
    jmp storeChar  ; Jump to storeChar to save the converted character
checkUpper:
    cmp AL, 'A'
    jl nextChar  ; If the character is not an upper-case letter, jump to nextChar
    cmp AL, 'Z'
    jg nextChar  ; If the character is not an upper-case letter, jump to nextChar
    add AL, 32  ; Convert to lower case
storeChar:
    mov [ECX], AL  ; Save the converted character
nextChar:
    inc ECX  ; Move to the next character
    jmp proLoop  ; Repeat the loop
endProLoop:
    ; Print the reversed string
    call CRLF
    dec ECX  ; Point to the last character
    mov edx, offset promptDisplay
    call WriteString
    call CRLF
printLoop:
    cmp ECX, offset buff
    jl endPrintLoop  ; If we've reached the beginning of the string, jump to endPrintLoop
    mov AL, [ECX]
    call WriteChar  ; Print the character
    dec ECX  ; Move to the previous character
    jmp printLoop  ; Repeat the loop
endPrintLoop:
    ; Print the counts
    call CRLF
    mov EDX, offset promptUpper
    call WriteString
    mov EAX, upperCaseCount
    call WriteDec  ; Print the count of upper-case letters
    mov EDX, offset promptUpper1
    call WriteString
    call CRLF
    mov EDX, offset promptTotal
    call WriteString
    mov EAX, totalCount
    call WriteDec  ; Print the total count of characters
    mov EDX, offset promptTotal1
    call WriteString
    call CRLF
    ; Display the register values
    call DumpRegs
    exit
main ENDP
END main
