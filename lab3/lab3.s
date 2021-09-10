// Sierra Martin (M/W 11:30-1:50)
// CS3B
// Lab 3 - Assembler program to add two 128-bit numbers
// Goal: OP3 = OP1 - OP2
// 1-(-1) = 2

.global _start // Provide program starting address

_start:
// Load OP1 with 128-bit value of 1.
 mov X2, #1 // Move #0xFF into lefthand register of OP1
 mov X3, #1 // Move #0xFF into righthand register of OP1

// Load OP2 with 128-bit value of -1
 mov X4, #-1 // Move #0xFF into leftmost register of OP2
 mov X5, #-1 // righthand register of OP2 = -1

// TODO: OP3 for result: OP3 = OP1 - OP2

 SUBS X1, X3, X5 // Subtracting X3 - X5, Store carry, store result in X1
 SBC X0, X2, X4 // Subtracting X2 - X4, add carry, store result in X0

 mov X0, #0 // Use 0 return code
 mov X8, #93 // Service code 93 terminates
 svc 0 // Call Linux to terminate
