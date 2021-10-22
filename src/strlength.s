//strlength
// Subroutine getstring will read a string of characters terminated by a null
// X0: Points to first byte of a CString
// LR: Contains the return address

// Returned register contents:
//      X0: Length of the CString excluding the null character
// All registers are preserved except X0.

    .data
    
    .global    strlength        //Provide program starting address to linker

    .text
strlength:
    // PRESERVE REGISTERS AS PER AAPCS
    STR     X19, [SP, #-16]!        // PUSH
    STR     X20, [SP, #-16]!        // PUSH
    STR     X21, [SP, #-16]!        // PUSH
    STR     X22, [SP, #-16]!        // PUSH
    STR     X23, [SP, #-16]!        // PUSH
    STR     X24, [SP, #-16]!        // PUSH
    STR     X25, [SP, #-16]!        // PUSH
    STR     X26, [SP, #-16]!        // PUSH
    STR     X27, [SP, #-16]!        // PUSH
    STR     X28, [SP, #-16]!        // PUSH
    STR     X29, [SP, #-16]!        // PUSH
    STR     X30, [SP, #-16]!        // PUSH LR
    
    // We need a do while
    mov     X7, X0            //point to first digit (leftmost) of CString
    mov        X2, #0            //Counter
    
topLoop:
    ldrb    W1, [X7],#1        //indirect addressing X1 = *X0
    cmp        W1, #0            //if (W1 == NULL CHARACTER)
    beq        botLoop            //    jump to bottom of subroutine
    add        X2, X2, #1        // increment the counter
    b        topLoop

botLoop:
    mov        X0, X2            //X0 = Length of the CString
    
    // POPPED IN REVERSE ORDER (LIFO)
    LDR     X30, [SP], #16            // POP
    LDR     X29, [SP], #16            // POP
    LDR     X28, [SP], #16            // POP
    LDR     X27, [SP], #16            // POP
    LDR     X26, [SP], #16            // POP
    LDR     X25, [SP], #16            // POP
    LDR     X24, [SP], #16            // POP
    LDR     X23, [SP], #16            // POP
    LDR     X22, [SP], #16            // POP
    LDR     X21, [SP], #16            // POP
    LDR     X20, [SP], #16            // POP
    LDR     X19, [SP], #16            // POP

    RET        LR                // Return to caller
    .end
      