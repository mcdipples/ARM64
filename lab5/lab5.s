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
szX:    .asciz   "10"
szY:    .asciz   "15"
szSum:  .asciz   "??"
szAdd:  .asciz   " + "
szEq:   .asciz   " = "
chCr:   .byte    10
dbX:    .word    0
dbY:    .word    0
dbSum:  .word    0

    .global_start       // Provide program starting address to linker
    .text
_start:

/****************************************************************************************
    * CONVERT TO DECIMAL AND ADD:
    * We want to convert szX and szY to decimal values, then store the return (X0) values
    * after each function call (bl ascint64(var)) into new variables dbX and dbY. We then 
    * want to add  dbX and dbY and store the result into dbSUm. 
    * ______________________________________________________________________________________
    * OUTPUT: 10 + 15 = ??
****************************************************************************************/
    //  CONVERT szX to an integer and add it to the accumulator register (X0)
    ldr X0, =szX        // X0 = &szX
    bl ascint64         // bl Branch Link stores the next LOC
                        // in the Link Register
                        // Upon return X0 = ascint64(*X0)

    ldr X10, =dbX       // move address of dbX into X10 (X10 = *dbX)
    str X0, [X10]       // dereference pointer *dbX (value stored in address in X10 is now storing value in X0)
    mov X13, X0         // Copying comp result (X0) to X13 

    ldr X0, =szY        // X0 = &szY
    bl ascint64         // bl Branch Link stores the next LOC
                        // in the Link Register
                        // Upon return X0 = ascint64(*X0)

    ldr X12, =dbY       // move address of dbY into X12 (X12 = *dbY)   
    str X0, [X12]       // dereference pointer *dbY (value at address stored in [X12] is now storing value in X0)   
    mov X14, X0         // Copying comp result (X0) to X13      

    // TODO: code to process X + Y, registers X10 and above can be safely used.

    add X15, X13, X14   // add values of X10(dbX) + X11(dbX) and store into X14(which needs to be put into dbSum)
    ldr X16, =dbSum     // move address of dbSum to X15 (X15 = *dbSum)
    str X15, [X16]      // dereference pointer *dbSum (value stored in address in X16 is now storing value held in X15)

    /****************************************************************************************
    * PRINT THE RESULT:
    * Setup the parameters to the string variables, and then call Linux to do it. 
    * ______________________________________________________________________________________
    * OUTPUT: 10 + 15 = ??
    ****************************************************************************************/
    mov X0, #1          // 1 = StdOut
    ldr X1, =szX        // string to print
    mov X2, #2          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 
    // Output: 51

    mov X0, #1          // 1 = StdOut
    ldr X1, =szAdd        // string to print
    mov X2, #2          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 
    // Output: +

    mov X0, #1          // 1 = StdOut
    ldr X1, =szY        // string to print
    mov X2, #2          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 
    //Output: 9

    mov X0, #1          // 1 = StdOut
    ldr X1, =szEq        // string to print
    mov X2, #2          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 
    //Output: = 

    mov X0, #1          // 1 = StdOut
    ldr X1, =szSum        // string to print
    mov X2, #2          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 
    //Output: ??

    /****************************************************************************************
    * EXIT:
    * Setup the parameters to exit the program, and then call Linux to do it. 
    ****************************************************************************************/
exit:
    mov X0, #0          // Use 0 return code
    mov X8, #93         // Service command code 93 terminates the program
    svc 0               // Call Linux to terminate the program 

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
    *   X0 - decimal result
    * Registers X0 - X8 are modified and NOT PRESERVED 
    * (DO NOT USE THIS YET.) All registers are preserved except X0 
    ****************************************************************************************/
ascint64:
    // === loop =============================
    mov X8, X0          // Preserve X0 since strlength will overwrite it
    mov X9, LR          // Preserve LR before losing it to strlenth 
    bl strlength        // X0 = strlength(*X0)
    mov LR, X9          // Restore Link Register

    mov X5, X0          // Copy X0 (length) into X5
    cmp X0, #0          // if (strlenth(*X0) == 0)
    beq botloop         // exit loop
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

    sub W1, W1, #0x30   // Subtract the ascii offset of 48
    mul X3, X1, X2      // X3 = x * 10^y and y is stored in X3
                        // x is now stored in W1
    add X6, X6, X3      // X6 is accumulator 
    mul X2, X2, X4      // result of X4 ^ X2
    sub X5, X5, #1
    cmp X5, #0          // Compare X5 == 0 
    beq botloop         // if (X5 ==0)
    b   topLoop         // jump to botLoop

botLoop:
    mov X0, X6          // Store result into X0
    br  LR              // Return

    /****************************************************************************************   
    * SUBROUTINE strlength:
    * Will read a string of characters terminated by a null
    * _______________________________________________________________________________________
    * R0: Points to the first byte of a cString
    * LR: Contains the return address
    * _______________________________________________________________________________________
    * Returned register contents:
    *   X0: Length of the cString excluding the null character
    * All registers are preserved except X0
    ****************************************************************************************/
strlength:
    // === We need a do-while ==================
    mov X7, X0          // Indirect addressing X1 = *X0
    mov X2, #0          // Counter

topLoop2:
    ldrb W1, [X7], #1   // Indirect addressing X1 = *X0 
    cmp W1, #0          // if (W1 == NULL CHARACTER)
    beq botLoop2        // jump to bottom of subroutine
    add X2, X2, #1      // increment the counter
    b topLoop2

botLoop2:
    mov X0, X2          // X0 - length of the cString
    br  LR              // Return
    
    .end 