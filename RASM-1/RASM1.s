/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : RASM1
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 10/05/2021
*_______________________________________________________________________________________
CS3B RASM1 Input –  Data –  Calculate
Write a well-documented program which will perform the below calculations after inputting 4 variables.
** HANDLING NEGATIVES IS EXTRA CREDIT **
________________________________________________________________________________________
X = (A + B) – (C + D) where A, B, C, D are all quads that are input by the user at run time. 
Name the program RASM1.s 
When your program executes the below should be displayed (note indentation). 
I have bolded and underlined the information typed to either execute the program or to input the data values
Name: your name 
Class: CS 3B   
Lab: RASM1  
Date: 8/23/2018 
Enter a whole number: 100 
Enter a whole number: 200
Enter a whole number: 300
Enter a whole number: 400
(100 + 200) – (300 + 400)  = 0xFFFFFFFFFFFFFE70 (-400x10)
The addresses of the 4 ints: 00404010  00404014  00404018  0040401C

If I ran the program a second time, entering different values
Name: your name Class: CS 3B   
Lab: RASM1  
Date: 8/23/2018 
Enter a whole number: 120000
Enter a whole number: -25000000 
Enter a whole number: -38000000
Enter a whole number: 21403876594 
(120000 + -25000000) – (-38000000 + 2140387654)  => 0xFFFFFFFB0502F50E
The addresses of the 4 ints:   00404014  00404018  004040100040401C 
****************************************************************************************/
// Data section
    .data 
dbnum1:     .quad       0   // X10 = *&  X14 = stored value                      
dbnum2:     .quad       0   // X11 = *&  X15 = stored value
dbnum3:     .quad       0   // X12 = *&  X16 = stored value
dbnum4:     .quad       0   // X13 = *&  X17 = stored value

sznum1:     .skip       10
sznum2:     .skip       10
sznum3:     .skip       10
sznum4:     .skip       10
szresult:   .skip       21  // result 3 = X20

szmem1:     .skip       19  // string memory that will hold dbnum1's memory address 
szmem2:     .skip       19  // string memory that will hold dbnum2's memory address 
szmem3:     .skip       19  // string memory that will hold dbnum3's memory address 
szmem4:     .skip       19  // string memory that will hold dbnum4's memory address 

szheader1:  .asciz      "Name: Sierra Martin" //(20)
szheader2:  .asciz      "Class: CS3B"//(12)
szheader3:  .asciz      "Lab: RASM1"//(11)
szheader4:  .asciz      "Date: 10/4/2021"//(16)

szPrompt:   .asciz      "Enter a whole number: "//(23)
szAddress:  .asciz      "The addresses of the 4 ints: " //(30)
szleft:     .asciz      "("
szright:    .asciz      ")"
szplus:     .asciz      " + "
szmin:      .asciz      "-"
szeq:       .asciz      " = "
szspce:     .asciz      "  "
hexStr:     .ascii      "0123456789ABCDEFG"
chCr:       .byte       10

// result 1 = X18
// result 2 = X19
// result 3 = X20

// Main
    .global _start
    .text
_start:
// === Output class header ===================
    LDR X0, =szheader1
    bl  putstring
    LDR X0, =chCr        // \n
    bl  putch
    LDR X0, =szheader2
    bl  putstring
    LDR X0, =chCr        // \n
    bl  putch
    LDR X0, =szheader3
    bl  putstring
    LDR X0, =chCr        // \n
    bl  putch
    LDR X0, =szheader4
    bl  putstring
    LDR X0, =chCr        // \n
    bl  putch
    LDR X0, =chCr        // \n
    bl  putch 

// === Prompt user to input num1 =============
    LDR X0, =szPrompt
    bl  putstring

    // take input 1 - store in string - send thru ascint64 and store.
    LDR X1, =sznum1     // X1 = &sznum1
    MOV X2, #19         // X2 = 19

    bl getstr           // b&l to getstr

    // === put stored value into ascint64 ======
    LDR X0, =sznum1
    bl  ascint64

    // === then store new value into dbnum1 =======
    LDR X10, =dbnum1     // move address of dbnum1 into X10 (X10 = *dbnum1)
    STR X0, [X10]        // dereference pointer *dbnum1 (address in X10 is now storing value that was in X0)
    MOV X14, X0          // Copying comp result (X0) to X14 

// === Prompt user to input num2 =============
    LDR X0, =szPrompt
    bl  putstring

    // take input 1 - store in string - send thru ascint64 and store.
    LDR X1, =sznum2     // X1 = &sznum2
    MOV X2, #19         // X2 = 19

    bl getstr           // b&l to getstr

    // === put stored value into ascint64 ======
    LDR X0, =sznum2
    bl  ascint64

    // === then store new value into dbnum1 =======
    LDR X11, =dbnum2     // move address of dbnum2 into X10 (X10 = *dbnum2)
    STR X0, [X11]        // dereference pointer *dbnum2 (address in X11 is now storing value that was in X0)
    MOV X15, X0          // Copying comp result (X0) to X15 

// === Prompt user to input num3 =============
    LDR X0, =szPrompt
    bl  putstring

    // take input 1 - store in string - send thru ascint64 and store.
    LDR X1, =sznum3     // X1 = &sznum3
    MOV X2, #19         // X2 = 19

    bl getstr           // b&l to getstr

    // === put stored value into ascint64 ======
    LDR X0, =sznum3
    bl  ascint64

    // === then store new value into dbnum1 =======
    LDR X12, =dbnum3     // move address of dbnum1 into X12 (X12 = *dbnum3)
    STR X0, [X12]        // dereference pointer *dbnum3 (address in X12 is now storing value that was in X0)
    MOV X16, X0          // Copying comp result (X0) to X16 

// === Prompt user to input num4 =============
    LDR X0, =szPrompt
    bl  putstring

    // take input 1 - store in string - send thru ascint64 and store.
    LDR X1, =sznum4     // X1 = &sznum4
    MOV X2, #19         // X2 = 19

    bl getstr           // b&l to getstr

    // === put stored value into ascint64 ======
    LDR X0, =sznum4
    bl  ascint64

    // === then store new value into dbnum1 =======
    LDR X13, =dbnum4     // move address of dbnum4 into X13 (X13 = *dbnum4)
    STR X0, [X13]        // dereference pointer *dbnum4 (address in X13 is now storing value that was in X0)
    MOV X17, X0          // Copying comp result (X0) to X17 
    // output newline 
    LDR X0, =chCr        // \n
    bl  putch

// === EQUATION ==============================
    // ADD num 1 + num 2, store result1
    ADD X18, X14, X15
    // ADD num 3 + num 4, store result2 
    ADD X19, X16, X17
    // SUB result 2 from result1, store into result3 
    SUB X20, X18, X19
    // Send to hex64asc
    LDR X0, =szresult   // string memory that will hold result3's memory address
    MOV X1, X20         // X1 = result3
    bl hex64asc         // bl - store next LOC to link register and branch

// === OUTPUT EQUATION =======================
    // output '('
    LDR X0, =szleft
    bl  putstring
    // output num 1
    LDR X0, =sznum1
    bl  putstring
    // output ' + '
    LDR X0, =szplus
    bl  putstring
    // output num 2
    LDR X0, =sznum2
    bl  putstring
    // output ')'
    LDR X0, =szright
    bl  putstring
    // output ' - '
    LDR X0, =szmin
    bl  putstring
    // output '('
    LDR X0, =szleft
    bl  putstring
    // output num 3
    LDR X0, =sznum3
    bl  putstring
    // output " + "
    LDR X0, =szplus
    bl  putstring
    // output num 4
    LDR X0, =sznum4
    bl  putstring
    // output ')'
    LDR X0, =szright
    bl  putstring
    // output ' = '
    LDR X0, =szeq
    bl  putstring
    // output result3 
    LDR X0, =szresult
    bl  putstring
    // output newline
    LDR X0, =chCr        // \n
    bl  putch    
    LDR X0, =chCr        // \n
    bl  putch 
    // output "The addresses of the 4 ints:    "
    LDR X0, =szAddress
    bl  putstring

// === OUTPUT NUM 1-4 ADDRESSES ======= =======
    // Setup params for memory locations to be output:
    LDR X0, =szmem1       // string memory that will hold dbnum1's memory address
    LDR X1, =dbnum1       // X1 = &dbnum1
    bl  hex64asc

    LDR X0, =szmem2       // string memory that will hold dbnum2's memory address
    LDR X1, =dbnum2       // X1 = &dbnum2
    bl  hex64asc

    LDR X0, =szmem3       // string memory that will hold dbnum3's memory address
    LDR X1, =dbnum3       // X1 = &dbnum3
    bl  hex64asc

    LDR X0, =szmem4       // string memory that will hold dbnum4's memory address
    LDR X1, =dbnum4       // X1 = &dbnum4
    bl  hex64asc

    // output addresses
    // output address of num 1
    LDR X0, =szmem1
    bl  putstring
    // output space
    LDR X0, =szspce
    bl  putstring
    // output address of num 2
    LDR X0, =szmem2
    bl  putstring
    // output space
    LDR X0, =szspce
    bl  putstring   
    // output address of num 3
    LDR X0, =szmem3
    bl  putstring
    // output space
    LDR X0, =szspce
    bl  putstring  
    // output address of num 4
    LDR X0, =szmem4
    bl  putstring
    // output newline
    LDR X0, =chCr        // \n
    bl  putch 

exit:
    mov X0, #0           // Use 0 return code
    mov X8, #93          // Service command code 93 terminates the program
    svc 0                // Call Linux to terminate the program 

//=============================================================================================================
//=============================================================================================================
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

    mov X3, X1         // Scratch register - preserve X1 for future use (X1 holds dbX/dbY)
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
    * SUBROUTINE putch:
    * _______________________________________________________________________________________
    * Provided a pointer to a character, putch will display the character to the terminal.
    * _______________________________________________________________________________________
    * X0: must point to a character byte
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

.end
