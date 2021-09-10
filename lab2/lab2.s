//
// Assembler program to add two 192-bit numbers
// 
//
// X0-X2 - parameters to Linux function services
// X8 - Linux function number
//
.global _start // Provide program starting address

_start:
// Load OP1 with 192-bit value of -1.
 mov X0, #-1 // Move #0xFF into the leftmost register of OP1
 mov X1, #-1 // Move #0xFF into middle register of OP1
 mov X2, #-1 // Move #0xFF into right most registers of OP1

// Load OP2 with 192-bit value of -1
 mov X3, #-1 // Move #0xFF into leftmost register of OP1
 mov X4, X3 // Copy X3 into X4
 mov X5, X3 // Copy X3 into X5

// TODO: OP3 for result: OP3 = OP1 + OP

 ADDS X6, X0, X3 // adding X0 + X3, no need to add carry. Stored in X6
 ADCS X7, X1, X4 // adding X1 + X4, add carry, carry again. Stored in X7
 ADC X10, X2, X5 // adding X2 + X5, add carry, no need to carry this time. Stored in X10

 mov X0, #0 // Use 0 return code
 mov X8, #93 // Service code 93 terminates
 svc 0 // Call Linux to terminate
