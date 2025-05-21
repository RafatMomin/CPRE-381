.data
.text
.globl main
main:
#this should test every negative number from the 32 bit limit to 0 without failure.
ori $t0, -2147483648

loop:
beq $t0, $0, Exit
addi $t0, $t0, 1
beq $0, $0, loop


Exit: