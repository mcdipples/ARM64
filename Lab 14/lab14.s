// Programmer: Sierra Martin
// classwork: 
// Purpose: Demonstrate branching to an external procedure 
// Date: 10/20/2021

    .data
iX:     .word       0xDEADBEEF   // W6    
iY:     .word       0xCAFEBABE   // W7
 
    .global _start        // Provide program starting address to linker
    .text
_start:

    LDR     X6, =iX
    LDR     W6, [X6]        // W6 now holds value within iX

    LDR     X7, =iY
    LDR     W7, [X7]        // W7 now holds value within iY

    // PROBLEM #1
    ADDS    W0, W6, W7
    // Answer: Leave out the 0X, W0 = a9ac79ad || N=1, Z=0, C=1, V=0

    // PROBLEM #2
    ADC     W1, W6, W7
    // Answer: a9ac79ae || N=1, Z=0, C=1, V=0

    //Problem #3
    SUBS    W2, W6, W7
    // Answer: 13af0431 || (0010) N=0, Z=0, C=1, V=0

    // PROBLEM #4
    SBC     W3, W6, W7
    // Answer: 13af0431 || (0010) N=0, Z=0, C=1, V=0

    // PROBLEM #5
    REV32   X4, X6
    // Answer: efbeadde || (0010) N=0, Z=0, C=1, V=0

    // PROBLEM #6
    REV   X5, X6
    // Answer: efbeadde00000000 ||  (0010) N=0, Z=0, C=1, V=0

exit:
    // Setup the parameters to exit the program
    // and then call Linux to do it.
    mov    X0, #0      // Use 0 return code
    mov   X8, #93      // Service command code 93 terminates this program
    svc    0           // Call linux to terminate the program

    .end
    