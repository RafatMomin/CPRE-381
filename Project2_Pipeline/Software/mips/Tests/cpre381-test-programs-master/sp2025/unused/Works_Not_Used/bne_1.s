# bne_mss3247_0.s - Common Case
.data
.text
.globl main
main:
    # Initialize regs with different values
    addi $1, $0, 5      # $1=5
    addi $2, $0, 10     # $2=10
    
    # test when not equal (should branch)
    bne $1, $2, Leap 
    
    # Should not execute if branch works
    addi $3, $0, 1      
    j end               # goto exit
    
Leap:
    addi $3, $0, 100    # $3 = 100 (indicates successful branch)
    
end:
    halt