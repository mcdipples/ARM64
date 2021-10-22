/****************************************************************************************
* AUTHOR	 : Sierra Martin
* STUDENT ID : 1130942
* HW NAME    : Lab 11
* CLASS      : CS3B
* SECTION    : M-W 11:30p - 1:50p
* DUE DATE   : 10/03/2021
*_______________________________________________________________________________________
Create the following C++ like arrays in your data segment..

int iSrcArray[16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};

int iDestArray[16];

Write a for loop (do not use the for directive)s to copy the data from iSrcArray to iDestArray.
****************************************************************************************/

        .data
iSrcArray:       .word       0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15      // 0000000000410100
iDestArray:      .skip       64                                         // 0000000000410140

        .global _start
        .text
_start:

    // make a loop to access each index of iSrcArray
    // access first index (with pointer post-increment), pull value, store in Xn
    // access first index of iDest (with pointer post-increment)
    // store Xn into that index
    // loop (16 times)

    // X0 = &iSrcArray
    // X1 = *iSrcArray[i] (moves to next index afterwards)
    // X2 = &iDestArray
    // X3 = *iDestArray[i] (moves to next index afterwards)
    // X4 = (COUNT)

    MOV X4, #16              // X3 = 0 (COUNT / i)
    LDR X0, =iSrcArray      // X0 = &iSrcArray
    LDR X2, =iDestArray     // X2 = &iDestArray
loop:
    // == Get the values of the indexes for each array into a register ==
    LDR X1, [X0]            // X1 = *iSrcArray 
    LDR X3, [X2]            // X3 = *iDestArray

    MOV X5, X1              // move iSrcArray[i](X1) into X5

    STRB W5, [X2]            // stores X5 into whatever X2 points to (iDestArray[i])  

    ADD X0, X0, #4          // increment index by 1 
    ADD X2, X2, #4          // increment index by 1 
    SUB X4, X4, #1          // i--

    CMP X4, #0              // for i > 16, loop
    b.ge loop   

    exit:
    mov X0, #0           // Use 0 return code
    mov X8, #93          // Service command code 93 terminates the program
    svc 0                // Call Linux to terminate the program 

    .end
