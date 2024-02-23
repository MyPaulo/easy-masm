INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

TITLE
; Name: 
; Date: 
; ID: 
; Description:  Calculate fibonacci sequence (fn-1)+(fn-2)

.data

	n0 DWORD 0
	n1 DWORD 1
	cur DWORD 0
	prompt BYTE "Enter N terms: ", 0
	fib BYTE "Fibonacci sequence with N = ", 0
	is BYTE " is ", 0
	space BYTE " ", 0

.code
main PROC

	; Clear the console
	call Clrscr
	
	; Write prompt to console
	mov edx, OFFSET prompt
	call WriteString

	; Read input from keyboard
	call ReadDec

	; Write message to console
	mov edx, OFFSET fib
	call WriteString	; write fibonacci message
	call WriteDec		; write the inputted character
	mov edx, OFFSET is
	call WriteString
	mov edx, OFFSET space	; move space offset into edx for later use

	; Set ecx as the loop counter
	mov ecx, eax
    inc ecx

	L1:
		; Write current number to console
		mov eax, cur
		call WriteDec
		call writestring	; write a space

		; Compare current number with n1
		; If current is less than n1, we know that we're at n = 0
		cmp eax, n1
		jge J1			; jump to algorithm for n>0

		; else...
		mov cur, 1 		; increase current to 1 (only executed when n = 0)
		jmp J2			; skip n>0 algorithm
		
		J1:
		; sum n0 and n1 into ebx
		mov ebx, n0
		add ebx, n1

		; move sum of n0 + n1 into current
		mov cur, ebx
		
		; move n1 into n0
		mov ebx, n1
		mov n0, ebx

		; move current into n1
		mov ebx, cur
		mov n1, ebx

		J2:
		
	loop L1

	call Crlf

	exit

main ENDP
END main







































































































































































































































































































































COMMENT ?INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

TITLE Ass2-Q1.asm

; Name: 
; Date: 
; ID: 
; Description: 

.data
    ; Declare and initialize data
    promptN BYTE "Enter N terms: ",0  ; Prompt for user input
    promptDisplay BYTE "Fibonacci sequence with N = ", 0  ; Output prompt
    fibSequencePrompt BYTE " is: ", 0  ; Output prompt

.code
main PROC
    ; Prompt user for input
    mov EDX, offset promptN
    call WriteString
    call ReadInt  ; Read user input
    inc EAX  ; Increment EAX because Fibonacci sequence starts from 0

    ; Initialize variables
    dec EAX ; Decrement EAX to account for the 0th term
    mov ECX, EAX  ; ECX is used as a counter for the loop
    mov EBX, 1    ; EBX stores the number of terms
    mov EDI, 0    ; EDI is used as an index for the fibArray
    mov esi, 0    ; ESI stores the current Fibonacci number
   
    mov edx, offset promptDisplay
    call WriteString
    mov EAX, ECX ; Print the number of terms
    call WriteDec  
    mov EDX, offset fibSequencePrompt
    call WriteString
    mov eax, 0
    call WriteDec
    mov eax, " " ; add the space character
    call WriteChar
    inc esi
    ; Generate and print the Fibonacci sequence
    fibonacciLoop:
        mov eax, ebx
        call WriteDec
        mov eax, " "
        call WriteChar
        mov eax, esi
        add esi, ebx
        mov ebx, eax
        loop fibonacciLoop

    call Crlf 
    call Crlf
    ;call DumpRegs ; Displays registers in console
    exit  ; Exit the program

main ENDP
END main
?

















