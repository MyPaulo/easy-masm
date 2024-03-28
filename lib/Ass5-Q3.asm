INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


TITLE

; Name: 
; Date: 
; ID: 
; Description: Prompt the user for the coefficients a, b, and c 
    ;of a polynomial in the form 𝑎𝑥2 + 𝑏𝑥 +𝑐 = 0. 
    ;Calculate and display the real roots of the polynomial using the quadratic formula
    ;the quadratic equation appears on Slide-56 of Chapter-12. If any root is imaginary, 
    ;display an appropriate message. 



.data
    
	; data declarations go here
    radix REAL8 ?
    
    prompt1 DB "Coefficient for (A) for Ax^2 + BX + C: ",0
    prompt2 DB "Coefficient for (B) for Ax^2 + BX + C: ",0
    prompt3 DB "Coefficient for (C) for Ax^2 + BX + C: ",0
    prompt4 DB "This polynomial has an imaginary root",0
    prompt5 DB "Root 1: ",0
    prompt6 DB "Root 2: ",0

    coeffA REAL4 ?
    coeffB REAL4 ?
    coeffC REAL4 ?

    two REAL4 2.0
    four REAL4 4.0
    zero REAL4 0.0
    junk REAL4 0.0
    
    part1 REAL4 ? ;sqrt(B^2 -4AC);
.code

getCoefficients PROC
    ;prompt the user for coefficient A
    mov edx, offset prompt1
    call WriteString
    call ReadFloat
    fstp coeffA
    ;prompt the user for coefficient B
    mov edx, offset prompt2
    call WriteString
    call ReadFloat
    fstp coeffB
    ;prompt the user for coefficient C
    mov edx, offset prompt3
    call WriteString
    call ReadFloat
    fstp coeffC

    ret
getCoefficients ENDP

main PROC

	; code goes here
    call Clrscr
    finit
    call getCoefficients

; k = B^2 - 4AC
    fld coeffB ; load into top of stack 
    fmul ST(0),ST(0) ; mult top stack by itself B^2
    fld four ; load 4 on top of stack 
    fmul coeffA
    fmul coeffC
    fsub ; ST(0) = ST(1) - ST(0)
; Expression under the radical must be postive.
    fld zero
    fcomi ST(0),ST(1) ; compare zero to ST(0)
    ja imaginary_root ; must be negative
;calculate the Square root
    fstp junk ; pop the zero value
    fsqrt     ; square root of ST(0)
    fst part1 ; save part1

;calculate the first root (-B + sqrt(b^2-4AC))
    fld coeffB
    fchs
    fadd part1
    fld coeffA
    fmul two
    fdivp ST(1),ST(0)
;dsipaly the first root
    call CRLF
    mov edx, offset prompt5
    call WriteString
    call WriteFloat
    call CRLF
    ;jmp normal
;calculate the second root (-B + ....)
    fld coeffB
    fchs
    fsub part1

    fld coeffA
    fmul two
    fdivp ST(1), ST(0)


;dsipaly the second root
    mov edx, offset prompt6
    call WriteString
    call WriteFloat
    call CRLF
    call CRLF
    jmp normal
imaginary_root:
    call CRLF
    mov edx, offset prompt4
    call WriteString
    call CRLF
    call CRLF
	;call DumpRegs ; displays registers in console
	exit
    normal:
main ENDP
END main




