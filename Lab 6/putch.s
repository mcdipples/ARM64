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
chX:    .byte   'A' 

    .global _start      // Provide program starting address to linker
    .text

_start:
    // syntax
    //ldr X0, =chX        // X0 = &chX  
   // bl  putch           // bl = Branch Link: stores the next LOC 
                        // in the link register and jumps to subroutine

    /****************************************************************************************
    * EXIT:
    * Setup the parameters to exit the program, and then call Linux to do it. 
    ****************************************************************************************/
exit:
    mov X0, #0          // Use 0 return code
    mov X8, #93         // Service command code 93 terminates the program
    svc 0               // Call Linux to terminate the program 


    /****************************************************************************************
    * SUBROUTINE putch:
    * _______________________________________________________________________________________
    * Provided a pointer to a character, putch will display the character to the terminal.
    * _______________________________________________________________________________________
    * R0: must point to a character byte
    * LR: must contain the return address
    ****************************************************************************************/
putch:
    mov X9, LR          // Preserve LR 
    mov X8, X0          // X8 = X0 (&chX)
    //mov X2, #1          // X2 = 1 (string length)

    /****************************************************************************************
    * PRINT:
    * Setup the parameters to print chX, and then call Linux to do it. 
    * ______________________________________________________________________________________
    * OUTPUT: A
    ****************************************************************************************/
    mov X0, #1          // 1 = StdOut
    mov X1, X8          // char to print
    mov X2, #1          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 

    br  LR              // Return 
    