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
	arr DWORD 10,25,45,3,37,66
	len = ($ - arr) / 4 ; return number of element in array
	;count DWORD 6
	
.code
main PROC
	; code goes here
	mov EAX,0
	mov ECX, len
	mov EBX, offset arr
	next:
	add EAX, [EBX]
	add EBX, type arr ; add ebx, 4
	loop next
	call WriteDec
	call DumpRegs ; displays registers in console
	exit

main ENDP
END main
