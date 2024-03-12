
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


TITLE Vector and Stack Operations

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    Vector DWORD 20 DUP(?)      ; Vector array of maxsize 20
    V_size DWORD ?              ; Size of the Vector
    userInput DWORD ?           ; Variable to store user input

    ; Prompt messages
    promptDo BYTE "What do you want to do now? > ", 0
    promptSizeOfV BYTE "What is the size N of Vector? > ", 0
    promptValue BYTE "What are the ", 0
    promptValues BYTE " values in Vector? > ", 0
    promptVector BYTE "Vector = ", 0
    promptStackEmpty BYTE "Stack is empty", 0
    promptBeforeArrayToStack BYTE "Vector is before ArrayToStack", 0
    promptAfterArrayToStack BYTE "Stack is after ArrayToStack", 0
    promptAfterStackToArray BYTE "Vector is after StackToArray", 0
    promptBeforeStackReverse BYTE "Vector is before StackReverse", 0
    promptAfterStackReverse BYTE "Vector is after StackReverse", 0
    promptErrorStackEmpty BYTE "Error - Stack is empty: Cannot perform StackToArray", 0

.code

main PROC
    ; Display prompt for user action
    mov edx, OFFSET promptDo
    call WriteString

    ; Read user input
    call ReadInt
    mov userInput, eax

    ; Handle user action
    cmp userInput, 0
    je createVector
    cmp userInput, 1
    je fillStackFromArray
    cmp userInput, 2
    je fillVectorFromStack
    cmp userInput, 3
    je reverseVectorUsingStack
    cmp userInput, -1
    je exitProgram

    jmp invalidInput

createVector:
    ; Implement creating a new Vector
    ; Prompt for the size of Vector
    ; Read size input
    ; Prompt for values of Vector
    ; Read values into Vector
    ; Display Vector
    jmp main

fillStackFromArray:
    ; Implement filling a stack from a vector
    ; Display Vector before ArrayToStack
    ; Implement ArrayToStack
    ; Display Stack after ArrayToStack
    ; Display Vector after ArrayToStack
    ; Check if Stack is empty
    ; Display Stack empty message if empty
    jmp main

fillVectorFromStack:
    ; Implement filling a vector from a stack
    ; Display Stack before StackToArray
    ; Implement StackToArray
    ; Display Vector after StackToArray
    ; Check if Stack is empty
    ; Display Stack empty message if empty
    jmp main

reverseVectorUsingStack:
    ; Implement reversing a vector using the stack
    ; Display Vector before StackReverse
    ; Implement StackReverse
    ; Display Vector after StackReverse
    ; Check if Stack is empty
    ; Display Stack empty message if empty
    jmp main

exitProgram:
main ENDP
END main
