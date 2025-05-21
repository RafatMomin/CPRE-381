addi $t0, $zero, 0xFFFFFFFF #initiates register to max value
addi $t1, $zero,-1 #initiate register to negative value
or $t2, $t0, $t2 #verify that or can be used for negative values as well as the maximum value that can be stored in a register
halt
