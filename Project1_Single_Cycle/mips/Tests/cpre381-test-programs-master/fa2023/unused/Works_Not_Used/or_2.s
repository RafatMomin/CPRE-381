addi $t0, $zero, 0x10010010 #initiate register
addi $t1, $zero, 0 #initate register
or $t2, $t0, $t2 #verify that or works with zero and a negative value
halt
