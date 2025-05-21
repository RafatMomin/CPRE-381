.data
.text
.globl test2
test2:
#test the normal function of this by subtracting a positive number by another, smaller positive number

addiu $t1,$0,10 #to test ,set t1 to 10
addiu $t2,$0,5 #set t2 to 5
subu $t0,$t1,$t2 # subtract the value 5 from 10 in decimal, t1-t2

# found this on the MARS, website, can use syscall to output to the terminal, which makes it easier to read my test results
li  $v0, 1
add $a0, $t0, $zero
syscall #expected printed output is 5

#This test is important because it tests the core subtraction functionality of this MIPS command.
halt
