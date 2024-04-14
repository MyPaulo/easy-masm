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
    
	; data declarations go here
	B DWORD 7.8
	M DWORD 3.6
	N DWORD 7.1
	P DWORD ?

.code
main PROC

	; code goes here
	finit
	FLD B
	FLD N
	FADD
	FLD M
	fchs
	fmul
	FST P
	mov EAX,P
	call writefloat
	finit
	call ShowFPuStack
	

	;call DumpRegs ; displays registers in console
	exit

main ENDP
END main
