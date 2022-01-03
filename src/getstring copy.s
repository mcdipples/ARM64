 /****************************************************************************************
    * SUBROUTINE getstr:
    * _______________________________________________________________________________________
    * Will read a string of characters terminated by a null character
    * _______________________________________________________________________________________
    * X1: Must point to first byte of buffer to receive the string. 
    * X2: Is the length of the string buffer 
    * LR: contains the return address
    * _______________________________________________________________________________________
    * Returned register contents:
    * X0: Will return the # of bytes read 
    * All AAPCS mandated registers are preserved. 
****************************************************************************************/   
    
    .data

    .global getstr
    .text

getstr:
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

    // our code here
    MOV X0, #0          // STDIN(0)m - tells system to read from keyboard
    MOV X8, #63        // 63 - system call for read 
    SVC #0              // returns the number of bytes in X0. Records the 
                        // keystrokes from the keyboard until '\n'

    // At this point, X0 contains the number of bytes read
    // Strip off the \n
    SUBS X0, X0, #1     // SUBS triggers the cpsr flag to reflect whether or not the result was ...
                        // Did the user only hit newline <ENTER>?
    LDRB W8, [X1, X0]   // Load 1 byte into the lower half of X8 1 byte that begins with X1 and goes 
                        // for a count of the number of bytes. 
    CMP W8, #'\n'
    BEQ getstr_exit
    ADD X0, X0, #1      // exclude the null 

getstr_exit:

    MOV  W3, #0         // Stores null character in W3
    STRB W3, [X1, X0]   // Stores null char into X1 with offset of X0 (length of string -1)

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

