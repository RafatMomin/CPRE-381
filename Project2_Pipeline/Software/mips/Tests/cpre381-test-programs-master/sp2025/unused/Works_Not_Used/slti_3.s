# Test Case 1: test if negative immediate values work
# Checks if immediate value is sign extended properly

addi $t1, $0, -3     # Set register

slti $t2, $t1, -1    # $t2 = $t1 < -1

halt
# $t2 should be set to 1
