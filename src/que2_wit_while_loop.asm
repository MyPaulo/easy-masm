TITLE

; Name: Paul osuji	
; Date: 
; ID: 110157511
; Description: 

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	; data declarations go here
	bigEndian BYTE 12h, 34h, 0ABh, 0CDh ; read as 12, 34, AB, CD (in hex values)
	littleEndian DWORD ?

	bigE byte "bigEndian = ",0
    littE byte "littleEndian = ",0

	spacer BYTE "h, ",0

.code
main PROC	
	; Write "bigEndian = " to the console
	mov edx, OFFSET bigE
	call WriteString

	; Move the spacer offset into EDX (to be used by the loop below)
	mov edx, OFFSET spacer

	; Set the loop counter to the number of elements in bigEndian
	; LENGTHOF operator returns the number of elements in an array.
	mov ecx, LENGTHOF bigEndian ; ECX = 4
	
	; The loop starts at 4 and decrements 1 on each iteration
	; ECX will be used to index elements in the array bigEndian.
	L1:
		; Create the index for the next element in the array
		mov ebx, LENGTHOF bigEndian
		sub ebx, ecx

		; Move the next element of bigEndian into eax
		movzx eax, [bigEndian + ebx]

		; Set the display format for WriteHexB in ebx (lookup WriteHexB procedure for more info on this)
		mov ebx, TYPE bigEndian
		call WriteHexB

		; Write the spacer (offset is already in edx)
		call WriteString

	loop L1

	; Newline
	call Crlf

	;Little endian code
    mov AL, [bigEndian]
    mov [bigEndian+7],AL
    mov AL, [bigEndian+1]
    mov [bigEndian+6],AL
    mov AL, [bigEndian+2]
    mov [bigEndian+5],AL
    mov AL, [bigEndian+3]
    mov [bigEndian+4],AL

    mov EDX, offset littE
    call WriteString
    mov EAX, [littleEndian]
    call WriteHex
	mov al, 'h'
	call WriteChar

	exit
	

main ENDP
END main
