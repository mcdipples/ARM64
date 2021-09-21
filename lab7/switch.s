/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : Lab 7
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 9/15/2021
*_______________________________________________________________________________________
* Program function: Create an Assembly Language framework to
* implement a SELECT/CASE construct. The format is
*
* SELECT number
*  CASE 1:
*    << statements if number is 1 >>
*  CASE 2:
*    << statements if number is 2>>
*  CASE ELSE:
*    << statements if not any other case >>
* END SELECT
* X0 = where &chNum is stored, X1, X2, X8, X9 are used by putch 
****************************************************************************************/
.data
szElse:     .asciz      "DEFAULT CASE\n"
chNum:      .byte       3
chOne:      .byte       '1'
chTwo:      .byte       '2'

    .global _start
    .text
_start:
    
loop:
    ldr X0, =chNum          // X0 = &chNum [0323101]
    ldrb W3, [X0]           // X3 = the value inside of X0
    cmp X3, #1              // if chNum = 1 
    b.eq putchOne              // go to output character 
                            // will continue to caseTwo to check for the char '2'
caseTwo:
    cmp X3, #2              // if chNum > 2
    b.eq putchTwo               // jump to output to putch 
    // otherwise continue and print string for case 3  

else: 
// output string s
mov X0, #1          // 1 = StdOut
    ldr X1, =szElse        // string to print
    mov X2, #14          // length of our string
    mov X8, #64         // Linux write system call
    svc 0               // Call Linux to output the string 
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
putchOne:
    mov X9, LR          // Preserve LR 
    ldr X0, =chOne
    mov X8, X0          // X8 = X0 (&chNum)
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

    b  exit              // Return to exit 
    
    /****************************************************************************************
    * SUBROUTINE putch:
    * _______________________________________________________________________________________
    * Provided a pointer to a character, putch will display the character to the terminal.
    * _______________________________________________________________________________________
    * R0: must point to a character byte
    * LR: must contain the return address
    ****************************************************************************************/
putchTwo:
    mov X9, LR          // Preserve LR 
    ldr X0, =chTwo
    mov X8, X0          // X8 = X0 (&chNum)
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

    b  exit              // Return to exit 
    