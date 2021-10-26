/****************************************************************************************
    * SUBROUTINE intasc64:
    * _______________________________________________________________________________________
    * Will convert a binary double word (aka quad) to a printable string of ascii characters
    * representing the decimal value. 
    * You have to provide the address of a string that is large enough to hold the converted
    * value. Ensure that you allow for the largest possible value that a quad could be. 
    * _______________________________________________________________________________________
    * X0: Must point to address of a cString large enough to hold the converted value. 
    * X1: Contains the binary (signed) value to be converted to ascii
    * LR: contains the return address
    * _______________________________________________________________________________________
    * Registers X19-X29, and SP are preserved
    * All 64 bits of each value stored in X19-X29 must be preserved (use push and pop)
****************************************************************************************/
   .data
   iX:     .quad       0x0DE0B6B3A7640000   // 10 ^ 18 
    .global intasc64
    .text
intasc64:
    //LDR     X0, =szTest
   // MOV     X1, #0x0DE0             
   // MOVK    X1, #0xB6B3, LSL #16            
   // MOVK    X1, #0xA764, LSL #32              
   // MOVK    X1, #0x0000, LSL #48 
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

    // if value is negative, jump
    CMP     X1, #0
    B.LT    store_negative
    B       resume              // else proceed
    store_negative:
    SUB     X1, X7, X1          // X1 = 0-X1 (makes the value positive)
    MOV     W3, #'-'            // W3 will be overwritten when resuming 
    STRB    W3, [X0], #1        // store '-' into the least significant byte of the string pointed to by X0, increment * by 1  
    b       resume
resume:
    MOV     X4, #0              // keeps track of previously accumulated values to subtract
    MOV     X5, #0              // this will act as our flag to determine whether we should insert characters into the string or not
                                // while X5 == 0, there is no non-zero char to insert
    MOV     X6, #10             // for math 
    MOV     X7, #0              // for math 
    // X3 = 10^18 (start from right side)
    // Since 0x0DE0 B6B3 A764 0000 is too large to use #imm16
    // we must load it in parts. 
    LDR     X3, =iX
    LDR     X3, [X3]        // W3 now holds value within iX
   // MOV     X3, #0x0DE0             
  //  MOVK    X3, #0xB6B3, LSL #16            
  //  MOVK    X3, #0xA764, LSL #32              
  //  MOVK    X3, #0x0000, LSL #48              
loop:
  // updates X4's value for the present iteration
    MUL     X4, X4, X6          // shifts X4 over to the left by 1 decimal place depending on value of X4
    MOV     X2, X1              // X2 = X1
    SDIV    X2, X2, X3          // X2 = X2/X3 (X3 = 10^N)
    SUB     X2, X2, X4          // X2 = X2-X4 -  removes any leading digits from X2's value to focus on exclusively one digit
    ADD     X4, X4, X2          // X4 += X2, adds X2's isloated value to the extra register ()
                                // This will be used to truncate leading digits in next loop
    SDIV    X3, X3, X6         // X3 /= 10 

    // IF (X5 != 0 || X2 > 0 || X3 == 10^0)
    CMP     X5, #0
    B.NE    store             
    CMP     X2, #0
    B.GT    store
    CMP     X3, #1
    B.EQ    store
    // store value 
    B       loop                // else loop

store:
    MOV     X5, #1              // X5 = 1 which means we hit our first nonzero character to store (first digit of our number)
    ADD     X2, X2, #'0'        // X2 += ASCII value of 0 (0x30)
    STRB    W2, [X0], #1        // store value of X2 into position pointed to by X0
                                // increment by 1 
    CMP     X3, #1              // IF X3 == 10^0, exit loop
    B       endloop
    B       loop                // else loop

endloop:
    // POPPED IN REVERSE ORDER (LIFO)
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

    ret LR              // Return to caller 
