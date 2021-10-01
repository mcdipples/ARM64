/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : Lab 11
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 10/03/2021
*_______________________________________________________________________________________
Given the following variable definitions:
1 num1: .word x
2 num2: .word y

Prompt the user to enter x and y from the keyboard. Do the conversions and store in num1 and num2. Load
the two numbers from memory, compare them, and move the largest number into register r0.

Upload the source file and a gdb/gef screenshot showing memory values of x and y as well as the value of r0.

x = 512

y = 255
****************************************************************************************/

        .data
numx:       .word       0
numy:       .word       0 
szBufferX:  .skip       21
szBufferY:  .skip       21 

szPromptX:  .asciz      "Enter X: "
szPromptY:  .asciz      "Enter Y: "


      .global _start
      .text
_start:

    // == Prompt user to enter x ==
    LDR X0, =szPromptX
    bl  putstring

    LDR X1, =szBufferX   // X1 = &szBuffer
    MOV X2, #21          // X2 = 21

    bl  getstr            // b&l to getstr
    // [[szBufferX = X for output]]

    // === put stored value into ascint64 ======
    LDR X0, =szBufferX
    bl  ascint64


    // === then store new value into numx =======
    LDR X10, =numx       // move address of numx into X10 (X10 = *numx)
    STR X0, [X10]       // dereference pointer *numx (address in X10(numx) is now storing value that was in X0)
    MOV X13, X0         // Copying comp result (X0) to X13 
    // [[X13 = X]]

    // === Prompt user to input y =============
    LDR X0, =szPromptY
    bl  putstring

    LDR X1, =szBufferY   // X1 = &szBuffer
    MOV X2, #21          // X2 = 21

    bl getstr            // b&l to getstr
    // [[szBufferY = Y for output]]

    // === put stored value into ascint64 ======
    LDR X0, =szBufferY
    bl  ascint64

    // === then store new value into dbY =======
    LDR X12, =numy       // move address of dbY into X12 (X12 = *dbY)   
    STR X0, [X12]       // dereference pointer *dbY (address stored in [X12] is now storing value in X0)   
    MOV X14, X0         // Copying comp result (X0) to X13      
    // [[X14 = Y]]

    // == * Comparison * ==
    // need to compare and see which number is larger
    // subtract one from the other, if less than 0, then store the larger number in R0
    // else if greater than 0, store that value 

    SUB X15, X14, X13  // SUB X16 = Y - X
    CMP X15, #0         // if difference > 0
    b.gt yGreater       // store Y
    CMP X15, #0         // if difference < 0
    b.lt xGreater       // store X

exit:
    mov X0, #0           // Use 0 return code
    mov X8, #93          // Service command code 93 terminates the program
    svc 0                // Call Linux to terminate the program 
//=============================================================================================================
//=============================================================================================================
    /****************************************************************************************
    * X is greater
    ****************************************************************************************/
xGreater:
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

    MOV X0, X13
    b exit

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

    /****************************************************************************************
    * Y is greater
    ****************************************************************************************/
yGreater:
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

    MOV X0, X14
    b exit

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


    /****************************************************************************************
    * SUBROUTINE strlength:
    * _______________________________________________________________________________________
    * Will read a string of characters terminated by a null, reads and counts til it hits a null
    * _______________________________________________________________________________________
    * X0:Points to the first byte of a cString
    * LR: contains the return address
    * All registers are preserved except X0
    * _______________________________________________________________________________________
    * Returned register contents:
    * X0: length of the cString excluding the null character
    * All registers preserved except X0
    ****************************************************************************************/
strlength:
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

    // We need a do-while
    mov X7, X0          // Point to the first digit (leftmost) of cString
    mov X2, #0          // Counter

topLoop2:
    ldrb W1, [X7], #1   // Indirect addressing X1 = *X0
    cmp  W1, #0         // if (W1 == NULL CHARACTER) 
    beq  botloop2       // jump to the bottom of the subroutine
    add  X2, X2, #1     // increment counter
    b    topLoop2       // jump back up to the top of the loop

botloop2:
    mov  X0, X2         // X0 = Length of the cString

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
    ADD X0, X0, #1

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

    sub W1, W1, #0x30   // Subtract the ascii offset of 48
    mul X3, X1, X2      // X3 = x * 10^y and y is stored in X3
                        // x is now stored in W1
    add X6, X6, X3      // X6 is accumulator 
    mul X2, X2, X4      // result of X4 ^ X2
    sub X5, X5, #1
    cmp X5, #0          // Compare X5 == 0 
    beq botLoop         // if (X5 ==0)
    b   topLoop         // jump to botLoop

botLoop:
    mov X0, X6          // Store result into X0
    br  LR              // Return

    /****************************************************************************************
    * SUBROUTINE putstring:
    * _______________________________________________________________________________________
    * Provided a pointer to a null terminated string, putstring will
    * display the string to the terminal.
    * _______________________________________________________________________________________
    * X0: Must point to a null terminated string
    * LR: must contain the return address
    * All registers except X2, X4, X7 are preserved
    * _______________________________________________________________________________________
    * X2 - Stores the strlength of *X (CString)
    * X3 - Saves LR b/c strlength will change it
    * X4 - Saves X0 b/c strlength will change it
    ****************************************************************************************/
putstring:
    MOV X9, LR           // preserve LR 

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

	mov	X8, X0		    // X8 = X0
	bl	strlength	    // X0 = strlength(*X0)
	mov	X2, X0	        // X2 = stringLength(*X0)
 
    /****************************************************************************************
    * PRINT:
    * Setup the parameters to print *X0, and then call Linux to do it. 
    * ______________________________________________________________________________________
    * OUTPUT: string
    ****************************************************************************************/
	mov	X0, #1		    // 1 = Stdout
	mov	X1, X8		    // string to print
    
	mov	X8, #64		    // Linux write system call
	svc	0		        // Call Linux to output the string
 
 
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

    MOV LR, X9          // put address back to main into LR
    ret LR                // return to main


/*Build your own:
  Sauce: Pesto
  Cheese: mozzarella and lots of parm! a little bit of feta too plz
  Veggies: (lots) of basil, mushroom, onion, crushed garlic, cherry tomatoes, 
            spinach
  Meat: chorizo (yes ik it's vegan), salami, pepperoni
  Toppings: salt and oregano plz 
   */

.end
