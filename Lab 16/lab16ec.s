/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : Lab 16 EC
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 10/31/2021
*_______________________________________________________________________________________
Write a program that:
10 pts Extra Credit.

Replicate Collatz conjecture pg 35-36 RPiA.pdf and make the following modifications....

Get n from the user via getstring.
Print the number steps (iterations) that it takes to get to 1.
Upload source code and screenshot. Use 9944.
****************************************************************************************/
        .data
szInput:         .skip       20
szOutput:        .skip       20
szPrompt:        .asciz      "Input number: "
szX:             .asciz      "It took "
szY:             .asciz      " iterations to get to 1.\n"
chcr:            .asciz      "\n" 

        .global _start
        .text
_start:

    LDR     X0, =szPrompt      // Output "Input number: " 
    BL      putstring

    LDR     X1, =szInput  // input number
    MOV     X2, #21
    BL      getstr

    LDR     X0, =szInput    // X0 returns hex value of input 
    BL      ascint64    

    MOV     X1, X0 
    mov     X2, #0      // X2 <- 0 the # of steps
loop:
    cmp     X1, #1      // compare X1 and 1
    beq     end         // branch to end if X1 == 1

    and     X3, X1, #1  // X3 <- X1 & 1 [mask]
    cmp     X3, #0      // compare X3 and 0
    bne     odd         // branch to odd if X3 != 0

even:
    mov     X1, X1, ASR #1      // X1 <- (X1 >> 1) [divided by 2]
    b       end_loop
odd:
    add     X1, X1, X1, LSL #1  // X1 <- X1 + (X1 << 1) [3n]
    add     X1, X1, #1          // X1 <- X1 + 1 [3n+1]

end_loop:
    add     X2, X2, #1  // X2 <- X2 + 1
    b       loop        // branch to loop


 end:
    LDR     X0, =szOutput      // Throw value of X11 into intasc64 for output
    MOV     X1, X2
    BL      intasc64

    LDR     X0, =szX      // Output "It took "
    BL      putstring

    LDR     X0, =szOutput      // Output "number"
    BL      putstring

    LDR     X0, =szY      // Output " iterations to get to 1.\n"
    BL      putstring

    mov     X0, #0           // Use 0 return code
    mov     X8, #93          // Service command code 93 terminates the program
    svc     0                // Call Linux to terminate the program 
