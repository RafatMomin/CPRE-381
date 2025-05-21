.data
.text
.globl main
main:
    # Start Test
lw $t0, ($t1) # should fail as this address is reserved

# End Test
# Exit program
halt