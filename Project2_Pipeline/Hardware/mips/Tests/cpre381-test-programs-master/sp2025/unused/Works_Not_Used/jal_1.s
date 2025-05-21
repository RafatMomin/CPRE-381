# @author Braeden Wood
# This is an assembly file created for the purpose of testing:
# Does $ra get set to the expected value? This is an important base case

 .data
successStr:   .asciiz "Success!"
failStr:      .asciiz "No good :("

.text
.globl main

main:
    jal jump_And_Link
    
jump_And_Link:
    
    # Compare $ra after linking. Should be initial PC + 4
    beq $ra, 0x00400004, pass
    
    # Failed if got to here
    j fail


pass:
    # Print the result of the test and exit
    li      $v0, 4 
    la      $a0, successStr
    syscall
    j end
    
fail:
    # Print the result of the test and exit
   li	    $v0, 4
   la	    $a0, failStr
   syscall

end:
halt