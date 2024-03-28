INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

; R = (A % B) * (C / D)
.data
    varA SBYTE 14
    varB SBYTE  5
    varC SBYTE 21
    varD SBYTE 10
    R SBYTE ?
    prompt1  DB "R = (A % B) * (C / D)",0
    prompt2  DB "R = (10 % 3) * (20 / 5)",0
    prompt3  DB "R = ",0

.code
main PROC
    LEA EDX, prompt1
    call WriteString
    call CRLF
    LEA EDX, prompt2
    call WriteString
    call CRLF

    mov al, varA
    cbw ; extend AL into AH
    idiv varB ; AL=3, AH=1
    mov bl, AH ; store 1
    mov al, varC
    cbw
    idiv varD; AL=4 AH=0
    imul bl ; multiply with remainder
    mov R, al ; store the result in R

    movzx eax, R ; zero extend R to eax
    LEA EDX, prompt3
    call WriteString
    call WriteDec ; print the result

    call DumpRegs ; displays registers in console
    exit

main ENDP
END main
