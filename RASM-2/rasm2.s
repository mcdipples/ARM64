

    .data
kbBuf:      .skip       512

szPrompt1:  .asciz      "Enter your first number:  "
szPrompt2:  .asciz      "Enter your second number:  "

szSum:              .asciz  "\nThe sum is "
szDif:              .asciz  "\nThe difference is "
szProd:             .asciz  "\nThe product is "
szQuot:             .asciz  "\nThe quotient is "
szRem:              .asciz  "\nThe remainder is "

szOverflowAdd:      .asciz  "OVERFLOW occurred when ADDING\n"
szOverflowSub:      .asciz  "OVERFLOW occurred when SUBTRACTING\n"
szOverflowMul:      .asciz  "OVERFLOW occurred when MULTIPLYING\n"
szOverflowConv:     .asciz  "OVERFLOW occurred when CONVERTING\n"
szInvalidString:    .asciz  "INVALID character in numeric string\n"
szDivByZero:        .asciz  "You cannot divide by 0, THUS there is no quotient or remainder.\n"


    .global_start
    .text
_start:
// Num 1 = X10
// Num 2 = X11
// Result = X12
// Result/remainder = X13

// === INPUT NUMBERS =================================
top_enter1:
    // print prompt for num 1 
    LDR     X0, =szPrompt1
    BL      putstring

    // Enter first number
    LDR     X1, =kbBuf
    MOV     X2, #21
    BL      getstr

    CMP     X0, #0      // if user only hits enter, program exits 
    B.EQ    exit

    // Convert number to hex value 
    LDR     X0, =kbBuf
    BL      ascint64
    // Check if number is valid, branch to output error message and then back to top 
    // if not (Carry Flag is set to 1)
    // ....

    MOV     X10, X0     // store num1 into X10 for math 

    // check 
 //________________________________________________
top_enter2:
    // print prompt for num 2 
    LDR     X0, =szPrompt2
    BL      putstring

    // Enter second number
    LDR     X1, =kbBuf
    MOV     X2, #21
    BL      getstr

    CMP     X0, #0      // if user only hits enter, program exits 
    B.EQ    exit

    // Convert number to hex value 
    LDR     X0, =kbBuf
    BL      ascint64
    // Check if number is valid, branch to output error message and then back to top 
    // if not (Carry Flag is set to 1)
    // ....

    MOV     X11, X0     // store num2 into X11 for math 



//============================================
    ADDS    X3, X1, X2

    // if i have an overflow, i need to jump 
    // B.VS - branch if V flag (overflow) is set
    BVS     OV_Add              // If overflow flag is set, print error 
    LDR     X0, =szSum          // message and resume operations. else
    BL      putstring           // print out the sum 

Add_Resume:
    SUBS    X3, X1, X2
    BVS     OV_Sub
    LDR     X0, =szDif
    BL      putstring
Sub_Resume:
    B       exit

OV_Add:
    LDR     X0, =szOverflowAdd
    BL      putstring
    B       Add_Resume
OV_Sub:
    LDR     X0, =szOverflowSub
    BL      putstring
    B       Sub_Resume

// printReg is apparently an instruction you can do 
// and printStr
// syntax: printReg 4 // printStr "Outputs:"
// play with this, unsure of how it works. 

exit:
    // Setup the parameters to exit the program
    // and then call Linux to do it.
    mov    X0, #0      // Use 0 return code
    mov   X8, #93      // Service command code 93 terminates this program
    svc    0           // Call linux to terminate the program

    .end