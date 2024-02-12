INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

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









































































































































;second way of doing this which is faster
COMMENT ?
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    ; Declare and initialize data
    promptN BYTE "Enter N terms: ",0  ; Prompt for user input
    fibArray DWORD 50 DUP(0)  ; Array to store Fibonacci numbers
    promptSpace BYTE " ", 0  ; Space character for formatting output
    PromptDisplay BYTE "Fibonacci sequence with N = ", 0  ; Output prompt
    fibSequencePrompt BYTE " is: ", 0  ; Output prompt

.code
main PROC
    ; Prompt user for input
    mov EDX, offset promptN
    call WriteString
    call ReadInt  ; Read user input
    inc EAX  ; Increment EAX because Fibonacci sequence starts from 0

    ; Check if user input is larger than array size
    cmp EAX, LENGTHOF fibArray
    jbe @F  ; If not, jump to label @F
    mov EAX, LENGTHOF fibArray  ; If yes, limit the input to the array size
    @@:  ; Label @F
    ; Store the number of terms
    mov ECX, EAX  ; ECX is used as a counter in loops
    mov EBX, EAX  ; EBX stores the number of terms
    
    ; Initialize the first two Fibonacci numbers
    mov eax, 1
    mov fibArray[0], 0  ; First Fibonacci number is 0
    mov fibArray[4], eax  ; Second Fibonacci number is 1
    
    ; Generate the Fibonacci sequence
    mov EDI, 2  ; Start from the third number
fibLoop:
    mov eax, fibArray[EDI * 4 - 4]  ; Get the previous Fibonacci number
    add eax, fibArray[EDI * 4 - 8]  ; Add the number before the previous one
    mov fibArray[EDI * 4], eax  ; Store the new Fibonacci number
    inc EDI  ; Move to the next number
    loop fibLoop  ; Repeat until all numbers are generated

    ; Print the Fibonacci sequence
    mov ECX, EBX  ; Set the counter to the number of terms
    mov EDI, 0  ; Start from the first number
    mov EDX, offset PromptDisplay
    call WriteString
    mov EAX, EBX
    call WriteDec  ; Print the number of terms
    mov EDX, offset fibSequencePrompt
    call WriteString
    printLoop:
        mov eax, fibArray[EDI * 4]  ; Get the current Fibonacci number
        call WriteDec  ; Print the number
        mov EDX, offset promptSpace
        call WriteString  ; Print a space
        inc EDI  ; Move to the next number
        loop printLoop  ; Repeat until all numbers are printed

    call Crlf  ; Print a newline
    call DumpRegs ; Displays registers in console
    exit  ; Exit the program

main ENDP
END main
?