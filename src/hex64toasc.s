   
   .data
hexStr:     .ascii      "0123456789ABCDEFG"

    .global hex64asc
    .text
/****************************************************************************************
    * SUBROUTINE hex64asc:
    * _______________________________________________________________________________________
    * Will convert a binary double word (aka quad) to a printable string of ascii characters. 
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
hex64asc:
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

    /*  X0 is address of the destination cString (19bytes)
     *  X1 holds the hexadecimal value to be converted to a cString
     *  W2 - loop index
     *  W3 - scratch register
    */
    // === Hardcode '0x' into our destination string ============
    // Load W3 with the memory pointed to by X0
    mov W3, #0x30
    strb W3, [X0], #1  // Stores value of X4 into the least significant byte of X0, increment X0 by 1
    mov W3, #0x78
    strb W3, [X0], #1  // Stores value of W3 into the first+1 byte of X0, increment X0 by 1 

    // for-loop
    mov W2, #60        // W2 = I 
loop:

    mov X3, X1         // Scratch register - preserve X1 for future use (X1 holds dbX)
    lsr X3, X3, X2     // lsr - logical shift right (LSR <Xd>, <Xn>, <Xm>) - shifting X3 to the right I times and storing result in X3
    and X3, X3, #0x0000000F // Mask off all BUT the right most nibble of result 

    ldr X4, =hexStr     // X4 = &hexStr
    add X4, X4, X3      // X4 -> hex[x3] (pointing to whatever character it is.)
    ldrb W4, [X4]       // X4 = contents of X4 (whatever that ascii character is, it is now in x4)

    // need to store this into our destination 

    strb W4, [X0], #1   // Stores value of X4 into the least significant byte of X0, increment index by 1

    sub W2, W2, #4      // I = I - 4
    
    cmp W2, #0 
    b.ge loop           // If I >= 0 goto loop

    mov W3, #0          // W3 = NULL character
    strb W3, [X0]       // stored NULL to make destString a cString


    /*
    but you can use this number in addition with the hex value 0x30 to get the proper hex value for a correlative ascii character within 0-9 
    This, however, will not get you digits A-F
    which I'm going to leave a mystery for you but it's pretty much the same methodology to get 0-9 ascii characters */

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

