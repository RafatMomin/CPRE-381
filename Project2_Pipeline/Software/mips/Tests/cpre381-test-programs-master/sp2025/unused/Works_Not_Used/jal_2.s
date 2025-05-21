# @author Braeden Wood
# This is an assembly file created for the purpose of testing
# if the jal instruction is properly overwritten. 
# For example, we want $ra = PC + 4
# as opposed to some other operation where $ra not being
# word aligned might cause an issue.

 .data
successStr:   .asciiz "Success!"

.text
.globl main

main:
    # Normally, if $ra is not word aligned and remains word aligned,
    # such as 0x00400001, an error would occur when trying to use jr
    lui $ra, 0x0040  
    addi $ra, $ra, 1
    jal jump_And_Link
    
jump_And_Link:
    bne $ra, 0x00400001, fail
    j pass

pass:
    # Print the result of the test and exit
    li      $v0, 4 
    la      $a0, successStr
    syscall
    j end

fail:
    # Print the result of the test and exit
    li      $v0, 4 
    la      $a0, successStr
    syscall

end:
halt