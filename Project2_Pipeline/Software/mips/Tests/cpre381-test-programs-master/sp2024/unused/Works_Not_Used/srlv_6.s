# Test 1: shifting right by a variable amount when the amount is 0
# This test tests when the shift amount is a register that has the value 0 so it shouldn't change the value in $20


.data
.text
.globl main
main:
    # Start Test

    addi $5, $0, 0
    addi $20, $0, 2147483648
    
    srlv $20, $20, $5 
            
    # End Test

    # Exit program
    halt
