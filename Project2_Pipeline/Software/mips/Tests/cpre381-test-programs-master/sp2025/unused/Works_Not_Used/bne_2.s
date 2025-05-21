# bne_mss3247_1.s - Edge Case: Branch Not Taken
.data
.text
.globl main
main:
    # Initialize registers
    addi $1, $0, 5      # $1 = 5
    addi $2, $0, 5      # $2 = 5
    
    # Test BNE when registers are equal, this should not branch
    bne $1, $2, not_expected 
    
    # Should execute this if branch is not taken (expected)
    addi $3, $0, 100    # $3 = 100 (indicates branch correctly not taken)
    j end
    
not_expected:
    addi $3, $0, 1      # This should be skipped if branch works correctly
 
end:
    halt