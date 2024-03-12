TITLE

; Name: 
; Date: 
; ID: 
; Description: 

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data

    ;data declarations go here
    Vector DWORD 4, 32, 74, 3

.code

ArrayToStack PROC
    mov ecx, 4
    pop edx 
    push eax
    push edx
    L1:
        mov ebx, 4
        sub ebx, ecx
        lea eax, Vector
        push dword ptr [eax + ebx * 4]
        loop L1
    ret

ArrayToStack ENDP


main PROC

    ;code goes here
    call ArrayToStack
    call DumpRegs

    mov ecx, 4

    L2:
        pop eax
        call WriteDec
        call Crlf
        loop L2

    exit

main ENDP
END main