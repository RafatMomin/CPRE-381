.data
.text
.globl main

# Test case 1: shift the value in rt by an amount specified from another register (rs)

# Justification: This test is testing the basic functionality of the srlv instruction, which is to make sure the value 
#                in rt is shifted by the correct amount in  rs. This test is also looking at if the shifted value is 
#                zero-extended, meaning the vacant upper bits get filled in with zeros.

main:
# Start Test
lui $t0, 0xFFFF      # $t0 = rt = 0xFFFF0000
addiu $t1, $t1, 16   # $t1 = rs = 16, specifies to shift the value in rt to the right by 16 bits
srlv $t2, $t0, $t1   # $t0 should be shifted to the right by 16, and zeros filling in the vacant upper bits
                     # Thus, $t2 = rd = 0x0000FFFF
# End Test

# Exit program
halt
