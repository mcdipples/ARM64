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
iSrcArray       .skip       64

        .global _start
        .text
_start:

//================================
// STORE DATA TO AN ARRAY
//================================
    MOV W1, #88             // Quiz #1 score 
    LDR X2, =iSrcArray      // X2 = &iSrcArray

    STR W1, [X2]            // Move what is in W1 into whatever X2 is pointing to 
    

    MOV W1, #92
    LDR X2, =iSrcArray

    // we don't want to override the value -- so what do we do?
 /* 
 OR WE CAN STR W1, [X2, #4]! WHICH ADDS 4 BYTES TO THE POINTER AFTER THE STORE SO WE CAN STORE THE NEXT NUM 
 */
    ADD X2, X2, #4          // Adding 4 bytes, move pointer
    STR W1, [X2]       

 //================================
 // PULL VALUES FROM AN ARRAY (in 
 // this case, we're adding them all 
 // together?)
 //================================
    // LETS RETRIEVE THE VALUES FROM RAM AND COMPUTE THE AVERAGE
    MOV W3, #0              // SCRATCH REGISTER FOR SUM 
    LDR X2, =iSrcArray

    LDR X3, [X2, #4]!            // X3 = *X2 = array [0]
    ADD W4, W4, W3          // W4 = W4 + X3 (32 BIT ADDING) SUM = ARRAY[0]\

    LDR X3, [X2, #4]!            // X2 = *X2 = array [1]
    ADD W4, W4, W3          // W4 = W4 + X3 (32 BIT ADDING) SUM = ARRAY[1]

    /*
    ldr from Xn, = iSrcArray
    ldr xn, [xn]
    str xn, [xi]
     */




    ADD X2, X2, #4          // W2 = W2 + 4 (MOVING POINTER TO THE NEXT INDEX)

    LDR X2, [X2]                // X2 = *X2 = array[1]

    ADD W4, W4, W2              // W3 = W3 + X2  SUM = SUM + ARRAY[1]                  
