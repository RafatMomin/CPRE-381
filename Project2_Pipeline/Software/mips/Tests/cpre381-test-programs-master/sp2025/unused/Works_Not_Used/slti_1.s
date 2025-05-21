# Test Case 1: test if negative register values work
# Included to check if negative numbers are considered rather than just positive ones

addi $t1, $0, -1     # Set register

slti $t2, $t1, 0    # $t2 = $t1 < 0

halt
# $t2 should be set to 1