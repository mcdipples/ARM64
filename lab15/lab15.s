/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : LAB 15
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 10/25/2021
*_______________________________________________________________________________________
Write a program that:

gets 2 integers from the user (x,y) --- for example 7, 8
if x == y, then display (values) x == y ---- for example 7 == 7
else if x > y, then display (values) x > y ---- for example 8 > 7
else display (values) x < y ---- for example 7 < 8
________________________________________________________________________________________
run 1: 
input: x = 500 and y = 500
output: x == y

run 2: 
input: x = -1 and y = -5
output: x > y

run 3: 
input: x = 53 and y = 66
output: x < y
****************************************************************************************/

    .data
szX:        .skip       19      // stores user-input x value string
szY:        .skip       19      // stores user-input y value string 
iX:         .word       0       // X5 - stores numerical value translated from string
iY:         .word       0       // X6 - stores numerical value translated from string

szPromptX:  .asciz      "Enter X: "
szPromptY:  .asciz      "Enter Y: "
szOutEQ:    .asciz      "x == y\n"
szOutGT:    .asciz      "x > y\n"
szOutLT:    .asciz      "x < y\n"
 
    .global _start          // Provide program starting address to linker
    .text
_start:
// === Prompt user to input X =============
    LDR     X0, =szPromptX
    bl      putstring

// take input 1 - store in string - send thru ascint64 and store.
    LDR     X1, =szX         // X1 = &szX 
    MOV     X2, #19          // X2 = 19

    bl      getstr           // b&l to getstr

    // === put stored value into ascint64 ======
    LDR     X0, =szX
    bl      ascint64
    
    // === then store new value into iX =======
    LDR     X3, =iX          // move address of iX into X3 (X3 = *dbnum1)
    STR     X0, [X3]         // dereference pointer *iX (address in X3 is now storing value that was in X0)
    MOV     X5, X0           // Copying comp result (X0) to X5 

// === Prompt user to input Y =============
    LDR     X0, =szPromptY
    bl      putstring

// take input 1 - store in string - send thru ascint64 and store.
    LDR     X1, =szY         // X1 = &szY 
    MOV     X2, #19          // X2 = 19

    bl      getstr           // b&l to getstr

    // === put stored value into ascint64 ======
    LDR     X0, =szY
    bl      ascint64
    
    // === then store new value into iX =======
    LDR     X4, =iY          // move address of iX into X4 (X4 = *dbnum1)
    STR     X0, [X4]         // dereference pointer *iX (address in X4 is now storing value that was in X0)
    MOV     X6, X0           // Copying comp result (X0) to X6 

// === Compare x and y ====================
    CMP     X5, X6
    B.EQ    equal 
    B.LT    less
    B.GT    greater
    // if none, exit 
    B       exit

equal:
    LDR     X0, =szOutEQ
    bl      putstring
    b exit 
less:
    LDR     X0, =szOutLT
    bl      putstring
    b exit 
greater:
    LDR     X0, =szOutGT
    bl      putstring
    b exit 

exit:
    // Setup the parameters to exit the program
    // and then call Linux to do it.
    mov         X0, #0          // Use 0 return code
    mov         X8, #93         // Service command code 93 terminates this program
    svc         0               // Call linux to terminate the program

    .end
    