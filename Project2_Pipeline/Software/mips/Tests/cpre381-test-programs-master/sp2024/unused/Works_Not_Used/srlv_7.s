.data

.text

# Test 1: Shift Right Logical Variable by 0
# Expected behavior: No change in the value of $s0 as shifting by 0 should not affect the value.
# Justification: This test is important because it ensures that the instruction behaves as expected even in edge cases, confirming that the processor handles shift 
# operations correctly, including the scenario where no actual shifting occurs.
test_srlv_0:
    addi $s0, $0, 15       # Initialize $s0 with a value
    addi $s1, $0, 0        # Initialize $s1 with shift amount 0
    srlv $s0, $s0, $s1     # Perform srlv operation

halt
