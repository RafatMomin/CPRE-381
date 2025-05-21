.data
.text
.globl main
main:
    # Start Test
addi $t1, $t1, 0x01000000
lw $t4, 0($t1) # expected = fail as it is the program text address
and $t1, $t1, $zero # set to 0

# End Test
# Exit program
halt