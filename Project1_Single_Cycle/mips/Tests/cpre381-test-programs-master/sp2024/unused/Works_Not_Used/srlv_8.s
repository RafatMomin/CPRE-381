.data

.text

# Test 2: Shift Right Logical Variable by a positive value
# Expected behavior: The value of $s0 should be shifted right by the value stored in $s1.
# Justification: It verifies whether the processor can perform right logical shifts as expected, ensuring that the value is shifted by the specified number of bits without 
# introducing errors such as sign extension or unexpected behavior. Testing with a positive shift amount is crucial as it covers common use cases where data needs to be shifted 
# rightward by varying amounts, validating the functionality of the instruction for practical applications.
test_srlv_positive:
    addi $s0, $0, 15       # Initialize $s0 with a value
    addi $s1, $0, 3        # Initialize $s1 with shift amount 3
    srlv $s0, $s0, $s1     # Perform srlv operation

halt
