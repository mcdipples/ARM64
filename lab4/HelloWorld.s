//
// Program to print: "The sun did not shine."
//  		     "It was too wet to play."

.global _start // Provide program starting address
// Setup the parameters to print the strings
// and then call Linux to do it.
_start:

// Print first string
 mov X0, #1      // 1 = StdOut
 ldr X1, =szMsg1 // string to print
 mov X2, #23     // length of our string (plus null char)
 mov X8, #64 	 // Linux write system call 
 svc 0 		 // call linux to output the string

// Print newline '\n' char.. this is ascii 10
 mov X0, #1	 // 1 = StdOut
 ldr X1, =chCr   // char to print
 mov X2, #1 	 // length of char (1 byte)
 mov X8, #64
 svc 0		 // output the string again

// Print second string
 mov X0, #1
 ldr X1, =szMsg2 // string to print
 mov X2, #24     // length of our sting (plus null char)
 mov X8, #64 // Linux write system call
 svc 0 // Call Linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
 mov X0, #0 // Use 0 return code
 mov X8, #93 // Service code 93 terminates
 svc 0 // Call Linux to terminate
 
.data
szMsg1: .asciz "The sun did not shine."
szMsg2: .asciz "It was too wet to play."
chCr: .byte 10
