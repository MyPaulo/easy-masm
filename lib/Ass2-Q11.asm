INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


.data
Vector DWORD 50 DUP(?)
varN DWORD ?
varI DWORD ?
varJ DWORD ?
SumNeg DWORD ?
CountPos DWORD ?
MinValue DWORD ?
IsPalindrome BYTE ?
strInputN BYTE "What is the size N of Vector? > ",0
strVecVal BYTE "What are the values in Vector? > ",0
strSizeN BYTE "Size of Vector is N = ",0
strVec BYTE "Vector = ",0
strSumNeg BYTE "The sum of all the negative values in Vector is: Sum = ",0
strCountPos BYTE "The number of all the positive values in Vector is: Count = ",0
strMinMax BYTE "Please give me two values I and J such that 1 <= I <= J <= N > ",0
strMinMaxResult BYTE "I = %d and J = %d, and",0
strMinValue BYTE "The minimum value between position %d and %d of Vector is: Minimum = %d",0
strPalindrome BYTE "Vector is a palindrome because it reads the same way in both directions.",0
strNotPalindrome BYTE "Vector is NOT a palindrome.",0
strInvalidIorJ BYTE "Invalid I or J",0
strNegSize BYTE "Size must be positive or zero",0
strRepeat BYTE "Repeat with a new Vector of different size and/or content? (Y/N) > ",0

.code
main PROC
    mov ecx, 1 ; Default repeat loop counter

repeatLoop:
    ; Prompt for N and read input
    mov edx, OFFSET strInputN
    call WriteString
    call ReadInt
    mov varN, eax

    ; Check if N is negative
    cmp varN, 0
    jl invalidN

    ; Prompt for Vector values and read input
    mov edx, OFFSET strVecVal
    call WriteString
    call ReadVector

    ; Display Vector size and values
    mov edx, OFFSET strSizeN
    call WriteString
    mov eax, varN
    call WriteInt
    call crlf

    mov edx, OFFSET strVec
    call WriteString
    lea esi, Vector
    call WriteVector
    call crlf

    ; Compute sum of negative values
    lea esi, Vector
    mov ecx, varN
    mov eax, 0 ; Reset sum to 0
    call SumNegValues
    mov SumNeg, eax
    mov edx, OFFSET strSumNeg
    call WriteString
    mov eax, SumNeg
    call WriteInt
    call crlf

    ; Count positive values
    lea esi, Vector
    mov ecx, varN
    mov eax, 0 ; Reset count to 0
    call CountPosValues
    mov CountPos, eax
    mov edx, OFFSET strCountPos
    call WriteString
    mov eax, CountPos
    call WriteInt
    call crlf

    ; Prompt for I and J
    mov edx, OFFSET strMinMax
    call WriteString
    call ReadInt
    mov varI, eax
    call ReadInt
    mov varJ, eax

    ; Check if I, J, or N are less than 1
    cmp varI, 1
    jl invalidIorJ
    cmp varJ, 1
    jl invalidIorJ
    cmp eax, varN
    jg invalidIorJ
    cmp eax, varN
    jg invalidIorJ

    ; Display I and J
    mov edx, OFFSET strMinMaxResult
    mov eax, varI
    call WriteInt
    mov eax, varJ
    call WriteInt
    call crlf

    ; Find minimum value between position I and J
    lea esi, Vector
    call FindMinValue
    mov edx, OFFSET strMinValue
    mov eax, varI
    call WriteInt
    mov eax, varJ
    call WriteInt
    mov eax, MinValue
    call WriteInt
    call crlf

    ; Check if Vector is a palindrome
    lea esi, Vector
    ;call IsPalindrome
    mov IsPalindrome, al
    cmp IsPalindrome, 1
    je isPalindromeLabel
    mov edx, OFFSET strNotPalindrome
    call WriteString
    jmp repeatCheck

isPalindromeLabel:
    mov edx, OFFSET strPalindrome
    call WriteString

repeatCheck:
    ; Prompt for repeating the process
    mov edx, OFFSET strRepeat
    call WriteString
    call ReadChar
    cmp al, 'Y'
    je repeatLoop

    ; Exit the program
    jmp exitProgram

invalidN:
    mov edx, OFFSET strNegSize
    call WriteString
    jmp repeatCheck

invalidIorJ:
    mov edx, OFFSET strInvalidIorJ
    call WriteString
    jmp repeatLoop

exitProgram:
    call crlf
    call crlf
    call ExitProcess

main ENDP

SumNegValues PROC
    ; Computes the sum of negative values in Vector
    ; Input: esi - Pointer to the array (Vector)
    ;        ecx - Number of elements in the array (N)
    ; Output: eax - Sum of negative values
    mov eax, 0 ; Initialize sum to 0
sumLoop:
    cmp ecx, 0
    jle sumDone ; Exit loop if ecx is 0 or negative
    mov ebx, [esi] ; Load current element to ebx
    cmp ebx, 0 ; Check if the element is negative
    jl addNeg ; Jump if negative
    jmp nextElem ; Continue to the next element
addNeg:
    add eax, ebx ; Add the negative value to sum
nextElem:
    add esi, 4 ; Move to the next element
    loop sumLoop ; Loop through all elements
sumDone:
    ret
SumNegValues ENDP

CountPosValues PROC
    ; Counts the number of positive values in Vector
    ; Input: esi - Pointer to the array (Vector)
    ;        ecx - Number of elements in the array (N)
    ; Output: eax - Count of positive values
    mov eax, 0 ; Initialize count to 0
countLoop:
    cmp ecx, 0
    jle countDone ; Exit loop if ecx is 0 or negative
    mov ebx, [esi] ; Load current element to ebx
    cmp ebx, 0 ; Check if the element is positive
    jg addPos ; Jump if positive
    jmp nextElem ; Continue to the next element
addPos:
    inc eax ; Increment the count of positive values
nextElem:
    add esi, 4 ; Move to the next element
    loop countLoop ; Loop through all elements
countDone:
    ret
CountPosValues ENDP

FindMinValue PROC
    ; Finds the minimum value between positions I and J in Vector
    ; Input: esi - Pointer to the array (Vector)
    ;        ecx - Number of elements in the array (N)
    ;        I, J - Indices of the range to find the minimum value
    ; Output: MinValue - Minimum value in the specified range
    lea esi, [esi + 4 * I - 4] ; Move esi to position I
    mov ebx, [esi] ; Initialize MinValue with the value at position I
    mov ecx, J ; Number of elements in the range
    dec ecx ; Decrease the count to avoid extra comparison in the loop
minLoop:
    cmp ecx, 0
    jle minDone ; Exit loop if ecx is 0 or negative
    add esi, 4 ; Move to the next element
    mov eax, [esi] ; Load current element to eax
    cmp eax, ebx ; Compare with current MinValue
    jl updateMin ; Jump if the current element is smaller
    jmp nextElemMin ; Continue to the next element
updateMin:
    mov ebx, eax ; Update MinValue with the smaller element
nextElemMin:
    loop minLoop ; Loop through all elements in the range
minDone:
    mov MinValue, ebx ; Store the result in MinValue
    ret
FindMinValue ENDP

ReadVector PROC
    ; Reads values into Vector from the keyboard
    ; Input: N - Number of elements to read
    ; Output: Vector - Array of signed double-word integers
    mov ecx, N
    lea esi, Vector ; Set esi to the address of Vector
readLoop:
    call ReadInt ; Read an integer from the keyboard
    mov [esi], eax ; Store the integer in Vector
    add esi, 4 ; Move to the next element in Vector
    loop readLoop ; Loop until all elements are read
    ret
ReadVector ENDP

WriteVector PROC
    ; Writes the values of Vector to the console
    ; Input: N - Number of elements to write
    ;        Vector - Array of signed double-word integers
    mov ecx, N ; Set the loop counter to N
    lea esi, Vector ; Set esi to the address of Vector
writeLoop:
    mov eax, [esi] ; Load the current element from Vector
    call WriteInt ; Write the current element to the console
    mov edx, OFFSET strSpace ; Add a space
    call WriteString ; Write a space to the console
    add esi, 4 ; Move to the next element in Vector
    loop writeLoop ; Loop until all elements are written
    ret
WriteVector ENDP

WriteString PROC
    ; Writes a null-terminated string to the console
    ; Input: edx - Address of the null-terminated string
    invoke WriteConsole, hConsoleOutput, edx, StrLen(edx), ADDR charsWritten, 0
    ret
WriteString ENDP

WriteInt PROC
    ; Writes an integer to the console
    ; Input: eax - Integer to write
    invoke dwtoa, eax, ADDR buffer ; Convert integer to ASCII
    invoke WriteConsole, hConsoleOutput, ADDR buffer, StrLen(ADDR buffer), ADDR charsWritten, 0
    ret
WriteInt ENDP

ReadInt PROC
    ; Reads an integer from the keyboard
    ; Output: eax - Integer read from the keyboard
    invoke ReadConsole, hConsoleInput, ADDR buffer, SIZEOF buffer, ADDR charsRead, 0
    invoke atoi, ADDR buffer ; Convert ASCII to integer
    ret
ReadInt ENDP

ReadChar PROC
    ; Reads a single character from the keyboard
    ; Output: al - Character read from the keyboard
    invoke ReadConsole, hConsoleInput, ADDR buffer, 1, ADDR charsRead, 0
    movzx eax, buffer ; Zero-extend the ASCII character to a DWORD
    mov al, BYTE PTR eax ; Extract the low byte (character)
    ret
ReadChar ENDP

crlf PROC
    ; Writes a newline character to the console
    mov edx, OFFSET newline
    invoke WriteConsole, hConsoleOutput, edx, StrLen(edx), ADDR charsWritten, 0
    ret
crlf ENDP

newline BYTE 0DH, 0AH, 0 ; Newline character sequence
buffer BYTE 11 DUP(?) ; Buffer for storing input characters
charsRead DWORD ?
charsWritten DWORD ?
hConsoleInput HANDLE ?
hConsoleOutput HANDLE ?

INCLUDE Irvine32.inc

main ENDP
END main
