INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

TITLE Ass2-Q1.asm

; Name: Paul Osuji
; Date: 
; ID: 110157511
; Description: 

.data
	; data declarations go here
    vector SDWORD 50 dup(?) ; array  of 50  SDWORD integers
    V_size SDWORD ?
    V_sum SDWORD ?
    V_count SDWORD ?
    V_min SDWORD ?
    V_i SDWORD ?
    V_j SDWORD ?
    isPalindrome Byte ?

    promptSize BYTE "what is the size N of Vector?> ",0
    promptSizeInvalid BYTE "Size must be positive or zero",0
    promptValue1 BYTE "what are the ",0
    promptValue2 BYTE " values in Vector?> ",0

    promptSizeDisplay BYTE "Size of Vector is N = ",0
    promptValueDisplay BYTE "Vector = ",0
    promptSpace Byte " ",0
    promptComma Byte ",",0

    promptSum BYTE "The sum of all the negative values in Vector is: Sum = ",0
    promptCount BYTE "The number of all the positive values in Vector is: Count = ",0

    promptIJ BYTE "Please give me two values I and J such that 1 <= I <= J <= N: ",0
    promptInvalidIJ BYTE "Invalid I or J", 0
    ;promptIJ_display BYTE "i= and j= ",0
    prompt_I BYTE "I = ",0
    prompt_and BYTE " and ",0
    prompt_J BYTE "J = ",0
    promptMin BYTE "The minimum value between position ",0
    promptLow BYTE " and ",0
    promptHigh BYTE " of Vector is: Minimun = ",0

    promptisPalindrome BYTE "Vector is NOT a palindrome", 0
    promptPalindrome BYTE "Vector is a palindrome because it reads the same way in both directions.", 0

    promptRepeat BYTE "Repeat with a new Vector of different size and/or content? press Y or y > ", 0
    userResponse BYTE ?
    promptExit BYTE "Goodbye!, exiting...", 0
.code
main PROC
    ; code goes here
; Start of the program
start: 
    call CRLF 
    call CRLF 
    ; Start of the checkSize loop
    checkSize:
        mov EDX, offset promptSize  
        call writeString  
        call ReadInt 
        cmp EAX, 0 ; Compare the integer read from the user with 0
        jl invalidSize ; If the integer is less than 0, jump to invalidSize
        jmp validSize ; If the integer is not less than 0, jump to validSize

    invalidSize: ; Start of the invalidSize section
        call CRLF 
        mov EDX, offset promptSizeInvalid 
        call writeString 
        call CRLF 
        call CRLF 
        jmp checkSize ; Jump back to the start of the checkSize loop

    validSize: ; Start of the validSize section
        mov V_size, EAX ; Store the valid size read from the user into V_size

    ; Start filling the vector with SDWORD integers from keyboard input
    mov ECX, V_size ; Load the size of the vector into ECX
    mov EDI, offset vector ; Load the address of the start of the vector into EDI
    call CRLF 

    ; Display the prompt once
    mov EDX, offset promptValue1 
    call writeString 
    mov EAX, V_size 
    call WriteDec 
    mov EDX, offset promptValue2 
    call writeString 

    cmp ECX, 0 ; Compare the size of the vector with 0
    je skip ; If the size of the vector is 0, jump to skip

    L1: ; Start of the L1 loop
        call ReadInt ; read an integer from the user
        mov [EDI], EAX ; Store the integer read from the user into the current position of the vector
        add EDI, TYPE SDWORD ; Increment the address stored in the EDI register by the size of a signed double-word (SDWORD)
    loop L1 ; End of the L1 loop

    skip: ; Start of the skip section
    call CRLF 

    ;display the size of Vector
    mov EDX, offset promptSizeDisplay 
    call writeString 
    mov EAX,V_size 
    call WriteDec ;  WriteDec  to print the size of the vector
    call CRLF 
    call CRLF

    mov ECX, V_size ; Load the size of the vector into ECX
    cmp ecx,0
    je skipp
    ;display the values of the vectors 
    mov EDX, offset promptValueDisplay 
    call writeString 
    
    mov EDI, offset vector ; Load the address of the start of the vector into EDI

    L2: ; Start of the L2 loop
        mov EAX,[EDI] ; Load the value at the current position of the vector into EAX
        call WriteInt 
        cmp ECX, 1 ; Compare the current loop counter with 1
        je endLoop ; If the loop counter is 1, jump to endLoop
        mov EDX, offset promptComma 
        call writeString 
        mov EDX, offset promptSpace 
        call writeString 
        add EDI, TYPE SDWORD ; Increment the address stored in the EDI register by the size of a signed double-word (SDWORD)
    loop L2 ; End of the L2 loop
    skipp:
    endLoop: ; Start of the endLoop section
    call CRLF 


    ; Start calculating the sum of all negative values and counting all positive values
    mov ECX, V_size 
    mov EDI, offset vector 
    mov V_sum,0 ; Initialize the sum of negative values to 0
    mov V_count, 0 ; Initialize the count of positive values to 0

    L3: ; Start of the L3 loop
        mov EAX, [EDI] 
        cmp EAX, 0 ; Compare the value with 0
        jle isNegative ; If the value is less than or equal to 0, jump to isNegative
        inc V_count ; If the value is greater than 0, increment the count of positive values
        jmp next ; Jump to next
        isNegative: ; Start of the isNegative section
            add V_sum, EAX ; If the value is less than or equal to 0, add it to the sum of negative values
        next: ; Start of the next section
            add EDI, TYPE SDWORD ; Increment the address stored in the EDI register by the size of a signed double-word (SDWORD)
    loop L3 ; End of the L3 loop

    ;display sum of all negatives values
    call CRLF 
    mov EDX, offset promptSum 
    call writeString 
    mov EAX, V_sum 
    call WriteInt 
    call CRLF 

    ;display count of all postives values
    call CRLF 
    mov EDX, offset promptCount 
    call writeString 
    mov EAX, V_count 
    call WriteDec 
    call CRLF 


    ; Ask for two values I and J
    askIJ:
        call CRLF 
        mov EDX, offset promptIJ 
        call writeString 
        call ReadInt 
        mov V_i, EAX 
        call ReadInt 
        mov V_j, EAX 

    ; Check if I and J are valid
        mov ECX, V_j ; Load the value of V_j into ECX
        cmp EAX, 1 ; Compare the last integer read from the user with 1
        jl invalidIJ ; If the integer is less than 1, jump to invalidIJ
        mov EAX, V_j ; Load the value of V_j into EAX
        cmp EAX, 1 ; Compare the value of V_j with 1
        jl invalidIJ ; If V_j is less than 1, jump to invalidIJ
        mov EAX, V_i ; Load the value of V_i into EAX
        cmp EAX, V_size ; Compare the value of V_i with the size of the vector
        jg invalidIJ ; If V_i is greater than the size of the vector, jump to invalidIJ
        mov EAX, V_j ; Load the value of V_j into EAX
        cmp EAX, V_size ; Compare the value of V_j with the size of the vector
        jg invalidIJ ; If V_j is greater than the size of the vector, jump to invalidIJ
        jmp validIJ ; If none of the above conditions are met, jump to validIJ

    invalidIJ: ; Start of the invalidIJ section
        mov EDX, offset promptInvalidIJ 
        call writeString 
        jmp askIJ 

    validIJ: ; Start of the validIJ section
        ; Find the minimum value between position I and J
        mov ECX, V_j ; Load the value of V_j into ECX
        sub ECX, V_i ; Subtract the value of V_i from ECX
        inc ECX ; Increment ECX
        mov EDI, offset vector ; Load the address of the start of the vector into EDI
        mov EAX, V_i ; Load the value of V_i into EAX
        dec EAX ; Decrement EAX
        imul EAX, TYPE SDWORD ; Multiply EAX by the size of a signed double-word (SDWORD)
        add EDI, EAX ; Add the result to the address stored in the EDI register
        mov EAX,[EDI] ; Load the value at the current position of the vector into EAX
        mov V_min, EAX ; Store the value into V_min
        dec ECX ; Decrement ECX
        L4: ; Start of the L4 loop
            mov EAX,[EDI] 
            cmp EAX, V_min ; Compare the value with V_min
            jge nextv ; If the value is greater than or equal to V_min, jump to nextv
            mov V_min, EAX ; If the value is less than V_min, store the value into V_min
            nextv: ; Start of the nextv section
                add EDI, TYPE SDWORD ; Increment the address stored in the EDI register by the size of a signed double-word (SDWORD)
        loop L4 ; End of the L4 loop

        ; Display I and J
        call CRLF 
        mov EDX, offset prompt_I 
        call writeString 
        mov EAX, V_i 
        call WriteDec 
        mov EDX, offset prompt_and 
        call writeString 
        mov EDX, offset prompt_J 
        call writeString 
        mov EAX, V_j 
        call WriteDec 
        call CRLF 

        ; Display the minimum value
        call CRLF 
        mov EDX, offset promptMin 
        call writeString 
        mov EAX, V_i 
        call WriteDec 
        mov EDX, offset promptLow 
        call writeString 
        mov EAX, V_j 
        call WriteDec 
        mov EDX, offset promptHigh 
        call writeString 
        mov EAX, V_min 
        call WriteInt 
        call CRLF 

        ; Check if the vector is a palindrome
        call CRLF 
        mov EDI, offset vector 
        mov ESI, offset vector
        mov EAX, V_size 
        dec EAX ; Decrement EAX
        imul EAX, TYPE SDWORD ; Multiply EAX by the size of a signed double-word (SDWORD)
        add ESI, EAX ; Add the result to the address stored in the ESI register

        L5: ; Start of the L5 loop
            mov EAX, [EDI] 
            cmp EAX, [ESI] ; Compare the value with the value at the end of the vector
            jne notPalindrome ; If the values are not equal, jump to notPalindrome
            add EDI, TYPE SDWORD ; Increment the address stored in the EDI register by the size of a signed double-word (SDWORD)
            sub ESI, TYPE SDWORD ; Decrement the address stored in the ESI register by the size of a signed double-word (SDWORD)
            cmp EDI, ESI ; Compare the addresses stored in the EDI and ESI registers
            jbe L5 ; If the address stored in the EDI register is less than or equal to the address stored in the ESI register, continue the loop

        mov isPalindrome, 1; Set isPalindrome to 1 to indicate that the vector is a palindrome
        jmp displayResult ; Jump to displayResult

        notPalindrome: ; Start of the notPalindrome section
        mov isPalindrome, 0 ; Set isPalindrome to 0 to indicate that the vector is not a palindrome

        displayResult: ; Start of the displayResult section
        cmp isPalindrome, 0 ; Compare isPalindrome with 0
        je displayNotPalindrome ; If isPalindrome is 0, jump to displayNotPalindrome
        mov EDX, offset promptPalindrome 
        call writeString 
        jmp endDisplay ; Jump to endDisplay

        displayNotPalindrome: ; Start of the displayNotPalindrome section
        mov EDX, offset promptisPalindrome 
        call writeString 

        endDisplay: ; Start of the endDisplay section
        call CRLF 

        ; Ask the user if they want to repeat the program
        call CRLF 
        mov EDX, offset promptRepeat 
        call writeString 
        call ReadChar 
        mov userResponse, al 

        ; Check the user's response
        cmp userResponse, 'Y' 
        je start 
        cmp userResponse, 'y' 
        je start ; If the user's response is 'y', jump to start

    ; If the user typed anything other than 'Y' or 'y', display the exit message and exit
    call CRLF 
    call CRLF 
    mov EDX, offset promptExit 
    call writeString 
    call CRLF 

    ;call DumpRegs 
    exit 

main ENDP 
END main 

