/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : Lab 5
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 9/15/2021
*_______________________________________________________________________________________
* Program function: Display to the terminal the result of adding two 64-bit numbers.
****************************************************************************************/

    .data

    .global putch      // Provide program starting address to linker
    .text
    // syntax:
    // ldr X0, =chX         // X0 = &chX  
    // bl  putch            // bl = Branch Link: stores the next LOC 
                            // in the link register and jumps to subroutine
    /****************************************************************************************
    * SUBROUTINE putch:
    * _______________________________________________________________________________________
    * Provided a pointer to a character, putch will display the character to the terminal.
    * _______________________________________________________________________________________
    * X0: must point to a character byte
    * LR: must contain the return address
    ****************************************************************************************/
putch:
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

    mov X9, LR          // Preserve LR 
    mov X8, X0          // X8 = X0 (&chX)

    /****************************************************************************************
    * PRINT:
    * Setup the parameters to print chX, and then call Linux to do it. 
    * ______________________________________________________________________________________
    * OUTPUT: chX
    ****************************************************************************************/
    mov X0, #1          // 1 = StdOut
    mov X1, X8          // char to print
    mov X2, #1          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 

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

    br  LR              // Return 
    