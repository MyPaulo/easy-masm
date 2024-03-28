COMMENT!
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
    aName  Byte "Abraham Lincoln",0
    nameSize = ($-aName) - 1

.code
main PROC

;push the name on the stack
    mov ecx, nameSize
    mov esi, 0
L1: movzx eax, aName[esi] ; get character
    push eax ; push eax on stack
    inc esi
    loop L1
; Pop the name from the stack, in reverse,
; and store in the aName array.
    mov ecx, nameSize
    mov esi, 0
L2: pop eax ;get character
    mov aName[esi], al
    inc esi
    loop L2
; Display the name.
    mov edx, offset aName
    call WriteString
    call CRLF
    call CRLF


	;call DumpRegs ; displays registers in console
	exit

main ENDP
END main 
 !
COMMENT\
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    aName  Byte 50 DUP(0) ; allocate space for 50 characters
    nameSize DWORD ?

.code
main PROC
    ; Get the string from the user
    mov edx, OFFSET aName
    mov ecx, SIZEOF aName
    call ReadString
    mov nameSize, eax ; save the size of the string

    ; Push the string onto the stack
    mov ecx, nameSize
    mov esi, 0
L1: movzx eax, aName[esi] ; get character
    push eax ; push eax on stack
    inc esi
    loop L1

    ; Pop the string from the stack, in reverse, and store in the aName array.
    mov ecx, nameSize
    mov esi, 0
L2: pop eax ; get character
    mov aName[esi], al
    inc esi
    loop L2

    ; Display the string.
    mov edx, OFFSET aName
    call WriteString
    call CRLF
    call CRLF

    exit
main ENDP
END main
\

COMMENT }
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    numList DWORD 4 DUP(0) ; allocate space for 50 integers
    numCount DWORD 0

.code
main PROC
    ; Get the integers from the user
    mov ecx, SIZEOF numList / 4 ; number of integers
    mov edi, OFFSET numList ; address of the array
L1: call ReadInt ; read an integer
    mov [edi], eax ; store the integer
    add edi, 4 ; move to the next element
    inc numCount ; increment the count
    loop L1

    ; Push the integers onto the stack
    mov ecx, numCount
    mov edi, OFFSET numList
L2: mov eax, [edi] ; get integer
    push eax ; push eax on stack
    add edi, 4 ; move to the next element
    loop L2

    ; Pop the integers from the stack, in reverse, and display them.
    mov ecx, numCount
L3: pop eax ; get integer
    call WriteInt ; display the integer
    call CRLF
    loop L3

    exit
main ENDP
END main
}

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.code
main PROC
    ; Assign integer values to EAX, EBX, ECX, EDX, ESI, and EDI
    mov eax, 1
    mov ebx, 2
    mov ecx, 3
    mov edx, 4
    mov esi, 5
    mov edi, 6
  
    ; Use PUSHAD to push the general-purpose registers on the stack
    pushad

    ; Using a loop, pop each integer from the stack and display it on the screen
    mov ecx, 8 ; There are 8 general-purpose registers
L1:
    pop eax ; Pop the top value from the stack
    call WriteInt ; Display the value
    call Crlf ; Newline
    loop L1 ; Repeat until ECX is 0
    call DumpRegs
    exit
main ENDP

END main
