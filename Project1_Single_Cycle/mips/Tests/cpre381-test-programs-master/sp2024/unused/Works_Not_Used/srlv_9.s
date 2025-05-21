.data

.text

# Test 3: Shift Right Logical Variable by the maximum possible value
# Expected behavior: Shifting by the maximum possible value should result in 0.
# Justification: Shifting by the maximum value effectively shifts all bits out of the register, resulting in a value of 0. Verifying this behavior is crucial as it ensures 
# that the processor handles edge cases correctly, preventing potential errors such as overflow or unexpected behavior due to shifting beyond the register size. 

test_srlv_max:
    addi $s0, $0, 15       # Initialize $s0 with a value
    addi $s1, $0, 31       # Initialize $s1 with shift amount 31 (maximum possible)
    srlv $s0, $s0, $s1     # Perform srlv operation

halt
