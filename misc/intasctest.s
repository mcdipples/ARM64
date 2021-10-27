
   .data
szTest:     .skip       20   
szprompt:   .asciz      "enter value:  "
szRes:      .asciz      "result:  "
szEndRes:   .skip       21

    .global _start
    .text
_start:

// take input 1 - store in string - send thru ascint64 and store.    
    LDR X0, =szprompt   // "enter value:  "
    BL putstring

    LDR X1, =szTest
    MOV X2, #20
    bl getstr           // take input

    // === put stored value into ascint64 ======
    LDR X0, =szTest
    bl  ascint64

    // === then store new value into x1 =======
    /*    
    * X0: Must point to address of a cString large enough to hold the converted value. 
    * X1: Contains the binary (signed) value to be converted to ascii
     */
    MOV X1, X0          // Copying comp result (X0) to X1
    LDR X0, =szEndRes   // X0 = &szEndRes
    bl intasc64

    // output result, load X0 into szEndRes
    LDR X0, =szRes   // "enter value:  "
    BL putstring     // "result:  "
    
    LDR X0, =szEndRes
    BL putstring

exit:
    mov X0, #0           // Use 0 return code
    mov X8, #93          // Service command code 93 terminates the program
    svc 0                // Call Linux to terminate the program 

.end
