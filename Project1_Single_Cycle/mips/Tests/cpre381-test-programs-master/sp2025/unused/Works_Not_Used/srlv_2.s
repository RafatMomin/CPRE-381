.data
.text
.globl main

# Test case 2: set rs = 0 to prevent any shifting in rt

# Justification: This test is testing more basic functionality of the srlv instruction. We want to make sure that if the value in
#                rs is 0, then the value in rt won't be shifted at all. This will result in rd = rt

main:
# Start Test
lui $t0, 0xFFFF      # $t0 = rt = 0xFFFF0000
addiu $t1, $t1, 0    # $t1 = rs = 0, specifies to shift the value in rt to the right by 0 bits, aka not shift the value at all
srlv $t2, $t0, $t1   # $t0 should not be shifted. Thus, $t2 = rd = rt = 0xFFFF0000
# End Test

# Exit program
halt
