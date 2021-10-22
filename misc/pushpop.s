    .data
    .global _start        // Provide program starting address to linker
    .text
_start:

PUSH    {X19, X20-X30}
POP     {X0, X1, X2}

exit:
    // Setup the parameters to exit the program
    // and then call Linux to do it.
    mov    X0, #0      // Use 0 return code
    mov   X8, #93      // Service command code 93 terminates this program
    svc    0           // Call linux to terminate the program

    .end