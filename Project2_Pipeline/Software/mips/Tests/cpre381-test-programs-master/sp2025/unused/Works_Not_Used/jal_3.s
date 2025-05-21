#@author Braeden Wood
# This is a very simple test that determines if
# 'jal' correctly jumps and skips executing the instruction
# immediately after it.

 .data
successStr:   .asciiz "Success!"
failStr:      .asciiz "No good :("

.text
.globl main

main:
    jal jump_And_Link
    
    # If it gets here, it has failed :(((  
    j fail
    
jump_And_Link:

    # Success!!!
    j pass


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