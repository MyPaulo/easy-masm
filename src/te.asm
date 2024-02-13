INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib



TITLE Program reverse name   

.data
prompt BYTE "Enter your last name in lowercase ",0
myName BYTE 50 DUP(0)
nameSize DWORD ?

.code
main PROC
    LEA EDX, prompt
    call WriteString
    LEA EDX, myName
    mov ECX, (SIZEOF myName) - 1
    call ReadString
    mov nameSize, EAX

    mov ECX, nameSize
    mov esi, 0










	call DumpRegs
	exit
main ENDP
END main