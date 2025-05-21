# Test Case 1: test if 32 bit register value can be compared to 16 bit immediate
# This test case makes sure the immediate value is extended to 32 bits

lui $t1, 0x00FF     # Set register to number represented by more than 16 bits (not negative)

slti $t2, $t1, 0    # $t1 < 0

halt
# $t2 should be set to 0 for this test