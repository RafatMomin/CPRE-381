.data
.text
.globl main

# Test case 3: set rt to have a value of all zeros

# Justification: Since the srlv instruction just shifts bits to the right and replaces the upper vacant bits with zero, then if
#                you try to shift a value with all zeros, the resulting value should still be all zeros (rd = rt = 0x00000000). 
#                This test is making sure that the srlv instruction is purely shifting bits and zero-extending the final result.

main:
# Start Test
addu $t0, $zero, $zero       # $t0 = rt = 0 + 0 = 0 = 0x00000000
addiu $t1, $t1, 32           # $t1 = rs = 32, specifies to shift the value in rt to the right by 32 bits
srlv $t2, $t0, $t1           # $t0 should be shifted to the right by 32 bits and zero-extended, where the result will still be all zeros
                             # Thus, $t2 = rd = 0x00000000
# End Test

# Exit program
halt