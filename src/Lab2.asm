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
    val1 dword 4040h
    val2 word 1555h
    val3 byte "Hello World", 0
.code

main PROC

	; program syntax here
	mov EDX, offset val3
	call WriteString ; display hellword  
	call crlf  ; space or \n  

    mov eax,val1
    add ax, val2
	;call DumpRegs ; displays registers in console

    mov cx, val2;
    sub ecx, 500h
    ;call DumpRegs ; displays registers in console

    mov ebx, 3000h
    add eax, ebx
    sub ax, cx
    add val2, cx

    mov eax, 111h
    add val1,eax

    call DumpRegs
	exit

main ENDP
	; insert additional procedure here
    
END main