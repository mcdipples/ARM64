/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : Lab 9
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 9/26/2021
*_______________________________________________________________________________________
* Program function: Convert a 64-bit hex to ascii 
****************************************************************************************/

    .data
dbX:        .quad       2000
dbY:        .quad       32  
szX:        .skip       19
hexStr:     .ascii      "0123456789ABCDEFG"
szPlus:     .ascii      " + "

    .global _start
    .text
_start:

    ldr X0, =szX        // X0 = &szX
    ldr X1, =dbX        // X1 = &dbX
    ldr X1, [X1]        // X1 = memory contents of dbX 

    str X0, [SP, #-16]! // PUSH X0 onto the stack 

    bl hex64asc         // bl - store next LOC to link register and branch

    ldr X0, [SP], #16   // POP XO from stack 

    bl putstring        // bl - store next LOC to link register and branch

   // ldr X0, =szPlus
    // bl putstring 

exit:
    mov X0, #0          // Use 0 return code
    mov X8, #93         // Service command code 93 terminates the program
    svc 0               // Call Linux to terminate the program 

//=============================================================================================================
//=============================================================================================================


    /****************************************************************************************
    * SUBROUTINE hex64asc:
    * _______________________________________________________________________________________
    * Will convert a binary double word (aka quad) to a printable string of ascii hex characters. 
    * You have to provide the address of a string that is large enough to hold the converted
    * value. Ensure that you allow for the largest possible value that a quad could be. 
    * _______________________________________________________________________________________
    * X0: Must point to address of a cString large enough to hold the converted value. 
    * X1: Contains the binary (signed) value to be converted to hex (ascii)
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
    strb W3, [X0], #1  // Stores value of W3 into the first+1 bit of X0, increment X0 by 1

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

    b exit              // branch up to exit the program

.end
