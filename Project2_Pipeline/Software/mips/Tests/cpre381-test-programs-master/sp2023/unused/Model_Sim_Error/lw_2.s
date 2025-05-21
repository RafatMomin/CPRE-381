.data
myArray: .word 2, 4, 6, 8, 10  # an array of integers #TA EDIT
.text
.globl main
main:
    # Start Test
addi $t1, $t1, 0x10040000
lw $t3, 0($t1) # expected = pass as it is the bottom of the heap
and $t1, $t1, $zero # set to 0

# End Test
# Exit program
halt
