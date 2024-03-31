INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

TITLE Ass5-Q1.asm 

 
; Name: 
; Date: 
; ID: 
; Description:  The greatest common divisor (GCD) of two integers X and Y 
                ;is the largest integer Z that will evenly divide both integers. 
                ;The GCD algorithm involves integer division in a loop. Write the recursive GCD function 
                ;in ASM. Your main program must call this function with a pairs of 32-bit unsigned 
                ;parameters X and Y. Your GCD function should return the greatest common divisor of
                ; X and Y in register EAX, and your main program should display this value 
                ;EAX [= GCD of X and Y]. 

.data
    prompt1 DB "Enter value for a: ",0
    prompt2 DB "Enter value for b: ",0
    valA DWORD ?
    valB DWORD ?
    valGCD DWORD ?
    promptValA DB "The value for a = ",0
    promptValB DB " and b = ",0
    promptResult DB "The gcd between ",0
    promptAnd DB " and ",0
    promptEquals DB " = ",0

    promptSample DB "Testing EdgeCases provided by proffesor",0
    Test1 DB "GCD(5,20) = ",0
    Test2 DB "GCD(24,18) = ",0
    Test3 DB "GCD(11,7) = ",0
    Test4 DB "GCD(432,226) = ",0
    Test5 DB "GCD(0,0) = ",0

    promptTry DB "Did you wanna try another unsigned value",0

.code
gcd PROC
        ; Takes arguments a and b, pushed onto stack - respectively - before calling.
        ; Returns: the GCD of a and b, in EAX.

        ; Stack Frame Prologue (see chapter 8.2.2, 6th edition):
        push ebp                ; preserve existing value in ebp
        mov ebp, esp            ; set ebp as the beginning of the procedure's stack frame

        ; Moving forward, we can now be sure that, in the stack:
        ;   [ebp] is the value of ebp prior to calling the current procedure (preserved temporarily)
        ;   [ebp + 4] is the procedure's return address
        ;   [ebp + 8] is the address of parameter b
        ;   [ebp + 12] is the address of parameter a


        ; Compare value b to zero. If equal, jump to base case.
        mov eax, [ebp + 8]
        cmp eax, 0
        je BaseCase

        ; Else, push b onto the stack.
        push eax

        ; Calculate a % b, then push the result onto the stack as well.
        mov eax, [ebp + 12]     ; set a as the dividend
        cdq                     ; sign extend EAX into EDX (required for 32 bit division)
        push ebx                ; preserve original value in ebx
        mov ebx, [ebp + 8]      ; set b as the divisor
        idiv ebx                ; a / b
        pop ebx                 ; restore ebx (we don't the register anymore)
        push edx                ; push the remainder from the division onto the stack

        ; Recursive call.
        call gcd

        ; Remove the 2 values that were added to the stack before the recursive call.
        add esp, 8              ; equivalent to pop x2, without needing to store the popped values

        jmp Return
        
    BaseCase:
        mov eax, [ebp + 12]     ; put a in eax

    Return:
        pop ebp                 ; restore ebp
        ret
gcd ENDP
main PROC
    call Clrscr

    ;testing the following sample provided by professor
    LEA EDX, promptSample
    call WriteString
    call CRLF
    call CRLF
    ;GCD(5,20)
    push 5
    push 20
    call GCD
    LEA EDX, Test1
    call WriteString
    call WriteDec
    call CRLF
    ;GCD(24,18)
    push 24
    push 18
    call GCD
    LEA EDX, Test2
    call WriteString
    call WriteDec
    call CRLF
    ;GCD(11,27)
    push 11
    push 27
    call GCD
    LEA EDX, Test3
    call WriteString
    call WriteDec
    call CRLF
    ;GCD(432,226)
    push 432
    push 226
    call GCD
    LEA EDX, Test4
    call WriteString
    call WriteDec
    call CRLF
    ;GCD(0,0)
    push 0
    push 0
    call GCD
    LEA EDX, Test5
    call WriteString
    call WriteDec
    call CRLF
    call CRLF

    LEA EDX, promptTry
    call WriteString
    call CRLF
    call CRLF
    ;asking user for a and b value 
    LEA EDX, prompt1
    call WriteString
    call ReadInt
    mov valA, EAX
    LEA EDX, prompt2
    call WriteString
    call ReadInt
    mov valB, EAX
    call CRLF
    ;printing the value  of a and b to make sure it is what user enterd
    LEA EDX, promptValA 
    call WriteString
    mov EAX, valA
    call WriteDec
    LEA EDX, promptValB 
    call WriteString
    mov EAX, valB
    call WriteDec
    call CRLF
;push a and b onto the stack as parameters for gcd, then call gcd
    push valA
    push valB
    call gcd
    mov valGCD, EAX


;printing the result
    LEA EDX, promptResult
    call WriteString
    mov EAX, valA
    call WriteDec
    LEA EDX, promptAnd
    call WriteString
    mov EAX, valB
    call WriteDec
    LEA EDX, promptEquals
    call WriteString
    mov EAX, valGCD
    call WriteDec
    call CRLF
    call CRLF
     
    exit
main ENDP

END main
