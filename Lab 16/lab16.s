/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : Lab 16
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 10/31/2021
*_______________________________________________________________________________________
Write a program that:

Declare/Initial an array to hold 10 integers. Initialize to 0.
Execute a for loop to get 10 number's from the user and store them into the array.
Execute another for loop (must be different loop than #2)  to sum the values of the array.
Execute another for loop to print the values to the terminal.
Display the sum to the terminal.
Upload your source.s and the output of your file as a screenshot.png.

Use the following numbers in your submission: 

27	7	36	79	21	89	14	23	18	3
****************************************************************************************/

        .data
iSrcArray:       .skip       40      // 0x410340
iSumArray:       .skip       40 
szPrompt:        .asciz      "Input 10 numbers into the array:\n"
szOut:           .asciz      "Here are the numbers you inputted: "
szInput:         .asciz      "Input number: "
szSum:           .asciz      "Here is the sum of all of the numbers: "
szSpace:         .asciz      " "
chcr:            .asciz      "\n"
kbBuf:           .skip       512   

        .global _start
        .text
_start:
// === input ===================================
        MOV     X4, #9              // X4 - count (i)
        LDR     X10, =iSrcArray     // X1 = &iSrcArray

        LDR     X0, =szPrompt       // "Input 10 numbers into the array: "
        BL      putstring
loop_input:
        LDR     X0, =szInput    // "Input number: "
        BL      putstring

        // Branch and link to getstring to take user input for current index
        LDR     X1, =kbBuf
        MOV     X2, #3
        BL      getstr

        LDRH    W3, [X1]        // load 2 bytes stored in kbBuf       
        STRH    W3, [X10]       // stores keyboard buffer value into iSrcArray 

        ADD     X10, X10, #4        // &iSrcArray + 1 
        SUB     X4, X4, #1          // i--

        CMP     X4, #0              // for i > 10, loop
        b.ge    loop_input

        LDR     X1, =iSrcArray      // X1 = &iSrcArray

// === output ===================================
        LDR     X0, =szOut      // "Here are the numbers you inputted: "
        BL      putstring

        LDR     X10, =iSrcArray // X10 = &iSrcArray
        MOV     X4, #9         // i = 9 

loop_output:
        MOV     X0, X10
        BL      putstring        // outputs iSrcArray[i]

        ldr     X0, =szSpace        // X1 = &chSpace  
        bl      putstring

        ADD     X10, X10, #4          // &iSrcArray + 1 
        SUB     X4, X4, #1          // i--

        CMP     X4, #0              // for i > 10, loop
        b.ge    loop_output 
        
        ldr     X0, =chcr        // \n 
        bl      putstring

// === Sum of all numbers =======================
        LDR     X0, =szSum     // "Here is the sum of all of the numbers:  "
        BL      putstring

        LDR     X10, =iSrcArray // X10 = &iSrcArray
        MOV     X12, #9         // i = 9
loop_sum:
        //* X0: Must point to a null-terminated string
        MOV     X0, X10
        BL      ascint64

        ADD     X11, X11, X0

        ADD     X10, X10, #4          // &iSrcArray + 1 
        SUB     X12, X12, #1          // i-- 

        CMP     X12, #0              // for i > 10, loop
        b.ge    loop_sum 
        
        LDR     X0, =iSumArray      // Throw value of X11 into intasc64 for output
        MOV     X1, X11
        BL      intasc64

        LDR     X0, =iSumArray      // Output sum 
        BL      putstring

        ldr     X0, =chcr        // \n 
        bl      putstring

    exit:
    mov X0, #0           // Use 0 return code
    mov X8, #93          // Service command code 93 terminates the program
    svc 0                // Call Linux to terminate the program 

    .end
