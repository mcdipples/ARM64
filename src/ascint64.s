
/****************************************************************************************
    * SUBROUTINE ascint64:
    * _______________________________________________________________________________________
    * This method converts a string of characters to an equivalent 8-byte (dword) value.
    * The binary value of the converted ASCII string is returned inside the X0 register. 
    * If there is an invalid character inside the numeric string (which would invalidate
    * the conversion) the Carry Flag is set to 1 and the X0 register returns 0. 
    * 
    * If the numeric string contains a number that is too large to fit inside a dword, the
    * Over Flow is set to 1 and and the X0 register returns 0.
    * _______________________________________________________________________________________
    * X0: Must point to a null-terminated string
    * LR: Contains the return address
    * _______________________________________________________________________________________
    * Returned register contents:
    *   X0 - numerical result
    * _______________________________________________________________________________________
    * Registers X0 - X8 are modified and NOT PRESERVED 
    * (DO NOT USE THIS YET.) All registers are preserved except X0 
****************************************************************************************/    
    .data
    
    .global    ascint64        //Provide program starting address to linker

    .text
ascint64:
    // PRESERVE REGISTERS AS PER AAPCS
    str X19, [SP, #-16]! // PUSH
    str X20, [SP, #-16]!
    str X21, [SP, #-16]!
    str X22, [SP, #-16]!
    str X23, [SP, #-16]!
    str X24, [SP, #-16]!
    str X25, [SP, #-16]!
    str X26, [SP, #-16]!
    str X27, [SP, #-16]!
    str X28, [SP, #-16]!
    str X29, [SP, #-16]!
    str X30, [SP, #-16]! // PUSH LR 
    // === loop =============================
    mov X8, X0          // Preserve X0 since strlength will overwrite it
    mov X9, LR          // Preserve LR before losing it to strlenth 
    bl strlength        // X0 = strlength(*X0)
    mov LR, X9          // Restore Link Register

    mov X5, X0          // Copy X0 (length) into X5
    cmp X0, #0          // if (strlenth(*X0) == 0)
    beq botLoop         // exit loop
    mov X0, X8          // Restoring X0 to point to my cString

    // === Power math for base 10 ============
    mov X2, #1          // y
    mov X4, #10         // base 10 
    mov X6, #0          // accumulator register

topLoop:
    mov X7, #0
    add X7, X7, X0      // Point to the last digit in *X0 (i.e.: 1's digit) 
    add X7, X7, X5      // X7 -> to the end of the cString so we can work backwards (NULL)
    sub X7, X7, #1      
    ldrb W1, [X7], #1   // Indirect addressing X1 = *X0 
    cmp W1, #'-'        // if char = '-'
    b.eq negate

    sub W1, W1, #0x30   // Subtract the ascii offset of 48
    mul X3, X1, X2      // X3 = x * 10^y and y is stored in X3
                        // x is now stored in W1
    add X6, X6, X3      // X6 is accumulator 
    mul X2, X2, X4      // result of X4 ^ X2
    sub X5, X5, #1

    cmp X5, #0          // Compare X5 == 0 
    beq botLoop         // if (X5 ==0)
    b   topLoop         // jump to botLoop

negate:
    MVN X6, X6
    ADD X6, X6, #1

botLoop:
    ldr X30, [SP], #16  // POP
    ldr X29, [SP], #16  // POP
    ldr X28, [SP], #16  // POP
    ldr X27, [SP], #16  // POP
    ldr X26, [SP], #16  // POP
    ldr X25, [SP], #16  // POP
    ldr X24, [SP], #16  // POP
    ldr X23, [SP], #16  // POP
    ldr X22, [SP], #16  // POP
    ldr X21, [SP], #16  // POP
    ldr X20, [SP], #16  // POP
    ldr X19, [SP], #16  // POP

    mov X0, X6          // Store result into X0
    br  LR              // Return
