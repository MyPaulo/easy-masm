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
    Vector DWORD 20 DUP(?) ; vector array of maxsize 20
    V_size DWORD ?
    user_choice DWORD ?

    ;All prompt definitions
    promptDo DB "what do you want to do now?> ",0
    promptSizeOfV DB "What is the size N of vector? > ",0
    promptValue1 DB "What are the ",0
    promptValue2 DB " values in Vector? > ",0
    promptSizeN DB "Size of Vector is N = ",0
    promptVector DB "Vector = ",0
    promptStack DB " Stack is empty",0
    promptBeforeArraytoStack DB "Vector is before ArrayToStack",0
    promptAfterArraytoStack DB "Stack is after ArrayToStack",0
    promptAfterStackToArray DB "Vector is after StackToArray",0
    promptBeforeStackReverse DB "Vector is before StackReverse",0
    promptAfterStackReverse DB "Vector is after StackReverse",0
    promptErrorStackEmpty DB "Error - Stack is empty: Cannot perform StackToArray",0

.code




main PROC

	; code goes here
    mov EDX, OFFSET promptDo
    call WriteString
    call ReadInt
    mov user_choice, EAX

    cmp user_choice, 0
    je CreatVector



CreatVector:
    mov EDX, OFFSET promptSizeOfV
    call WriteString
    call ReadInt
    mov V_size, EAX

    ;Prompt for the size of Vector
    mov EDX, OFFSET promptValue1
    call WriteString
    Call WriteDec
    mov EDX, OFFSET promptValue2
    call WriteString

    mov ECX, V_size
    mov EDI, offset Vector

    L1:
        call ReadInt
        mov [EDI], EAX
        add EDI, TYPE SDWORD
        loop L1
        call CRLF
    
    mov EDX, OFFSET promptSizeN
    Call WriteString
    Call WriteDec
    mov ECX, V_size
    call CRLF
   
    mov EDX, OFFSET promptVector
    Call WriteString
    L2:
        mov EBX, V_size
        sub EBX, ECX
        mov EAX, Vector[TYPE DWORD * EBX]
        call WriteDec
        mov AL, 32
        call WriteChar 
        loop L2

main ENDP
END main
