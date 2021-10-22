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

    .data
    
    .global putstring      // provide program starting address to linker 

    .text

putstring:
    // PRESERVE REGISTERS AS PER AAPCS
    STR     X19, [SP, #-16]!        // PUSH
    STR     X20, [SP, #-16]!        // PUSH
    STR     X21, [SP, #-16]!        // PUSH
    STR     X22, [SP, #-16]!        // PUSH
    STR     X23, [SP, #-16]!        // PUSH
    STR     X24, [SP, #-16]!        // PUSH
    STR     X25, [SP, #-16]!        // PUSH
    STR     X26, [SP, #-16]!        // PUSH
    STR     X27, [SP, #-16]!        // PUSH
    STR     X28, [SP, #-16]!        // PUSH
    STR     X29, [SP, #-16]!        // PUSH
    STR     X30, [SP, #-16]!        // PUSH LR
	//mov	X9, LR		    // Preserve the LR
	mov	X8, X0		    // X8 = X0
	bl	strlength	    // X0 = strlength(*X0)
	//mov	LR, X9
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
    LDR     X30, [SP], #16            // POP
    LDR     X29, [SP], #16            // POP
    LDR     X28, [SP], #16            // POP
    LDR     X27, [SP], #16            // POP
    LDR     X26, [SP], #16            // POP
    LDR     X25, [SP], #16            // POP
    LDR     X24, [SP], #16            // POP
    LDR     X23, [SP], #16            // POP
    LDR     X22, [SP], #16            // POP
    LDR     X21, [SP], #16            // POP
    LDR     X20, [SP], #16            // POP
    LDR     X19, [SP], #16            // POP

    RET        LR                // Return to caller
    .end
      