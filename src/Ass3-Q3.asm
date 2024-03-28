TITLE

; Name: Paul Osuji, Temirlan Rashid, Hassan Sajid
; Date: 13/03/2024
; ID: 110157511, 
; Description: 

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	; data declarations go here
    returnTemp DWORD ?
    Vector DWORD 20 DUP(?) ; vector array of maxsize 20
    V_size DWORD ?
    Stack_size DWORD 0 
    user_choice DWORD ?
    StackIsEmpty BYTE 1 ; default stack is empty
    ;All prompt definitions
    promptDo DB "what do you want to do now?> ",0
    promptSizeOfV DB "What is the size N of vector? > ",0
    promptValue1 DB "What are the ",0
    promptValue2 DB " values in Vector? > ",0
    promptSizeN DB "Size of Vector is N = ",0
    promptVector DB "Vector is ",0
    promptStack DB "Stack is ",0
    promptStackIsEmpty DB "Stack is empty",0
    promptStackNotEmpty DB "Stack is not empty",0
    promptBeforeArraytoStack DB "before ArrayToStack",0
    promptAfterArraytoStack DB "after ArrayToStack",0
    promptBeforeStacktoArray DB "before StackToArray",0
    promptAfterStackToArray DB "after StackToArray",0
    promptBeforeStackReverse DB "before StackReverse",0
    promptAfterStackReverse DB "after StackReverse",0
    promptErrorStackEmpty DB "Error - Stack is empty: Cannot perform StackToArray",0
    promptErrorStackEmptyGeneric DB "Error - Vector is empty: Cannot perform operations on empty array",0
    promptErrorInvalidSize DB "Error - Invalid size: Size must be more than 0 and less than 20",0Ah,0
    promptGoodBye DB "I am exiting... Thank you Honey.. and Get lost....",0
    PromptInvalid DB "Invalid Option. Valid selections are 0,1,2,3 and -1",0Ah,0

.code

CreatVector PROC
Top:
    ; Prompt for size and elements of Vector
    mov EDX, OFFSET promptSizeOfV
    call WriteString
    call ReadInt
    cmp EAX, 0
    jle Error
    cmp EAX, 20
    jle Continue
    Error:
    LEA EDX, promptErrorInvalidSize
    call WriteString
    jmp Top

Continue:
    mov V_size, EAX
    mov EDX, OFFSET promptValue1
    call WriteString
    Call WriteDec
    mov EDX, OFFSET promptValue2
    call WriteString
    ; Loop to read and store elements in Vector
    mov ECX, V_size
    mov EDI, offset Vector
    L1:
        call ReadInt
        mov [EDI], EAX
        add EDI, TYPE SDWORD
        loop L1
        call CRLF
    ; Display size of Vector
    mov EDX, OFFSET promptSizeN
    Call WriteString
    mov eax, V_size
    Call WriteDec
    call CRLF
    ret
CreatVector ENDP


ArrayToStack PROC
    ; Save the return address of this procedure into a temporary variable
    pop EDX
    mov returnTemp, EDX

    ; Display a prompt to the user for entering the stack elements
    LEA EDX, promptStack
    call WriteString
	
    ; ECX is used as a counter for the loop
    mov ecx, V_size
    
    L1:
        ; EBX is used to calculate the offset for accessing the Vector array
        mov EBX, ECX
        dec EBX
        ; Access the Vector array at the calculated offset and store the value in EAX
        mov EAX, Vector[TYPE DWORD * EBX]
        call WriteDec
        ; Push the value onto the stack
        push EAX
        ; Output a space for formatting purposes
        mov AL, 32
        call WriteChar
        call WriteChar
        ; Erase the value from the Vector array
        mov Vector[TYPE DWORD * EBX], 0
        ; Increment the size of the stack
        inc Stack_size
        ; Repeat the loop until ECX is zero
        loop L1

    LEA EDX, promptAfterArrayToStack
    call WriteString
    call Crlf
    call PrintVector

    ; Reset V_size to 0
    mov V_size, 0

    ; Set the StackIsEmpty flag to 0 (false) to indicate that the stack is not empty
    mov StackIsEmpty,0

    ; Push the saved return address back onto the stack before returning from the procedure
    push returnTemp
    ret
ArrayToStack ENDP

StackToArray PROC
    ; Temporarily pop the return address and store it in a variable for later use
    pop edx
    mov returnTemp, EDX

    ; Loop L2 is for showing the values in the stack without popping
    ; Move the size of the stack into ECX
    mov ecx, Stack_size
    L2:
        ; Calculate the offset for accessing the stack
        mov EBX, ECX
        dec EBX
        ; Access the stack at the calculated offset and store the value in EAX
        mov EAX, [ESP+(EBX*4)]
        ; Display the value to the user
        call WriteDec
        ; Output a space for formatting purposes
        mov AL,32
        call WriteChar
        ; Repeat the loop until ECX is zero
        loop L2

    ; Copy size of Stack_size into V_size
    mov eax, Stack_size
    mov V_size, eax

    ; Move the size of the vector into ECX
    mov ecx, V_size
    L1:
        ; Calculate the offset for accessing the Vector array
        mov EBX, V_size
        sub EBX, ECX
        ; Pop a value from the stack and store it in EAX
        pop EAX
        dec Stack_size
        ; Store the value in the Vector array at the calculated offset
        mov Vector[TYPE DWORD * EBX], EAX
        ; Repeat the loop until ECX is zero
        loop L1
            
    ; Set the StackIsEmpty flag to 1 (true) to indicate that the stack is empty
    mov StackIsEmpty,1

    ; Push the saved return address back onto the stack before returning from the procedure
    push returnTemp
    ret
StackToArray ENDP

StackReverse PROC
    ; pop the procedure's return address for safekeeping
    pop EDX
    mov returnTemp, EDX

    ; Print the status of the stack before reversing
    mov StackIsEmpty, 0; Stack is now empty
    call StackStatus

    ; Loop 1: Push all elements from the array onto the stack
    mov ECX, V_size
    mov EDI, offset Vector
    L1:
        mov eax, [EDI]
        push eax
        add EDI, TYPE DWORD
        Loop L1
    ; Loop 2: Pop all elements from the stack back into the array
    mov ECX, V_size
    mov EDI, offset Vector
    L2:
        pop eax
        mov [EDI], EAX
        add EDI, TYPE DWORD
        loop L2
    ; Print the status of the stack after reversing
    mov StackIsEmpty, 1; Stack is now empty
    ; push the return address back onto the stack
    push returnTemp
    ret
StackReverse ENDP

;printing the content of array vector
PrintVector PROC
    mov EDX, OFFSET promptVector
    Call WriteString
	mov ecx, V_size

	L1:
		mov ebx, V_size
		sub ebx, ecx
		mov eax, Vector[TYPE DWORD * ebx]
		call WriteDec
		mov al, 32
		call WriteChar
		call WriteChar
		loop L1
	ret
PrintVector ENDP

StackStatus PROC
    ; Check if stack is empty
    cmp StackIsEmpty,1
    jne StackNotEmpty
    ; Print message if stack is empty
    LEA EDX, promptStackIsEmpty
    call WriteString
    jmp stackendp
StackNotEmpty:
    ; Print message if stack is not empty
    LEA EDX, promptStackNotEmpty
    call WriteString
stackendp:
    call CRLF
    ret
StackStatus ENDP

main PROC

	; code goes here
Top:
    mov EDX, OFFSET promptDo
    call WriteString
    call ReadInt
    call Crlf
    mov user_choice, EAX

    cmp user_choice, 0
    je getVector
    cmp user_choice, 1
    je fillStackFromArray
    cmp user_choice, 2
    je fillVectorFromStack
    cmp user_choice, 3
    je reverseStack
    cmp user_choice, -1
    jl InvalidOption
    je exitProgram

InvalidOption:
    LEA EDX, PromptInvalid
    call WriteString
    call CRLF
    jmp Top

    getVector: ;prompt 0
        call CreatVector
        call PrintVector
        call Crlf
        call StackStatus
        call CRLF
    jmp Top

    fillStackFromArray: ;prompt1
        cmp V_size, 0
        jle errorStackEmptyGeneric
        call PrintVector
        LEA EDX, promptBeforeArrayToStack
        call WriteString
        call Crlf
        call ArrayToStack
    
        LEA EDX, promptAfterArrayToStack
        call WriteString
        call Crlf
        call StackStatus
        call Crlf
        jmp Top

    fillVectorFromStack: ;promp 2
        cmp StackIsEmpty, 1
        je emptyError
        LEA EDX,promptStack
        call WriteString
        call StackToArray
        LEA EDX,promptBeforeStacktoArray
        call WriteString
        call Crlf
        call PrintVector
        LEA EDX, promptAfterStackToArray 
        call WriteString
        call Crlf
        call StackStatus
        call Crlf
        jmp Top
    reverseStack: ;prompt 3
        cmp V_size, 0
        jle errorStackEmptyGeneric
        call PrintVector
        LEA EDX, promptBeforeStackReverse
        call WriteString
        call CRLF
        call StackReverse
        call PrintVector
        LEA EDX, promptAfterStackReverse
        call WriteString
        call CRLF
        call StackStatus
        call CRLF
        jmp Top

    emptyError:
        LEA EDX, promptErrorStackEmpty
        call WriteString
        call Crlf
        call Crlf
        jmp Top

    errorStackEmptyGeneric:
        LEA EDX, promptErrorStackEmptyGeneric
        call WriteString
        call Crlf
        call Crlf
        jmp Top
    

    exitProgram:
        LEA EDX, promptGoodBye
        call WriteString
        call CRLF
        call CRLF 
    exit
main ENDP
END main
