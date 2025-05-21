.data
.text
.globl test3
test3:

#this test will make sure that 0-0 works correctly for the subu instruction and does not induce an overflow.
addiu $t1,$0,0 #to test set $t1 to zero
addiu $t2,$0,0 #to test set $t2 to zero

subu $t0,$t1,$t2

li  $v0, 1
add $a0, $t0, $zero
syscall #expected printed output is 0

#this test is important because it lets us know that subu can be used to zero out a register without causing an overflow and sending bad data to other instructions
halt
