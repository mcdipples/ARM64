// Programmer: Dr. Barnett
// Lab 13: 
// Purpose: Demonstrate branching to an external procedure 
// Date: 18  Sept 2021

    .data
szMsg:    .asciz    "Cat\n"

    .global _start        // Provide program starting address to linker

    .text
_start:
    
    mov        X19, #19
    mov        X20, #20
    mov        X21, #21
    mov        X22, #22
    mov        X23, #23
    mov        X24, #24
    mov        X25, #25
    mov        X26, #26    
    mov        X27, #27
    mov        X28, #28
    mov        X29, #29
    
    ldr        X0,  =szMsg
    
    bl        strlength




exit:
    // Setup the parameters to exit the program
    // and then call Linux to do it.
    mov    X0, #0      // Use 0 return code
    mov   X8, #93      // Service command code 93 terminates this program
    svc    0           // Call linux to terminate the program

    .end
    